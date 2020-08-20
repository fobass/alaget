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
                            Text("Facebook")
                                .foregroundColor(.white)
                                .font(.custom("TrebuchetMS-Bold", size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                                .background(Color.blue)
                            
                        }
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.7), radius:  2)
                        
                        
                        Button(action: {
                            self.isPresented = true
                        }) {
                            Text("Google")
                                .foregroundColor(.white)
                                .font(.custom("TrebuchetMS-Bold", size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                                .background(Color.blue)
                        }
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.7), radius:  2)
                        
                        Button(action: {
                            self.isPresented = true
                        }) {
                            Text("Apple")
                                .foregroundColor(.white)
                                .font(.custom("TrebuchetMS-Bold", size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                                .background(Color.black)
                        }
                        
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.7), radius:  2)
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
