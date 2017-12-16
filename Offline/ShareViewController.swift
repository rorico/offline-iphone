//
//  ShareViewController.swift
//  Offline
//
//  Created by Daniel Chen on 12/13/17.
//  Copyright © 2017 Daniel Chen. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Site.ArchiveURL.path)
    }
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider
        let propertyList = String(kUTTypeFileURL)
        
        if itemProvider.hasItemConformingToTypeIdentifier(propertyList) {
            itemProvider.loadItem(forTypeIdentifier: propertyList, options: nil, completionHandler: { (decoder, error) -> Void in
                if (error != nil) {
                    print(error)
                    return
                }
                guard let url = decoder as? URL else {
                    print("decoder isn't a url")
                    return
                }
                do {
                    let data = try Data(contentsOf: url)
                    let str = String(data: data, encoding: .utf8)
                    let newSite = Site(name: self.contentText, html: str!)!
                    
                    NSKeyedUnarchiver.setClass(Site.self, forClassName: "Site")
                    NSKeyedArchiver.setClassName("Site", for: Site.self)
                    let defaults = UserDefaults(suiteName: "group.offline")
                    defaults?.synchronize()
                    let decoded = defaults?.object(forKey: "sites") as? Data
                    var sites: [Site] = []
                    if (decoded != nil) {
                        sites = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? [Site] ?? []
                    }
                    sites.append(newSite)
                    
                    let encoded = NSKeyedArchiver.archivedData(withRootObject: sites)
                    defaults?.set(encoded, forKey: "sites")
                    defaults?.synchronize()
                } catch {
                    print(error)
                }
            })
        } else {
            print("error")
        }
        
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
}
