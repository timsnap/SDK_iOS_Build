//
//  HomePageNetworkServiceProtocol.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

class HomePageNetworkService: HomePageNetworkServiceProtocol {
    
    let service: NetworkServiceProtocol = NetworkService()
    
    func startChallenge(
        requestData: UserData,
        completion: @escaping (Result<StartChallenge, Error>) -> Void
    ) {
        service.request(
            endpoint: .startChallenge(data: requestData),
            completion: completion
        )
    }
    
}
