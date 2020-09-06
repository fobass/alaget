//
//  Profile.ViewModel.swift
//  alaget
//
//  Created by Ernist Isabekov on 17/08/2020.
//

import Foundation
import Combine
import CoreData
import SwiftUI

enum AuthType {
    case facebook
    case google
    case apple
    case none
}

final class SettingsStore: ObservableObject {
    @Published var profile : Profile = Profile.init(uuid: "", firstName: "", lastName: "", pwd: "", gender: 0, phoneNumber: "", email: "", dateOfBirth: Date(), photoURL: "", emergencyContact: 0, isActive: true, isVerified: true, verifiedDocID: 0, about: "", dateJoined: Date(), score: 0, lat: 0, lon: 0, commentsID: 0)
    @Published var isLogin: Bool = false
    @Published var Session : String?
    @Published var authType : AuthType = .none
    @Published var settings: [Setting] = []
    @Published var progressFill: Float = 0.0
    @Published var isChaged: Bool = false
    @Published var IsEnabledLocation: Bool = false
    
    let defaults = UserDefaults.standard
    
    init() {
//        remove()
//        logout()
        self.IsEnabledLocation = (CLLocationManager.locationServicesEnabled()) && (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() ==  .authorizedAlways)
        self.settings = [
            Setting.init(title: "Notifications", icon: "bell", type: 0),
            Setting.init(title: "Get help", icon: "questionmark.square", type: 3),
            Setting.init(title: "Give us feedback", icon: "equal.square", type: 4),
            Setting.init(title: "Privacy settings", icon: "doc.text", type: 5)
        ]
        self.isLogin = defaults.bool(forKey: "isLogin")
        if (isLogin) {
            load()
        }
    }
    
    func logout()  {
        self.isLogin = false
        defaults.setValue(false, forKey: "isLogin")
    }
    
    func login()  {
        self.isLogin = true
        defaults.setValue(true, forKey: "isLogin")
    }
    
    private func progressDocCheck(profile: Profile){
           progressFill = 0.1
           if (profile.about != "") {
               progressFill += 0.1
           }
//           if (profile.dateOfBirth != "") {
//               progressFill += 0.1
//           }
           if (profile.email != "") {
               progressFill += 0.1
           }
           if (profile.emergencyContact != -1) {
               progressFill += 0.1
           }
           if (profile.firstName != "") {
               progressFill += 0.1
           }
           if (profile.lastName != "") {
               progressFill += 0.1
           }
           if (profile.gender > 0) {
               progressFill += 0.1
           }
           if (profile.isVerified) {
               progressFill += 0.1
           }
           if (profile.phoneNumber != "") {
               progressFill += 0.1
           }
           if (profile.photoURL != "") {
               progressFill += 0.1
           }
       }
    
    func load(){
        self.profile.uuid = defaults.string(forKey: "uuid")!
        self.profile.firstName = defaults.string(forKey: "firstName")!
        self.profile.lastName = defaults.string(forKey: "lastName")!
        self.profile.gender = defaults.integer(forKey: "gender")
        self.profile.phoneNumber = defaults.string(forKey: "phoneNumber")!
        self.profile.dateOfBirth = defaults.object(forKey: "dateOfBirth")! as! Date
        self.profile.email = defaults.string(forKey: "email")!
        self.profile.photoURL = defaults.string(forKey: "photoURL")!
        self.profile.emergencyContact = defaults.integer(forKey: "emergencyContact")
        self.profile.isActive = defaults.bool(forKey: "isActive")
        self.profile.isVerified = defaults.bool(forKey: "isVerified")
        self.profile.verifiedDocID = defaults.integer(forKey: "verifiedDocID")
        self.profile.about = defaults.string(forKey: "about")!
        self.profile.dateJoined = defaults.object(forKey: "dateJoined")! as! Date
        self.profile.score = defaults.integer(forKey: "score")
        self.profile.lat = defaults.double(forKey: "lat")
        self.profile.lon = defaults.double(forKey: "lon")
        self.profile.commentsID = defaults.integer(forKey: "commentsID")

        self.progressDocCheck(profile: self.profile)
        
    }
    
