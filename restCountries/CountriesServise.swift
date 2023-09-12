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
    func loadCountries(completion: @escaping(Result<[Country],Error>)->Void)
    func loadFilteredCountries(searchText: String, completion: @escaping(Result<[Country],Error>)->Void)
    func loadCountry(fullName: String, completion: @escaping(Result<Country,Error>) -> Void)
}

class CountriesService: CountriesServiceProtocol {
    private var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCountries(completion: @escaping(Result<[Country],Error>)->Void) {
        let request = Requests.allList
        loadCountries(path: request.path, completion: completion)
    }
    
    func loadFilteredCountries(searchText: String, completion: @escaping(Result<[Country],Error>)->Void) {
        let request = Requests.search(searchText)
        loadCountries(path: request.path, completion: completion)
    }
    
    func loadCountry(fullName: String, completion: @escaping(Result<Country,Error>) -> Void) {
        let request = Requests.fullname(fullName)
        loadCountries(path: request.path) { (result: Result<[Country], Error>) in
            switch result {
            case .success(let countries):
                completion(.success(countries.first!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func loadCountries<T: Codable>(path: String, completion: @escaping(Result<T, Error>)->Void) {
        networkClient.request(path: path) { (result: Result<T, Error>) in
            switch result {
            case .success(let data) :
                completion(.success(data))
            case .failure(let error):
                completion(.failure(CustomError(message: "Что-то пошло не так...")))
                if let customError = error as? CustomError {
                    print(customError.message)
                } else {
                    print(error)
                }
            }
        }
    }
}
