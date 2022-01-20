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
        subview.round(radius: 24, corners: .allCorners)
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
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        swiperView.addSubview(scrollView)
        let vc = scrollView.centerYAnchor.constraint(equalTo: swiperView.centerYAnchor)
        let tc = scrollView.trailingAnchor.constraint(equalTo: swiperView.trailingAnchor)
        let topc = scrollView.topAnchor.constraint(equalTo: swiperView.topAnchor)
        topc.priority = .defaultLow
        let bc = scrollView.bottomAnchor.constraint(equalTo: swiperView.bottomAnchor)
        bc.priority = .defaultLow
        let lc = scrollView.leadingAnchor.constraint(equalTo: swiperView.leadingAnchor)
        swiperView.addConstraints([tc, topc, bc, lc, vc])
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(subview)
        let trailingConstraint = subview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        let leadingConstraint = subview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16)
        let topConstraint = subview.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor)
        let bottomConstraint = subview.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor)
        let widthConstraint = subview.widthAnchor.constraint(equalTo: swiperView.widthAnchor, constant: -32)
        swiperView.addConstraints([trailingConstraint, topConstraint, leadingConstraint, bottomConstraint, widthConstraint])
        
        subview.configure(model: tempGenerator.generateBetEvent())
    }
}

