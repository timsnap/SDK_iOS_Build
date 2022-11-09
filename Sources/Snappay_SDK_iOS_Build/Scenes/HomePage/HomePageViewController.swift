//
//  HomePageViewController.swift
//  
//
//  Created by Timothy Obeisun on 11/9/22.
//

import UIKit

class HomePageViewController: UIViewController {
    private let userData: UserData
    var homePageView: HomePageView?
    var viewModel: HomePageViewModelDelegate!
    var configurator: HomePageConfiguratorProtocol = HomePageConfigurator()
    
    init(userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configurator.configure(with: HomePageNetworkService(), viewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.homeVcDelegate = self
        viewModel?.startChallenge(userData: userData)
    }
    
    func attachView(_ displayView: HomePageView) {
        self.homePageView = displayView
    }
}

extension HomePageViewController {
    func setupViews() {
        view.backgroundColor = .white
        guard let homePageView = homePageView else { return }
        view.addSubview(homePageView)
        homePageView.anchor(
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
}

extension HomePageViewController: HomeVcDelegate{
    func startChallengeError(error: Error) {
        // TODO: Track Error then display
    }
    
    func startChallengeData(data: StartChallenge) {
        // TODO: Pass the data Gotten From the Endpoint to the Next Screen
    }
}
