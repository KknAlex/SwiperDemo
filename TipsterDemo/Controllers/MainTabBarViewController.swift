//
//  MainTabBarViewController.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    private let centerButton = UIButton(type: .custom)
    private let buttonHeight: CGFloat = 80
    
    // MARK: - Vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let horizontalConstraint = centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor)
        let verticalConstraint = centerButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor, constant: -20)
        let widthConstraint = centerButton.widthAnchor.constraint(equalToConstant: buttonHeight)
        let heightConstraint = centerButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    // MARK: - Actions
    
    @objc func centerButtonPressed(_ sender: Any) {
        showAddScreen()
    }
    
    // MARK: - Helpers
    
    private func setupUI() {
        configureCenterButton()
    }
    
    private func configureCenterButton() {
        centerButton.setImage(#imageLiteral(resourceName: "plus_icon"), for: .normal)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.addTarget(self, action: #selector(centerButtonPressed), for: .touchUpInside)
        tabBar.addSubview(centerButton)
    }
    
    private func showAddScreen() {
        let vc = AddViewController.fromStoryboard()
        present(vc, animated: true, completion: nil)
    }
}
