//
//  Utils.swift
//  QRCodeWidget
//
//  Created by Veight Zhou on 11/02/2018.
//  Copyright © 2018 com.veightz. All rights reserved.
//

import Foundation
import CoreImage

func ScanScreenQRCode() -> [String]? {
    let displayCountPointer = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
    guard CGGetActiveDisplayList(0, nil, displayCountPointer) == .success else { return nil }
    
    let activeDisplaysPointer = UnsafeMutablePointer<CGDirectDisplayID>.allocate(capacity: Int(displayCountPointer.pointee))
    guard CGGetActiveDisplayList(displayCountPointer.pointee, activeDisplaysPointer, nil) == .success,
        let detector = CIDetector.init(
            ofType: CIDetectorTypeQRCode,
            context: nil,
            options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]) else { return nil }
    
    var activeDisplays = [CGDirectDisplayID]()
    for index in 0..<displayCountPointer.pointee { activeDisplays.append(activeDisplaysPointer[Int(index)])}
    activeDisplaysPointer.deallocate(capacity: Int(displayCountPointer.pointee))
    displayCountPointer.deallocate(capacity: 1)
    
    return activeDisplays
        .flatMap { CGDisplayCreateImage($0)}
        .flatMap { detector.features(in: CIImage.init(cgImage: $0))}
        .flatMap { ($0 as? CIQRCodeFeature)?.messageString }
}


func createQRFromString(_ str: String) -> CIImage? {
    let stringData = str.data(using: String.Encoding.utf8)
    guard let filter = CIFilter(name: "CIQRCodeGenerator")  else { return nil }
    filter.setValue(stringData, forKey: "inputMessage")
    filter.setValue("H", forKey: "inputCorrectionLevel")
    return filter.outputImage
}

func logInfo(_ text: String) {
    print(text)
}

func logError(_ text: String) {
    print(text)
}

func logWarning(_ text: String) {
    print(text)
}


extension CIImage {
    func toCGImage() -> CGImage? {
        let ciImage = self.transformed(by: CGAffineTransform(scaleX: 5.0, y: 5.0))
        return CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent)
    }
}

extension CGSize {
    func scaleTo(_ scaleFactor: Int) -> CGSize {
        return CGSize(width: self.width * CGFloat(scaleFactor), height: self.height * CGFloat(scaleFactor))
    }
}
