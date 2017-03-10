//
//  StickerManager.swift
//  StickerTest
//
//  Created by Taguhi Abgaryan on 2/23/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

class StickerManager {
    
    static let shared = StickerManager()
    
    public var packages = [StickerPackage]()
    
    private init() {
        setupPackages()
    }
    
    // generates packages of stickers
    private func setupPackages() {
        setupStickerPackages()
        setupGifPackages()
    }
    
    private func setupStickerPackages() {
        let collections = [
            Colors.allColorsCollection.colors,
            Colors.redCollection.colors,
            Colors.blueCollection.colors,
            Colors.magentaCollection.colors,
            Colors.cyanCollection.colors,
            Colors.greenCollection.colors,
            Colors.grayCollection.colors,
            Colors.maroonCollection.colors,
            Colors.pinkCollection.colors,
            Colors.orangeCollection.colors,
            Colors.whiteCollection.colors,
            Colors.yellowCollection.colors,
            Colors.purpleCollection.colors,
            ]
        let names = [
            "All",
            "Red",
            "Blue",
            "Magenta",
            "Cyan",
            "Green",
            "Gray",
            "Maroon",
            "Pink",
            "Orange",
            "White",
            "Yellow",
            "Purple",
            ]
        // generate all packages
        for index in 0..<collections.count {
            var stickers = [UIImage]()
            // decide count of stickers in current package
            let count = Constants.stickersMinCount + Int(arc4random()) % (Constants.stickersMaxCount - Constants.stickersMinCount)
            // generate stickers
            for _ in 0..<count {
                if let image = Renderer.generateRandomImage(using: collections[index], size: Constants.stickerSize) {
                    stickers.append(image)
                }
            }
            let thumbnail = Renderer.generateRandomImage(using: collections[index], size: Constants.stickerSize)
            let package = StickerPackage(thumbnail: thumbnail!, stickers: stickers, name: names[index])
            packages.append(package)
        }
    }
    
    private func setupGifPackages() {
        let thumbnail = Renderer.generateRandomImage(size: CGSize(width: 3, height: 3))
        let stickers = [
            UIImage.gif(name: "ColorPickerGIF"),
        ]
        
        let gifPackage1 = StickerPackage(thumbnail: thumbnail ?? UIImage(), stickers: stickers as! [UIImage] , name: "GIFs")
        
        
        packages.append(gifPackage1)
    }
    
}

class StickerPackage {
    
    let thumbnail: UIImage?
    let stickers: [UIImage]?
    let name: String
    
    init(thumbnail: UIImage, stickers: [UIImage], name: String) {
        self.thumbnail = thumbnail
        self.stickers = stickers
        self.name = name
    }
}
