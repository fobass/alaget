//
//  ContentView.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection : Int = 0
    
    var body: some View {
        
        TabView(selection: self.$selection){
            Departure_View()
            tabItem {
                Image(systemName: (selection == 0) ? "magnifyingglass" : "magnifyingglass")
                    .resizable()
                    .imageScale(.large)
                Text("EXPLOER")
            }
            .tag(0)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
