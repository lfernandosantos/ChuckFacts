//
//  RequestResult.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation


enum RequestResult<T, String> {
    case success(T)
    case failure(String)
}
