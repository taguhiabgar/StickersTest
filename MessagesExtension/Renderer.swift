//
//  Renderer.swift
//  StickerTest
//
//  Created by Taguhi Abgaryan on 2/23/17.
//  Copyright © 2017 Taguhi Abgaryan. All rights reserved.
//

import UIKit

struct RGBColor {
    var alpha: UInt8 = 0
    var red: UInt8 = 0
    var green: UInt8 = 0
    var blue: UInt8 = 0
}

class Renderer {
    
    public static func generateRandomImage(size: CGSize) -> UIImage? {
        let pixels = Renderer.randomPixelData(size: size)
        return imageFromPixelData(pixels: pixels, size: size)
    }
    
    public static func generateRandomImage(using colors: [UIColor], size: CGSize) -> UIImage? {
        let pixels = Renderer.randomPixelData(with: colors, size: size)
        return imageFromPixelData(pixels: pixels, size: size)
    }
    
    // generates random pixel data using only given colors
    private static func randomPixelData(with colors: [UIColor], size: CGSize) -> [RGBColor] {
        var data = [RGBColor]()
        for _ in 0..<Int(size.width * size.height) {
            let randomIndex = Int(arc4random()) % colors.count
            let cgFloatComponents = colors[randomIndex].cgColor.components
            var uint8Components = [UInt8]()
            if cgFloatComponents?.count == 4 {
                for item in cgFloatComponents! {
                    let intItem = item * 255.0
                    uint8Components.append(UInt8(intItem))
                }
                let r = uint8Components[0]
                let g = uint8Components[1]
                let b = uint8Components[2]
                let a = uint8Components[3]
                let pixel = RGBColor(alpha: UInt8(a), red: UInt8(r), green: UInt8(g), blue: UInt8(b))
                data.append(pixel)
            }
        }
        return data
    }
    
    // generates random pixel data using all colors
    private static func randomPixelData(size: CGSize) -> [RGBColor] {
        var data = [RGBColor]()
        for _ in 0..<Int(size.width * size.height) {
            let colorsNumber = UInt32(UInt8.max)
            let a = arc4random() % colorsNumber
            let r = arc4random() % colorsNumber
            let g = arc4random() % colorsNumber
            let b = arc4random() % colorsNumber
            let pixel = RGBColor(alpha: UInt8(a), red: UInt8(r), green: UInt8(g), blue: UInt8(b))
            data.append(pixel)
        }
        return data
    }
    
    private static func imageFromPixelData(pixels: [RGBColor], size: CGSize) -> UIImage? {
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo:CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        assert(pixels.count == Int(size.width * size.height))
        var data = pixels // to make it mutable
        let dataLength = data.count * MemoryLayout<RGBColor>.size
        let providerRef = CGDataProvider(data: NSData(bytes: &data, length: dataLength))
        let image = CGImage(
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: Int(size.width) * Int(MemoryLayout<RGBColor>.size),
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef!,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
        return UIImage(cgImage: image!)
    }
}


