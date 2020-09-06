//
//  Trip.ViewModel.swift
//  alaget
//
//  Created by Ernist Isabekov on 29/08/2020.
//

import Foundation
import Combine
import CoreData
import SwiftUI


final class TripStore: ObservableObject {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Published var trips: [Trip] = []
    @Published var selectedItem: Trip?
    @Published var isChaged: Bool = false
    let session: URLSession = {
         let configuration = URLSessionConfiguration.default
         configuration.timeoutIntervalForRequest = TimeInterval(7)
         configuration.timeoutIntervalForResource = TimeInterval(7)
         return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
     }()
    
    init() {
//        self.trips = [
//            Trip.init(userID: "asd", country: "asd", city: "asd", code: "sdf", remark: "sdf", lastUpdate: "wqe", image: "asd", lat: 0, lon: 0, distance: 0, tripGrpKey: "asd"),
//            Trip.init(userID: "asd", country: "asd", city: "asd", code: "sdf", remark: "sdf", lastUpdate: "wqe", image: "asd", lat: 0, lon: 0, distance: 0, tripGrpKey: "asd")
//        ]
        load()
    }
    
    func load() {
        self.trips.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Trips")
        do {
            if let result = try? appDelegate.persistentContainer.viewContext.fetch(request){
                for item in result{
                    let id = (item as AnyObject).id! as UUID
                    let userID = (item as AnyObject).userID!! as String
                    let country = (item as AnyObject).country!! as String
                    let city = (item as AnyObject).city!! as String
                    let code = (item as AnyObject).code!! as String
                    let remark = (item as AnyObject).remark!! as String
                    let lastupd = (item as AnyObject).lastUpdate!! as String
                    let arrDate = (item as AnyObject).arrDate!! as Date
                    let depDate = (item as AnyObject).depDate!! as Date
                    let tripGrpKey = (item as AnyObject).tripGrpKey!! as String
                    
                    let trip = Trip.init(id: id, uuid: userID, country: country, city: city, code: code, depdate: depDate, arrdate: arrDate, remark: remark, lastupdate: lastupd, tripgrpkey: tripGrpKey)
                    
                    self.trips.append(trip)
                }
            }
        }
    }
    func insert(trip: Trip) {
        
        let table = Trips(context: appDelegate.persistentContainer.viewContext)
        table.id   = trip.id
        table.userID  = trip.uuid
        table.country = trip.country
        table.city    = trip.city
        table.code    = trip.code
        table.remark  = trip.remark
        table.arrDate = trip.arrdate
        table.depDate = trip.depdate
        table.lastUpdate = trip.lastupdate
        table.tripGrpKey = trip.tripgrpkey
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
            // completionHandler(true, "Successful")
//            self.trips.append(trip)
            print("Successfuly Saved to core Data")
        }catch {
            debugPrint("Tony: Could not save \(error.localizedDescription)")
            // completionHandler(false, "Successful")
        }
        
        let insertData: [String: Any] = ["id": trip.id.uuidString, "uuid": trip.uuid, "country": trip.country, "city": trip.city, "code": trip.code, "depdate": DateToStr(date: trip.depdate), "arrdate": DateToStr(date: trip.arrdate), "remark": trip.remark, "lastupdate": trip.lastupdate, "tripgrpkey": trip.tripgrpkey]
                     
