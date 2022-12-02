////
////  File.swift
////  
////
////  Created by Timothy Obeisun on 11/22/22.
////
//
//import Foundation
//
//class PaymentViewModel: PaymentViewModelDelegate {
//    var paymentViewDelegate: PaymentViewDelegate?
//    
//    private let paymentNetworkService: PaymentNetworkServiceProtocol
//    
//    init(
//        paymentNetworkService: PaymentNetworkServiceProtocol
//    ) {
//        self.paymentNetworkService = paymentNetworkService
//    }
//    
//    func verifyChallenge() {
//        paymentNetworkService.verifyChallenge { result in
//            switch result {
//            case .success(let data):
//                self.paymentViewDelegate?.verifyChallengeData(data: data)
//            case .failure(let error):
//                self.paymentViewDelegate?.verifyChallengeError(error: error)
//            }
//        }
//    }
//}
//TODO

