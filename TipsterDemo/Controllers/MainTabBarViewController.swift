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
    private let selectedTopView = UIView()
    private var selectedTopViewCenterXConstraint: NSLayoutConstraint?
    
    // MARK: - Vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let horizontalConstraint = centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor)
        let verticalConstraint = centerButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor, constant: -20)
        let widthConstraint = centerButton.widthAnchor.constraint(equalToConstant: buttonHeight)
        let heightConstraint = centerButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        tabBar.frame.size.height = 95
        tabBar.frame.origin.y = view.frame.height - 95
    }
    
    // MARK: - Actions
    
    @objc func centerButtonPressed(_ sender: Any) {
        showAddScreen()
    }
    
    // MARK: - Helpers
    
    private func setupUI() {
        configureCenterButton()
        addTabBarTopLine()
        configureSelectedView()
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
    
    private func addTabBarTopLine() {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor(hex: 0x868291).withAlphaComponent(0.2)
        tabBar.addSubview(topView)
        let trailingConstraint = topView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor)
        let leadingConstraint = topView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor)
        let topConstraint = topView.topAnchor.constraint(equalTo: tabBar.topAnchor)
        let heightConstraint = topView.heightAnchor.constraint(equalToConstant: 0.5)
        view.addConstraints([trailingConstraint, leadingConstraint, topConstraint, heightConstraint])
    }
    
    private func configureSelectedView() {
        selectedTopView.translatesAutoresizingMaskIntoConstraints = false
        selectedTopView.backgroundColor = UIColor(hex: 0xF5F2F7)
        tabBar.addSubview(selectedTopView)
        let heightConstraint = selectedTopView.heightAnchor.constraint(equalToConstant: 2)
        let widthConstraint = selectedTopView.widthAnchor.constraint(equalToConstant: 24)
        let topConstraint = selectedTopView.topAnchor.constraint(equalTo: tabBar.topAnchor)
        selectedTopViewCenterXConstraint = selectedTopView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor, constant: 40)
        view.addConstraints([heightConstraint, widthConstraint, topConstraint, selectedTopViewCenterXConstraint!])
        animateSelectedView(duration: 0, index: 0)
    }
    
    private func animateSelectedView(duration: Double, index: Int) {
        let oneWidthPart = tabBar.bounds.width / 5
        let step = index == 0 ? 0 : oneWidthPart * CGFloat(index)
        self.selectedTopViewCenterXConstraint?.constant = step - (oneWidthPart * 2)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    // MARK: - UITabBarDelegate
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.firstIndex(of: item)
        animateSelectedView(duration: 0.3, index: index ?? 0)
    }
}
