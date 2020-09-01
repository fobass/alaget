//
//  Profile.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 30/08/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import AuthenticationServices
import GoogleSignIn

struct GenderPicker: View {
    @State private var pickerIndex = 0
    var data = [""]
    // USE this if needed to notify parent
    @Binding var notifyParentOnChangeIndex: Int
    // @EnvironmentObject var store: ProfileStore
    var body: some View {
        let pi = Binding<Int>(get: {
            return self.pickerIndex
        }, set: {
            self.pickerIndex = $0
            //self.store.isChaged = true
            
            // USE this if needed to notify parent
            self.notifyParentOnChangeIndex = $0
        })
        
        return VStack{
            Picker(selection: pi, label: Text("")) {
                ForEach(self.data.indices) {
                    Text(self.data[$0])
                }
            }
            .labelsHidden()
        }
        .environment(\.horizontalSizeClass, .regular)
    }
    
}

struct Profile_View: View {
    var title: String
    var Identities = ["Driver's license", "Passport", "Identity card"]
    var Gender = ["Not Specified", "Male", "Female", "Other"]
    @State var profile: Profile
    @State private var IdentityMode = 0
    @State private var GenderMode = 0
    @State private var acSave = false
    @State private var offsetValue: CGFloat = 0.0
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var selectedDate: Date? = nil
    @EnvironmentObject var store: SettingsStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let googleSignIn = GIDSignIn.sharedInstance()
    
    var body: some View {
        VStack {
            
            Form{
                Section{
                    HStack{
                        if (image == nil) {
                            WebImage(url: URL(string: self.profile.photoURL)!)
                                .resizable()
                                .frame(width: 80, height: 80, alignment: .center)
                                .clipShape(Circle())
                                .scaledToFill()
                                .overlay(Circle().stroke(Color.red.opacity(0.1), lineWidth: 0.5))
                        } else {
                            image?
                                .resizable()
                                .aspectRatio(2316/3088, contentMode: .fill)
                                .frame(width: 80, height: 80, alignment: .center)
                                .clipShape(Circle())
                                .shadow(color: Color.red.opacity(0.2), radius: 3)
                                .scaledToFill()
                                .overlay(Circle().stroke(Color.red.opacity(0.2), lineWidth: 1))
                        }
                        VStack(alignment: .center) {
                            Text("Choose your profile image (optional)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
//                        Spacer()
                    }
                }
                .gesture(TapGesture().onEnded(){
                    self.showImagePicker.toggle()
                })
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        self.image = Image(uiImage: image)
                        self.store.isChaged = true
                    }
                }
                
                Section(){
                    VStack(alignment: .leading) {
                        Text("First Name")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        HStack {
                            TextField("", text: self.$profile.firstName, onEditingChanged: { isEditing in
                                if (self.profile.firstName != self.store.profile.firstName) {
                                    self.store.isChaged = true
                                }
                            }, onCommit: {
                                print("onCommit")
                            })
//                            if (self.profile.firstName != self.store.profile.firstName) {
//                                Text("")
//                            }
                        }
                        
                    }
                    .padding([.top, .bottom], 10)
                    
                    VStack(alignment: .leading) {
                        Text("Last Name")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        HStack {
                            TextField("", text: self.$profile.lastName, onEditingChanged: { isEditing in
                                if (self.profile.lastName != self.store.profile.lastName) {
                                    self.store.isChaged = true
                                }
                            }, onCommit: {
                                print("onCommit")
                            })
                        }
                    }
                    .padding([.top, .bottom], 10)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Gender")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Picker(selection: $profile.gender, label: Text(" ")) {
                                ForEach(0..<Gender.count) {
                                    Text(self.Gender[$0])
                                }
                                
                            }
                            .labelsHidden()
                            //                            GenderPicker(data: Gender, notifyParentOnChangeIndex: self.$profile.gender)//.environmentObject(self.store)
                        }
                    }
                    .padding([.top, .bottom], 10)
                    
                    VStack(alignment: .leading) {
                        Text("Date Of Birth")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        DatePicker("ddd", selection: self.$profile.dateOfBirth, displayedComponents: .date)
//                        DatePicker(
//                            "",
//                            selection: Binding<Date>(get: {(self.profile.dateOfBirth)}, set: {self.profile.dateOfBirth = $0}),
//                            displayedComponents: .date
//                        )
                        .labelsHidden()
                    }
                    .padding([.top, .bottom], 10)
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        HStack {
                            TextField("", text: self.$profile.email, onEditingChanged: { isEditing in
                                if (self.profile.email != self.store.profile.email) {
                                    self.store.isChaged = true
                                }
                            }, onCommit: {
                                print("onCommit")
                            })
                        }
                    }
                    .padding([.top, .bottom], 10)
                    
