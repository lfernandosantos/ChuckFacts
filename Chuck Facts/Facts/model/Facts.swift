//
//  FactsResult.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

struct Fact : Codable {
    let category : [String]?
    let icon_url : String?
    let id : String?
    let url : String?
    let value : String?

    enum CodingKeys: String, CodingKey {

        case category = "category"
        case icon_url = "icon_url"
        case id = "id"
        case url = "url"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent([String].self, forKey: .category)
        icon_url = try values.decodeIfPresent(String.self, forKey: .icon_url)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }

    static func decode(from json: Any) -> Fact? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            if let decodedObject = try? JSONDecoder().decode(Fact.self, from: jsonData) {
                return decodedObject
            }
        }
        return nil
    }

}
