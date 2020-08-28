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

class ChatHelper : ObservableObject {
//    var didChange = PassthroughSubject<Void, Never>()
    @Published var realTimeMessages : [Message] = []
    
    func sendMessage(_ chatMessage: Message) {
        realTimeMessages.append(chatMessage)
//        didChange.send(())
    }
    
//    init() {
//        self.realTimeMessages = [
//            Message.init(content: "FASdSADs", user: User.init(name: "Test", avatar: "person", isCurrentUser: false)),
//            Message.init(content: "FASdSADaq", user: User.init(name: "Test", avatar: "person", isCurrentUser: false)),
//            Message.init(content: "FASdSADq", user: User.init(name: "Test", avatar: "person", isCurrentUser: true)),
//
//        ]
//    }
}


class ScrollToModel: ObservableObject {
    enum Action {
        case end
        case top
    }
    @Published var direction: Action? = nil
}

