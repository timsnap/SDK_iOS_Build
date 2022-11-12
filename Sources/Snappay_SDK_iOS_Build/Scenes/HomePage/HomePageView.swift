//
//  HomePageView.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import UIKit

class HomePageView: UIView {
    
    var backButtonDidTap: (() -> Void)?
    var scanButtonDidTap: (() -> Void)?
    
    lazy var baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = .clear
        return baseView
    }()
    
    lazy var backButton: UIButton = {
        let backButton = UIButton()
        let image = UIImage().loadImage(named: "back_Arrow")
        backButton.setImage(image, for: .normal)
        backButton.backgroundColor = .clear
        return backButton
    }()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.backgroundColor = .clear
        logo.contentMode = .scaleAspectFit
        logo.layer.cornerRadius = 5
        return logo
    }()
    
    lazy var paymentDescriptionLabel: UILabel = {
        let paymentDescriptionLabel = UILabel()
        paymentDescriptionLabel.numberOfLines = 0
        paymentDescriptionLabel.textAlignment = .center
        paymentDescriptionLabel.textColor = #colorLiteral(red: 0, green: 0.7239694595, blue: 0.9761376977, alpha: 1)
        return paymentDescriptionLabel
    }()
    
    lazy var scanTitle: UILabel = {
        let scanTitle = UILabel()
        scanTitle.text = "Scan face to authenticate payments"
        scanTitle.font = .boldSystemFont(ofSize: 15)
        scanTitle.numberOfLines = 0
        scanTitle.textAlignment = .center
        scanTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return scanTitle
    }()
    
    lazy var scanImageContainer: UIView = {
       let scanImageContainer = UIView()
        scanImageContainer.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.8392156863, blue: 0.9843137255, alpha: 0.4431069303)
        scanImageContainer.layer.cornerRadius = 35
        return scanImageContainer
    }()
    
    lazy var scanImageView: UIImageView = {
       let scanImageView = UIImageView()
        scanImageView.backgroundColor = .clear
        let image = UIImage().loadImage(named: "scan_1")
        scanImageView.image = image
        return scanImageView
    }()
    
    lazy var scanButton: UIButton = {
        let scanButton = UIButton()
        scanButton.setTitle("Scan", for: .normal)
        scanButton.backgroundColor = #colorLiteral(red: 0, green: 0.7239694595, blue: 0.9761376977, alpha: 1)
        scanButton.setTitleColor(.white, for: .normal)
        scanButton.layer.cornerRadius = 10
        scanButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return scanButton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        prepareViews()
        prepareConstraints()
        setupBackButton()
        setupScanButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareViews()
        prepareConstraints()
        setupBackButton()
        setupScanButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomePageView {
    func prepareViews() {
        addSubview(baseView)
        
        baseView.addSubview(
            [
                backButton,
                logo,
                paymentDescriptionLabel,
                scanTitle,
                scanButton,
                scanImageContainer
            ]
        )
        
        scanImageContainer.addSubview(scanImageView)
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
        
        backButton.anchor(
            top: topAnchor,
            left: leftAnchor,
            paddingTop: 20,
            paddingLeft: 20,
            width: 35,
            height: 35
        )
        
        logo.anchor(
            top: baseView.topAnchor,
            paddingTop: 20,
            width: 50,
            height: 50
        )
        logo.centerX(inView: baseView)
        
        paymentDescriptionLabel.anchor(
            top: logo.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 50,
            paddingLeft: 65,
            paddingRight: 65
        )
        
        scanTitle.anchor(
            top: paymentDescriptionLabel.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 60,
            paddingLeft: 65,
            paddingRight: 65
        )
        
        scanButton.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingLeft: 25,
            paddingBottom: 20,
            paddingRight: 25,
            height: 50
        )
        
        scanImageContainer.anchor(
            bottom: scanButton.topAnchor,
            paddingBottom: 100,
            width: 70,
            height: 70
        )
        scanImageContainer.centerX(inView: baseView)
        
        scanImageView.anchor(
            width: 45,
            height: 45
        )
        scanImageView.center(inView: scanImageContainer)
    }
    
    func setupLabel(text: String) {
        let before = "A payment request of "
        let text = text
        let after  = " was inititiated "
        let regular = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)
        ]
        let attributedString = NSMutableAttributedString(string:before, attributes:regular)
        let attrs = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)
        ]
        let boldString = NSMutableAttributedString(string: text, attributes:attrs)
        let afterString = NSMutableAttributedString(string: after, attributes:regular)
        attributedString.append(boldString)
        attributedString.append(afterString)
        paymentDescriptionLabel.attributedText = attributedString
    }
}

extension HomePageView {
    func setupBackButton() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        guard let backButtonDidTap = backButtonDidTap else { return }
        backButtonDidTap()
    }
    
    func setupScanButton() {
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func scanButtonTapped() {
        guard let scanButtonDidTap = scanButtonDidTap else { return }
        scanButtonDidTap()
    }
}
