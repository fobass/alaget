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
    @Published var selectedItem: Explorer = Explorer.init(country: "", city: "", date: "", isToday: false, members: [
        Member.init(name: "", remark: "", isVerified: true, distance: 0.0, avatar: "", flyDate: "")
    ])
    
    init() {
        self.list = [
            Explorer.init(country: "Russia", city: "Moscow", date: "September, 21", isToday: true, members: [
                Member.init(name: "Boris", remark: "lskdfjg;l dflkgds fbs;djfkgnsd b;skdfjbds'of b'sdflj", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
                Member.init(name: "Mechel", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
                Member.init(name: "Boris", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg",flyDate: "Today"),
                Member.init(name: "Mechel", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg",flyDate: "Today"),
                Member.init(name: "Julia", remark: "", isVerified: true, distance: 4.0, avatar: "",flyDate: "Today"),
            ]),

            Explorer.init(country: "China", city: "Bejin", date: "Augst, 01", isToday: false, members: [
                Member.init(name: "Low Chan", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
                Member.init(name: "Yun Gau", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
                Member.init(name: "Max Lau", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
            ]),
            Explorer.init(country: "Germany", city: "Berlin", date: "Augst, 01", isToday: false, members: [
                Member.init(name: "Low Chan", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
                Member.init(name: "Yun Gau", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
                Member.init(name: "Max Lau", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
                Member.init(name: "Low Chan", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
                Member.init(name: "Yun Gau", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
                Member.init(name: "Max Lau", remark: "", isVerified: true, distance: 4.0, avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", flyDate: "Today"),
            ]),
        ]
    }
    
}
