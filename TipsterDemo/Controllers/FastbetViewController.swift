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
    
    private let subview: BetEventView = .fromNib()
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
        let verticalConstraint = subview.centerYAnchor.constraint(equalTo: swiperView.centerYAnchor)
        let trailingConstraint = subview.trailingAnchor.constraint(equalTo: swiperView.trailingAnchor)
        let leadingConstraint = subview.leadingAnchor.constraint(equalTo: swiperView.leadingAnchor)
        swiperView.addConstraints([trailingConstraint, verticalConstraint, leadingConstraint])
        
        subview.configure(model: tempGenerator.generateBetEvent())
    }
}

