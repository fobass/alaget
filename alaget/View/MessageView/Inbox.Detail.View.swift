//
//  Inbox.Detail.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 20/08/2020.
//

import SwiftUI

struct ContentMessageView: View {
    var contentMessage: String
    var isCurrentUser: Bool
    var body: some View {
        VStack{
            HStack{
                Text(contentMessage)
                    .foregroundColor(isCurrentUser ? Color.white : Color.black)
            }
            .padding(8)
            .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
            
            .cornerRadius(10)
        }
    }
}

struct MessageView: View {
    var currentMessage: Message
    var body: some View{
        HStack() {
            if !currentMessage.user.isCurrentUser {
                ContentMessageView(contentMessage: currentMessage.content,
                                   isCurrentUser: currentMessage.user.isCurrentUser)
                Spacer()
            } else {
                Spacer()
                ContentMessageView(contentMessage: currentMessage.content,
                                   isCurrentUser: currentMessage.user.isCurrentUser)
            }
        }
        .padding([.leading,.trailing], 15)
    }
}

struct Inbox_Detail_View: View {
    var dialogScreen : Bool
    var secondUser = User.init(name: "Test", avatar: "person", isCurrentUser: true)
    @State var typingMessage: String = ""
    @State var moveTo: Int = 0
    @EnvironmentObject var chatHelper: ChatHelper
    @ObservedObject private var keyboard = KeyboardResponder()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject var vm = ScrollToModel()
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                if (dialogScreen) {
                    HStack{
                        Button(action: {
                        }, label: {
                            HStack{
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 35, height: 35, alignment: .center)
                                
                                Text("item.name")
                                    .font(.footnote)
                                    .fontWeight(.black)
                                    .foregroundColor(Color.gray.opacity(0.9))
                                    .lineLimit(1)
                            }
                        })
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .font(.custom("ArialRoundedMTBold", size: 30))
                                .foregroundColor(Color.red.opacity(0.7))
                            
                        })
                    }
                    .background(Color.itemBackgroundColor(for: self.colorScheme))
                    .padding([.trailing, .leading], 20)
                    .padding([.top], 10)
                    .padding(.bottom, 0)
                } else {
                    Button(action: {
                        withAnimation(Animation.linear.delay(2)) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Image(systemName: ( dialogScreen ? "xmark.circle" : "chevron.left"))
                            .font(.custom("ArialRoundedMTBold", size: 14))
                            .padding(.all, 19)
                            .foregroundColor(Color.black)
                            //                        .background(Color.red)
                            .clipShape(Circle())
                    })
                    
                    Button(action: {
                        self.isPresented = true
                    }, label: {
                        HStack{
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                            
                            Text("item.name")
                                .font(.footnote)
                                .fontWeight(.black)
                                .foregroundColor(Color.gray.opacity(0.9))
                                .lineLimit(1)
                        }
                    })
                    Spacer()
                }
                
            }
            VStack {
                ScrollView {
                    ScrollViewReader { scrollProxy in
                        LazyVStack {
                            Text("08:05pm")
                                .font(.custom("TrebuchetMS", size: 10))
                            ForEach(chatHelper.realTimeMessages, id: \.self) { msg in
                                MessageView(currentMessage: msg)
                                    .padding([.top,.bottom], 5)
//                                    .background(Color.red)
                            }
                        }
                        .onReceive(vm.$direction) { action in
                            guard !chatHelper.realTimeMessages.isEmpty else { return }
                            withAnimation {
                                switch action {
                                    case .top:
                                        scrollProxy.scrollTo(chatHelper.realTimeMessages.first!, anchor: .top)
                                    case .end:
                                        scrollProxy.scrollTo(chatHelper.realTimeMessages.last!, anchor: .bottom)
                                    default:
                                        return
                                }
                            }
                        }
                    }
                    
                }
                
                HStack {
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    Button(action: {
                        self.sendMessage()
//                        withAnimation {
                            vm.direction = .end
//                        }
                    }) {
                        Text("Send")
                        
                    }
                    .disabled(self.typingMessage.isEmpty)
                }
                .frame(minHeight: CGFloat(10))
                .padding([.top,.bottom], 5)
                .padding([.leading,.trailing], 10)
            }
            .navigationBarHidden(true)
            .padding(.bottom, keyboard.currentHeight)
            .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
        }.onTapGesture {
            self.endEditing(true)
        }
        
        .sheet(isPresented: $isPresented) {
            Explorer_Detail_View(uuid: "rrrr", tripid: "d", dialogScreen: true)
        }
        
    }
    func sendMessage() {
        chatHelper.sendMessage(Message(content: typingMessage, user: secondUser))
        typingMessage = ""
    }
}



struct Inbox_Detail_View_Previews: PreviewProvider {
    
    static var previews: some View {
        Inbox_Detail_View(dialogScreen: true).environmentObject(ChatHelper())
    }
}
