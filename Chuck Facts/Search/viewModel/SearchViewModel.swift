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

    var facts = Observable<[FactViewModel]>([])

    func searchWith(suggestions: String) {
        SearchFactsService().fetch(category: suggestions) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let fact):
                if let fact = fact {
                    self.saveResult(facts: [fact])
                    self.facts.value = [FactViewModel(fact: fact)]
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
                    self.saveResult(facts: searchFact)
                    let listViewModel = searchFact.map({ (item) -> FactViewModel in
                        return FactViewModel(fact: item)
                    })
                    self.facts.value = listViewModel
                }
            }
        }
    }

    func saveResult(facts: [Fact]) {
        facts.forEach { (item) in
            FactEntity.save(fact: item, persistence: PersistenceManager.shared)
        }
    }
}
