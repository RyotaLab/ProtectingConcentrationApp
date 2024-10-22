//
//  ProtectConcentrationApp.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI
import NotificationCenter
import UIKit

@main
struct ProtectConcentrationApp: App {
    
    @StateObject private var purchaseManager = PurchaseManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(purchaseManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        //通知処理
        NotificationManager.instance.requestPermission()
        UNUserNotificationCenter.current().delegate = self
        
        //レビューリクエストが済んでいるか判断
        let isRequestReview = UserDefaults.standard.bool(forKey: "isRequest")
        
        if !isRequestReview {
            //初期値はゼロ、起動ごとに1回増やす
            var launchCount = UserDefaults.standard.integer(forKey: "launchCount")
            launchCount += 1
            UserDefaults.standard.setValue(launchCount, forKey: "launchCount")
        }
        
        return true
    }
    
}
