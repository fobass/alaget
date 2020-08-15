//
//  Explorer.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI

struct Explorer_View: View {
    @State var selection: Int = 0
    var body: some View {
        TabView(selection: self.$selection){
            Departure_View().tabItem {
                Image(systemName: (selection == 0) ? "magnifyingglass" : "magnifyingglass")
                    .resizable()
                    .imageScale(.large)
                Text("EXPLOER")
            }
            .tag(0)
            
            Indox_View().tabItem {
                Image(systemName: (selection == 0) ? "message" : "message")
                    .resizable()
                    .imageScale(.large)
                Text("EXPLOER")
            }
            .tag(0)
        }
    }
}

struct Explorer_View_Previews: PreviewProvider {
    static var previews: some View {
        Explorer_View()
    }
}
