//
//  StickerManager.swift
//  StickerTest
//
//  Created by Taguhi Abgaryan on 2/23/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

class StickerManager {
    
    static var packages = [StickerPackage]()
    
}

class StickerPackage {
    
    let thumbnail: UIImage
    let stickers: [UIImage]
    let name: String
    
    init(thumbnail: UIImage, stickers: [UIImage], name: String) {
        self.thumbnail = thumbnail
        self.stickers = stickers
        self.name = name
    }
}