                    VStack(alignment: .leading) {
                        Text("Phone")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        HStack {
                            TextField("", text: self.$profile.phoneNumber, onEditingChanged: { isEditing in
                                if (self.profile.phoneNumber != self.store.profile.phoneNumber) {
                                    self.store.isChaged = true
                                }
                            }, onCommit: {
                                print("onCommit")
                            })
                            
                        }
                    }
                    .padding([.top, .bottom], 10)
                    
                    VStack(alignment: .leading) {
                        Text("About")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        HStack {
                            TextField("", text: self.$profile.about, onEditingChanged: { isEditing in
                                if (self.profile.about != self.store.profile.about) {
                                    self.store.isChaged = true
                                }
                            }, onCommit: {
                                print("onCommit")
                            })
                            
                        }
                    }
                    .padding([.top, .bottom], 10)
                }
                
                Section(){
                    VStack(alignment: .leading) {
                        Text("Location")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        HStack {
                            Text("self.store.location")
                        }
                    }
                    .padding([.top, .bottom], 10)
                    
                }
                
                Section(){
//                    VStack(alignment: .leading) {
//                        VStack(alignment: .leading) {
//                            Text("Identity verification")
//                                .font(.subheadline)
//                                .bold()
//                            Spacer()
//                            Picker(selection: $IdentityMode, label: Text(" ")) {
//                                ForEach(0..<Identities.count) {
//                                    Text(self.Identities[$0])
//                                }
//
//                            }
//                            .labelsHidden()
//                        }
//                    }
//                    .padding([.top, .bottom], 10)
                    
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text("Emergency Contact")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        HStack {
                            TextField("", text: self.$profile.about, onEditingChanged: { isEditing in
                                if (self.profile.about != self.store.profile.about) {
                                    self.store.isChaged = true
                                }
                            }, onCommit: {
                                print("onCommit")
                            })
                            
                        }
                    }
                    .padding([.top, .bottom], 10)
                    
                }
                
                Section(){
                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            googleSignIn?.signOut()
                            self.store.logout()
                        }) {
                            Text("Log Out")
                                .font(.headline)
                                .foregroundColor(Color.red.opacity(0.4))
                        }
                        Spacer()
                    }
                    
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            .onAppear(){
                if (self.store.profile.gender != self.profile.gender) {
                    self.store.isChaged = true
                } else {
                    self.store.isChaged = false
                }
            }
            
            .keyboardSensible($offsetValue)
            .navigationBarItems(leading:
                                    Button(action: {
                                        if (self.store.isChaged) {
                                            self.acSave.toggle()
                                        } else {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }) {
                                        Image(systemName: "chevron.left")
                                            .font(.custom("ArialRoundedMTBold", size: 17))
                                            .padding(.all, 10)
                                            .foregroundColor(Color.black)
                                    }
                                    .padding([.bottom,.top, .trailing], 20)
                                    .clipShape(Circle())
                                ,
                                trailing:
                                    Button(action: {
                                        withAnimation(){
                                            self.update()
                                        }
                                    }) {
                                        Image(systemName: "checkmark")
                                            .font(.custom("ArialRoundedMTBold", size: 17))
                                            .padding(.all, 10)
                                            .foregroundColor((!self.store.isChaged) ? Color.black : Color.blue)
                                    }
                                    .padding([.bottom,.top, .trailing], 20)
                                    .clipShape(Circle())
                                    .disabled((!self.store.isChaged))// || (image == nil))
            )
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text(title), displayMode: .inline)
            
        }
        
        .alert(isPresented: $acSave) {
            Alert(title: Text("Usaved changes"), message: Text("Do you want to save the changes to your profile?"), primaryButton: .destructive(Text("Discard")) {
                self.store.isChaged = false
                self.presentationMode.wrappedValue.dismiss()
            },
            
            secondaryButton: .cancel(Text("Save"), action: {
                self.update()
            }))
            
        }
    }
    
    func update()  {
        if self.store.isChaged {
            self.store.profile.lastName = self.profile.lastName
            self.store.profile.firstName = self.profile.firstName
            self.store.profile.phoneNumber = self.profile.phoneNumber
            self.store.profile.email = self.profile.email
            self.store.profile.about = self.profile.about
            self.store.profile.gender = self.profile.gender
            self.store.profile.dateOfBirth = self.profile.dateOfBirth
            
            self.store.update(profile: self.store.profile, completionHandler: {success, err in
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            })
        }
    }
}

struct Profile_View_Previews: PreviewProvider {
    static var user = Setting.init(title: "Notifications", icon: "person", type: 1)
    static var previews: some View {
        Profile_View(title: "title", profile: SettingsStore().profile).environmentObject(SettingsStore())//.previewLayout(.sizeThatFits)
    }
}
