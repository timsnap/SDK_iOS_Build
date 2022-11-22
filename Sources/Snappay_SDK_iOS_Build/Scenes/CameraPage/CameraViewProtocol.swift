//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/18/22.
//

import Foundation

protocol CameraViewNetworkServiceProtocol {
    func uploadChallenge(
        image: String,
        fileExtension: String,
        completion: @escaping (Result<UploadChallenge, Error>
        ) -> Void
    )
    func verifyChallenge(completion: @escaping (Result<VerifyChallengeData, Error>) -> Void)
}

protocol CameraViewConfiguratorProtocol: AnyObject {
    func configure(with networkService: CameraViewNetworkServiceProtocol,viewController: CameraViewController)
}

protocol CameraViewModelDelegate: AnyObject {
    func uploadChallenge(uploadData: UploadChallengeRequest)
    func verifyChallenge()
    var cameraViewDelegate: CameraViewDelegate? {set get }
}

protocol CameraViewDelegate {
    func uploadChallengeData(data: UploadChallenge)
    func uploadChallengeError(error: Error)
    func verifyChallengeData(data: VerifyChallengeData)
    func verifyChallengeError(error: Error)
}