    func remove() {
        defaults.removeObject(forKey: "uuid")
        defaults.removeObject(forKey: "firstName")
        defaults.removeObject(forKey: "lastName")
        defaults.removeObject(forKey: "gender")
        defaults.removeObject(forKey: "phoneNumber")
        defaults.removeObject(forKey: "dateOfBirth")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "photoURL")
        defaults.removeObject(forKey: "emergencyContact")
        defaults.removeObject(forKey: "isActive")
        defaults.removeObject(forKey: "isVerified")
        defaults.removeObject(forKey: "verifiedDocID")
        defaults.removeObject(forKey: "about")
        defaults.removeObject(forKey: "dateJoined")
        defaults.removeObject(forKey: "score")
        defaults.removeObject(forKey: "lat")
        defaults.removeObject(forKey: "lon")
        defaults.removeObject(forKey: "commentsID")
    }
    
    func update(profile: Profile, completionHandler: @escaping (Bool, String) -> ()){
        defaults.set(profile.uuid , forKey: "uuid")
        defaults.set(profile.firstName, forKey: "firstName")
        defaults.set(profile.lastName, forKey: "lastName")
        defaults.set(profile.gender, forKey: "gender")
        defaults.set(profile.phoneNumber, forKey: "phoneNumber")
        defaults.set(profile.dateOfBirth , forKey: "dateOfBirth")
        defaults.set(profile.email, forKey: "email")
        defaults.set(profile.photoURL, forKey: "photoURL")
        defaults.set(profile.emergencyContact, forKey: "emergencyContact")
        defaults.set(profile.isActive, forKey: "isActive")
        defaults.set(profile.isVerified , forKey: "isVerified")
        defaults.set(profile.verifiedDocID, forKey: "verifiedDocID")
        defaults.set(profile.about, forKey: "about")
        defaults.set(profile.dateJoined, forKey: "dateJoined")
        defaults.set(profile.score, forKey: "score")
        defaults.set(profile.lat, forKey: "lat")
        defaults.set(profile.lon, forKey: "lon")
        defaults.set(profile.commentsID, forKey: "commentsID")
    
        load()
        
//        completionHandler(true, "")
        
        
        
        
        let profileData: [String: Any] = ["uuid": profile.uuid, "firstName": profile.firstName, "lastName": profile.lastName, "pwd": "google_auth", "gender": profile.gender, "phoneNumber": profile.phoneNumber, "dateOfBirth": profile.dateOfBirth, "email": profile.email, "photoURL": profile.photoURL, "emergencyContact": profile.emergencyContact, "isActive": profile.isActive, "isVerified": profile.isVerified, "verifiedDocID": profile.verifiedDocID, "about": profile.about, "dateJoined": profile.dateJoined, "score": profile.score, "lat": (CLLocationManager().location?.coordinate.latitude ?? 0.0), "lon": (CLLocationManager().location?.coordinate.longitude ?? 0.0), "commentsID": profile.commentsID]

        if let uri = URL(string: URL_PROFILE_API_END_POINT + "/" + profile.uuid){
            var request = URLRequest(url: uri)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: profileData, options: .prettyPrinted)
                request.httpBody = jsonData
                request.httpMethod = "PUT"
                print(jsonData)
            } catch let e {
                print(e)
            }
            
            let session: URLSession = {
                 let configuration = URLSessionConfiguration.default
                 configuration.timeoutIntervalForRequest = TimeInterval(7)
                 configuration.timeoutIntervalForResource = TimeInterval(7)
                 return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
            }()
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            session.dataTask(with: request) { jsonData, res, err in
                if let data = jsonData {
                    if let _ = try? JSONDecoder().decode(Profile.self, from: data){
                        DispatchQueue.main.sync(execute: {
                            completionHandler(true, "")
                        })
                    }
                }
            }.resume()
        }
    }
    
    func insert(profile: Profile, completionHandler: @escaping (Bool, String) -> ()){
        defaults.set(profile.uuid , forKey: "uuid")
        defaults.set(profile.firstName, forKey: "firstName")
        defaults.set(profile.lastName, forKey: "lastName")
        defaults.set(profile.gender, forKey: "gender")
        defaults.set(profile.phoneNumber, forKey: "phoneNumber")
        defaults.set(profile.dateOfBirth , forKey: "dateOfBirth")
        defaults.set(profile.email, forKey: "email")
        defaults.set(profile.photoURL, forKey: "photoURL")
        defaults.set(profile.emergencyContact, forKey: "emergencyContact")
        defaults.set(profile.isActive, forKey: "isActive")
        defaults.set(profile.isVerified , forKey: "isVerified")
        defaults.set(profile.verifiedDocID, forKey: "verifiedDocID")
        defaults.set(profile.about, forKey: "about")
        defaults.set(profile.dateJoined, forKey: "dateJoined")
        defaults.set(profile.score, forKey: "score")
        defaults.set(profile.lat, forKey: "lat")
        defaults.set(profile.lon, forKey: "lon")
        defaults.set(profile.commentsID, forKey: "commentsID")
        
        defaults.setValue(true, forKey: "isLogin")
        load()
        
        
        let profileData: [String: Any] = ["uuid": profile.uuid, "firstName": profile.firstName, "lastName": profile.lastName, "pwd": "google_auth", "gender": profile.gender, "phoneNumber": profile.phoneNumber, "dateOfBirth": DateToStr(date: profile.dateOfBirth), "email": profile.email, "photoURL": profile.photoURL, "emergencyContact": profile.emergencyContact, "isActive": profile.isActive, "isVerified": profile.isVerified, "verifiedDocID": profile.verifiedDocID, "about": profile.about, "dateJoined": DateToStr(date: profile.dateJoined), "score": profile.score, "lat": (CLLocationManager().location?.coordinate.latitude ?? 0.0), "lon": (CLLocationManager().location?.coordinate.longitude ?? 0.0), "commentsID": profile.commentsID]
        
        if let uri = URL(string: URL_PROFILE_API_END_POINT){
            var request = URLRequest(url: uri)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: profileData, options: .prettyPrinted)
                request.httpBody = jsonData
                request.httpMethod = "POST"
                print(jsonData)
            } catch let e {
                print(e)
            }
            
            let session: URLSession = {
                 let configuration = URLSessionConfiguration.default
                 configuration.timeoutIntervalForRequest = TimeInterval(7)
                 configuration.timeoutIntervalForResource = TimeInterval(7)
                 return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
             }()

            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            session.dataTask(with: request) { jsonData, res, err in
                if let _ = jsonData {
//                    do {
                        DispatchQueue.main.sync(execute: {
                            completionHandler(true, "")
                        })
                        
//                        let decoded = try JSONDecoder().decode(Profile.self, from: data)
//                        print(decoded)
//                    } catch {
//                        print(error)
//                    }
//                    if let _ = try? JSONDecoder().decode(Profile.self, from: data){
//                        DispatchQueue.main.sync(execute: {
//                            completionHandler(true, "")
//                        })
//                    } else  {
//                        if let message = try? JSONDecoder().decode(ServerMessage.self, from: data){
//                            DispatchQueue.main.sync(execute: {
//                                if (message.message.contains("ER_DUP_ENTRY")) {
//                                    self.fetch(uuid: message.id, completionHandler: { success, message in
//                                        completionHandler(success, message)
//                                    })
//                                }
//                            })
//                        }
//                    }


                }
            }.resume()
        }
    }
}
