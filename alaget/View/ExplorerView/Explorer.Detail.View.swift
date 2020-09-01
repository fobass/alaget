//
//  Explorer.Detail.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 17/08/2020.
//


// Swift
//
// AppDelegate.swift

import SwiftUI
import SDWebImageSwiftUI

struct Explorer_Detail_View: View {
    var dialogScreen : Bool
    @State var isMessageScreen: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var store = SettingsStore()
    @ObservedObject var store1 = ExplorerStore()
    var body: some View {
        VStack{
            if (dialogScreen) {
                HStack{
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .font(.custom("ArialRoundedMTBold", size: 30))
                            .foregroundColor(Color.red.opacity(0.7))
                        
                    })
                    .background(Color.itemBackgroundColor(for: self.colorScheme))
                    .cornerRadius(30)
                    .shadow(color: Color.red.opacity(0.3),  radius: 1)
                    .padding([.trailing], 20)
                    .padding([.top], 10)
                    .padding([.bottom], 2)
                }
                
            }
            ScrollView{
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 5){
                        Text(store.profile.DisplayGreetingName)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            //                                .foregroundColor(Color.backgroundColor(for: self.colorScheme))
                            .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 10, trailing: 5))
                        HStack{
                            Text("About me " + store.profile.about)
                                .font(.footnote)
                            //                                    .foregroundColor(Color.backgroundColor(for: self.colorScheme))
                        }
                        HStack{
                            Image(systemName:"mappin.circle")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color(red: 1.002, green: 0.507, blue: 0.439))
                            
                            Text("profile.location")
                                .fontWeight(.bold)
                                .font(.footnote)
                                .foregroundColor(Color(red: 1.002, green: 0.507, blue: 0.439))
                        }
                        .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 15, trailing: 0))
                    }
                    Spacer()
                    VStack(){
                        WebImage(url: URL(string: store.profile.photoURL))
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                            .clipShape(Circle())
                        HStack{
                            Image(systemName:"star.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color.orange.opacity(0.5))
                            
                            Text(String(store.profile.score))
                                .fontWeight(.bold)
                                .font(.footnote)
                                .foregroundColor(Color.orange.opacity(0.5))
                        }
                    }
                }
                HStack{
                    HStack(alignment: .center) {
                        Button(action: {
                            print("sad")
                        }) {
                            Text("Follow")
                                .font(.footnote)
                                .foregroundColor(Color.white.opacity(0.9))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                        }
                        .frame(width: 130, height: 30)
                        .cornerRadius(10)
                        .background(Color.blue.opacity(0.7))
                        
                        Button(action: {
                            withAnimation {
                                self.isMessageScreen = true
                            }
                        }) {
                            Text("Message")
                                .font(.footnote)
                                .foregroundColor(Color.white.opacity(0.9))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                            
                        }
                        .sheet(isPresented: $isMessageScreen) {
                            Inbox_Detail_View(dialogScreen: true).environmentObject(ChatHelper())
                        }

                        .frame(width: 140, height: 30)
                        .cornerRadius(10)
                        .background(Color.blue.opacity(0.7))
                    }
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    Spacer()
                    HStack{
                        Text("Verified")
                            .font(.footnote)
                            .foregroundColor(Color.blue)
                        Image(systemName:"checkmark.circle.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(isVerifiedColor())
                        //                        .opacity((flyer.isVerified == 0) ? 1.0 : 0.0)
                    }
                }
                Spacer(minLength: 30)
                VStack{
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("7:00 PM")
                                    .font(.custom("TrebuchetMS-Bold", size: 22))
                                    .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                HStack{
                                    Text(store1.list[0].country )
                                        .font(.custom("TrebuchetMS-Bold", size: 18))
                                        .foregroundColor(Color.gray.opacity(0.8))
                                        .lineLimit(1)
                                    
                                    Text(store1.list[0].city + " kasjldhf" )
                                        .font(.custom("TrebuchetMS-Bold", size: 18))
                                        .foregroundColor(Color.gray.opacity(0.8))
                                        .lineLimit(1)
                                }
                                Spacer()
                            }
                            Spacer()
                            VStack{
                                Image(systemName: "airplane")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .foregroundColor(Color.blue.opacity(0.5))
                                    .shadow(color: Color.gray.opacity(0.3), radius: 7)
                                    .padding(.all, 5)
                                    .background(Color.orange.opacity(0.2))
                                    .cornerRadius(3.0)
                                Spacer()
                            }
                            
                        }
                        
                        VStack(alignment: .center){
                            HStack{
                                Text("store1.list[0] test  djgh slkdfj slkfj slkfj  ")
                                    .font(.custom("TrebuchetMS-Bold", size: 17))
                                    .foregroundColor(Color.blue.opacity(0.8))
                            }
                            Spacer()
                        }
                        .padding(.top, -10)
                    }
                    .padding(.all, 10)
                }
                .frame(height: 180, alignment: .center)
                .background(Color.itemBackgroundColor(for: self.colorScheme))
                
                .cornerRadius(5)
                .shadow(color: Color.gray.opacity(0.3), radius: 3)
                .buttonStyle(ScaleButtonStyle())
                
                
                
            }
            .padding(.all, 20)
            
            ProfileUpcomingFlyCell()
            
        }
        }
        .navigationBarTitle("", displayMode: .inline)
        
    }
    
    func isVerifiedColor() -> Color {
        return ((store.profile.isVerified)) ? Color.gray.opacity(0.7) : Color.blue.opacity(0.7)
    }
}

