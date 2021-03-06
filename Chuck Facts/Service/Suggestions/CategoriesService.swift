//
//  CategoriesService.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

struct CategoriesService: BaseService {

    func fetch(completion: @escaping(RequestResult<[String], String>) -> Void) {
        self.request(endPoint: .categories) { (result) in
            switch result {
            case .failure(let error):
                completion(RequestResult.failure(error))
            case .success(let json):
                let list = json as? [String] ?? []
                completion(RequestResult.success(list))

            }
        }
    }
}

