//
//  AppDelegate.swift
//  ShoppingList
//
//  Created by Hyun on 2016. 3. 12..
//  Copyright © 2016년 wook2. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let seedList = "seedList"

    
    // MARK : Computed Property
    var filePath: String {
        // Get file path
        let fileName = "seedList"
        let fileURL:NSURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        return fileURL.URLByAppendingPathComponent(fileName).path!
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        loadSampleData()
        return true
    }

    // MARK : Helper Method
    func loadSampleData() {
    
        guard let isSeedExist = NSUserDefaults.standardUserDefaults().objectForKey(seedList) as? Bool else {
            print("Cannot unwrapped optional")
            return
        }
        
        if !isSeedExist {
        
            if let filePath  = NSBundle.mainBundle().pathForResource("seed", ofType: "plist"), let seedItems = NSArray(contentsOfFile: filePath) {
        
                var items:[Item]?
            
                for seedItem in seedItems {
            
                    if let name = seedItem["name"] as? String, let price = seedItem["price"] as? Float
                    {
                        print("name: \(name), price : \(price)")
                    
                        // Create Item
                        items?.append(Item(name: name, price:price))
                    }
                }
            }
            
            NSUserDefaults.standardUserDefaults().setObject("true", forKey: seedList)
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

