//
//  DataManager.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

class DataManager {

    static let suggestionsKey: String = "suggestions"

    static func saveSugestions(_ suggestions: [String]) {
        UserDefaults.standard.set(suggestions, forKey: suggestionsKey)
    }


    static func loadSuggestions() -> [String] {
        let list: [String] = UserDefaults.standard.stringArray(forKey: suggestionsKey) ?? []
        return list
    }
}

