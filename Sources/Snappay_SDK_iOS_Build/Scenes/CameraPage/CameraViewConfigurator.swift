//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/18/22.
//

import Foundation

import Foundation

class CameraViewConfigurator: CameraViewConfiguratorProtocol {
    func configure(
        with networkService: CameraViewNetworkServiceProtocol,
        viewController: CameraViewController
    ) {
        let viemodel = CameraViewModel(cameraViewNetworkService: networkService)
        viewController.viewModel = viemodel
    }
}
