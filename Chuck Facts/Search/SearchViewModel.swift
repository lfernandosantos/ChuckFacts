//
//  SearchViewModel.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 06/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation
import Bond

class SearchViewModel {

    var facts = Observable<[Fact]>([])

    func searchWith(suggestions: String) {
        SearchFactsService().fetch(category: suggestions) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let fact):
                if let fact = fact {
                    self.facts.value = [fact]
                }
            }
        }
    }

    
    func searchFacts(query: String) {
        SearchFactsService().fetch(query: query) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let searchFact):
                if searchFact.count > 0 {
                     DataManager.saveLastSearch(query)
                    self.facts.value = searchFact
                }
            }
        }
    }
}
