//
//  New.Trip.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 29/08/2020.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        let myTextView = UITextView()
        myTextView.delegate = context.coordinator
        
        myTextView.font = UIFont(name: "HelveticaNeue", size: 29)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.00)
        myTextView.textColor = UIColor(white: 1, alpha: 1)//(Color.white.opacity(0.9))
        myTextView.textAlignment = .center
        // myTextView.text = self.placeholder
        
        return myTextView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent: TextView
        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            var newText = textView.text!
            newText.removeAll { (character) -> Bool in
                return character == "\n"
            }
            if (text == "\n") {
                textView.resignFirstResponder()
            }
            return (newText.count + text.count) <= 90
            //return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}

struct CarouselView<Content: View>: View {
    private var numberOfImages: Int
    private var content: Content

    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            // 1
            ZStack(alignment: .bottom) {
                VStack{
                HStack(spacing: 3) {
                    // 3
                    ForEach(0..<self.numberOfImages, id: \.self) { index in
                        Circle()
                            .frame(width: index == self.currentIndex ? 10 : 8,
                                   height: index == self.currentIndex ? 10 : 8)
                            .foregroundColor(index == self.currentIndex ? Color.blue : .white)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .padding([.bottom, .top], 8)
                           
                            .animation(.spring())
                            
                    }
                }
                
                HStack(spacing: 0) {
                    self.content
                }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                    .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                    .animation(.spring())
                    .onReceive(self.timer) { _ in
                        self.currentIndex = (self.currentIndex + 1) % (self.numberOfImages == 0 ? 1 : self.numberOfImages)
                }
                }
                // 2
                
            }
        }
    }
}

struct ATSeachCellView: View {
    var direction: LocationModel
    var body: some View {
        HStack {
            Image(systemName: "rectangle")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(Color(UIColor.random()))
            Spacer(minLength: 15)
            VStack(alignment: .leading) {
                HStack {
                    Text(direction.display)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(Color.gray.opacity(0.9))
                    Spacer()
                }
            }
            .lineLimit(nil)
        }
        .background(Color.white)
        .padding([.top, .bottom], 5)
    }
}

struct SearchView: View {
    @Binding var city : String
    @Binding var country : String
    @Binding var code : String
    @Binding var tripGrpKey: String
    @Binding var nextViewId: Int
    @State var showCancelButton: Bool = false
    @State var searchText: String = ""
//    @State var text: String = ""
    @ObservedObject var location = LocationStore()
    var body: some View {
        VStack{
            HStack{
                Text("Where are you going?")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.6))
                Spacer()
            }
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                TextField("Search your destination", text: self.$location.keyword, onEditingChanged: { isEditing in
                    self.showCancelButton.toggle()
                }, onCommit: {
                    print("onCommit")
                })
                .foregroundColor(Color.black)
                .font(.system(size: 16))
                
                Button(action: {
                    self.location.keyword = ""
                    self.showCancelButton.toggle()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(self.location.keyword == "" ? 0 : 1)
                }
            }
            .padding([.leading, .trailing], 20)
            .padding([.top, .bottom], 15)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
            .foregroundColor(Color.gray.opacity(0.7))
            .resignKeyboardOnDragGesture()
            .animation(showCancelButton ? .easeOut : .none)
            .onDisappear(){
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
//            Spacer()
//            NewTripViewCell(display: "self.country" + ", " + self.city)
            
            if (showCancelButton){
                ScrollView{
                    ForEach(self.location.list) { item in
                        VStack{
                            ATSeachCellView(direction: item)
                                .gesture(TapGesture().onEnded(){
//                                    withAnimation(){
                                        self.location.keyword = item.iso2 + ", " + item.city
                                        self.city = item.city
                                        self.country = item.country
                                        self.code = item.iso2
                                        self.tripGrpKey = String(item.id)
                                        self.showCancelButton.toggle()
                                        UIApplication.shared.endEditing(true)
//                                        self.endEditing()
//                                    }
                                })
                            
                            Divider()
                                .background(Color.gray.opacity(0.4))
                                .padding(0)
                        }
                    }
                }
            } else {
                if (self.city != "") {
                    NewTripLocationNameViewCell(display: self.country + ", " + self.city)
                    
                    HStack{
                        Button(action: {
                            
                        }, label: {
                            Text("")
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
//                        .disabled((self.location.keyword == "") ? true : false)
                    }
//                    .opacity((self.location.keyword != "") ? 1 : 0)
//                    .padding([.leading, .trailing], 40)
//                    .padding([.top,.bottom], 20)
                    
                }
            }
            
            Spacer()
        }
    }
}


struct NewTripLocationNameViewCell: View {
    @State var display: String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Text("")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.leading, 2)
                        .padding(.top, -10)
                    Spacer()

                }
                VStack{
                    Spacer()
                    HStack{
                        Text(display)
                            .font(.system(size: 20))
                            .fontWeight(.black)
                            .foregroundColor(Color.white.opacity(0.9))
                    }
                    Spacer()
                }
                Spacer()
                HStack{
                    Text("")
                        .font(.system(size: 12))
                        .fontWeight(.black)
                        .foregroundColor(Color.white.opacity(0.6))
                    Spacer()
                    Text("")
                        .font(.system(size: 7))
                        .fontWeight(.black)
                        .foregroundColor(Color.gray.opacity(0.9))
                }
            }
            .padding(10)
        }
        .frame(height: 200)
        .background(Color.red.opacity(0.6))
        .cornerRadius(5)
        .padding([.bottom, .top], 20)
        .shadow(color: Color.gray,  radius: 3)
        
    }
    
}

