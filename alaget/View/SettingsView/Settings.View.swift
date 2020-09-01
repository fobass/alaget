//
//  Profile.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 24/08/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.yellow)
                    .animation(.linear)
            }
        }
    }
}

struct Settings_View: View {
    @State private var acActiive = true
    @EnvironmentObject var store : SettingsStore
    var body: some View {
        NavigationView{
            Form {
                Section {
                    NavigationLink(destination: Profile_View(title: "Edit personal info", profile: self.store.profile).environmentObject(store)){
                        VStack{
//                            if (store.progressFill > 1) {
//                                Spacer()
//                            }
                            HStack{
                                WebImage(url: URL(string: self.store.profile.photoURL))
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .clipShape(Circle())
                                  //  .scaledToFill()
                                    .overlay(Circle().stroke(Color.red.opacity(0.1), lineWidth: 0.5))
                                VStack(alignment: .leading, spacing: 5){
                                    Text(self.store.profile.firstName)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black.opacity(0.7))
                                        .lineLimit(1)
//                                    HStack{
//                                        Image(systemName:"mappin.circle")
//                                            .resizable()
//                                            .frame(width: 16, height: 16)
//                                            .foregroundColor(Color.blue.opacity(0.5))
//                                            .font(.subheadline)
                                        
//                                        Text("self.store.location")
//                                            .fontWeight(.bold)
//                                            .font(.subheadline)
//                                            .foregroundColor(Color.blue.opacity(0.5))
//                                    }
                                }
                                Spacer()
                            }
//                            if (store.progressFill < 1) {
//                                ProgressBar(value: $store.progressFill).frame(height: 5)
//                            }
                        }
//                        .padding([.top,.bottom], (store.progressFill > 1) ? 0 : 5)
                        
                    }
                    //
                    //                }
                    //                .onAppear(){
                    //                    self.user.loadUserData()
                }
                
                Section{
                    ForEach(store.settings) { item in
                        if (item.type == 1){
                            Toggle(isOn: self.$acActiive) {
                                HStack {
                                    Image(systemName: item.icon)
                                        .font(Font.system(size: 22, weight: .light))
                                    Text(item.title)
                                        .font(.system(size: 16))
                                }
                                .padding([.top,.bottom], 15)
                            }
                        }
                        else {
                            NavigationLink(destination: Settings_Detail_View(setting: item)){
                                HStack {
                                    Image(systemName: item.icon)
                                        .font(Font.system(size: 22, weight: .light))
                                    Text(item.title)
                                        .font(.system(size: 16))
                                }
                                .padding([.top,.bottom], 15)
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            
            .navigationBarTitle(Text("Profile"), displayMode: .large)
        }
    }
}

struct Settings_View_Previews: PreviewProvider {
    static var previews: some View {
        Settings_View()
    }
}
