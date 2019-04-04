//
//  FactsResponse.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

struct FactsResponse: Codable {
    let total : Int?
    let fact : [Fact]?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case fact = "result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        fact = try values.decodeIfPresent([Fact].self, forKey: .fact)
    }

    static func decode(from json: Any) -> FactsResponse? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            if let decodedObject = try? JSONDecoder().decode(FactsResponse.self, from: jsonData) {
                return decodedObject
            }
        }
        return nil
    }


}
