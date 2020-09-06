//
//  env.swift
//  alaget
//
//  Created by Ernist Isabekov on 24/08/2020.
//

import Foundation

var URL_API_END_POINT = "http://192.168.0.106:3000/api/explorer"
var URL_PROFILE_API_END_POINT = "http://192.168.0.106:3000/api/profile"
var URL_TRIPS_API_END_POINT = "http://192.168.0.106:3000/api/trip"
var MY_LOCATION: [String: Any] = [
    "lat": "48.803246",
    "lon": "2.359815",
    "uuid": "222",
    "dist": "125"
]
var userStore = SettingsStore()
var explorerStore = ExplorerStore()
var tripStore = TripStore()
