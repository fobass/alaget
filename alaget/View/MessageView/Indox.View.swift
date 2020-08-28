//
//  Indox.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 20/08/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct Inbox_View: View {
    var secondUser = User.init(name: "Test", avatar: "person", isCurrentUser: true)
    @State var isPresented: Bool = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var store = InboxStore()
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(store.list) { item in
//                    NavigationLink(destination: Inbox_Detail_View()) {
                    VStack{
                    Button(action: {
                        self.isPresented = true
                    }, label: {
                        VStack{
                            HStack{
                                WebImage(url: URL(string: item.avatar))
                                    .resizable()
                                    .frame(width: 55, height: 55, alignment: .center)
                                    .clipShape(Circle())
                                VStack(alignment: .leading) {
                                    HStack{
                                    Text(item.name)
                                        .font(.footnote)
                                        .fontWeight(.black)
                                        .foregroundColor(Color.gray.opacity(0.9))
                                        .lineLimit(1)
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            Text("12/12/12")
                                                .font(.footnote)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.gray.opacity(0.6))
                                                .lineLimit(0)
                                                Image(systemName: "chevron.right")
                                                    .resizable()
                                                    .frame(width: 6, height: 12, alignment: .leading)
                                                    .foregroundColor(Color.blue.opacity(0.6))
                                                    .font(.custom("TrebuchetMS-Bold", size: 12))
                                        }
                                        
                                    }
                                    Spacer()
                                    HStack{
                                        Image(systemName: "checkmark.circle.fill")
                                            .resizable()
                                            .frame(width: 12, height: 12, alignment: .leading)
                                            .foregroundColor(Color.blue)
                                            .opacity((item.isReaded) ? 0.7 : 0)
                                            .font(.custom("ArialRoundedMTBold", size: 12))
                                        Text(item.lastText)
                                            .font(.footnote)
    //                                        .fontWeight(.bold)
                                            .foregroundColor(Color.gray.opacity(0.9))
                                            .lineLimit(2)
                                        
                                    }
                                    Spacer()
                                    
                                }
                                Spacer()
                            }
                            
                            .background(Color.backgroundColor(for: self.colorScheme))
                            .padding([.trailing, .leading], 20)
                            .padding([.top], 5)
                            .padding([.bottom], 10)
                        }
                    })
                    
                    }
                    .fullScreenCover(isPresented: $isPresented){
                        Inbox_Detail_View(dialogScreen: false).environmentObject(ChatHelper())
                    
                    }
//                    }
                    
                    .buttonStyle(PlainButtonStyle())
                    Divider()
                        .padding([.trailing, .leading], 20)
                }
                
                .padding([.top], 20)
            }
            .navigationBarTitle("Inbox", displayMode: .large)
        }
        
        
    }
}

struct Indox_View_Previews: PreviewProvider {
    static var previews: some View {
        Inbox_View()
    }
}
