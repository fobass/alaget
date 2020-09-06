//
//  Extentions.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import Foundation
import UIKit
import SwiftUI

func DateToStr(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "YYYY-MM-dd 00:00:00"
    return formatter.string(from: date)
}

func StrToDate(str: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    if let date = dateFormatter.date(from: str) {
        return date
    } 
    return Date()
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode)
    private var presentationMode
    
    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void
    
    final class Coordinator: NSObject,
        UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {
        
        @Binding
        private var presentationMode: PresentationMode
        private let sourceType: UIImagePickerController.SourceType
        private let onImagePicked: (UIImage) -> Void
        
        init(presentationMode: Binding<PresentationMode>,
             sourceType: UIImagePickerController.SourceType,
             onImagePicked: @escaping (UIImage) -> Void) {
            _presentationMode = presentationMode
            self.sourceType = sourceType
            self.onImagePicked = onImagePicked
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            onImagePicked(uiImage)
            presentationMode.dismiss()
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode,
                           sourceType: sourceType,
                           onImagePicked: onImagePicked)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}

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
    
    func keyboardSensible(_ offsetValue: Binding<CGFloat>) -> some View {
            
            return self
                .padding(.bottom, offsetValue.wrappedValue)
                .animation(.easeOut)
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                        
                        let keyWindow = UIApplication.shared.connectedScenes
                            .filter({$0.activationState == .foregroundActive})
                            .map({$0 as? UIWindowScene})
                            .compactMap({$0})
                            .first?.windows
                            .filter({$0.isKeyWindow}).first
                        
                        let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
                        
                        let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let height = value.height - 47
                        
                        offsetValue.wrappedValue = height - (bottom  )
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                        offsetValue.wrappedValue = 0
                    }
            }
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
