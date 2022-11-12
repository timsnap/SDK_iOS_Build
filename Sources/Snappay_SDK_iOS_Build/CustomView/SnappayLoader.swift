//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/12/22.
//

import UIKit


class SnappayLoader: UIView {

    var blurEffectView: UIVisualEffectView?

    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.backgroundColor = #colorLiteral(red: 0, green: 0.7239694595, blue: 0.9761376977, alpha: 0.4739317602)
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}
