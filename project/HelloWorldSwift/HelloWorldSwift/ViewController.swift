//
//  Copyright (c) 2011-2014 orbotix. All rights reserved.
//

import UIKit
import PubNub

class ViewController: UIViewController {
    var robot: RKConvenienceRobot!
    var ledON = false
    
    var client: MessagingClient!;
    
    var contentView: MainView!;
    
    var stopper: Int! = 0;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init () {
        super.init(nibName: nil, bundle: NSBundle(forClass: self.dynamicType))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillResignActive:", name: UIApplicationWillResignActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appDidBecomeActive:", name: UIApplicationDidBecomeActiveNotification, object: nil)
        
//        RKRobotDiscoveryAgent.sharedAgent().addNotificationObserver(self, selector: "handleRobotStateChangeNotification:")
        
        RKRobotDiscoveryAgent.sharedAgent().addNotificationObserver(self, selector: #selector(self.handleRobotStateChangeNotification(_:)))
        
        contentView = MainView(frame: CGRectZero);
        view = contentView;
        
//        client = MessagingClient(controller: self);
        
        contentView.Sleep.addTarget(self, action: #selector(self.sleep(_:)), forControlEvents: .TouchUpInside)
        
        contentView.DriveForward.addTarget(self, action: #selector(self.driveForward(_:)), forControlEvents: .TouchUpInside)
        
        contentView.DriveReverse.addTarget(self, action: #selector(self.driveReverse(_:)), forControlEvents: .TouchUpInside)
        
        contentView.DriveLeft.addTarget(self, action: #selector(self.driveLeft(_:)), forControlEvents: .TouchUpInside)
        
        contentView.DriveRight.addTarget(self, action: #selector(self.driveRight(_:)), forControlEvents: .TouchUpInside)
        
        contentView.Stop.addTarget(self, action: #selector(self.stop(_:)), forControlEvents: .TouchUpInside)
        
        contentView.InitToggle.addTarget(self, action: #selector(self.initToggle(_:)), forControlEvents: .TouchUpInside)
    }
    
    func appWillResignActive(note: NSNotification) {
        RKRobotDiscoveryAgent.disconnectAll()
        stopDiscovery()
    }
    
    func appDidBecomeActive(note: NSNotification) {
        startDiscovery()
    }
    
    func sleep(sender: AnyObject) {
        if let robot = self.robot {
            contentView.Label.text = "Sleeping"
            robot.sleep()
        }
    }
    
    func handleRobotStateChangeNotification(notification: RKRobotChangedStateNotification) {
        let noteRobot = notification.robot
        
        switch (notification.type) {
        case .Connecting:
            contentView.Label.text = "\(notification.robot.name()) Connecting"
            break
        case .Online:
            let conveniencerobot = RKConvenienceRobot(robot: noteRobot);
            
            if (UIApplication.sharedApplication().applicationState != .Active) {
                conveniencerobot.disconnect()
            } else {
                self.robot = RKConvenienceRobot(robot: noteRobot);
                
                contentView.Label.text = noteRobot.name()
                stabilize();
            }
            break
        case .Disconnected:
            contentView.Label.text = "Disconnected"
            startDiscovery()
            robot = nil;
            
            break
        default:
            NSLog("State change with state: \(notification.type)")
        }
    }
    
    func startDiscovery() {
        contentView.Label.text = "Discovering Robots"
        RKRobotDiscoveryAgent.startDiscovery()
    }
    
    func stopDiscovery() {
        RKRobotDiscoveryAgent.stopDiscovery()
    }
    
    var isRed: Bool = true;
    var isGreen: Bool = false;;
    var isBlue: Bool = false;
    
    var doContinue: Bool = false;
    
    func togleLED() {
        if let robot = self.robot {
            
            if (isRed) {
                isGreen = true;
                isRed = false;
                isBlue = false;
                robot.setLEDWithRed(0.0, green: 1.0, blue: 0.0)
            } else if (isBlue) {
                isRed = true;
                isGreen = false;
                isBlue = false;
                robot.setLEDWithRed(1.0, green: 0.0, blue: 0.0)
            } else {
                isBlue = true;
                isRed = false;
                isGreen = false;
                robot.setLEDWithRed(0.0, green: 0.0, blue: 1.0)
            }
            
            let delay = Int64(0.5 * Float(NSEC_PER_SEC))
            
            if (doContinue) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), { () -> Void in
                self.togleLED();
                })
            } else {
                self.stabilize();
            }
        }
    }
    
    func stabilize() {
        robot.setLEDWithRed(50, green: 100, blue: 0);
    }
    
    func drive(command: String) {

            if (command == "Forward") {
                self.driveForward();
            } else if (command == "Reverse") {
                self.driveReverse();
            } else if (command == "Left") {
                self.driveLeft();
            } else if (command == "Right") {
                self.driveRight();
            } else if (command == "Stop") {
                self.stop();
        }
    }
    
    let velocity:Float = 0.4;
    
    func driveForward() {
        robot.driveWithHeading(0, andVelocity: velocity);
    }
    
    func driveReverse() {
        robot.driveWithHeading(180, andVelocity: velocity);
    }
    
    func driveLeft() {
        robot.driveWithHeading(270, andVelocity: velocity);
    }
    
    func driveRight() {
        robot.driveWithHeading(90, andVelocity: velocity);
    }
    
    func stop() {
        robot.stop();
    }
    
    func driveForward(sender: AnyObject) {
        driveForward();
    }
    
    func driveReverse(sender: AnyObject) {
        driveReverse();
    }
    
    func driveLeft(sender: AnyObject) {
        driveLeft();
    }
    
    func driveRight(sender: AnyObject) {
        driveRight();
    }
    
    func stop(sender: AnyObject) {
        stop();
    }
    
    func initToggle(sender: AnyObject) {
        doContinue = !doContinue;
        togleLED();
    }
}





