//
//  ChuckFactsViewModel.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 10/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

protocol FactItemPressedDelegate {
    func clickShareFact(_ at: Int)
}


struct FactViewModel {
    let title: String
    let link: String
    let category: String

    init(fact: Fact) {
        self.title = fact.value ?? " "
        self.link = fact.url ?? " "
        self.category = fact.category?.first?.uppercased() ?? Constants.Fact.UNCATEGORIZED.rawValue
    }
}


struct ChuckFactsViewModel {

    var facts: [FactViewModel] {
        let data = PersistenceManager.shared.fetch(FactEntity.self)
        let dbFacts = data.map { (item) -> Fact in
            return Fact(from: item)
        }
        return dbFacts.map({ (item) -> FactViewModel in
            return FactViewModel(fact: item)
        })
    }

}
