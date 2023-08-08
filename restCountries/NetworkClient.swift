//
//  NetworkClient.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 25.07.2023.
//

import Foundation

class NetworkClient : NSObject {
    private var networkConfiguration = NetworkConf()
    private let jsonDecoder = JSONDecoder()
    
    //Конфигурация
    lazy var  configuration: URLSessionConfiguration =  {
        let configuration =  URLSessionConfiguration.default
            //configuration.timeoutIntervalForRequest = 500
        return configuration
    }()
    
    
    lazy var urlSession: URLSession? = {
        return URLSession.init(configuration: configuration)
    }()
    
    private var dataTask: URLSessionDataTask? = nil
    
    func request<T:Codable>(path: String, completion: @escaping(Result<T,Error>)->Void) {
       // print("request - \(networkConfiguration.url)\(path)")
        guard let url = URL(string: "\(networkConfiguration.url)\(path)") else {
            completion(.failure(CustomError(message: "Wrong uri")))
            print("error")
            return
        }
        let urlRequest = URLRequest(url: url)

        self.dataTask = urlSession?.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let self = self else {return}
            
            if let data = data {
                let json = String.init(data: data, encoding: .utf8)
                self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let content = try self.jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(content))
                    }
                } catch {
                    print(error)
                }
                if let content = try? self.jsonDecoder.decode(T.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.success(content))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(CustomError(message: "Failed parsing")))
                    }
                }
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else  {
                if let respn = response as? HTTPURLResponse, respn.statusCode < 200 || respn.statusCode >= 400 {
                    //error
                    DispatchQueue.main.async {
                        completion(.failure(CustomError(message: "\(respn.statusCode)")))
                    }
                }
            }
        })
        self.dataTask?.resume()
    }
}
