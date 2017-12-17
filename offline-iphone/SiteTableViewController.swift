//
//  SiteTableViewController.swift
//  offline-iphone
//
//  Created by Daniel Chen on 12/16/17.
//  Copyright © 2017 Daniel Chen. All rights reserved.
//

import UIKit

class SiteTableViewController: UITableViewController {
    
    var sites = [Site]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults(suiteName: "group.offline")
        defaults?.synchronize()
        let decoded = defaults?.object(forKey: "sites") as? Data
        sites = []
        let newS = Site(name: "test", html: "tests")
        sites.append(newS!)
        if (decoded != nil) {
            NSKeyedUnarchiver.setClass(Site.self, forClassName: "Site")
            sites = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? [Site] ?? []
        }
        if (sites.count > 0) {
            self.performSegue(withIdentifier: "show", sender: sites[0])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SiteTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SiteTableViewCell else {
            fatalError("dequeued cell is not an instance of SiteTableViewCell.")
        }
        
        let site = sites[indexPath.row]
        cell.label.text = site.name
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let controller = segue.destination as? ViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        if let site = sender as? Site {
            controller.site = site
        } else {
            guard let selected = sender as? SiteTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selected) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedSite = sites[indexPath.row]
            controller.site = selectedSite
        }
    }
    
}
