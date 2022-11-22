//
//  NetworkService.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, Error>) -> ()
    )
}

class NetworkService: NetworkServiceProtocol {
    /// Request Executes the web call and will decode the JSON response into the codable object provided
    /// - Parameters:
    ///   - endpoint: the endpoint to make the HTTP request against
    ///   - completion: the JSON response converted to the provided Codable Object, if successful or failure otherwise
    func request<T: Codable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.path = endpoint.path
        components.host = endpoint.baseURL
        guard let url = components.url else { return }
        
        var request = URLRequest(url: url)
        let params = endpoint.parameters
        
        request.httpMethod = endpoint.method
        if params != nil {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params as Any, options: [])
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(getApikey(), forHTTPHeaderField: "X-API-KEY")
        request.addValue(getToken(), forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard response != nil, let data = data else { return }
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(
                        domain: "",
                        code: 400,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"]
                    )
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    /// getToken Method gets the token from the KeyChain
    func getToken() -> String {
        guard let data = KeyChainManager.get(
            service: "snappay.com",
            account: "snappayAdmin"
        ) else { return "" }
        let token = String(decoding: data, as: UTF8.self)
        return "Bearer \(token)"
    }
    
    /// getApikey Method gets the apiKey from the KeyChain
    func getApikey() -> String {
        guard let data = KeyChainManager.get(
            service: "snappay.com",
            account: "snappayApiKey"
        ) else { return "" }
        let apiKey = String(decoding: data, as: UTF8.self)
        return apiKey
    }
}

