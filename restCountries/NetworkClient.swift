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
            
            if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<400:
                    let json = String.init(data: data, encoding: .utf8)
                    //print(json)
                    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let content = try self.jsonDecoder.decode(T.self, from: data)
                        completion(.success(content))
                    } catch {
                        print(error)
                    }
                    if let content = try? self.jsonDecoder.decode(T.self, from: data) {
                        completion(.success(content))
                    } else {
                        completion(.failure(CustomError(message: "Failed parsing")))
                    }
                default:
                    completion(.failure(CustomError(message: "\(response.statusCode)")))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        })
        self.dataTask?.resume()
    }
}
