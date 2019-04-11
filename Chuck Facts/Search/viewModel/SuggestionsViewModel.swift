//
//  SuggestionsViewModel.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation
import Bond

class SuggestionsViewModel {
    
    var listSuggestions = Observable<[String]>([])

    init() {
        listSuggestions.value = DataManager.loadSuggestions().shuffled()
        if listSuggestions.value.isEmpty {
            fetchSuggestions()
        }
    }


    func fetchSuggestions() {
        CategoriesService().fetch { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let list):
                DataManager.saveSugestions(list)
                self.listSuggestions.value = DataManager.loadSuggestions()
            }
        }
    }
}
