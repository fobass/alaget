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
    var body: some View {
        
        VStack{
            HStack{
                Button(action: {
                    withAnimation(Animation.linear.delay(2)) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.custom("ArialRoundedMTBold", size: 28))
                        .foregroundColor(Color.red.opacity(0.7))
                        .background(Color.white)
                        .clipShape(Circle())
                })
                Spacer()
            }
            .padding([.leading, .trailing], 20)
        
        TabView(selection: self.$selection){
            Explorer_View().tabItem {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
