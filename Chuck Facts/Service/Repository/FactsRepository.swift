//
//  FactsRepository.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 20/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

struct FactRepository {
    func getFacts()-> [FactViewModel] {
        let data = PersistenceManager.shared.fetch(FactEntity.self)
        let dbFacts = data.map { (item) -> Fact in
            return Fact(from: item)
        }
        return dbFacts.map({ (item) -> FactViewModel in
            return FactViewModel(fact: item)
        })
    }

    func save(facts: [Fact]) {
        PersistenceManager.shared.cleanDB(FactEntity.self)
        facts.forEach { (item) in
            FactEntity.save(fact: item, persistence: PersistenceManager.shared)
        }
    }
}
