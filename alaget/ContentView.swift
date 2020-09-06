//
//  Explorer.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 0
    @Environment(\.presentationMode) var presentationMode
    
//    init() {
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().barTintColor = .white
//        UINavigationBar.appearance().backgroundColor = .white
//
//        UITableView.appearance().backgroundColor = .clear
//        UITableView.appearance().separatorStyle = .none
//        UITableView.appearance().separatorColor = .clear
//    }
    var body: some View {
        VStack{
            TabView(selection: self.$selection){
                Explorer_View().environmentObject(explorerStore)
                    .tabItem {
                    Image(systemName: (selection == 0) ? "magnifyingglass" : "magnifyingglass")
                        .resizable()
                        .imageScale(.large)
                    Text("DEPARTURES")
                }
                .tag(0)
                
                Inbox_View().tabItem {
                    Image(systemName: (selection == 0) ? "message" : "message")
                        .resizable()
                        .imageScale(.large)
                    Text("INDOX")
                }
                .tag(1)
                
                Trip_View().environmentObject(tripStore)
                    .tabItem {
                    Image(systemName: "globe")
                        .resizable()
                      .imageScale(.large)
                    Text("TREVEL LIST")
//                    Spacer()
                }
                .tag(2)
                
                Settings_View().environmentObject(userStore)
                    .tabItem {
                    Image(systemName: "gear")
                        .resizable()
                      .imageScale(.large)
                    Text("SETTINGS")
                }
                .tag(3)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
