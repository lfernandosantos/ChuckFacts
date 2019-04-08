//
//  SuggestionsViewModel.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

class SuggestionsViewModel {
    var listSuggestions: [String]

    init() {
        listSuggestions = DataManager.loadSuggestions()
    }

    func fetchSuggestions() {
        CategoriesService().fetch { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let list):
                DataManager.saveSugestions(list)
                self.listSuggestions = DataManager.loadSuggestions()
            }
        }
    }
}
