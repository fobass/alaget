//
//  Trip.Model.swift
//  alaget
//
//  Created by Ernist Isabekov on 29/08/2020.
//

import Foundation

struct Trip: Identifiable, Equatable, Codable {
    var id = UUID()
    var uuid  : String
    var country : String
    var city    : String
    var code    : String
    var depdate = Date()
    var arrdate = Date()
    var remark  : String
    var lastupdate : String
    var tripgrpkey: String
    
//    var displayDistance : String {
//        get {
//            if distance > 0 {
//                return String(format: "%.1f", distance) + "km"
//            } else {
//                return ""
//            }
//        }
//    }
    
    var display : String {
        get {
            if (code != "" && city != "") {
                return code.uppercased() + ", " + city.uppercased()
            } else {
                return ""
            }
        }
    }
    
    var depDateDisplay: String {
        get {
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateFormat = "MMM dd"
            return formatter.string(from: depdate)
        }
    }
    
    var depDisplay: String {
        get {
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateFormat = "MMMM dd, EEEE"
            return formatter.string(from: depdate)
        }
    }
    var depDateMYSQL: String {
        get {
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
            return formatter.string(from: depdate)
        }
    }
    
    var arrDateMYSQL: String {
        get {
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
            return formatter.string(from: arrdate)
        }
    }
    
    var getDateDisplay: String {
        get {
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateFormat = "EE, MMM d"
            return formatter.string(from: depdate)
        }
    }
    var getHourDisplay: String {
        get {
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateFormat = "EE, hh:mm a"
            return formatter.string(from: depdate)
        }
    }
    
}

//extension Trip: Codable {
//    enum CodingKeys: String, CodingKey {
//        case tripID
//        case userID
//        case country
//        case city
//        case code
//        case remark
//        case depDate
//        case arrDate
//        case lastUpdate
//        case image
//        case tripGrpKey
//        case isFlyToday
//        case lon
//        case lat
//    }
//}


struct LocationModel: Codable, Identifiable, Equatable{
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        return lhs.id == rhs.id && rhs.id == lhs.id
    }
    let city: String
    let lat, lng: Double
    let country, iso2, iso3: String
    let id: Int
    
    var display : String {
        get {
            return iso2.uppercased() + ", " + city.uppercased()
        }
    }
}
