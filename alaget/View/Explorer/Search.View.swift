//
//  Search.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI

struct Search_View: View {
    @State var showCancelButton: Bool = false
    @State var searchText: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    withAnimation(Animation.linear.delay(2)) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.custom("ArialRoundedMTBold", size: 14))
                        .padding(.all, 19)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .clipShape(Circle())
                })
                
                TextField("Type country or citiy name", text: self.$searchText, onEditingChanged: { isEditing in
                    self.showCancelButton.toggle()
                }, onCommit: {
                    print("onCommit")
                })
                .foregroundColor(Color.black)
                .font(.system(size: 16))
                
                Button(action: {
                    self.searchText = ""
                    self.showCancelButton.toggle()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(self.searchText == "" ? 0 : 1)
                        .font(.custom("ArialRoundedMTBold", size: 14))
                        .padding(.all, 16)
                        .foregroundColor(Color.gray)
                        .background(Color.white)
                        .clipShape(Circle())
                    
                }
            }
            Spacer()
        }
    }
}

struct Search_View_Previews: PreviewProvider {
    static var previews: some View {
        Search_View()
    }
}
