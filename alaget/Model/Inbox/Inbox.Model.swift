//
//  Inbox.Model.swift
//  alaget
//
//  Created by Ernist Isabekov on 20/08/2020.
//

import Foundation

struct Inbox: Identifiable {
    var id = UUID()
    var avatar: String
    var name: String
    var lastText: String
    var isReaded: Bool
}
