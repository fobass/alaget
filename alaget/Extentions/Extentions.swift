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

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 0.5)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


extension Bundle {
    
//    public var appVersionShort: String? {
//        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
//            return result
//        } else {
//            return "⚠️"
//        }
//    }
//    public var appVersionLong: String? {
//        if let result = infoDictionary?["CFBundleVersion"] as? String {
//            return result
//        } else {
//            return "⚠️"
//        }
//    }
//    public var appName: String? {
//        if let result = infoDictionary?["CFBundleName"] as? String {
//            return result
//        } else {
//            return "⚠️"
//        }
//    }
    
    public var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "⚠️"
    }
    public var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "⚠️"
    }
    public var version: String {
        return "\(release).\(build)"
    }
    public var name: String {
        if let result = infoDictionary?["CFBundleName"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    
}

extension Color {

    static let lightBackgroundColor = Color(white: 1.0)

    static let darkItemBackgroundColor = Color("itemColor")
    
    static let darkBackgroundColor = Color(white: 0.0)

    static func itemBackgroundColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return darkItemBackgroundColor
        } else {
            return lightBackgroundColor
        }
    }
    
    static func backgroundColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return darkBackgroundColor
        } else {
            return lightBackgroundColor
        }
    }
    
    
    
    static func shadowColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return Color.gray.opacity(0.3)
        } else {
            return Color.gray.opacity(0.5)
        }
    }
}

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
