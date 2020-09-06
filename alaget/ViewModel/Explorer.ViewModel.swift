//
//  Explorer.ViewModel.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import Foundation
import Combine

final class ExplorerStore: ObservableObject {
    @Published var list: [Explorer] = []
    @Published var flyingProfile: FlyingProfile?
    @Published var flyingProfileTrips: [FlyingTrip] = []
    @Published var isProfileLoaded: Bool = false
    @Published var isTripsLoaded: Bool = false
    @Published var isLoaded: Bool = false
    @Published var selectedItem: Explorer?
    @Published var isToday : Bool = false
    @Published var isUpcoming : Bool = false
    var lastSelection : String = ""
    
    let session: URLSession = {
         let configuration = URLSessionConfiguration.default
         configuration.timeoutIntervalForRequest = TimeInterval(7)
         configuration.timeoutIntervalForResource = TimeInterval(7)
         return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
     }()
    
    
    func getTodayTrip(tripid: String) -> FlyingTrip {
        if let row = flyingProfileTrips.firstIndex(where: { $0.id.uuidString == tripid }) {
            if (flyingProfileTrips[row].isToday) {
                return flyingProfileTrips[row]
            } else {
                let flyingTrip : FlyingTrip = flyingProfileTrips.filter({ $0.isToday })[0]
                return flyingTrip
            }
        } else {
            let flyingTrip : FlyingTrip = flyingProfileTrips.filter({ $0.isToday })[0]
            return flyingTrip
        }
    }
    
    func isTodayTrip(tripid: String) -> Bool {
        if let row = flyingProfileTrips.firstIndex(where: { $0.id.uuidString == tripid }) {
            if (flyingProfileTrips[row].isToday) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func fetch() {
        if let url = URL(string: URL_API_END_POINT){
            var request = URLRequest(url: url)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: MY_LOCATION, options: .prettyPrinted)
                request.httpBody = jsonData
                request.httpMethod = "POST"
                print(jsonData)
            } catch let e {
                print(e)
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            session.dataTask(with: request) { jsonData, response, error in
                if let data = jsonData {
                    do {
                        let list = try JSONDecoder().decode([Explorer].self, from: data)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.list.append(contentsOf: list)
                            self.isToday = (list.filter({ $0.isToday }).count > 0)
                            self.isUpcoming = (list.filter({ !$0.isToday }).count > 0)
                            self.isLoaded = true
                        }
                        
                    } catch let e {
                        print(e)
                    }

                } else {
                    if let _ = error {
                        self.fetch()
                    }
                    DispatchQueue.main.async {
//                        self.loading = false
                    }
                }
            }.resume()
            
        }
        
    }
    
    init() {
        fetch()
    }
    
    func fetchProfile(uuid: String) {
        if (self.lastSelection != uuid) {
            self.lastSelection = uuid
            if let url = URL(string: URL_PROFILE_API_END_POINT + "/" + uuid){
                isProfileLoaded = false
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                session.dataTask(with: request) { jsonData, response, error in
                    if let data = jsonData {
                        do {
                            let profile = try JSONDecoder().decode(FlyingProfile.self, from: data)
                            DispatchQueue.main.async {
                                self.flyingProfile = FlyingProfile.init(uuid: profile.uuid, firstName: profile.firstName, lastName: profile.lastName, pwd: "", gender: profile.gender, phoneNumber: profile.phoneNumber, email: profile.email, dateOfBirth: profile.dateOfBirth, photoURL: profile.photoURL, emergencyContact: profile.emergencyContact, isActive: profile.isActive, isVerified: profile.isVerified, verifiedDocID: profile.verifiedDocID, about: profile.about, dateJoined: profile.dateJoined, score: profile.score, lat: profile.lat, lon: profile.lon, commentsID: profile.commentsID)
                                self.isProfileLoaded = true
                            }
                            
                        } catch let e {
                            print(e)
                        }
                        
                    } else {
                        if let _ = error {
                            //                        self.fetch()
                        }
                        DispatchQueue.main.async {
                            //                        self.loading = false
                        }
                    }
                }.resume()
            }
            
            
            
            if let uri = URL(string: URL_TRIPS_API_END_POINT + "/" + uuid){
                isTripsLoaded = false
                self.flyingProfileTrips.removeAll()
                var request = URLRequest(url: uri)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                session.dataTask(with: request) { jsonData, res, err in
                    if let data = jsonData {
                        do {
                            let trips = try JSONDecoder().decode([FlyingTrip].self, from: data)
                            DispatchQueue.main.sync(execute: {
                                
                                self.flyingProfileTrips.append(contentsOf: trips)
                                self.isTripsLoaded = true
                            })
                            
                        } catch let e {
                            print(e)
                        }
                        
                        
                    }
                }.resume()
            }
            
        }
    }
    
    func fetchTrips(uuid: String) {
        if (self.lastSelection != uuid) {
            self.lastSelection = uuid
            if let uri = URL(string: URL_TRIPS_API_END_POINT + "/" + uuid){
                isTripsLoaded = false
                var request = URLRequest(url: uri)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                session.dataTask(with: request) { jsonData, res, err in
                    if let data = jsonData {
                        do {
                            let trips = try JSONDecoder().decode([FlyingTrip].self, from: data)
                            DispatchQueue.main.sync(execute: {
                                self.flyingProfileTrips.removeAll()
                                self.flyingProfileTrips.append(contentsOf: trips)
                                self.isTripsLoaded = true
                            })
                            
                        } catch let e {
                            print(e)
                        }
                        
                        
                    }
                }.resume()
            }
        }
    }
    
}
