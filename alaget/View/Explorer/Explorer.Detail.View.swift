//
//  Explorer.Detail.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 17/08/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct Explorer_Detail_View: View {
    @ObservedObject var store = ProfileStore()
//    @ObservedObject var store1 = ExplorerStore()()
    var body: some View {
//        NavigationView{
            ScrollView{
                VStack{
                    HStack{
                        VStack(alignment: .leading, spacing: 5){
                            Text(store.profile!.DisplayGreetingName)
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.7))
                                .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 10, trailing: 5))
                            HStack{
                                Text("About me " + store.profile!.about)
                                    .font(.footnote)
                                    .foregroundColor(Color.black.opacity(0.7))
                            }
                            HStack{
                                Image(systemName:"mappin.circle")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color.orange.opacity(0.5))
                                
                                Text("profile.location")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(Color.orange.opacity(0.5))
                            }
                            .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 15, trailing: 0))
                        }
                        Spacer()
                        VStack(){
                            WebImage(url: URL(string: store.profile!.photoURL))
                                .resizable()
                                .frame(width: 80, height: 80, alignment: .center)
                                .clipShape(Circle())
                            HStack{
                                Image(systemName:"star.fill")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color.orange.opacity(0.5))
                                
                                Text(String(store.profile!.score))
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
                            }
                            .frame(width: 130, height: 30)
                            .cornerRadius(10)
                            .background(Color.blue.opacity(0.7))
                            
                            Button(action: {
        //                        withAnimation {
//                                self.isMessage = true
        //                        }
                            }) {
                                Text("Message")
                                    .font(.footnote)
                                    .foregroundColor(Color.white.opacity(0.9))
                                
                            }
                            
//                            .fullScreenCover(isPresented: self.$isMessage){
//                                Message_View().environmentObject(profileStore)
//                            }
                            
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
                                .foregroundColor(Color.black.opacity(0.7))
                            Image(systemName:"checkmark.circle.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(isVerifiedColor())
        //                        .opacity((flyer.isVerified == 0) ? 1.0 : 0.0)
                        }
                    }
                    
//                    ProfileTodayFlyCell(flierTrips: self.store1.flierTrips.filter({$0.isToday}))
//                    ProfileUpcomingFlyCell(flierTrips: self.store1.flierTrips.filter({!$0.isToday}))
                    
                }
                .padding(.all, 20)
                
            }
            
            .navigationBarTitle("", displayMode: .inline)
//        }
    }
    
    func isVerifiedColor() -> Color {
        return ((store.profile?.isVerified)!) ? Color.gray.opacity(0.7) : Color.blue.opacity(0.7)
    }
}


//struct ProfileTodayFlyCell: View {
//    private let rows = [GridItem(.fixed(230))]
//    var flierTrips : [FlierTrips]
//    var body: some View {
//        VStack{
//            HStack{
//                Text("Today's trip")
//                    .font(.system(size: 16))
//                    .fontWeight(.heavy)
//                    .foregroundColor(Color.black.opacity(0.8))
//                Spacer()
//            }
//            .padding([.top, .leading, .trailing], 20)
//            ScrollView(.horizontal, showsIndicators: false){
//                VStack{
//                    LazyHGrid(rows: rows, spacing: 15) {
//                        ForEach(self.flierTrips) { item in
//                            Button(action: {
//                            }, label: {
//                                VStack{
//                                    HStack{
//                                        Text(item.country)
//                                            .foregroundColor(Color.white)
//                                            .font(.custom("TrebuchetMS-Bold", size: 18))
//                                        Spacer()
//                                    }
//                                    .padding([.top, .leading, .trailing], 5)
//                                    Spacer()
//                                    HStack(alignment: .center){
//                                        Text(item.remark)
//                                            .font(.custom("ArialRoundedMTBold", size: 20))
//                                            .fontWeight(.black)
//                                            .foregroundColor(Color.white)
//                                            .shadow(color: Color.gray.opacity(0.4),  radius: 2)
//                                            .multilineTextAlignment(.center)
//                                            .frame(alignment: .leading)
//                                            .padding(EdgeInsets.init(top: 0, leading: 25, bottom: 30, trailing: 25))
//                                    }
//                                    Spacer()
//                                    
//                                }
//                                .frame(width: UIScreen.main.bounds.width - 40 , height: 220)
//                                
//                                .background(Color.green)
//                            })
//                            .cornerRadius(5)
//                            
//                        }
//                        .buttonStyle(FliersScaleButtonStyle())
//                    }
////                    .background(Color.red)
//                    .shadow(color: Color.gray.opacity(0.7), radius: 3)
////                    .padding(.top, 5)
//                    
//                }
//                .padding([.leading, .trailing], 20)
//                
//                
//                Spacer()
//            }
//        }
//    }
//}
//
//struct ProfileUpcomingFlyCell: View {
//    private let rows = [GridItem(.fixed(180))]
//    var flierTrips : [FlierTrips]
//    var body: some View {
//        VStack{
//            HStack{
//                Text("Upcomiing trips")
//                    .accentColor(Color.black.opacity(0.7))
//                    .font(.custom("TrebuchetMS-Bold", size: 16))
//                Spacer()
//            }
//            .padding([.leading, .trailing], 20)
//            .padding(.top, 5)
//            
//            ScrollView(.horizontal, showsIndicators: false){
//                VStack{
//                    LazyHGrid(rows: rows, spacing: 15) {
//                        ForEach(flierTrips) { item in
//                            Button(action: {
//                            }, label: {
//                                VStack{
//                                    HStack{
//                                        Text(item.country)
//                                            .foregroundColor(Color.white)
//                                            .font(.custom("TrebuchetMS-Bold", size: 15))
//                                        Spacer()
//                                    }
//                                    .padding(.all, 5)
//                                    Spacer()
//                                    HStack(alignment: .center){
//                                        Text(item.remark)
//                                            .font(.custom("ArialRoundedMTBold", size: 12))
////                                            .fontWeight(.black)
//                                            .foregroundColor(Color.white)
//                                            .shadow(color: Color.gray.opacity(0.4),  radius: 2)
//                                            .multilineTextAlignment(.center)
////                                            .frame(alignment: .leading)
//                                            .padding(EdgeInsets.init(top: 0, leading: 25, bottom: 30, trailing: 25))
//                                    }
//                                    Spacer()
//                                }
//                                .frame(width: 170, height: 170)
//                                .background(Color.green)
//                            })
//                            .cornerRadius(5)
//                            .shadow(color: Color.gray.opacity(0.7), radius: 2)
//                            
//                        }
//                        .buttonStyle(FliersScaleButtonStyle())
//                    }
//                }
//                .padding([.leading, .trailing], 20)
//          
////                Spacer()
//                
//            }
//        }
//      
//        
//    }
//}


struct Explorer_Detail_View_Previews: PreviewProvider {
    static var previews: some View {
        Explorer_Detail_View()
    }
}