struct ProfileUpcomingFlyCell: View {
    private let rows = [GridItem(.fixed(180))]
    @ObservedObject var store = ExplorerStore()
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack{
            HStack{
                Text("Upcomiing trips")
//                    .accentColor(Color.black.opacity(0.7))
                    .font(.custom("TrebuchetMS-Bold", size: 16))
                Spacer()
            }
            .padding([.leading, .trailing], 20)
            .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: rows, spacing: 15) {
                    ForEach(store.list) { item in
                        VStack{
                            VStack{
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("7:00 PM")
                                            .font(.custom("TrebuchetMS-Bold", size: 12))
                                            .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                        
                                        Text(item.country)
                                            .font(.custom("TrebuchetMS-Bold", size: 13))
                                            .foregroundColor(Color.gray.opacity(0.8))
                                            .lineLimit(1)
                                        
                                        Text(item.city + " kasjldhf" )
                                            .font(.custom("TrebuchetMS-Bold", size: 13))
                                            .foregroundColor(Color.gray.opacity(0.8))
                                            .lineLimit(1)
                                        
                                        Spacer()
                                    }
                                    Spacer()
                                    VStack{
                                        Image(systemName: "airplane")
                                            .resizable()
                                            .frame(width: 15, height: 15, alignment: .center)
                                            .foregroundColor(Color.blue.opacity(0.5))
                                            .shadow(color: Color.gray.opacity(0.3), radius: 7)
                                            .padding(.all, 5)
                                            .background(Color.orange.opacity(0.2))
                                            .cornerRadius(3.0)
                                        Spacer()
                                    }
                                    
                                }
                                
                                VStack(alignment: .center){
                                    HStack{
                                        Text("store1.list[0] test  djgh slkdfj slkfj slkfj slkdfjslkdfskdfjsldkfj sdfsdf sdfsdf sdfsdf wfwef ")
                                            .font(.custom("TrebuchetMS-Bold", size: 12))
                                            .foregroundColor(Color.blue.opacity(0.8))
                                    }
                                    Spacer()
                                }
                                .padding(.top, -15)
                            }
                            .padding([.top, .leading, .trailing], 10)
                        }
                        .frame(width: 160, height: 150, alignment: .center)
                        .background(Color.itemBackgroundColor(for: self.colorScheme))
                        .cornerRadius(5)
                        .shadow(color: Color.gray.opacity(0.3), radius: 3)
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], -10)
            }
        }
    }
}


struct Explorer_Detail_View_Previews: PreviewProvider {
    static var previews: some View {
        Explorer_Detail_View(dialogScreen: true)
            .preferredColorScheme(.dark)
    }
}
