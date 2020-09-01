//
//  Departure.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct Explorer_View_tmp: View {
    @State var isFilter :Bool = false
    @State var presentedSearchView = false
    @State var dist : Float = 5
    @State var maxDist : Float = 20
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var store = ExplorerStore()
    private let rows = [GridItem(.fixed(100))]
    var body: some View {
        VStack{
            HStack{
                if (!self.isFilter) {
                    VStack{
                        Button(action: {
                            withAnimation {
                                self.presentedSearchView.toggle()
//                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            HStack{
                                Button(action: {
                                    withAnimation(Animation.linear.delay(2)) {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }, label: {
                                    Image(systemName: "chevron.left")
                                        .font(.custom("ArialRoundedMTBold", size: 14))
                                        .padding(.all, 19)
                                        .foregroundColor(Color.black)
//                                        .background(Color.white)
                                        .clipShape(Circle())
                                })
                                .zIndex(105)
                                VStack{
                                Text("Search")
                                    .padding(.all)
                                    .accentColor(Color.gray.opacity(0.7))
                                    .lineLimit(1)
                                    .font(.custom("TrebuchetMS-Bold", size: 16))
                                    .sheet(isPresented: $presentedSearchView) {
                                        Search_View()
                                    }
                                }
                                    
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation() {
                                        self.isFilter = !self.isFilter
                                    }
                                }, label: {
                                    Image(systemName: "line.horizontal.3.decrease.circle")
                                        .font(.custom("ArialRoundedMTBold", size: 14))
                                        .padding(.all, 19)
                                        .foregroundColor(Color.red.opacity(0.6))
//                                        .background(Color.white)
                                        .clipShape(Circle())
                                })
                                
                                .zIndex(106)
                            }
                            
                            .background(Color.itemBackgroundColor(for: self.colorScheme))
                            .cornerRadius(30)
                        }
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 15)
                    }
                    
                } else {
                        HStack{
                            Text("\(String(self.dist))km")
                                .accentColor(Color.black.opacity(0.7))
                                .lineLimit(1)
                                .font(.custom("TrebuchetMS-Bold", size: 16))
                                .frame(width: 60)
                                
                            
                            Slider(value: self.$dist, in: 0...self.maxDist, step: 0.2)
                            
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation() {
                                    self.isFilter = !self.isFilter
                                }
                            }, label: {
                                Text("OK")
//                                    .accentColor(Color.black.opacity(0.7))
                                    .lineLimit(1)
                                    .font(.custom("TrebuchetMS-Bold", size: 16))
                                    .frame(width: 50, height: 67, alignment: .center)
                                
                            })
                        }
                        
                        .padding(.top, 10)
                        .padding([.leading, .trailing], 20)
                        .padding(.bottom, -10)
                    

                }
            }
            .zIndex(101)
            .shadow(color: Color.gray.opacity(0.3),  radius: 4)
            
            ScrollView{
                FliersTodayCell()
                FliersUpcomingCell()
            }
        }
    }
}

