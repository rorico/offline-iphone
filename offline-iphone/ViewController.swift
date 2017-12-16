//
//  ViewController.swift
//  offline-iphone
//
//  Created by Daniel Chen on 12/6/17.
//  Copyright © 2017 Daniel Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var sites = [Site]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults(suiteName: "group.offline")
        defaults?.synchronize()
        let decoded = defaults?.object(forKey: "sites") as? Data
        sites = []
        if (decoded != nil) {
            NSKeyedUnarchiver.setClass(Site.self, forClassName: "Site")
            sites = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? [Site] ?? []
        }
        if (sites.count == 0) {
            return
        }
        webView.loadHTMLString(sites[0].html, baseURL: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

