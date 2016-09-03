//
//  Util.swift
//  LocaleInspector
//
//  Created by Aaron Madlon-Kay on 9/4/16.
//  Copyright © 2016 Aaron Madlon-Kay. All rights reserved.
//

import Foundation

extension String {
    func localizedStringAsIdentifier() -> String? {
        return Locale.current.localizedString(forIdentifier: self)
    }
}
