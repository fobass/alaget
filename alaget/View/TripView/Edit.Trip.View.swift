//
//  Edit.Trip.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 30/08/2020.
//

import SwiftUI

struct EditTripDepDateViewCell: View {
    var trip : Trip
    var rkManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 1)
        @Binding var showCalendar: Bool
    @Binding var nextViewId: Int
    var body: some View{
        VStack{
            VStack{
            HStack{
                Text("When are you going?")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.6))
                Spacer()
            }
//            .padding(.all, 15)
            Spacer()
            HStack(spacing: 20) {
                VStack{
//                    Text("bdfbdf")
                }
                .frame(width: 80, height: 81)
                .background(Color.red.opacity(0.6))
                .cornerRadius(5)
                .shadow(color: Color.gray,  radius: 3)
                VStack{
                    Text(trip.display)
                        .font(.system(size: 26))
                        .fontWeight(.black)
                        .foregroundColor(Color.black.opacity(0.6))
                }
                Spacer()
            }
//            .background(Color.black)
            Spacer()
            VStack(spacing: 21){
                HStack {
                    Text(getTextFromDate(date: rkManager.startDate) == "" ? getTextFromDate(date: trip.depDate) : getTextFromDate(date: rkManager.startDate))
                        .foregroundColor(Color.black)
                        .opacity(getTextFromDate(date: rkManager.startDate) == "" ? 0.3 : 0.8)
                        .font(.system(size: 16))
                    Spacer()
                    Button(action: {
                        self.showCalendar.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .font(.system(size: 28))
                    }
                }
                .padding(EdgeInsets.init(top: 15, leading: 15, bottom: 15, trailing: 15))
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .foregroundColor(Color.black.opacity(0.6))
                
                HStack {
                    Text(getTextFromDate(date: rkManager.endDate) == "" ? getTextFromDate(date: trip.arrDate) : getTextFromDate(date: rkManager.endDate))
                        .foregroundColor(Color.black)
                        .opacity(getTextFromDate(date: rkManager.endDate) == "" ? 0.3 : 0.8)
                        .font(.system(size: 16))
                    Spacer()
                    Button(action: {
                        self.showCalendar.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .font(.system(size: 28))
                    }
                }
                .padding(.all, 15)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .foregroundColor(Color.black.opacity(0.6))
            }
                Spacer()
                HStack{
                    Button(action: {
                        self.nextViewId -= 1
                    }, label: {
                        Text("Back")
                            .frame(width: 100, height: 40)
                            .background(Color.blue.opacity(0.7))
                            .foregroundColor(Color.white)
                            .cornerRadius(5)
                    })
                    Spacer()
                    Button(action: {
                        self.nextViewId += 1
                    }, label: {
                        Text("Next")
                            .frame(width: 100, height: 40)
                            .background(Color.blue.opacity(0.7))
                            .foregroundColor(Color.white)
                            .cornerRadius(5)
                    })
//                    .disabled((self.location.keyword == "") ? true : false)
                }
//                .opacity((self.location.keyword != "") ? 1 : 0)
                Spacer()
            
        }
//            .background(Color.blue.opacity(0.6))
            .frame(height: 400)
            Spacer()
            
        }
     
        
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM d, yyyy (EEEE)"
        return date == nil ? "" : formatter.string(from: date)
    }
}

struct Edit_Trip_View: View {
    @State var trip : Trip
    @State var showCalendar: Bool = false
    @State var viewId: Int = 0
    var bkgColor : UIColor = UIColor.random()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var store: TripStore
    var rkManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 1)
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Edit Trip")
                    .font(.footnote)
                    .fontWeight(.black)
                    .foregroundColor(Color.gray.opacity(0.9))
                    .lineLimit(1)
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
            
            ZStack{
                TabView(selection: self.$viewId){
                    
                    SearchView(city: self.$trip.city, country: self.$trip.country, code: self.$trip.code, tripGrpKey: self.$trip.tripGrpKey, nextViewId: self.$viewId)
                        .padding([.leading, .trailing], 20)
                        .padding([.top, .bottom], 15)
                        .tag(0)
                    
                    EditTripDepDateViewCell(trip: self.trip, rkManager: self.rkManager, showCalendar: self.$showCalendar, nextViewId: self.$viewId)
                        .tag(1)
                        .padding([.leading, .trailing], 20)
                        .padding([.top, .bottom], 15)
                    
                    ZStack{
                        NewTripRemarkViewCell(remark: self.$trip.remark, bkgColor: self.bkgColor)
                        HStack{
                            Button(action: {
                                self.viewId -= 1
                            }, label: {
                                Text("Back")
                                    .frame(width: 100, height: 40)
                                    .background(Color.blue.opacity(0.7))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(5)
                            })
                            Spacer()
                            Button(action: {
                                self.trip.depDate = (self.rkManager.startDate != nil) ? self.rkManager.startDate : self.trip.depDate
                                self.trip.arrDate = (self.rkManager.endDate != nil) ? self.rkManager.endDate : self.trip.arrDate
                                self.store.update(trip: self.trip)
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Post")
                                    .frame(width: 100, height: 40)
                                    .background(Color.blue.opacity(0.7))
//                                    .background(((getTextFromDate(date: rkManager.startDate) != "") && (getTextFromDate(date: rkManager.endDate) != "") && (self.trip.display != "")) ? Color.red.opacity(0.5) : Color.gray.opacity(0.7))
                                    .foregroundColor(Color.white)
                                    .font(.custom("ArialRoundedMTBold", size: 16))
                                    .cornerRadius(5)
                            })
//                            .disabled(((getTextFromDate(date: rkManager.startDate) != "") && (getTextFromDate(date: rkManager.endDate) != "") && (self.trip.display != "")) ? false : true)
                        }
                        .offset(y: -25)
                    }
                    .tag(2)
                    .padding([.leading, .trailing], 20)
                    .padding([.top, .bottom], 15)
                    
                    
                    
                }
                .tabViewStyle(PageTabViewStyle())
                
                if ($showCalendar.wrappedValue){
                    ZStack {
                        Color.white.opacity(0.2).edgesIgnoringSafeArea(.vertical)
                        VStack{
                            RKViewController(isPresented: self.$showCalendar, rkManager: self.rkManager)
                        }
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .offset(y: -120)
                        //.animation(.easeOut)
                    }
                    .zIndex(100.0)

                }
                
            }
        }
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM d, yyyy (EEEE)"
        return date == nil ? "" : formatter.string(from: date)
    }
}

struct Edit_Trip_View_Previews: PreviewProvider {
    
    static var trip = Trip.init(userID: "ww", country: "Moscow", city: "Moscow", code: "001", remark: "sad", lastUpdate: "sdf", image: "sf", lat: 0.1, lon: 0.3, distance: 2.0, tripGrpKey: "")
    
    static var previews: some View {
        Edit_Trip_View(trip: trip).environmentObject(TripStore())
    }
}
