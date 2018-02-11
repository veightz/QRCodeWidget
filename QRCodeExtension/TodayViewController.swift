//
//  TodayViewController.swift
//  QRCodeExtension
//
//  Created by Veight Zhou on 11/02/2018.
//  Copyright © 2018 com.veightz. All rights reserved.
//

import Cocoa
import NotificationCenter
import RxSwift
import RxCocoa

class TodayViewController: NSViewController, NCWidgetProviding {
    
    @IBOutlet weak var inputTextField: NSTextField!
    
    @IBOutlet weak var imageView: NSImageView!
    

    override var nibName: NSNib.Name? {
        return NSNib.Name("TodayViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = inputTextField.rx.text.subscribe(onNext: { (strings) in
            logInfo("next => \(String(describing: strings))")
            guard let cgImage = createQRFromString(self.inputTextField.stringValue)?.toCGImage() else { return }
            let size = self.imageView.frame.size.scaleTo(1)
            self.imageView.image = NSImage(cgImage: cgImage, size: size)
        })
        
//        _ = inputTextField.rx.text.do(onNext: { (strings) in
//            print("next => \(String(describing: strings))")
//            guard let cgImage = createQRFromString(self.inputTextField.stringValue)?.toCGImage() else { return }
//            let size = CGSize(width: self.imageView.frame.width, height: self.imageView.frame.width)
//            self.imageView.image = NSImage(cgImage: cgImage, size: size)
//        })
        
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        print("widgetPerformUpdate called.")
        completionHandler(.noData)
    }
    

}
