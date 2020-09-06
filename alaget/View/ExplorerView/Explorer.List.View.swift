//
//  Explorer.Detail.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct Explorer_List_View: View {
    var title: String
    var flyings: [Flying]
    @State var isFullView: Bool
    @State private var opacity: Double = 0
    @State var isPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack {
            ScrollView(){
                VStack{
                    ForEach(flyings){ item in
                        NavigationLink(destination: Explorer_Detail_View(uuid: item.uuid, tripid: item.id , dialogScreen: false).environmentObject(explorerStore)) {
                            HStack{
                                WebImage(url: URL(string: item.photoURL))
                                    .resizable()
                                    .frame(width: 55, height: 55, alignment: .center)
                                    .clipShape(Circle())
                                VStack(alignment: .leading) {
                                    Text(item.firstName)
                                        .font(.footnote)
                                        .fontWeight(.black)
                                        // .foregroundColor(Color.gray.opacity(0.9))
                                        .lineLimit(nil)
                                    HStack{
                                        Text(item.remark)
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                            // .foregroundColor(Color.gray.opacity(0.9))
                                            .lineLimit(1)
                                            .padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                                        Spacer()
                                    }
                                    HStack {
                                        Text("|")
                                            .foregroundColor(Color.gray.opacity(0.9))
                                            .lineLimit(nil)
                                        
                                        Image(systemName: "mappin.circle")
                                            .font(.custom("ArialRoundedMTBold", size: 12))
                                            .foregroundColor(Color(red: 1.002, green: 0.507, blue: 0.439))
                                        
                                        Text(item.displayDistance)
                                            .foregroundColor(Color(red: 1.002, green: 0.507, blue: 0.439))
                                        
                                        //                                            Text("|")
                                        //                                                .foregroundColor(Color.gray.opacity(0.9))
                                        //                                                .lineLimit(nil)
                                        //                                            Image(systemName: "calendar")
                                        //                                                .font(.custom("ArialRoundedMTBold", size: 12))
                                        //                                                .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                        //                                            Text("item.flyDate")
                                        //                                                .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                        //                                                .lineLimit(nil)
                                        Spacer()
                                        Image(systemName: "checkmark.circle.fill")
                                            .resizable()
                                            .frame(width: 12, height: 12, alignment: .leading)
                                            .foregroundColor(Color.blue)
                                            .opacity(((item.isVerified) != 0) ? 1 : 0)
                                    }
                                    .font(.custom("ArialRoundedMTBold", size: 12))
                                }
                                
                                Spacer()
                            }
                            .background(Color.backgroundColor(for: self.colorScheme))
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider()
                    }
                    
                }
                .padding(.all, 20)
                
            }
            
            //                .navigationBarItems(leading: <#T##View#>, trailing: <#T##View#>)
            
            
            //                .navigationBarItems(
            //                leading:
            //                   Text("")
            //                ,trailing: Button(action: {
            //                    self.presentationMode.wrappedValue.dismiss()
            //                }, label: {
            //                    Image(systemName: "xmark.circle")
            //                        .font(.custom("ArialRoundedMTBold", size: 30))
            //                        .foregroundColor(Color.red.opacity(0.7))
            //                })
            //                .background(Color.itemBackgroundColor(for: self.colorScheme))
            //                .cornerRadius(30)
            //                .shadow(color: Color.red.opacity(0.3),  radius: 1)
            //                )
            
            .navigationBarTitle(title, displayMode: .inline)
            
        }
    }
}

struct Explorer_List_View_Previews: PreviewProvider {
    static var previews: some View {
        Explorer_List_View(title: "Test", flyings: [Flying.init(uuid: "dsa", firstName: "Test", photoURL: "TTT", distance: 0.0, id: "1", remark: "Test test", isVerified: 1),
                                                    Flying.init(uuid: "dsa", firstName: "Test", photoURL: "TTT", distance: 0.0, id: "1", remark: "Test test", isVerified: 1),
                                                    Flying.init(uuid: "dsa", firstName: "Test", photoURL: "TTT", distance: 0.0, id: "1", remark: "Test test", isVerified: 1)], isFullView: false)
    }
}