                if let uri = URL(string: URL_TRIPS_API_END_POINT){
                    var request = URLRequest(url: uri)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: insertData, options: .prettyPrinted)
                        request.httpBody = jsonData
                        request.httpMethod = "POST"
                        print(jsonData)
                    } catch let e {
                        print(e)
                    }
                    
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    session.dataTask(with: request) { jsonData, res, err in
                        if let data = jsonData {
                            do {
                                let trip = try JSONDecoder().decode(Trip.self, from: data)
                                DispatchQueue.main.sync(execute: {
                                    self.trips.append(trip)
//                                    completionHandler(true, "")
                                })
                            } catch {
                                print(error)
                            }
                            
                        }
                    }.resume()
                }
        
    }
    
    func update(trip: Trip) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Trips")
        let predicate = NSPredicate(format: "id == %@", trip.id.uuidString)
        request.predicate = predicate
        let fetchTrip = try! appDelegate.persistentContainer.viewContext.fetch(request)
        let object = fetchTrip[0] as! NSManagedObject
        
        object.setValue(trip.id, forKey: "id")
        object.setValue(trip.country, forKey: "userID")
        object.setValue(trip.country, forKey: "country")
        object.setValue(trip.city, forKey: "city")
        object.setValue(trip.arrdate, forKey: "arrDate")
        object.setValue(trip.depdate, forKey: "depDate")
        object.setValue(trip.code, forKey: "code")
        object.setValue(trip.remark, forKey: "remark")
        object.setValue(trip.lastupdate, forKey: "lastUpdate")
        object.setValue(trip.tripgrpkey, forKey: "tripGrpKey")
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
            // completionHandler(true, "Successful")
            if let row = self.trips.firstIndex(where: { $0.id == trip.id }) {
                self.trips.remove(at: row)
                self.trips.append(trip)
            }
            print("Successfuly Updated to core Data")
        }catch {
            debugPrint("Tony: Could not save \(error.localizedDescription)")
            // completionHandler(false, "Successful")
        }
        
        
    }
    
    func deleteAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trips")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try appDelegate.persistentContainer.viewContext.execute(batchDeleteRequest)
        }
        catch {
            print(error)
        }
        
//        if let uri = URL(string: URL_TRIPS_API_END_POINT + "/" + tripID){
//            var request = URLRequest(url: uri)
//            request.httpMethod = "DELETE"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            session.dataTask(with: request) { jsonData, res, err in
//                if let data = jsonData {
//
//                    do {
//                        let decoded = try JSONDecoder().decode(ServerMessage.self, from: data)
//                        print(decoded)
//                    } catch {
//                        print(error)
//                    }
//
//                    if let message = try? JSONDecoder().decode(ServerMessage.self, from: data){
//                        DispatchQueue.main.sync(execute: {
//                            if (message.message.contains("successfully")) {
//                                if let row = self.trips.firstIndex(where: {$0.tripID == self._tripID})  {
//                                    self.trips.remove(at: row )
//                                    completionHandler(true, "")
//                                }
//                            }
//                        })
//                    }
//                }
//            }.resume()
//        }


      }
    
    func remove(id: UUID)  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trips")
        let predicate = NSPredicate(format: "id == %@", id.uuidString)
        fetchRequest.predicate = predicate
        let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try
                appDelegate.persistentContainer.viewContext.execute(request)
            if let row = self.trips.firstIndex(where: { $0.id == id }) {
                self.trips.remove(at: row)
            }
        }
        catch{
            
        }
    }

}


final class LocationStore: ObservableObject {
    @Published var list : [LocationModel] = []
    @Published var keyword: String = ""
    init() {
        self.list = [
            LocationModel.init(city: "Moscow", lat: 0.01, lng: 0.1, country: "Russia", iso2: "RU", iso3: "RUS", id: 001),
            LocationModel.init(city: "New York", lat: 0.01, lng: 0.1, country: "USA", iso2: "US", iso3: "USA", id: 002),
            LocationModel.init(city: "London", lat: 0.01, lng: 0.1, country: "UK", iso2: "GB", iso3: "GB", id: 003),
            LocationModel.init(city: "Munchen", lat: 0.01, lng: 0.1, country: "Germany", iso2: "GM", iso3: "GRM", id: 004),
            LocationModel.init(city: "Moscow", lat: 0.01, lng: 0.1, country: "Russia", iso2: "RU", iso3: "RUS", id: 006),
            LocationModel.init(city: "New York", lat: 0.01, lng: 0.1, country: "USA", iso2: "US", iso3: "USA", id: 007),
            LocationModel.init(city: "London", lat: 0.01, lng: 0.1, country: "UK", iso2: "GB", iso3: "GB", id: 008),
            LocationModel.init(city: "Munchen", lat: 0.01, lng: 0.1, country: "Germany", iso2: "GM", iso3: "GRM", id: 009),
        ]
    }
}
