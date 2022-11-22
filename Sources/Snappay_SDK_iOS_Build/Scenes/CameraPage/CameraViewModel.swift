//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/18/22.
//

import Foundation

class CameraViewModel: CameraViewModelDelegate {
    
    var cameraViewDelegate: CameraViewDelegate?
    
    private let cameraViewNetworkService: CameraViewNetworkServiceProtocol
    
    init(
        cameraViewNetworkService: CameraViewNetworkServiceProtocol
    ){
        self.cameraViewNetworkService = cameraViewNetworkService
    }
    
    func uploadChallenge(uploadData: UploadChallengeRequest) {
        cameraViewNetworkService.uploadChallenge(
            image: uploadData.image,
            fileExtension: uploadData.fileExtension) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.cameraViewDelegate?.uploadChallengeData(data: data)
                case .failure(let error):
                    self?.cameraViewDelegate?.uploadChallengeError(error: error)
                }
            }
    }
    
    func verifyChallenge() {
        cameraViewNetworkService.verifyChallenge { result in
            switch result {
            case .success(let data):
                self.cameraViewDelegate?.verifyChallengeData(data: data)
            case .failure(let error):
                self.cameraViewDelegate?.verifyChallengeError(error: error)
            }
        }
    }
}
