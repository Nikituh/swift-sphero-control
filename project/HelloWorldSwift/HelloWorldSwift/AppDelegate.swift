//
//  Copyright (c) 2011-2014 orbotix. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var controller: UIViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

        controller = ViewController();
        
        window?.rootViewController = controller;
        window?.makeKeyAndVisible();

        return true;
    }
}

