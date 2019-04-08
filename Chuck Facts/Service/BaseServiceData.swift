//
//  BaseServiceData.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

protocol BaseServiceData {
    var urlBase: String { get }
    var path: String { get }
}

internal enum BaseEndPoint {
    case categories
    case searchFacts(query: String)
    case searchFactsByCategory(query: String)
}
extension BaseEndPoint: BaseServiceData {
    var urlBase: String {
        return  "https://api.chucknorris.io/jokes/"
    }

    var path: String {
        switch self {

        case .categories:
            return "categories"

        case .searchFacts(let query):
            return "search?query=\(query)"

        case .searchFactsByCategory(let query):
            return "random?category=\(query)"
        }
    }
}

