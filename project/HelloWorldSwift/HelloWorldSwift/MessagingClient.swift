//
//  MessagingClient.swift
//  HelloWorldSwift
//
//  Created by Macbook on 4/15/16.
//  Copyright © 2016 orbotix. All rights reserved.
//

import Foundation
import PubNub

public class MessagingClient: NSObject, PNObjectEventListener {
    
    let CHANNEL: String = "garagebb8control";
    
    let PUBLISHKEY: String = "pub-c-98199bc8-0eff-41df-8b3c-4df4a3a6d1f8";
    let SUBSCRIBEKEY: String = "sub-c-ca87811c-f7ea-11e5-b552-02ee2ddab7fe";
    
    var controller: ViewController!
    
    // Instance property
    public var client: PubNub?
    
    // For demo purposes the initialization is done in the init function so that
    // the PubNub client is instantiated before it is used.
    init(controller: ViewController) {
        
        super.init();
        
        self.controller = controller;
        
        // Instantiate configuration instance.
        let configuration = PNConfiguration(publishKey: PUBLISHKEY, subscribeKey: SUBSCRIBEKEY)
        // Instantiate PubNub client.
        client = PubNub.clientWithConfiguration(configuration)

        client?.addListener(self)
        print("MessagingClient: Init: ");
        print( self.client);
        self.client?.subscribeToChannels([CHANNEL], withPresence: true)
    }
    
    // Handle new message from one of channels on which client has been subscribed.
    public func client(client: PubNub, didReceiveMessage message: PNMessageResult) {
        print("MessagingClient: Received");
        
        // Handle new message stored in message.data.message
        if message.data.actualChannel != nil {
            
            // Message has been received on channel group stored in
            // message.data.subscribedChannel
        }
        else {
            
            // Message has been received on channel stored in
            // message.data.subscribedChannel
        }
        
        print("Received message: \(message.data.message) on channel " +
            "\((message.data.actualChannel ?? message.data.subscribedChannel)!) at " +
            "\(message.data.timetoken)")
        
        let forward = "Optional({\"message\": \"forward\"})";
        let reverse = "Optional({\"message\": \"reverse\"})";
        let left = "Optional({\"message\": \"left\"})";
        let right = "Optional({\"message\": \"right\"})";
        let stop = "Optional({\"message\": \"stop\"})";
        
        let command = message.data.message;
        let final: String = String(command);
        var parsed: String!;
        
        if (final == forward) {
//            controller.driveForward();
            parsed = "Forward";
        } else if (final == reverse) {
//            controller.driveReverse();
            parsed = "Reverse";
        } else if (final == left) {
//            controller.driveLeft();
            parsed = "Left";
        } else if (final == right) {
//            controller.driveRight();
            parsed = "Right";
        } else if (final == stop) {
            parsed = "Stop";
        }
        
        controller.drive(parsed);
    }
    
    // New presence event handling.
    public func client(client: PubNub, didReceivePresenceEvent event: PNPresenceEventResult) {
        
        // Handle presence event event.data.presenceEvent (one of: join, leave, timeout,
        // state-change).
        if event.data.actualChannel != nil {
            
            // Presence event has been received on channel group stored in
            // event.data.subscribedChannel
        }
        else {
            
            // Presence event has been received on channel stored in
            // event.data.subscribedChannel
        }
        
        if event.data.presenceEvent != "state-change" {
            
            print("\(event.data.presence.uuid) \"\(event.data.presenceEvent)'ed\"\n" +
                "at: \(event.data.presence.timetoken) " +
                "on \((event.data.actualChannel ?? event.data.subscribedChannel)!) " +
                "(Occupancy: \(event.data.presence.occupancy))");
        }
        else {
            
            print("\(event.data.presence.uuid) changed state at: " +
                "\(event.data.presence.timetoken) " +
                "on \((event.data.actualChannel ?? event.data.subscribedChannel)!) to:\n" +
                "\(event.data.presence.state)");
        }
    }
    
    
//    // Handle subscription status change.
//    public func client(client: PubNub!, didReceiveStatus status: PNSubscribeStatus!) {
//        
//        if status.category == .PNUnexpectedDisconnectCategory {
//            
//            // This event happens when radio / connectivity is lost
//        }
//        else if status.category == .PNConnectedCategory {
//            
//            // Connect event. You can do stuff like publish, and know you'll get it.
//            // Or just use the connected event to confirm you are subscribed for
//            // UI / internal notifications, etc
//            
//            // Select last object from list of channels and send message to it.
//            let targetChannel = client.channels().last as! String
//            client.publish("Hello from the PubNub Swift SDK", toChannel: targetChannel,
//                compressed: false, withCompletion: { (status) -> Void in
//                    
//                    if !status.error {
//                        
//                        // Message successfully published to specified channel.
//                    }
//                    else{
//                        
//                        // Handle message publish error. Check 'category' property
//                        // to find out possible reason because of which request did fail.
//                        // Review 'errorData' property (which has PNErrorData data type) of status
//                        // object to get additional information about issue.
//                        //
//                        // Request can be resent using: status.retry()
//                    }
//            })
//        }
//        else if status.category == .PNReconnectedCategory {
//            
//            // Happens as part of our regular operation. This event happens when
//            // radio / connectivity is lost, then regained.
//        }
//        else if status.category == .PNDecryptionErrorCategory {
//            
//            // Handle messsage decryption error. Probably client configured to
//            // encrypt messages and on live data feed it received plain text.
//        }
//    }
    
}