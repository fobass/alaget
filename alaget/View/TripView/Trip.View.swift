//
//  Trip.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 29/08/2020.
//

import SwiftUI

struct TripViewCell: View {
    @State var item: Trip
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Text(item.country)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.leading, 2)
                        .padding(.top, -10)
                    Spacer()
                    Button(action: {

                    }, label: {
                        Image(systemName: "qtrash")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(Color.black.opacity(0.7))
                            .font(.headline)
                    })
                }
                VStack{
                    Spacer()
                    HStack{
                        Text(item.city)
                            .font(.system(size: 22))
                            .fontWeight(.black)
                            .foregroundColor(Color.white.opacity(0.9))
                    }
                    .padding(.top, -10)
                    Spacer()
                }
                Spacer()
                HStack{
                    Text("Flying on " + item.depDateDisplay)
                        .font(.system(size: 12))
                        .fontWeight(.black)
                        .foregroundColor(Color.white.opacity(0.6))
                    Spacer()
                    Text(item.lastUpdate)
                        .font(.system(size: 7))
                        .fontWeight(.black)
                        .foregroundColor(Color.gray.opacity(0.9))
                }
            }
            .padding(10)
        }
        .frame(height: 170)
        .background(Color.red.opacity(0.6))
        .cornerRadius(5)
        .padding([.trailing, .leading], 20)
        .padding(.bottom, 10)
        .shadow(color: Color.gray,  radius: 3)
    }
    
}

struct Trip_View: View {
    @State private var deleteAction: Bool = false
    @State private var addAction: Bool = false
    @State private var editAction: Bool = false
    private var columns = [GridItem(.flexible())]
    @ObservedObject var store = TripStore()
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    Text("My upcoming trips")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .foregroundColor(Color.black.opacity(0.5))
                    Spacer()
                }
                .padding(.leading, 25)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(store.trips){ item in
                        VStack{
                            Button(action: {
                                self.store.selectedItem = item
                                self.editAction.toggle()
                            }, label: {
                                TripViewCell(item: item)
                            })
                        }
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .fullScreenCover(isPresented: $editAction){
                        Edit_Trip_View(trip: self.store.selectedItem!)
                    }
                }
            }
            .navigationBarItems(trailing:
                VStack {
                    Button(action: {
                        self.addAction.toggle()
                    }) {
                       Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                       
                    }
                    .foregroundColor(Color.red.opacity(0.7))
                }
            )
            .navigationBarTitle("Trip", displayMode: .large)
            .fullScreenCover(isPresented: $addAction){
                New_Trip_View().environmentObject(store)
            }
            
        }
        
    }
}

struct Trip_View_Previews: PreviewProvider {
    static var previews: some View {
        Trip_View()//.environmentObject(TripStore())
//            .preferredColorScheme(.dark)
    }
}
