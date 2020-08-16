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
