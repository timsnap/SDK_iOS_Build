//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

protocol HomePageViewModelDelegate: AnyObject {
    func startChallenge(userData: UserData)
    var homeVcDelegate: HomeVcDelegate? {set get }
}

protocol HomeVcDelegate {
    func startChallengeData(data: StartChallenge)
    func startChallengeError(error: Error)
}

protocol HomePageNetworkServiceProtocol {
    func startChallenge(
        requestData: UserData,
        completion: @escaping (Result<StartChallenge, Error>
        ) -> Void
    )
}

protocol HomePageConfiguratorProtocol: AnyObject {
    func configure(
        with networkService: HomePageNetworkServiceProtocol,
        viewController: HomePageViewController
    )
}
