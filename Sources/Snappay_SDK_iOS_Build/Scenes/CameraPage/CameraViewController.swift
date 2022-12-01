//
//  CameraViewController.swift
//  
//
//  Created by Timothy Obeisun on 11/11/22.
//

import UIKit

class CameraViewController: UIViewController {
    var userData: UserData?
    var startChallenge: StartChallenge?
    var cameraView: CameraView?
    var configurator: CameraViewConfiguratorProtocol = CameraViewConfigurator()
    var viewModel: CameraViewModelDelegate!
    var globalBase64: String = ""
    
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
            self?.globalBase64 = base64
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
        cameraView.makeSecure()
    }
}

extension CameraViewController: CameraViewDelegate {
    func verifyChallengeData(data: VerifyChallengeData) {
        let errors = data.errors ?? []
        let verifyData = data.data
        let errorCount = errors.count
        if errorCount > 0 {
            DispatchQueue.main.async {
                self.customAlert(
                    errorMessage: errors.last ?? "",
                    errorTitle: errors.first ?? "",
                    completion: {
                        self.goToPreviousScreen()
                    }
                )
            }
        }
        
        switch verifyData {
        case "Success":
            moveToPaymentVc()
        case "Expired":
            self.customAlert(errorMessage: "Token Expired", errorTitle: "⚠️", completion: {
                self.goToPreviousScreen()
            })
        case "Failed":
            self.customAlert(errorMessage: "Failed", errorTitle: "⚠️", completion: {
                self.goToPreviousScreen()
            })
        default:
            return
        }
        self.view.removeSnappayLoader()
    }
    
    func verifyChallengeError(error: Error) {
        self.customAlert(
            errorMessage: error.localizedDescription,
            errorTitle: "",
            completion: {
                self.goToPreviousScreen()
            }
        )
        self.view.removeSnappayLoader()
    }
    
    func uploadChallengeData(data: UploadChallenge) {
        viewModel.verifyChallenge()
    }
    
    func uploadChallengeError(error: Error) {
        self.view.removeSnappayLoader()
    }
    
    func moveToPaymentVc() {
        let paymentVc = PaymentViewController()
        paymentVc.attachView(PaymentView())
        paymentVc.userData = userData
        if let decodedData = Data(base64Encoded: globalBase64, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
            paymentVc.image = image
        }
        self.navigationController?.pushViewController(paymentVc, animated: true)
    }
    
    func goToPreviousScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}
