//
//  UserSettingsTableViewController.swift
//  LocaleInspector
//
//  Created by Aaron Madlon-Kay on 9/3/16.
//  Copyright © 2016 Aaron Madlon-Kay. All rights reserved.
//

import UIKit

class SystemLocalesTableViewController: UITableViewController {
    
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
        tableView.contentInset.top = UIApplication.shared.statusBarFrame.height
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! SystemLocaleTableCell
        let section = categories[indexPath.section]
        let code = (alphabetized[section]?[indexPath.item])!
        cell.label.text = "\(code) - \(code.localizedStringAsIdentifier()!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = categories[section]
        return alphabetized[sec]!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].uppercased()
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return categories.map { $0.uppercased() }
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}

class SystemLocaleTableCell: UITableViewCell {
    @IBOutlet var label: UILabel!
}
