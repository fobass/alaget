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
    @Published var trips: [Trip] = []
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Published var selectedItem: Trip?
    @Published var isChaged: Bool = false
    init() {
        self.trips = [
            Trip.init(userID: "asd", country: "asd", city: "asd", code: "sdf", remark: "sdf", lastUpdate: "wqe", image: "asd", lat: 0, lon: 0, distance: 0, tripGrpKey: "asd"),
            Trip.init(userID: "asd", country: "asd", city: "asd", code: "sdf", remark: "sdf", lastUpdate: "wqe", image: "asd", lat: 0, lon: 0, distance: 0, tripGrpKey: "asd")
        ]
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
                    let image = (item as AnyObject).image!! as String
                    let arrDate = (item as AnyObject).arrDate!! as Date
                    let depDate = (item as AnyObject).depDate!! as Date
                    let distance = (item as AnyObject).distance! as Double
                    let lat = (item as AnyObject).distance! as Double
                    let lon = (item as AnyObject).distance! as Double
                    let tripGrpKey = (item as AnyObject).tripGrpKey!! as String
                    
                    let trip = Trip.init(id: id, userID: userID, country: country, city: city, code: code, depDate: depDate, arrDate: arrDate, remark: remark, lastUpdate: lastupd, image: image, lat: lat, lon: lon, distance: distance, tripGrpKey: tripGrpKey)
                    
                    self.trips.append(trip)
                }
            }
        }
    }
    func insert(trip: Trip) {
        let table = Trips(context: appDelegate.persistentContainer.viewContext)
        table.id   = trip.id
        table.userID  = "trip.userID"
        table.country = trip.country
        table.city    = trip.city
        table.code    = trip.code
        table.remark  = trip.remark
        table.image   = trip.image
        table.arrDate = trip.arrDate
        table.depDate = trip.depDate
        table.distance = trip.distance
        table.lastUpdate = trip.lastUpdate
        table.lat = trip.lat
        table.lon = trip.lon
        table.tripGrpKey = trip.tripGrpKey
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
            // completionHandler(true, "Successful")
            self.trips.append(trip)
            print("Successfuly Saved to core Data")
        }catch {
            debugPrint("Tony: Could not save \(error.localizedDescription)")
            // completionHandler(false, "Successful")
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
        object.setValue(trip.arrDate, forKey: "arrDate")
        object.setValue(trip.depDate, forKey: "depDate")
        object.setValue(trip.code, forKey: "code")
        object.setValue(trip.remark, forKey: "remark")
        object.setValue(trip.lastUpdate, forKey: "lastUpdate")
        object.setValue(trip.image, forKey: "image")
        object.setValue(trip.distance, forKey: "distance")
        object.setValue(trip.lat, forKey: "lat")
        object.setValue(trip.lon, forKey: "lon")
        object.setValue(trip.tripGrpKey, forKey: "tripGrpKey")
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
            // completionHandler(true, "Successful")
            if let row = self.trips.firstIndex(where: { $0.id == trip.id }) {
                self.trips.remove(at: row)
                self.trips.append(trip)
            }
            //                  update(trip: trip)
            print("Successfuly Updated to core Data")
        }catch {
            debugPrint("Tony: Could not save \(error.localizedDescription)")
            // completionHandler(false, "Successful")
        }
        
        
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
