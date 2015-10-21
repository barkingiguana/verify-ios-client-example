//
//  ViewController.swift
//  TestVerify
//
//  Created by Craig Webster on 18/10/2015.
//  Copyright © 2015 Barking Iguana. All rights reserved.
//

import UIKit
import BIVerify
import SnapHTTP

class ViewController: UIViewController {
    
    @IBOutlet weak var clickyButton: UIButton!
    @IBOutlet weak var verbField: UITextField!
    @IBOutlet weak var actionField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func click(sender: AnyObject) {
        let intent = BIVerify.expressIntent(verbField.text!, path: actionField.text!, parameters: [:])
        let signedAction = intent.sign("craigw", secret: "secret123", expiresAt: NSDate().dateByAddingTimeInterval(300))
        let url = "http://192.168.99.100:3000\(signedAction.signedPath)"
        print("URL: \(url)")
        http.get(url) { resp in
            print("response: \(resp.string)")
        }
    }
}