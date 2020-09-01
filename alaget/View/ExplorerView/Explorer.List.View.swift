//
//  Explorer.Detail.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct Explorer_List_View: View {
    var explorer: Explorer
    @State var isFullView: Bool
    @State private var opacity: Double = 0
    @State var isPresented: Bool = false
    @ObservedObject var store = ExplorerStore()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack {
                ScrollView(){
                    VStack{
                        ForEach(explorer.members){ item in
                            NavigationLink(destination: Explorer_Detail_View(dialogScreen: false)) {
                                HStack{
                                    WebImage(url: URL(string: item.avatar))
                                        .resizable()
                                        .frame(width: 55, height: 55, alignment: .center)
                                        .clipShape(Circle())
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.footnote)
                                            .fontWeight(.black)
                                            .foregroundColor(Color.gray.opacity(0.9))
                                            .lineLimit(nil)
                                        HStack{
                                            Text(item.remark)
                                                .font(.footnote)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.gray.opacity(0.9))
                                                .lineLimit(1)
                                                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                            Spacer()
                                        }
                                        HStack {
                                            Text("|")
                                                .foregroundColor(Color.gray.opacity(0.9))
                                                .lineLimit(nil)
                                            
                                            Image(systemName: "mappin.circle")
                                                .font(.custom("ArialRoundedMTBold", size: 12))
                                                .foregroundColor(Color(red: 1.002, green: 0.507, blue: 0.439))
                                            
                                            Text(item.distanceVal)
                                                .foregroundColor(Color(red: 1.002, green: 0.507, blue: 0.439))
                                            
                                            Text("|")
                                                .foregroundColor(Color.gray.opacity(0.9))
                                                .lineLimit(nil)
                                            Image(systemName: "calendar")
                                                .font(.custom("ArialRoundedMTBold", size: 12))
                                                .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                            Text(item.flyDate)
                                                .foregroundColor(Color(hue: 0.289, saturation: 0.631, brightness: 0.735))
                                                .lineLimit(nil)
                                            Spacer()
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: 12, height: 12, alignment: .leading)
                                                .foregroundColor(Color.blue)
                                                .opacity((item.isVerified) ? 1 : 0)
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
                
                .navigationBarTitle(explorer.country, displayMode: .inline)
            
        }
    }
}

struct Explorer_List_View_Previews: PreviewProvider {
    static var previews: some View {
        Explorer_List_View(explorer: ExplorerStore().list[0], isFullView: true)
    }
}
