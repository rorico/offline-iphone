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
        // Do any additional setup after loading the view, typically from a nib.
        sites = NSKeyedUnarchiver.unarchiveObject(withFile: Site.ArchiveURL.path) as? [Site] ?? []
        print(sites)
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

