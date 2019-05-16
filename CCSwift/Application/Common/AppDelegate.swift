//
//  AppDelegate.swift
//  CCSwift
//
//  Created by job on 2019/1/16.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit
import Toast_Swift
import UserNotifications
import CoreLocation
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = TabBarController()

//        FLEXManager.shared().showExplorer()
        
        
        /// 获取推送权限
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){accepted, error in}
  
        
        locationManager.delegate = self

        FirebaseApp.configure()
//        let content = UNMutableNotificationContent()
//        content.title = "后台唤起了呢"
//        //不同的标识生成不同的弹出框（identifier）这是个标识
//        let request = UNNotificationRequest.init(identifier: "哈哈哈哈哈", content: content, trigger: nil)
//        UNUserNotificationCenter.current().add(request) { erro in }
        
        return true
    }

    func push(_ title: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        //不同的标识生成不同的弹出框（identifier）这是个标识
        let request = UNNotificationRequest.init(identifier: "哈哈哈哈哈", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { erro in }
    }
    
    //    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    //        self.push("进入了");
    //    }
    //    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    //        self.push("出去了");
    //
    //    }
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        switch state {
        case .inside:
            self.push("后台静默下进入了");
            break
        case .outside:
            self.push("后台静默下退出了");
            break
        default:
            self.push("unknow");
        }
    }
    
    
    /// 捷径
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.interaction!.intent.isKind(of: CClionIntent.self){
            window?.makeToast("捷径触发成功")
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

