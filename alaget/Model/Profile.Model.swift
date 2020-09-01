//
//  Profile.swift
//  alaget
//
//  Created by Ernist Isabekov on 17/08/2020.
//

import Foundation

struct Setting: Identifiable {
    var id = UUID()
    var title: String
    var icon : String
    var type : Int
}

struct Profile {
    var uuid: String
    var firstName, lastName, pwd: String
    var gender: Int
    var phoneNumber, email: String
    var dateOfBirth: Date
    var photoURL: String
    var emergencyContact: Int
    var isActive, isVerified: Bool
    var verifiedDocID: Int
    var about: String
    var dateJoined: Date
    var score: Int
    var lat, lon: Double
    var commentsID: Int
    
    var DisplayGreetingName : String {
        get {
            if (!firstName.isEmpty) {
                return "Hi I'm, " + self.firstName
            } else {
                return ""
            }
        }
    }

}

extension Profile: Codable {
    enum CodingKeys: String, CodingKey {
        case uuid, firstName, lastName, pwd
        case gender, phoneNumber, dateOfBirth, email
        case photoURL
        case emergencyContact, isActive, isVerified, verifiedDocID
        case about, dateJoined
        case score
        case lat, lon
        case commentsID
    }
}
