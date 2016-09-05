//
//  UserSettingsTableViewController.swift
//  LocaleInspector
//
//  Created by Aaron Madlon-Kay on 9/3/16.
//  Copyright © 2016 Aaron Madlon-Kay. All rights reserved.
//

import UIKit

class UserLocalesViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let target = segue.destination as! LocaleDetailViewController
        let cell = sender as! UserLocaleTableCell
        target.locale = Locale(identifier: cell.locale!)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let cell = sender as! UserLocaleTableCell
        return cell.locale != nil
    }
}

extension UserLocalesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! UserLocaleTableCell
        var loc, text, detail: String?
        if indexPath.section == 0 {
            text = UIDevice.current.systemVersion
            detail = ""
        } else {
            if indexPath.section == 1 {
                loc = Locale.current.identifier
            } else {
                loc = Locale.preferredLanguages[indexPath.item]
            }
            text = loc
            detail = loc?.localizedStringAsIdentifier()
        }
        cell.locale = loc
        cell.textLabel?.text = text
        cell.detailTextLabel?.text = detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return Locale.preferredLanguages.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "OS Version"
        case 1:
            return "Current Locale"
        case 2:
            return "Preferred Languages"
        default:
            return nil
        }
    }
}

class UserLocaleTableCell: UITableViewCell {
    var locale: String?
}
