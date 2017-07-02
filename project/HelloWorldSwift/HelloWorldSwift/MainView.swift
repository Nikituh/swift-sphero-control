//
//  MainView.swift
//  HelloWorldSwift
//
//  Created by Aare Undo on 14/04/16.
//  Copyright © 2016 orbotix. All rights reserved.
//

import Foundation

import UIKit

public class MainView: UIView {
    
    public var Label: UILabel!
    public var Sleep: UIButton!
    
    public var DriveForward: UIButton!;
    public var DriveReverse: UIButton!;
    
    public var DriveLeft: UIButton!;
    public var DriveRight: UIButton!;
    
    public var Stop: UIButton!;
    public var InitToggle: UIButton!;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        backgroundColor = UIColor.init(red: 245, green: 245, blue: 245, alpha: 1.0);
        
        Label = UILabel();
        Label.textAlignment = NSTextAlignment.Center;
        
        Sleep = UIButton();
        Sleep.backgroundColor = UIColor.magentaColor();
        
        DriveForward = UIButton();
        DriveForward.backgroundColor = UIColor.lightGrayColor();
        
        DriveReverse = UIButton();
        DriveReverse.backgroundColor = UIColor.lightGrayColor();
        
        DriveLeft = UIButton();
        DriveLeft.backgroundColor = UIColor.lightGrayColor();
        
        DriveRight = UIButton();
        DriveRight.backgroundColor = UIColor.lightGrayColor();
        
        Stop = UIButton();
        Stop.backgroundColor = UIColor.greenColor();
        
        InitToggle = UIButton();
        InitToggle.backgroundColor = UIColor.blueColor();
        
        addSubview(Label);
        addSubview(Sleep);
        
        addSubview(DriveForward);
        addSubview(DriveReverse);
        
        addSubview(DriveLeft);
        addSubview(DriveRight);
        
        addSubview(Stop);
        addSubview(InitToggle);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        
        var x: CGFloat = 0;
        var y: CGFloat = 0;
        var w: CGFloat = frame.width;
        var h: CGFloat = 100;
        
        let buttonSize: CGFloat = 60;
        let innerPadding: CGFloat = 5;
        
        Label.frame = CGRect(x: x, y: y, width: w, height: h);
        
        y = frame.height - h;
        
        w = buttonSize;
        h = buttonSize;
        
        Sleep.frame = CGRect(x: x, y: y, width: w, height: h);

        x = 100;
        y = 200;
        
        DriveForward.frame = CGRect(x: x, y: y, width: w, height: h);
        
        y += 2 * buttonSize + 2 * innerPadding;
        
        DriveReverse.frame = CGRect(x: x, y: y, width: w, height: h);
        
        x -= buttonSize + innerPadding;
        y -= buttonSize + innerPadding;
        
        DriveLeft.frame = CGRect(x: x, y: y, width: w, height: h);
        
        x += 2 * buttonSize + 2 * innerPadding;
        
        DriveRight.frame = CGRect(x: x, y: y, width: w, height: h);
        
        x = frame.width - w;
        y = 100;
        
        Stop.frame = CGRect(x: x, y: y, width: w, height: h);
        
        y = 300;
        
        InitToggle.frame = CGRect(x: x, y: y, width: w, height: h);
    }
}






