//
//  UserSettingsTableViewController.swift
//  LocaleInspector
//
//  Created by Aaron Madlon-Kay on 9/3/16.
//  Copyright © 2016 Aaron Madlon-Kay. All rights reserved.
//

import UIKit

class SystemLocalesViewController: UIViewController {
    
    var categories: [String] = []
    var alphabetized: [String:[String]] = [:]

    func makeAlphabetizedMap() -> [String:[String]] {
        // Implementing this with reduce() crashes the Swift compiler :(
        var m: [String:[String]] = [:]
        Locale.availableIdentifiers.forEach {
            let key = String($0.characters.first!)
            if m[key] == nil {
                m[key] = []
            }
            m[key]?.append($0)
        }
        var sorted: [String:[String]] = [:]
        m.forEach { key, val in
            sorted[key] = val.sorted()
        }
        return sorted
    }
    
    override func viewDidLoad() {
        alphabetized = makeAlphabetizedMap()
        categories = alphabetized.keys.sorted()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let target = segue.destination as! LocaleDetailViewController
        let cell = sender as! SystemLocaleTableCell
        target.locale = Locale(identifier: cell.locale!)
    }
}

extension SystemLocalesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! SystemLocaleTableCell
        let section = categories[indexPath.section]
        let code = (alphabetized[section]?[indexPath.item])!
        cell.locale = code
        cell.textLabel?.text = code
        cell.detailTextLabel?.text = code.localizedStringAsIdentifier()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = categories[section]
        return alphabetized[sec]!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].uppercased()
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return categories.map { $0.uppercased() }
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}

class SystemLocaleTableCell: UITableViewCell {
    var locale: String?
}
