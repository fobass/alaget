//
//  Explorer.Model.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import Foundation

struct Member: Identifiable {
    var id = UUID()
    var name: String
    var remark: String
    var isVerified: Bool
    var distance: Double
    var avatar: String
    var flyDate: String
    var distanceVal: String {
        get {
            return (distance < 0.5) ? "0.5km" : String(format:"%.1f", distance) + "km"
        }
    }
}

struct Explorer: Identifiable {
    var id = UUID()
    var country: String
    var city : String
    var date: String
    var isToday: Bool
    var members: [Member]
}