struct FliersTodayCell_tmp: View {
    @State private var isPresented = false
    @ObservedObject var store = ExplorerStore()
    private let rows = [GridItem(.fixed(100))]
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack{
            HStack{
                Text("Today")
                    .accentColor(Color.black.opacity(0.7))
                    .font(.custom("TrebuchetMS-Bold", size: 16))
                    .foregroundColor(Color.gray)
                Spacer()
            }
            .padding([.leading, .trailing], 20)
            .padding(.top, 15)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: rows, spacing: 15) {
                    ForEach(self.store.list.filter({ $0.isToday })) { item in
                        VStack{
                        Button(action: {
                            self.store.selectedItem = item
                            self.isPresented = true
                        }, label: {
                            VStack(){
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(item.country )
                                            .font(.custom("TrebuchetMS-Bold", size: 13))
                                            .foregroundColor(Color.gray.opacity(0.8))
                                            .lineLimit(1)
                                        Spacer()
                                        Text("7:00 PM")
                                            .font(.custom("TrebuchetMS-Bold", size: 13))
                                            
                                            .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                    }
                                    Spacer()
                                    VStack{
                                        Image(systemName: "airplane")
                                            .resizable()
                                            .frame(width: 25, height: 25, alignment: .center)
                                            .foregroundColor(Color.blue.opacity(0.5))
                                            .shadow(color: Color.gray.opacity(0.3), radius: 7)
                                            .padding(.all, 5)
                                            .background(Color.orange.opacity(0.2))
                                            .cornerRadius(3.0)
                                        Spacer()
                                    }
                                    
                                }
                                Spacer()
                                HStack{
                                    Text(item.city)
                                        .lineLimit(1)
                                        .font(.custom("ArialRoundedMTBold", size: 16))
                                        .foregroundColor(Color.blue.opacity(0.8))
                                    Spacer()
                                }
                                Divider()
                                TodayImagesCell(fliers: item.members)
                                
                            }
                            .padding(.all, 15)
                            .frame(width: 175, height: 150)
                            .background(Color.itemBackgroundColor(for: self.colorScheme))
                            .cornerRadius(5)
                            .shadow(color: Color.gray.opacity(0.3), radius: 4)
                            
                            
                        })
                        .cornerRadius(5)
                        .shadow(color: Color.gray.opacity(0.4), radius: 2)
                        }
                   
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(.top, 5)
                .padding([.leading, .trailing], 20)
                .fullScreenCover(isPresented: $isPresented){
                    Explorer_List_View(explorer: self.store.selectedItem, isFullView: true)
                }
                Spacer()
                
            }
            
        }
    }
}

struct Explorer_View: View {
    @State var isFilter :Bool = false
    @State var presentedSearchView = false
    @State var dist : Float = 5
    @State var maxDist : Float = 20
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var store = ExplorerStore()
    private let rows = [GridItem(.fixed(100))]
    var body: some View {
        NavigationView{
            ScrollView{
                FliersTodayCell()
                FliersUpcomingCell()
            }
            
            .navigationBarTitle("Departures", displayMode: .large)
        }
    }
}

struct FliersTodayCell: View {
    @State private var isPresented = false
    @ObservedObject var store = ExplorerStore()
    private let rows = [GridItem(.fixed(100))]
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack{
            HStack{
                Text("Today")
                    .accentColor(Color.black.opacity(0.7))
                    .font(.custom("TrebuchetMS-Bold", size: 16))
                    .foregroundColor(Color.gray)
                Spacer()
            }
            .padding([.leading, .trailing], 20)
            .padding(.top, 15)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: rows, spacing: 15) {
                    ForEach(self.store.list.filter({ $0.isToday })) { item in
                        NavigationLink(destination: Explorer_List_View(explorer: item, isFullView: false)){
                            VStack{
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(item.country )
                                            .font(.custom("TrebuchetMS-Bold", size: 13))
                                            .foregroundColor(Color.gray.opacity(0.8))
                                            .lineLimit(1)
                                        Spacer()
                                        Text("7:00 PM")
                                            .font(.custom("TrebuchetMS-Bold", size: 13))
                                            
                                            .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                    }
                                    Spacer()
                                    VStack{
                                        Image(systemName: "airplane")
                                            .resizable()
                                            .frame(width: 25, height: 25, alignment: .center)
                                            .foregroundColor(Color.blue.opacity(0.5))
                                            .shadow(color: Color.gray.opacity(0.3), radius: 7)
                                            .padding(.all, 5)
                                            .background(Color.orange.opacity(0.2))
                                            .cornerRadius(3.0)
                                        Spacer()
                                    }
                                    
                                }
                                Spacer()
                                HStack{
                                    Text(item.city)
                                        .lineLimit(1)
                                        .font(.custom("ArialRoundedMTBold", size: 16))
                                        .foregroundColor(Color.blue.opacity(0.8))
                                    Spacer()
                                }
                                Divider()
                                TodayImagesCell(fliers: item.members)
                                
                            }
                            .padding(.all, 15)
                            .frame(width: 175, height: 150)
                            .background(Color.itemBackgroundColor(for: self.colorScheme))
                            .cornerRadius(5)
                            .shadow(color: Color.gray.opacity(0.3), radius: 4)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 5)
                .padding([.leading, .trailing], 20)
                Spacer()
                
            }
            
        }
    }
}

