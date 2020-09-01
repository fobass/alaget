//
//  Settings.Detail.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 30/08/2020.
//

import SwiftUI

struct Settings_Detail_View: View {
    var setting: Setting
    @State var acActiive: Bool = false
    @State var text: String = ""
//    @State var images: [ImageItem] = []
    @State var showImagePicker: Bool = false
//    @State var selectImage: ImageItem
    
    var body: some View {
        VStack{
            //                Section{
            if (setting.type == 0){
                Form{
                    Section{
                        Toggle(isOn: self.$acActiive) {
                            VStack(alignment: .leading){
                                Text("New message")
                                    .font(Font.system(size: 19, weight: .regular))
                                HStack {
                                    Text("Someone sent you new messeage.")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding([.top,.bottom], 4)
                            }
                            .padding([.top,.bottom], 5)
                        }
                        
                        Toggle(isOn: self.$acActiive) {
                            VStack(alignment: .leading){
                                Text("Emial")
                                    .font(Font.system(size: 19, weight: .regular))
                                HStack {
                                    Text("Sent new messeage to email.")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding([.top,.bottom], 4)
                            }
                            .padding([.top,.bottom], 5)
                        }
                        
                        Toggle(isOn: self.$acActiive) {
                            VStack(alignment: .leading){
                                Text("Listener")
                                    .font(Font.system(size: 19, weight: .regular))
                                HStack {
                                    Text("Your listener got match.")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding([.top,.bottom], 4)
                            }
                            .padding([.top,.bottom], 5)
                        }
                        
                        Toggle(isOn: self.$acActiive) {
                            VStack(alignment: .leading){
                                Text("Score")
                                    .font(Font.system(size: 19, weight: .regular))
                                HStack {
                                    Text("Your have new score.")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding([.top,.bottom], 4)
                            }
                            .padding([.top,.bottom], 5)
                        }
                        
                        Toggle(isOn: self.$acActiive) {
                            VStack(alignment: .leading){
                                Text("In-app sounds")
                                    .font(Font.system(size: 19, weight: .regular))
                                    .padding([.top,.bottom], 10)
                            }
                            .padding([.top,.bottom], 5)
                        }
                        
                        Toggle(isOn: self.$acActiive) {
                            VStack(alignment: .leading){
                                Text("In-app vibrations")
                                    .font(Font.system(size: 19, weight: .regular))
                                    .padding([.top,.bottom], 10)
                            }
                            .padding([.top,.bottom], 5)
                        }
                    }
                    //                }
                }
            }
            else if (setting.type == 4) {
                ScrollView{
                    Spacer(minLength: 20)
//                    HelpTextView(text: $text)
//                        .frame(minWidth: 150, maxWidth: UIScreen.main.bounds.width - 30, minHeight: 250, maxHeight: 270)
//                        .background(Color.gray.opacity(0.3))
//                        .cornerRadius(5)
                    HStack{
//                        ForEach(images) { item in
//                            ZStack{
//                                ZStack{
//                                    ZStack{
//                                        HStack{
//                                            Button(action: {
//                                                if let row = self.images.firstIndex(where: { $0.id == item.id }) {
//                                                    self.images.remove(at: row)
//                                                }
//                                            }, label: {
//                                                Image(systemName: "xmark.circle.fill")
//                                                    .resizable()
//                                                    .frame(width: 30, height: 30)
//                                                    .foregroundColor(Color.red)
//                                                    .background(Color.white)
//                                                    .clipShape(Circle())
//                                            })
//                                        }
//                                        .padding(EdgeInsets.init(top: 0, leading: 60, bottom: 50, trailing: 0))
//                                    }
//                                    .zIndex(1)
//                                    item.image
//                                        .resizable()
//                                        .frame(width: 80, height: 70)
//                                        .scaledToFill()
//                                }
//                                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
//                            }
//                        }
//                        if (images.count <= 3){
//                            Button(action: {
//                                self.showImagePicker.toggle()
//                            }, label: {
//                                Image(systemName: "photo")
//                                    //                                        .resizable()
//                                    .frame(width: 80, height: 70)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .strokeBorder(
//                                                style: StrokeStyle(
//                                                    lineWidth: 2,
//                                                    dash: [5]
//                                                )
//                                            )
//                                    )
//                                    .foregroundColor(.gray)
//                            })
//                            .disabled(!(images.count <= 4))
//                            .opacity(!(images.count <= 4) ? 0 : 1)
//                            Spacer()
//                        }
                    }
                    .padding(.leading, 15)
                    Button(action: {
                        print("tes")
                    }, label: {
                        Spacer()
                        Text("Reply")
                            .foregroundColor(Color.white)
                            .font(.callout)
                            .bold()
                        Spacer()
                    })
                    .frame(minWidth: 150, maxWidth: UIScreen.main.bounds.width - 30, minHeight: 50, maxHeight: 50)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .listStyle(PlainListStyle())
                }
//                .sheet(isPresented: $showImagePicker) {
//                    ImagePickerChat(sourceType: .photoLibrary) { image in
//                        self.selectImage = ImageItem(image: Image(uiImage: image))
//                        self.appeand()
//                    }
//                }
                
            }
            Text("")
                
                .navigationBarTitle(Text(setting.title), displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            
                                        }) {
                                            Text("Save")
                                                .fontWeight(.medium)
                                        }
                    .opacity((setting.type == 0) ? 1 : 0)
                                        .disabled((!(setting.type == 0)))
                )
        }
    }
    
    func appeand(){
//        self.images.append(selectImage)
    }
}

struct Settings_Detail_View_Previews: PreviewProvider {
    static var previews: some View {
        Settings_Detail_View(setting: Setting.init(id: UUID(), title: "asd", icon: "asd", type: 4))
    }
}
