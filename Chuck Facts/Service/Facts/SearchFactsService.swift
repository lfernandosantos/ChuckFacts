//
//  SearchFacts.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

struct SearchFactsService: BaseService {

    func fetch(query: String, completion: @escaping(RequestResult<[Fact], String>) -> Void) {
        self.request(endPoint: .searchFacts(query: query)) { (result) in
            switch result {
            case .failure(let error):
                completion(RequestResult.failure(error))
            case .success(let json):

                let response = FactsResponse.decode(from: json)
                let facts = response?.fact ?? []

                completion(RequestResult.success(facts))
            }
        }
    }
}

