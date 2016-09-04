//
//  LocaleDetailViewController.swift
//  LocaleInspector
//
//  Created by Aaron Madlon-Kay on 9/4/16.
//  Copyright © 2016 Aaron Madlon-Kay. All rights reserved.
//

import UIKit

class LocaleDetailViewController: UIViewController {
    var locale = Locale.current
    let props: [String:(Locale) -> String?] = ["alternateQuotationBeginDelimiter": { $0.alternateQuotationBeginDelimiter },
                                               "alternateQuotationEndDelimiter": { $0.alternateQuotationEndDelimiter },
                                               "calendar": { $0.calendar.description },
                                               "collationIdentifier": { $0.collationIdentifier },
                                               "collatorIdentifier": { $0.collatorIdentifier },
                                               "currencyCode": { $0.currencyCode },
                                               "currencySymbol": { $0.currencySymbol },
                                               "debugDescription": { $0.debugDescription },
                                               "decimalSeparator": { $0.decimalSeparator },
                                               "description": { $0.description },
                                               "exemplarCharacterSet": { $0.exemplarCharacterSet?.debugDescription },
                                               "groupingSeparator": { $0.groupingSeparator },
                                               "hashValue": { String($0.hashValue) },
                                               "identifier": { $0.identifier },
                                               "languageCode": { $0.languageCode },
                                               "quotationBeginDelimiter": { $0.quotationBeginDelimiter },
                                               "quotationEndDelimiter": { $0.quotationEndDelimiter },
                                               "regionCode": { $0.regionCode },
                                               "scriptCode": { $0.scriptCode },
                                               "usesMetricSystem": { String($0.usesMetricSystem) },
                                               "variantCode": { $0.variantCode },
                                               "customMirror": { $0.customMirror.description }]
    var propsKeys: [String] = []
    
    override func viewDidLoad() {
        propsKeys = props.keys.sorted()
    }

}

extension LocaleDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! LocaleDetailTableCell
        let key = propsKeys[indexPath.item]
        let desc = props[key]!(locale)
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.count
    }
}

class LocaleDetailTableCell: UITableViewCell {
}
