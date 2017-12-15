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

    var sites: [Site]?
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider
        let propertyList = String(kUTTypeFileURL)
        
        //weak let content = contentText
        
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
                    self.sites = NSKeyedUnarchiver.unarchiveObject(withFile: Site.ArchiveURL.path) as? [Site] ?? []
                    print(self.sites)
                    let newSite = Site(name: self.contentText, html: str!)!
                    self.sites!.append(newSite)
                    print(self.sites)
                    let result = NSKeyedArchiver.archiveRootObject(self.sites!, toFile: Site.ArchiveURL.path)
                    print("result: \(result)")
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
