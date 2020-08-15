//
//  ContentView.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Alaget")
                    .font(.custom("TrebuchetMS-Bold", size: 35))
                    .foregroundColor(Color.red.opacity(0.7))
                    .padding([.top], 30)
                Spacer()
            }
            
            .frame(height:  40, alignment: .center)
            ZStack{
                ScrollView{
                    
                    Button(action: {
                    }) {
                        ZStack{
                            Image("flight")
                                .resizable()
                                .frame(height: 500, alignment: .center)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
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
                    .padding(.top, 20)
                    
                }
                .zIndex(2.0)
                VStack(spacing: 5){
                    Spacer()
                    Text("© 2020-2021 Alaget Inc. All Rights Reserved ")
                        .font(.custom("ArialRoundedMT", size: 11))
                        .foregroundColor(Color.gray)
                    //                    Text("Version 1.0")
                    //                        .font(.custom("TrebuchetMS", size: 12))
                    //                        .foregroundColor(Color.gray)
                }
                .zIndex(1.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
