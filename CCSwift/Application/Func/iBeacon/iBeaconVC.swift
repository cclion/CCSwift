//
//  iBeaconVC.swift
//  CCSwift
//
//  Created by job on 2019/4/28.
//  Copyright © 2019 我是花轮. All rights reserved.
//
/*
 参考文章
 https://sevencho.github.io/archives/1f6c5df3.html
 https://sevencho.github.io/archives/b05dc691.html
 
 1.在info.plist文件里面配置下面的key
 NSLocationAlwaysAndWhenInUseUsageDescription // 推荐
 NSLocationWhenInUseUsageDescription
 NSLocationAlwaysUsageDescription
 2.在capabilities里面开启Background Modes的 Location updates
 
 */

import UIKit
import CoreLocation
import Toast_Swift
import UserNotifications

class iBeaconVC:
UIViewController,
CLLocationManagerDelegate{
    let locationManager = CLLocationManager()

    var showView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
    var data = [String:[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestAlwaysAuthorization() // 必须要申请权限,否者不会回调扫描到beacons的代理方法
        locationManager.delegate = self
//        locationManager.activityType = .automotiveNavigation
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locationManager.distanceFilter = 10.0
        
        let uuid = UUID.init(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825")
        let region = CLBeaconRegion.init(proximityUUID: uuid!, identifier: "test")
        region.notifyOnEntry = true
        region.notifyOnExit = true
        region.notifyEntryStateOnDisplay = true

        self.view.addSubview(showView)
        showView.center = self.view.center
        
        locationManager.startRangingBeacons(in: region)
        locationManager.startMonitoring(for: region)
    }

    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("开始检测")
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
            self.push("静默下进入了");
            break
        case .outside:
            self.push("静默下退出了");
            break
        default:
            self.push("unknow");
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        var toastStr = ""
        
        for b in beacons {
            toastStr = toastStr + (NSString.init(format: "%@%f\n", b.minor, b.accuracy) as String)
        }
        self.view.makeToast(toastStr)
        
        if beacons.count > 0 {
            var beacon:CLBeacon?
            
            for b in beacons {
                
                if b.accuracy >= 0 {
                    
                    if beacon == nil {
                      beacon = b
                    }
                    
                    if b.accuracy < beacon!.accuracy {
                        beacon = b
                        print(b)
                        print(b.accuracy)
                    }
                }
            }
            
            if beacon?.minor == 55666 {
                showView.backgroundColor = UIColor.yellow
            }else if beacon?.minor == 55660 {
                showView.backgroundColor = UIColor.red
            }else if beacon?.minor == 55658 {
                showView.backgroundColor = UIColor.green
            }else{
                showView.backgroundColor = UIColor.black
            }
        }
        
    }
    
    
}
