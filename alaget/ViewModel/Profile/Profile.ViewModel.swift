//
//  Profile.ViewModel.swift
//  alaget
//
//  Created by Ernist Isabekov on 17/08/2020.
//

import Foundation
import Combine

final class ProfileStore: ObservableObject {
    @Published var profile : Profile?
    
    init() {
        profile = Profile.init(uuid: "123", firstName: "Ernist", lastName: "Isabekov", pwd: "", gender: 1, phoneNumber: "06172334800", dateOfBirth: "June 18, 1988", email: "isabekove@gamil.com", photoURL: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", emergencyContact: 1, isActive: true, isVerified: true, verifiedDocID: 1, about: "Blogger", dateJoined: "Sep, 2020", score: 4, lat: 0.0, lon: 0.0, commentsID: 1)
    }
}
