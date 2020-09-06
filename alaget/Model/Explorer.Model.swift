//
//  Explorer.Model.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import Foundation



// MARK: - Element
struct Explorer: Identifiable, Codable, Equatable {
    static func == (lhs: Explorer, rhs: Explorer) -> Bool {
        return lhs.id == rhs.id && rhs.id == lhs.id
    }
    
    let id: Int
    let country, city, code, depdate: String
    let tripgrpkey: String
    let flyings: [Flying]
    
    var displayDate: String {
        get {
            
            let today = Calendar.current.isDateInToday(StrToDate(str: self.depdate))
            if today {
                return "Today"
            } else {
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateFormat = "MMM dd"
                return formatter.string(from: StrToDate(str: self.depdate))
            }
        }
    }
    
    var isToday: Bool{
        get {
            return (Calendar.current.isDateInToday(StrToDate(str: self.depdate)) ? true : false)
        }
    }
}

// MARK: - Flying
struct Flying: Identifiable, Codable, Equatable, Hashable {
    static func == (lhs: Flying, rhs: Flying) -> Bool {
        return lhs.id == rhs.id && rhs.id == lhs.id
    }
    
    let uuid, firstName: String
    let photoURL: String
    let distance: Double
    let id, remark: String
    let isVerified: Int
    
    var displayDistance : String {
        get {
            if distance > 0 {
                return String(format: "%.1f", distance) + "km"
            } else {
                return ""
            }
        }
    }
}


struct FlyingProfile {
    var uuid: String
    var firstName, lastName, pwd: String
    var gender: Int
    var phoneNumber, email: String
    var dateOfBirth: String
    var photoURL: String
    var emergencyContact: Int
    var isActive, isVerified: Bool
    var verifiedDocID: Int
    var about: String
    var dateJoined: String
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

extension FlyingProfile: Codable {
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

struct FlyingTrip: Identifiable, Equatable, Codable {
    var id = UUID()
    var uuid  : String
    var country : String
    var city    : String
    var code    : String
    var depdate : String
    var arrdate : String
    var remark  : String
    var lastupdate : String
    var tripgrpkey: String
    
    var display : String {
        get {
            if (code != "" && city != "") {
                return code.uppercased() + ", " + city.uppercased()
            } else {
                return ""
            }
        }
    }
    
    var isToday: Bool{
        get {
            return (Calendar.current.isDateInToday(StrToDate(str: self.depdate)) ? true : false)
        }
    }
    
    var displayDate: String {
        get {
            
            let today = Calendar.current.isDateInToday(StrToDate(str: self.depdate))
            if today {
                return "Today"
            } else {
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateFormat = "MMM dd"
                return formatter.string(from: StrToDate(str: self.depdate))
            }
        }
    }
    
    
}

