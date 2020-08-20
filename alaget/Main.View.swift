//
//  ContentView.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI

struct Main_View: View {
    @State var isPresented: Bool = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    Spacer()
                    Text((Bundle.main.name.capitalized))
                        .font(.custom("TrebuchetMS-Bold", size: 35))
                        .foregroundColor(Color.red.opacity(0.6))
                        .shadow(color: Color.red.opacity(0.8), radius:  2)
                        .frame(height: UIScreen.main.bounds.height / 30, alignment: .center)
                    Button(action: {
                        self.isPresented = true
                    }) {
                        ZStack{
                            Image("flight")
                                .resizable()
                                .frame(height: UIScreen.main.bounds.height / 1.8, alignment: .center)
                                .cornerRadius(15)
                                .shadow(color: Color.shadowColor(for: self.colorScheme), radius:  10)
                                
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
                            
                            
                        }
                    }
                    Spacer(minLength: 20)
                    VStack(spacing: 10) {
                        //                    Spacer()
                        
                        Button(action: {
                            self.isPresented = true
                        }) {
                            HStack{
                                Image("google")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color.white)
                                Text("Login with Google")
                                    .foregroundColor(Color.blue.opacity(0.6))
                                    .font(.custom("TrebuchetMS-Bold", size: 16))
                            }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                               // .background(Color(red: 0.257, green: 0.534, blue: 0.962))
                            .background(Color.white)
                        }
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.4), radius:  1)
                        
                        Button(action: {
                            self.isPresented = true
                        }) {
                            
                            HStack{
                                Image("facebook")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.white)
                                Text("Login with Facebook")
                                    .foregroundColor(.white)
                                    .font(.custom("TrebuchetMS-Bold", size: 16))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                            .background(Color(red: 0.259, green: 0.41, blue: 0.706))
                            
                            
                        }
                        .cornerRadius(10)
                        .shadow(color: Color.blue, radius:  1)
                        
                        
                        Button(action: {
                            self.isPresented = true
                        }) {
                            HStack{
                                Image(systemName: "applelogo")
                                    .resizable()
                                    .frame(width: 20, height: 25, alignment: .center)
                                    .foregroundColor(Color.white)
//                                    .padding(.leading, 20)
                                Text("Login with Apple")
                                    .foregroundColor(.white)
                                    .font(.custom("TrebuchetMS-Bold", size: 16))
//                                Spacer()
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                            .background(Color(red: 0.139, green: 0.158, blue: 0.179))
                        }
                        
                        .cornerRadius(10)
                        .shadow(color: Color.black, radius:  1)
                        
                    }
                   
                    
                    .frame(height: UIScreen.main.bounds.height / 5, alignment: .center)
                    Spacer()
                    VStack(spacing: 5){
                        Spacer()
                        Text("© 2020-2021 \(Bundle.main.name.capitalized) Inc. All Rights Reserved ")
                            .font(.custom("ArialRoundedMT", size: 11))
                            .foregroundColor(Color.gray)
                        
                        Text("Version: \(Bundle.main.version)")
                            .font(.custom("TrebuchetMS", size: 12))
                            .foregroundColor(Color.gray)
                    }
                }
                .padding([.leading, .trailing], 30)
            }
            .buttonStyle(ScaleButtonStyle())
            .fullScreenCover(isPresented: $isPresented){
                ContentView()
            }
        }
    }
}

struct Main_View_Previews: PreviewProvider {
    static var previews: some View {
        Main_View()
//                    .preferredColorScheme(.dark)
    }
}
