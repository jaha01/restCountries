//
//  Request.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 23.07.2023.
//

import Foundation

enum Requests {
    case allList
    case search(String)
    
    var path: String {
        switch self {
        case .allList:
            return "/v3.1/all"
        case .search(let searchText):
            return "/v3.1/name/\(searchText)"
        }
    }
}
