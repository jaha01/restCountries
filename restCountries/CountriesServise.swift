//
//  Service.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 25.07.2023.
//

import Foundation

// ViewController - draws UI, shows items, reports user actions
// Service (CountriesService) - handling user actions, doing some business logic
// Network Client - executes networks requests, decodes data

protocol CountriesServiceProtocol {
    func loadCountries(completion: @escaping([Country])->Void)
    func loadFilteredCountries(searchText: String, completion: @escaping([Country])->Void)
    func loadCountry(fullName: String, completion: @escaping(Country) -> Void)
}

class CountriesService: CountriesServiceProtocol {
    private var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCountries(completion: @escaping([Country])->Void) {
        let request = Requests.allList
        loadCountries(path: request.path, completion: completion)
    }
    
    func loadFilteredCountries(searchText: String, completion: @escaping([Country])->Void) {
        let request = Requests.search(searchText)
        loadCountries(path: request.path, completion: completion)
    }
    
    func loadCountry(fullName: String, completion: @escaping(Country) -> Void) {
        
    }
    
    private func loadCountries<T: Codable>(path: String, completion: @escaping(T)->Void) {
        networkClient.request(path: path) { (result: Result<T, Error>) in
            switch result {
            case .success(let data) :
                completion(data)
            case .failure(let error):
                if let customError = error as? CustomError {
                    print(customError.message)
                } else {
                    print(error)
                }
            }
        }
    }
}
