//
//  Inbox.ViewModel.swift
//  alaget
//
//  Created by Ernist Isabekov on 20/08/2020.
//

import Foundation
import Combine

final class InboxStore: ObservableObject{
    @Published var list : [Inbox] = []
    
    init() {
        self.list = [
            Inbox.init(avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", name: "Jhon", lastText: "Hisdfsdf sdfnb", isReaded: true),
            Inbox.init(avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", name: "Jessica", lastText: "Hihi hyset dfjgh sldkjfg sdfkljgsdlfg lskdjfgsldkjfgnsdkfjg sldkfjgsdlkjfgs lsdkjfghsldkjfg skdjfgsd fssdlfkg sfg", isReaded: true),
            Inbox.init(avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", name: "Lucas", lastText: "Ysasd sdf erie", isReaded: true),
            Inbox.init(avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", name: "Jhon", lastText: "Hisdfsdf sdfnb", isReaded: true),
            Inbox.init(avatar: "https://lh5.googleusercontent.com/-Hf39m3vuIQ0/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck_EkXVt6V-vwY6XZiSsguK7MCb_A/photo.jpg", name: "Jhon", lastText: "Hisdfsdf sdfnb", isReaded: true),
        ]
    }
}