struct TodayImagesCell: View {
    var fliers : [Member]
    var body: some View {
        HStack(){
            ForEach(fliers.prefix(3)) { item in
                VStack{
                    WebImage(url: URL(string: item.avatar))
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .clipShape(Circle())
                    
                }
                
            }
            
            if (fliers.count > 3) {
                ZStack{
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color.white.opacity(0.5))
                        .clipShape(Circle())
                        .shadow(color: Color.gray.opacity(0.5), radius: 2)
                    Text("+\(fliers.count - 3)")
                        .font(.custom("TrebuchetMS-Bold", size: 14))
                        .foregroundColor(Color.red.opacity(0.7))
                }
                .offset(x: 0, y: 0)
            }
            Spacer()
            
        }
        
    }
}


struct FliersUpcomingCell: View {
    @State private var isPresented = false
    private var columns = [GridItem(.flexible())]
    @ObservedObject var store = ExplorerStore()
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack{
            HStack{
                Text("Upcoming")
                    .accentColor(Color.black.opacity(0.7))
                    .font(.custom("TrebuchetMS-Bold", size: 16))
                    .foregroundColor(Color.gray)
                Spacer()
            }
            .padding(.top, 15)
            .padding(.bottom, 5)
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(self.store.list.filter({ !$0.isToday })) { item in
                    NavigationLink(destination: Explorer_List_View(explorer: item, isFullView: false)){
                        VStack{
                            HStack{
                                
                                VStack(alignment: .leading){
                                    Text(item.country)
                                        .font(.custom("TrebuchetMS-Bold", size: 13))
                                        .foregroundColor(Color.gray.opacity(0.8))
                                    Spacer()
                                    Text(item.city)
                                        .font(.custom("ArialRoundedMTBold", size: 16))
                                        .foregroundColor(Color.blue.opacity(0.8))
                                }
                                Spacer()
                                VStack(alignment: .trailing){
                                    Text(item.date)
                                        .font(.custom("TrebuchetMS-Bold", size: 13))
                                        .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                    Spacer()
                                    UpcomingImagesCell(fliers: item.members)
                                    
                                }
                            }
                        }
                        .padding(.all, 15)
                        .frame(height: 70)
                        .background(Color.itemBackgroundColor(for: self.colorScheme))
                        .cornerRadius(5)
                        .shadow(color: Color.gray.opacity(0.4), radius: 2)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            
        }
        .padding([.leading, .trailing], 20)
    }
}
struct UpcomingImagesCell: View {
    var fliers : [Member]
    var body: some View {
        HStack(){
            Spacer()
            ForEach(fliers.prefix(2)) { item in
                VStack(alignment: .trailing){
                    WebImage(url: URL(string: item.avatar))
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .clipShape(Circle())
                    
                }
                
            }
            
            if (fliers.count > 3) {
                ZStack{
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(Color.white.opacity(0.5))
                        .clipShape(Circle())
                        .shadow(color: Color.gray.opacity(0.5), radius: 2)
                    Text("+\(fliers.count - 3)")
                        .font(.custom("TrebuchetMS-Bold", size: 14))
                        .foregroundColor(Color.red.opacity(0.7))
                }
                //.offset(x: 0, y: 0)
            }
//            Spacer()
            
        }
    }
}

struct Explorer_View_Previews: PreviewProvider {
    static var previews: some View {
        Explorer_View()
            .preferredColorScheme(.dark)
    }
}
