//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Taguhi Abgaryan on 2/22/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit
import Messages

/*    +-------------------------------------------------------------------------------------------------------+
      |  NOTE: While not strictly enforced, here are the file sizes that Apple recommends for sticker packs:  |
      |  - Small:  300 x 300 pixel image                                                                      |
      |  - Medium: 378 x 378 pixel image                                                                      |
      |  - Large:  618 x 618 pixel image                                                                      |
      +-------------------------------------------------------------------------------------------------------+      */

// -- MessagesViewController constants

let packagesWidthCoefficient: CGFloat = 0.2

class MessagesViewController: MSMessagesAppViewController, UIScrollViewDelegate {
    
    private let packages = UIScrollView()
    private let packagesContainer = UIView()
    private let stickers = UIScrollView()
    private let stickersContainer = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPackages()
        setupStickers()
    }
    
    private func setupPackages() {
        packages.contentSize = packagesContentSize()
        packagesContainer.backgroundColor = Colors.lavender
        
        for index in 0..<10 {
            let packageButton = UIButton(type: .roundedRect)
            packageButton.frame = CGRect(x: 10, y: 10 + index * (50 + 10), width: 50, height: 50)
            packageButton.backgroundColor = UIColor.green
            packageButton.setTitle("test", for: UIControlState.normal)
            packageButton.tag = index
            //            buttonOne.addTarget(self, action: "buttonAction1x1:", for: UIControlEvents.touchUpInside)
            
            packagesContainer.addSubview(packageButton)
        }
        packages.addSubview(packagesContainer)
        view.addSubview(packages)
    }
    
    private func setupStickers() {
        stickers.contentSize = stickersContentSize()
        stickersContainer.backgroundColor = Colors.lavenderblush
        
//        let columns = 5
        
        for index in 0..<10 {
            let stickerButton = UIButton(type: .roundedRect)
            stickerButton.frame = CGRect(x: 10, y: 10 + index * (50 + 10), width: 50, height: 50)
            stickerButton.backgroundColor = UIColor.gray
            stickerButton.setTitle("test", for: UIControlState.normal)
            stickerButton.tag = index
            //            buttonOne.addTarget(self, action: "buttonAction1x1:", for: UIControlEvents.touchUpInside)
            stickersContainer.addSubview(stickerButton)
        }
        stickers.addSubview(stickersContainer)
        view.addSubview(stickers)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // packages
        let packagesSize = packagesContentSize()
        packages.frame = CGRect(x: 0, y: 0, width: packagesSize.width, height: view.bounds.height)
        packagesContainer.frame = CGRect(x: 0, y: 0, width: packagesSize.width, height: packagesSize.height)
        // stickers
        let stickersSize = stickersContentSize()
        stickers.frame = CGRect(x: packages.frame.midX, y: 0, width: stickersSize.width, height: view.bounds.height)
        stickersContainer.frame = CGRect(x: packages.frame.midX, y: 0, width: stickersSize.width, height: stickersSize.height)
        print("TA: did layout, --st \(stickers.frame.maxX), --wd \(view.bounds.width)")
        
    }
    
    private func packagesContentSize() -> CGSize {
        return CGSize(width: view.frame.width * packagesWidthCoefficient, height: 1000)
    }
    
    private func stickersContentSize() -> CGSize {
        return CGSize(width: view.frame.width - packagesContentSize().width, height: 1000)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("TA: Memory warning")
    }
    
// -----------------------------------------------------------------------------------------------
    
//    // MARK: - Conversation Handling
//    
//    override func willBecomeActive(with conversation: MSConversation) {
//        // Called when the extension is about to move from the inactive to active state.
//        // This will happen when the extension is about to present UI.
//        
//        // Use this method to configure the extension and restore previously stored state.
//    }
//    
//    override func didResignActive(with conversation: MSConversation) {
//        // Called when the extension is about to move from the active to inactive state.
//        // This will happen when the user dissmises the extension, changes to a different
//        // conversation or quits Messages.
//        
//        // Use this method to release shared resources, save user data, invalidate timers,
//        // and store enough state information to restore your extension to its current state
//        // in case it is terminated later.
//    }
//   
//    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
//        // Called when a message arrives that was generated by another instance of this
//        // extension on a remote device.
//        
//        // Use this method to trigger UI updates in response to the message.
//    }
//    
//    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
//        // Called when the user taps the send button.
//    }
//    
//    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
//        // Called when the user deletes the message without sending it.
//    
//        // Use this to clean up state related to the deleted message.
//    }
//    
//    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
//        // Called before the extension transitions to a new presentation style.
//    
//        // Use this method to prepare for the change in presentation style.
//    }
//    
//    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
//        // Called after the extension transitions to a new presentation style.
//    
//        // Use this method to finalize any behaviors associated with the change in presentation style.
//    }
    
}

