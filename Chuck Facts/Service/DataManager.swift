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
    static let searchsKey: String = "searchs"

    static func saveSugestions(_ suggestions: [String]) {
        UserDefaults.standard.set(suggestions, forKey: suggestionsKey)
    }


    static func loadSuggestions() -> [String] {
        let list: [String] = UserDefaults.standard.stringArray(forKey: suggestionsKey) ?? []
        return list
    }

    static func saveLastSearch(_ search: String) {
        var list = loadSearchs()
        list.append(search)
        if list.count > 4 {
            list.removeFirst()
        }
    }

    static func loadSearchs() -> [String] {
        let list: [String] = UserDefaults.standard.stringArray(forKey: searchsKey) ?? []
        return list.reversed()
    }
}

