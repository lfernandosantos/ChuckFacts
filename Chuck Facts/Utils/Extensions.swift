//
//  Utils.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 10/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        let bundle: Bundle = Bundle.main
        let tableName: String = "Localizable"
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }

}
