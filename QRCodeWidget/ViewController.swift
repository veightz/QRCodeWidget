//
//  ViewController.swift
//  QRCodeWidget
//
//  Created by Veight Zhou on 11/02/2018.
//  Copyright © 2018 com.veightz. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
//            DispatchQueue.global(qos: .background).async {
//                if let strings = ScanScreenQRCode(), strings.count > 0 {
//                    print(strings)
//                }
//            }
//        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func scheduledAction() {
        print("test")
    }


}

