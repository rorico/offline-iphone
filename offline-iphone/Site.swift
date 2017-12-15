//
//  Site.swift
//  offline-iphone
//
//  Created by Daniel Chen on 12/5/17.
//  Copyright © 2017 Daniel Chen. All rights reserved.
//

import UIKit
import os.log

class Site: NSObject, NSCoding {
    //MARK: Properties
    struct PropertyKey {
        static let name = "name"
        static let html = "html"
    }
    
    var name: String
    var html: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("sites")
    
    
    //MARK: Initialization
    init?(name: String, html: String) {
        // Initialize stored properties.
        self.name = name
        self.html = html
    }
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(html, forKey: PropertyKey.html)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        let html = aDecoder.decodeObject(forKey: PropertyKey.html) as! String
        self.init(name: name, html: html)
    }
}
