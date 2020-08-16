//
//  Explorer.Detail.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct Explorer_Detail_View: View {
    var explorer: Explorer
    @State var isFullView: Bool
    @State private var opacity: Double = 0
    @State var isPresented: Bool = false
    @ObservedObject var store = ExplorerStore()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        NavigationView {
                ScrollView(){
                    ForEach(explorer.members){ item in
                        HStack{
//                            Button(action: {
//                            }, label: {
                                WebImage(url: URL(string: item.avatar))
                                    .resizable()
                                    .frame(width: 65, height: 65, alignment: .center)
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
                                        Text(item.distanceVal)
                                            .foregroundColor(Color.orange.opacity(0.5))
                                        Text("|")
                                            .foregroundColor(Color.gray.opacity(0.9))
                                            .lineLimit(nil)
                                        Text(item.flyDate)
                                            .foregroundColor(Color.blue.opacity(0.4))
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
                                .background(Color.white)
//                            })


                            Spacer()
                        }
                        .buttonStyle(PlainButtonStyle())


                        Divider()
                    }
                    
                }
                .padding(.all, 20)
                        
                .navigationBarItems(leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle")
                        .font(.custom("ArialRoundedMTBold", size: 30))
                        .foregroundColor(Color.red.opacity(0.7))
                })
                .background(Color.backgroundColor(for: self.colorScheme))
                .cornerRadius(30)
                .shadow(color: Color.red.opacity(0.3),  radius: 1)
                )
                
                .navigationBarTitle(explorer.country, displayMode: .inline)
            
        }
    }
}

struct Explorer_Detail_View_Previews: PreviewProvider {
    static var previews: some View {
        Explorer_Detail_View(explorer: ExplorerStore().list[0], isFullView: true)
    }
}
