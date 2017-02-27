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
    
    // MARK: - Properties
    
    // Model
    private var stickerPackages = [StickerPackage]()
    private var chosenPackageIndex = 0 // NOTE: default index can de saved in user defaults // this shows index of a package that was chosen by user (default is 0)
    // View
    private let packagesView = UIScrollView()
    private let packagesContainerView = UIView()
    private let stickersView = UIScrollView()
    private let stickersContainerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stickerPackages = StickerManager.shared.packages
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPackages()
        setupStickers()
        updateFrames()
    }
    
    // size of one package view
    private func packageViewSize() -> CGSize {
        let width = packagesView.frame.width
        let height = width
        return CGSize(width: width, height: height)
    }
    
    // size of one sticker view
    private func stickerViewSize() -> CGSize {
        let width = stickersView.frame.width / CGFloat(Constants.stickersCountInRow)
        let height = width
        return CGSize(width: width, height: height)
    }
    
    private func setupPackages() {
        packagesView.contentSize = packagesContentSize()
        packagesContainerView.backgroundColor = Colors.lavender
        
        for index in 0..<stickerPackages.count {
            let packageView = UIImageView(image: stickerPackages[index].thumbnail)
            let size = packageViewSize()
            let coefficient = CGFloat(Constants.packageWidthCoefficient)
            let actualSize = CGSize(width: size.width * coefficient, height: size.height * coefficient)
            let margin = (size.width - actualSize.width) / 2.0
            packageView.frame = CGRect(x: margin, y: margin + CGFloat(index) * (actualSize.height + margin), width: actualSize.width, height: actualSize.height)
            packageView.layer.cornerRadius = packageView.frame.width / 2.0
            packageView.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(packageTapAction(sender:)))
            packageView.addGestureRecognizer(gesture)
            packageView.tag = index
            packagesContainerView.addSubview(packageView)
        }
        packagesView.addSubview(packagesContainerView)
        view.addSubview(packagesView)
    }
    
    private func setupStickers() {
        // remove previous stickers
        stickersContainerView.subviews.forEach({ $0.removeFromSuperview() })
        
        stickersView.contentSize = stickersContentSize()
        stickersContainerView.backgroundColor = Colors.lavenderblush
        
        if chosenPackageIndex >= 0 && chosenPackageIndex < stickerPackages.count {
            if let stickers = stickerPackages[chosenPackageIndex].stickers {
                for index in 0..<stickers.count {
                    let stickerView = UIImageView(image: stickers[index])
                    let size = stickerViewSize()
                    let coefficient = CGFloat(Constants.stickerWidthCoefficient)
                    let actualStickerSize = CGSize(width: size.width * coefficient, height: size.height * coefficient)
                    let margin = (size.width - actualStickerSize.width) / 2.0
                    stickerView.frame = CGRect(x: margin + CGFloat(index % Constants.stickersCountInRow) * (actualStickerSize.width + margin), y: margin + CGFloat(index / Constants.stickersCountInRow) * (actualStickerSize.height + margin), width: actualStickerSize.width, height: actualStickerSize.height)
                    stickerView.layer.cornerRadius = stickerView.frame.width / 2.0
                    stickerView.isUserInteractionEnabled = true
                    let gesture = UITapGestureRecognizer(target: self, action: #selector(stickerTapAction(sender:)))
                    stickerView.addGestureRecognizer(gesture)
                    stickerView.tag = index
                    stickersContainerView.addSubview(stickerView)
                }
                stickersView.addSubview(stickersContainerView)
                view.addSubview(stickersView)
            }
        } else {
            print("TA: Index out of range")
        }
    }
    
    @objc private func stickerTapAction(sender: UITapGestureRecognizer) {
        print("imagine i'm sending a sticker #\(sender.view?.tag)")
    }
    
    @objc private func packageTapAction(sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            chosenPackageIndex = tag
            setupStickers()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrames()
    }
    
    private func updateFrames() {
        // packages
        let packagesSize = packagesContentSize()
        packagesView.frame = CGRect(x: 0, y: 0, width: packagesSize.width, height: view.bounds.height)
        packagesContainerView.frame = CGRect(x: 0, y: 0, width: packagesSize.width, height: packagesSize.height)
        // stickers
        let stickersSize = stickersContentSize()
        stickersView.frame = CGRect(x: packagesView.frame.maxX, y: self.topLayoutGuide.length, width: stickersSize.width, height: view.bounds.height)
        stickersContainerView.frame = CGRect(x: 0, y: 0, width: stickersSize.width, height: stickersSize.height)
    }
    
    private func packagesContentSize() -> CGSize {
        let height = packageViewSize().height * CGFloat(stickerPackages.count)
        return CGSize(width: view.frame.width * packagesWidthCoefficient, height: height)
    }
    
    private func stickersContentSize() -> CGSize {
        if chosenPackageIndex >= 0 && chosenPackageIndex < stickerPackages.count {
            let all = stickerPackages[chosenPackageIndex].stickers?.count
            let col = Constants.stickersCountInRow
            let count = (all! - 1) / col + 1
            let height = stickerViewSize().height * CGFloat(count)
            return CGSize(width: view.frame.width - packagesContentSize().width, height: height)
        }
        return CGSize(width: 0, height: 0)
    }
    
}

