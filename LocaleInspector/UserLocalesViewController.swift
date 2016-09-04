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
}

extension UserLocalesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! UserLocaleTableCell
        let loc: String?
        if (indexPath.section == 0) {
            loc = Locale.current.identifier
        } else {
            loc = Locale.preferredLanguages[indexPath.item]
        }
        cell.locale = loc
        cell.textLabel?.text = loc
        cell.detailTextLabel?.text = loc?.localizedStringAsIdentifier()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : Locale.preferredLanguages.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Current Locale" : "Preferred Languages"
    }
}

class UserLocaleTableCell: UITableViewCell {
    var locale: String?
}
