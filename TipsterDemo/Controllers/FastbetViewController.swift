//
//  ViewController.swift
//  TipsterDemo
//
//  Created by Alex on 18.01.2022.
//

import UIKit

class FastbetViewController: UIViewController {
    
    @IBOutlet weak var swiperView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet var topViews: [UIView]!
    @IBOutlet var topLabels: [UILabel]!
    @IBOutlet weak var userNameLabel: UILabel!
    
    private let subview: SwiperView = .fromNib()
    private let tempGenerator = TempGenerator()

    // MARK: - Vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViews.forEach( {$0.round(radius: topViews[0].bounds.height / 2, corners: .allCorners)} )
        userImageView.round(radius: userImageView.bounds.height / 2, corners: .allCorners)
    }
    
    // MARK: - Actions
    
    @IBAction func notificationsButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func hamburgerButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        subview.animation(side: .right)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        subview.animation(side: .left)
    }
    
    // MARK: - Helpers
    
    private func setupUi() {
        configureSwiperView()
        
        userImageView.image = UIImage(named: tempGenerator.currentUser().imageName ?? "")
        userNameLabel.text = tempGenerator.currentUser().name
        topLabels[0].text = tempGenerator.currentUser().money
        topLabels[1].text = tempGenerator.currentUser().someCount
    }
    
    private func configureSwiperView() {
        subview.translatesAutoresizingMaskIntoConstraints = false
        swiperView.addSubview(subview)
        let heightConstraint = subview.heightAnchor.constraint(equalTo: swiperView.heightAnchor)
        let widthConstraint = subview.widthAnchor.constraint(equalTo: swiperView.widthAnchor, constant: -32)
        let centerXConstraint = subview.centerXAnchor.constraint(equalTo: swiperView.centerXAnchor)
        swiperView.addConstraints([heightConstraint, widthConstraint, centerXConstraint])
        subview.configure()
        subview.layoutIfNeeded()
    }
}

