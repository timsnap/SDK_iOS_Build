//
//  PaymentView.swift
//  
//
//  Created by Timothy Obeisun on 11/19/22.
//

import UIKit

class PaymentView: UIView {
    var paymentButtonDidTap: (() -> Void)?
    
    lazy var baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = .white
        return baseView
    }()
    
    lazy var tickIconBackgroundView: UIView = {
        let tickIconBackgroundView = UIView()
        tickIconBackgroundView.backgroundColor = UIColor().loadColor(named: "SnappayPrimary")
        tickIconBackgroundView.layer.cornerRadius = 55
        return tickIconBackgroundView
    }()
    
    lazy var tickIcon: UIImageView = {
        let tickIcon = UIImageView()
        let image = UIImage().loadImage(named: "tick_icon")
        tickIcon.image = image
        tickIcon.contentMode = .scaleAspectFit
        return tickIcon
    }()
    
    lazy var paymentDescriptionLabel: UILabel = {
        let paymentDescriptionLabel = UILabel()
        paymentDescriptionLabel.numberOfLines = 0
        paymentDescriptionLabel.textAlignment = .center
        paymentDescriptionLabel.textColor = UIColor().loadColor(named: "SnappayPrimary")
        return paymentDescriptionLabel
    }()
    
    lazy var profilePicture: UIImageView = {
        let profilePicture = UIImageView()
        profilePicture.backgroundColor = .darkGray
        profilePicture.layer.cornerRadius = 15
        profilePicture.clipsToBounds = true
        profilePicture.contentMode = .scaleAspectFill
        return profilePicture
    }()
    
    lazy var onlineIcon: UIImageView = {
        let onlineIcon = UIImageView()
        onlineIcon.image = UIImage().loadImage(named: "online_icon")
        return onlineIcon
    }()
    
    lazy var paymentButton: UIButton = {
        let paymentButton = UIButton()
        paymentButton.setTitle("Another Payment", for: .normal)
        paymentButton.backgroundColor = UIColor().loadColor(named: "SnappayPrimary")
        paymentButton.setTitleColor(.white, for: .normal)
        paymentButton.layer.cornerRadius = 10
        paymentButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return paymentButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViews()
        prepareConstraints()
        setupPaymentButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareViews()
        prepareConstraints()
        setupPaymentButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaymentView {
    func prepareViews() {
        addSubview(baseView)
        
        baseView.addSubview(
            [
                tickIconBackgroundView,
                paymentDescriptionLabel,
                profilePicture,
                paymentButton,
                onlineIcon
            ]
        )
        
        tickIconBackgroundView.addSubview(tickIcon)
    }
    
    func prepareConstraints() {
        baseView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
        
        tickIconBackgroundView.anchor(
            top: baseView.topAnchor,
            paddingTop: 120,
            width: 110,
            height: 110
        )
        tickIconBackgroundView.centerX(inView: baseView)
        
        tickIcon.centerX(inView: tickIconBackgroundView)
        tickIcon.centerY(inView: tickIconBackgroundView)
        
        paymentDescriptionLabel.anchor(
            top: tickIconBackgroundView.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 40,
            paddingLeft: 55,
            paddingRight: 55
        )
        
        profilePicture.anchor(
            top: paymentDescriptionLabel.bottomAnchor,
            paddingTop: 30,
            width: 78,
            height: 78
        )
        profilePicture.centerX(inView: baseView)
        
        paymentButton.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingLeft: 25,
            paddingBottom: 20,
            paddingRight: 25,
            height: 50
        )
        
        onlineIcon.anchor(
            top: profilePicture.bottomAnchor,
            right: profilePicture.rightAnchor,
            paddingTop: -10,
            paddingLeft: 0,
            width: 18,
            height: 18
        )
    }
}


extension PaymentView {
    func setupLabel(recipient: String, userName: String, amount: String) {
        let before = "Thank you \(userName),\nyour payment of \(amount)\n to "
        let text = recipient
        let after  = " has been received"
        let regular = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19)
        ]
        let attributedString = NSMutableAttributedString(string:before, attributes:regular)
        let attrs = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 19)
        ]
        let boldString = NSMutableAttributedString(string: text, attributes:attrs)
        let afterString = NSMutableAttributedString(string: after, attributes:regular)
        attributedString.append(boldString)
        attributedString.append(afterString)
        paymentDescriptionLabel.attributedText = attributedString
    }
}


extension PaymentView {
    func setupPaymentButton() {
        paymentButton.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
    }
    
    @objc func paymentButtonTapped() {
        guard let paymentButtonDidTap = paymentButtonDidTap else { return }
        paymentButtonDidTap()
    }
}