struct NewTripDepDateViewCell: View {
    var display: String
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
                    Text(self.display)
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
                    Text(getTextFromDate(date: rkManager.startDate) == "" ? "Start Date" : getTextFromDate(date: rkManager.startDate))
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
                    Text(getTextFromDate(date: rkManager.endDate) == "" ? "End Date" : getTextFromDate(date: rkManager.endDate))
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

struct NewTripRemarkViewCell: View {
    @Binding var remark: String
    var bkgColor: UIColor
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Text("Where are you going?")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black.opacity(0.6))
                    Spacer()
                }
                Text("People can see what you can take during thits trip")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .foregroundColor(Color.black.opacity(0.5))
            }
            VStack {
                VStack {
                    VStack(alignment: .center){
                        HStack(alignment: .center){
                            Spacer()
                            TextView(text: $remark)
                            Spacer()
                        }
                    }
                    Spacer()
                    HStack{
                        Text((self.remark.count == 0) ? "Max 90" : (String(self.remark.count)) +  " of 90")
                            .font(.system(size: 12))
                            .fontWeight(.black)
                            .foregroundColor(Color.white.opacity(0.6))
                        Spacer()
                    }
                    .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 7, trailing: 0))
                    
                }
                .background(
                    Color(bkgColor).opacity(0.7)
                )
                
                
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
            .shadow(color: Color.gray,  radius: 5)
            .frame(height: 235, alignment: .center)
            .onDisappear(){
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
            
//            HStack{
//                Button(action: {
//                    self.nextViewId -= 1
//                }, label: {
//                    Text("Back")
//                        .frame(width: 100, height: 40)
//                        .background(Color.blue.opacity(0.7))
//                        .foregroundColor(Color.white)
//                        .cornerRadius(5)
//                })
//                Spacer()
//                Button(action: {
//
//                }, label: {
//                    Text("Post")
//                        .frame(width: 100, height: 40)
//                        .background((self.postEnable || self.remark == "") ? Color.gray.opacity(0.5) : Color.red.opacity(0.7))
//                        .foregroundColor(Color.white)
//                        .font(.custom("ArialRoundedMTBold", size: 16))
//                        .cornerRadius(5)
//                })
//                .disabled((self.postEnable || self.remark == "") ? true : false)
//            }
//            .padding(.top, 30)
            Spacer()
        }
    }
}

struct New_Trip_View: View {
    @State var trip: Trip = Trip.init( userID: "", country: "", city: "", code: "", remark: "", lastUpdate: "", image: "", lat: 0.0, lon: 0.0, distance: 0.0, tripGrpKey: "")
    var rkManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 1)
    @State var viewId: Int = 0
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var location = LocationStore()
    @EnvironmentObject var store : TripStore
    @State var showCalendar: Bool = false
    var bkgColor : UIColor = UIColor.random()
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Add New Trip")
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
                    
                    NewTripDepDateViewCell(display: self.trip.display, rkManager: self.rkManager, showCalendar: self.$showCalendar, nextViewId: self.$viewId)
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
                                self.trip.depDate = self.rkManager.startDate
                                self.trip.arrDate = self.rkManager.endDate
                                self.store.insert(trip: self.trip)
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Post")
                                    .frame(width: 100, height: 40)
//                                    .background(Color.blue.opacity(0.7))
                                    .background(((getTextFromDate(date: rkManager.startDate) != "") && (getTextFromDate(date: rkManager.endDate) != "") && (self.trip.display != "")) ? Color.red.opacity(0.5) : Color.gray.opacity(0.7))
                                    .foregroundColor(Color.white)
                                    .font(.custom("ArialRoundedMTBold", size: 16))
                                    .cornerRadius(5)
                            })
                            .disabled(((getTextFromDate(date: rkManager.startDate) != "") && (getTextFromDate(date: rkManager.endDate) != "") && (self.trip.display != "")) ? false : true)
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

struct New_Trip_View_Previews: PreviewProvider {
    static var previews: some View {
        New_Trip_View()
    }
}
