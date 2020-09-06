//
//  Departure.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct LoadingIndicatorView: View {
    @State var b1 : Bool = false
    var body: some View{
        VStack{
            ZStack{
//               Capsule()
//                .frame(width: 180, height: 6, alignment: .center)
//                .foregroundColor(Color.gray.opacity(0.5))
                
                Capsule()
                    .clipShape(Rectangle().offset(x: b1 ? 80 : -80))
                    .frame(width: 180, height: 6, alignment: .leading)
                    .foregroundColor(Color.red.opacity(0.5))
                    .offset(x: b1 ? 14 : -14)
                    .animation(Animation.easeInOut(duration: 0.5).delay(0.2).repeatForever(autoreverses: true))
                    .onAppear {
                        b1.toggle()
                    }
            }
        }
//        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

//struct LoadingIndicatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingIndicatorView().previewLayout(.sizeThatFits)
////            .preferredColorScheme(.dark)
//    }
//}

struct Explorer_View: View {
    @State var isFilter :Bool = false
    @State var presentedSearchView = false
    @State var dist : Float = 5
    @State var maxDist : Float = 20
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var store : ExplorerStore
    private let rows = [GridItem(.fixed(100))]
    var body: some View {
        NavigationView{
            VStack{
                if (store.isLoaded){
                    ScrollView{
                        FliersTodayCell().environmentObject(store)
                        FliersUpcomingCell().environmentObject(store)
                    }
                } else {
                    LoadingIndicatorView()
                }
            }
            .navigationBarTitle("Departures", displayMode: .large)
        }
    }
}
//extension View {
//    func debug() -> Self {
//        print(Mirror(reflecting: self).subjectType)
//        return self
//    }
//}

struct FliersTodayCell: View {
    @State private var isPresented = false
    @EnvironmentObject var store : ExplorerStore
    private let rows = [GridItem(.fixed(100))]
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack{
            if (store.isToday){
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
                            NavigationLink(destination: Explorer_List_View(title: item.country, flyings: item.flyings, isFullView: false)){
                                VStack{
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text(item.country)
                                                .font(.custom("TrebuchetMS-Bold", size: 13))
                                                .foregroundColor(Color.gray.opacity(0.8))
                                                .lineLimit(1)
                                            Spacer()
                                            Text(item.displayDate)
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
                                    TodayImagesCell(flyings: item.flyings)
                                    
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
            else {
                Text("")
            }
        }
    }
}

struct TodayImagesCell: View {
    var flyings : [Flying]
    var body: some View {
        HStack(){
            ForEach(flyings.prefix(3), id: \.self) { item in
                VStack{
                    WebImage(url: URL(string: item.photoURL))
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .clipShape(Circle())

                }

            }

            if (flyings.count > 3) {
                ZStack{
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color.white.opacity(0.5))
                        .clipShape(Circle())
                        .shadow(color: Color.gray.opacity(0.5), radius: 2)
                    Text("+\(flyings.count - 3)")
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
    @EnvironmentObject var store : ExplorerStore
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack{
            if (store.isUpcoming) {
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
                        NavigationLink(destination: Explorer_List_View(title: item.country, flyings: item.flyings, isFullView: false)){
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
                                        Text(item.displayDate)
                                            .font(.custom("TrebuchetMS-Bold", size: 13))
                                            .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                        Spacer()
                                        
                                        UpcomingImagesCell(flyings: item.flyings)
                                        
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
            } else {
                Text("")
            }
            
        }
        .padding([.leading, .trailing], 20)
    }
}
struct UpcomingImagesCell: View {
    var flyings : [Flying]
    var body: some View {
        HStack(){
            Spacer()
            ForEach(flyings.prefix(2)) { item in
                VStack(alignment: .leading){
                    WebImage(url: URL(string: item.photoURL))
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .clipShape(Circle())

                }

            }

            if (flyings.count > 3) {
                ZStack{
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(Color.white.opacity(0.5))
                        .clipShape(Circle())
                        .shadow(color: Color.gray.opacity(0.5), radius: 2)
                    Text("+\(flyings.count - 3)")
                        .font(.custom("TrebuchetMS-Bold", size: 14))
                        .foregroundColor(Color.red.opacity(0.7))
                }
                //.offset(x: 0, y: 0)
            }
            Spacer()
            
        }
    }
}

struct Explorer_View_Previews: PreviewProvider {
    static var previews: some View {
        Explorer_View().environmentObject(explorerStore)
            .preferredColorScheme(.dark)
    }
}
