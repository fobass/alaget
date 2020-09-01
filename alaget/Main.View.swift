//
//  ContentView.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//
// Swift
//
// Add this to the header of your file, e.g. in ViewController.swift

import SwiftUI

struct Main_View: View {
    @EnvironmentObject var auth : SettingsStore
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack{
            
            if (userStore.isLogin){
                
                if (!userStore.IsEnabledLocation) {
                    LocationView().environmentObject(userStore)
                        .animation(.easeInOut)
                        .transition(.move(edge: .top))
                } else {
                    ContentView()
                }
//                    .animation(.easeInOut)
//                    .transition(.move(edge: .trailing))
            } else {
                Login_View().environmentObject(auth)
                    .animation(.easeInOut)
                    .transition(.move(edge: .leading))
            }
        }
           
    }
}

struct Main_View_Previews: PreviewProvider {
    static var previews: some View {
        Main_View()
//                    .preferredColorScheme(.dark)
    }
}
