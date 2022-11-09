//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

class HomePageViewModel: HomePageViewModelDelegate {
    var homeVcDelegate: HomeVcDelegate?
    
    private let homePageNetworkService: HomePageNetworkServiceProtocol
    
    
    init(
        homePageNetworkService: HomePageNetworkServiceProtocol
    ){
        self.homePageNetworkService = homePageNetworkService
    }
    
    func startChallenge(userData: UserData) {
        homePageNetworkService.startChallenge(requestData: userData) { [weak self] result in
            switch result {
            case .success(let data):
                self?.homeVcDelegate?.startChallengeData(data: data)
            case .failure(let error):
                self?.homeVcDelegate?.startChallengeError(error: error)
            }
        }
    }
}
