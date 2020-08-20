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
