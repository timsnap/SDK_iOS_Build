//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import Foundation

class HomePageConfigurator: HomePageConfiguratorProtocol {
    func configure(
        with networkService: HomePageNetworkServiceProtocol,
        viewController: HomePageViewController
    ) {
        let viemodel = HomePageViewModel(homePageNetworkService: networkService)
        viewController.viewModel = viemodel
    }
}
