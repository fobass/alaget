//
//  Extentions.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import Foundation
import UIKit
import SwiftUI


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.996 : 1)
            .opacity(configuration.isPressed ? 0.93 : 1)
            .animation(.linear(duration: 0.1))
    }
}
