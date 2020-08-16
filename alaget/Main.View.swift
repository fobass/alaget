//
//  ContentView.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI

struct Main_View: View {
    @State var isPresented: Bool = false
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Alaget")
                    .font(.custom("TrebuchetMS-Bold", size: 35))
                    .foregroundColor(Color.red.opacity(0.6))
                    .shadow(color: Color.red.opacity(0.8), radius:  2)
                    .padding([.top], 30)
                Spacer()
            }
            .frame(height:  40, alignment: .center)
            
            ZStack{
                ScrollView{
                    Button(action: {
                        self.isPresented = true
                    }) {
                        ZStack{
                            Image("flight")
                                .resizable()
                                .frame(height: 500, alignment: .center)
                                .cornerRadius(15)
                                .shadow(color: Color.gray.opacity(0.3), radius:  5)
                            VStack(alignment: .center){
                                VStack(spacing: 10){
                                    Text("People fly different direction today")
                                        .foregroundColor(Color.white)
                                        .font(.custom("ArialRoundedMTBold", size: 25))
                                        .lineLimit(5)
                                        .multilineTextAlignment(.center)
                                }
                                .padding([.top, .bottom], 25)
                                VStack(spacing: 10){
                                    Text("Send something to your family or friends. Find who is flying to your country")
                                        .foregroundColor(Color.white.opacity(0.9))
                                        .font(.custom("TrebuchetMS-Bold", size: 16))
                                        .lineLimit(5)
                                        .multilineTextAlignment(.center)
                                }
                                Spacer()
                                Button(action: {
                                    self.isPresented = true
                                }) {
                                    Text("Exlpoer")
                                        .padding([.top, .bottom], 10)
                                        .padding([.leading, .trailing], 20)
                                        .font(.custom("TrebuchetMS-Bold", size: 16))
                                        .background(Color.white)
                                        .cornerRadius(3)
                                    
                                }
                                .padding(.bottom, 50)
                            }
                            .padding([.leading, .trailing], 20)
                            Spacer()
                        }
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .padding([.leading, .trailing], 30)
                    .padding(.top, 30)
                }
                
                .fullScreenCover(isPresented: $isPresented){
                    ContentView()
                }
                
                .zIndex(2.0)
                VStack(spacing: 5){
                    Spacer()
                    Text("© 2020-2021 \(Bundle.main.name.capitalized) Inc. All Rights Reserved ")
                        .font(.custom("ArialRoundedMT", size: 11))
                        .foregroundColor(Color.gray)
                    Text("Version: \(Bundle.main.version)")
                        .font(.custom("TrebuchetMS", size: 12))
                        .foregroundColor(Color.gray)
                    //                    Text("Build: \(Bundle.main.build)")
                    //                        .font(.custom("TrebuchetMS", size: 12))
                    //                        .foregroundColor(Color.gray)
                    
                }
                .zIndex(1.0)
            }
        }
    }
}

struct Main_View_Previews: PreviewProvider {
    static var previews: some View {
        Main_View()
//            .preferredColorScheme(.dark)
    }
}
