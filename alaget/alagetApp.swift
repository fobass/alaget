//
//  alagetApp.swift
//  alaget
//
//  Created by Ernist Isabekov on 16/08/2020.
//

import SwiftUI
import UIKit
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    
    lazy var persistentContainer: NSPersistentContainer = {
         let container = NSPersistentContainer(name: "DataBase")
         container.loadPersistentStores(completionHandler: { (storeDescription, error) in
           if let error = error as NSError? {
             fatalError("Unresolved error \(error), \(error.userInfo)")
           }
         })
         return container
       }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("didFinishLaunchingWithOptions")
        return true
    }

}

@main
struct alagetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            Main_View().environmentObject(userStore)
        }
    }
}
