//
//  Trip.View.swift
//  alaget
//
//  Created by Ernist Isabekov on 29/08/2020.
//

import SwiftUI

struct Trip_View: View {
    @State var addAction : Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    Text("My upcoming trips")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .foregroundColor(Color.black.opacity(0.5))
                    Spacer()
                }
                .padding(.leading, 25)
            }
            .navigationBarItems(trailing:
                VStack {
                    Button(action: {
                        self.addAction.toggle()
                    }) {
                       Image(systemName: "plus.square.fill")
                    }
                }
            )
            .navigationBarTitle("Trip", displayMode: .large)
        }
    }
}

struct Trip_View_Previews: PreviewProvider {
    static var previews: some View {
        Trip_View()
    }
}
