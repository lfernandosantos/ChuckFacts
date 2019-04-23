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
    var errorSearch = Observable<String?>("")
    var searching = Observable<Bool>(false)

    func searchWith(suggestions: String) {
        searching.value = true
        SearchFactsService().fetch(category: suggestions) { (result) in
            self.searching.value = false
            switch result{
            case .failure(let error):
                self.errorSearch.value = error
            case .success(let fact):
                if let fact = fact {
                    self.saveResult(facts: [fact])
                    self.facts.value = [FactViewModel(fact: fact)]
                }
            }
        }
    }

    func searchFacts(query: String) {
        searching.value = true
        SearchFactsService().fetch(query: query) { (result) in
            self.searching.value = false
            switch result{
            case .failure(let error):
                self.errorSearch.value = error
            case .success(let searchFact):
                if searchFact.count > 0 {
                    DataManager.saveLastSearch(query)
                    FactRepository().save(facts: searchFact)
                    self.facts.value = FactRepository().getFacts()
                } else {
                  self.errorSearch.value = StringFile.emptySearch.rawValue.localized()
                }
            }
        }
    }

    private func saveResult(facts: [Fact]) {
        PersistenceManager.shared.cleanDB(FactEntity.self)
        facts.forEach { (item) in
            FactEntity.save(fact: item, persistence: PersistenceManager.shared)
        }
    }
}
