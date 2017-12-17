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
    
    var site: Site?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        if let site = site {
            navigationItem.title = site.name
            webView.loadHTMLString(site.html, baseURL: nil)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)        
        webView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

