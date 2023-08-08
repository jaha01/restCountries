//
//  Service.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 25.07.2023.
//

import Foundation

class Service {
    private var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func loadData(completion: @escaping([Country])->Void) {
        print("loadData - \(Requests.allList.path)")
        networkClient.request(path: Requests.allList.path) { (result: Result<[Country],Error>) in
            switch result {
            case .success(let data) :
//                guard let capital = data.currencies else {
//                    return
//                }
//                print("article list:")
//                for article in capital {
//                    print(article)
//                }
//                print("Currency = \(data.currencies)")
                
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
