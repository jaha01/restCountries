//
//  DI.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 26.07.2023.
//

import Foundation

class DI {
    static let shared = DI()

    lazy var networkClient: NetworkClient = {
       return NetworkClient()
    }()

    lazy var service: CountriesService = {
        return CountriesService(networkClient: networkClient)
    }()
}
