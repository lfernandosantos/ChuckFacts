//
//  BaseService.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseService {
    func request(url: URL, completion: @escaping (RequestResult<Any, String>) -> Void )
}

extension BaseService {
    func request(url: URL, completion: @escaping (RequestResult<Any, String>) -> Void ) {
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                completion(RequestResult.success(value))
            case .failure(let error):
                completion(RequestResult.failure(error.localizedDescription))
            }

        }
    }
}
