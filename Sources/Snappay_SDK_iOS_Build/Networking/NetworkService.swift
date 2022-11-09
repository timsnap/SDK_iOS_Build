//
//  NetworkService.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(
        userData: UserData,
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
        userData: UserData,
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
        request.httpBody = try? JSONSerialization.data(withJSONObject: params as Any, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(userData.apiKey ?? "", forHTTPHeaderField: "X-API-KEY")
        
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
}
