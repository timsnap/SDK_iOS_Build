//
//  PaymentViewController.swift
//  
//
//  Created by Timothy Obeisun on 11/19/22.
//

import UIKit

class PaymentViewController: UIViewController {
    var paymentView: PaymentView?
    var userData: UserData?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
        setupPaymentButtonTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.removeSnappayLoader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Receive Payment"
    }
    
    func attachView(_ displayView: PaymentView) {
        self.paymentView = displayView
    }
    
    func setupData() {
        paymentView?.setupLabel(
            recipient: userData?.receipientName ?? "",
            userName: userData?.sender ?? "",
            amount: userData?.amount.delimiterRefactored ?? ""
        )
    }
}

extension PaymentViewController {
    func setupViews() {
        view.backgroundColor = .white
        guard let paymentView = paymentView else { return }
        view.addSubview(paymentView)
        paymentView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
    }
    
    func setupPaymentButtonTapped() {
        paymentView?.paymentButtonDidTap = {
            self.navigationController?.popBackwards(3)
        }
        paymentView?.profilePicture.image = image
    }
}
