//
//  CameraViewController.swift
//  
//
//  Created by Timothy Obeisun on 11/11/22.
//

import UIKit

class CameraViewController: UIViewController {
    
    var startChallenge: StartChallenge?
    var cameraView: CameraView?
    var configurator: CameraViewConfiguratorProtocol = CameraViewConfigurator()
    var viewModel: CameraViewModelDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupUploadData()
        configurator.configure(with: CameraViewNetworkService(),viewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.cameraViewDelegate = self
    }
    
    func attachView(_ displayView: CameraView) {
        self.cameraView = displayView
    }
    
    func setupUploadData() {
        cameraView?.didUploadData = { [weak self] base64String, fileExtension in
            let base64 = base64String
            let fileExtension = ".\(fileExtension)"
            self?.view.showSnappayLoader()
            let data = UploadChallengeRequest(image: base64, fileExtension: fileExtension)
            self?.viewModel.uploadChallenge(uploadData: data)
        }
    }
}


extension CameraViewController {
    func setupViews() {
        view.backgroundColor = .white
        guard let cameraView = cameraView else { return }
        view.addSubview(cameraView)
        cameraView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
    }
}


extension CameraViewController: CameraViewDelegate {
    func uploadChallengeData(data: UploadChallenge) {
        self.view.removeSnappayLoader()
    }
    
    func uploadChallengeError(error: Error) {
        self.view.removeSnappayLoader()
    }
}
