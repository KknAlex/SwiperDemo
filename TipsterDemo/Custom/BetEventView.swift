//
//  BetEventView.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import UIKit

class BetEventView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentSubview: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet var topLabels: [UILabel]!
    @IBOutlet var bottomLabels: [UILabel]!
    @IBOutlet var bottomViews: [UIView]!
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        bottomViews[0].round(radius: 16, corners: [.bottomLeft, .topLeft])
        bottomViews[1].round(radius: 16, corners: [.bottomRight, .topRight])
    }
    
    func configure(model: BetEvent) {
        if let user = model.user, let imageName = user.imageName {
            userImageView.image = UIImage(named: imageName)
            topLabels[0].text = user.name
            topLabels[1].text = "Picks \(user.picks ?? "") * Profit \(user.profit ?? "") * Yield \(user.yield ?? "")"
        }
        
        bottomLabels[0].text = model.betAmount
        bottomLabels[1].text = model.participants
        
        userImageView.round(radius: 24, corners: .allCorners)
        
        configureSubview(model: model)
        
        layoutIfNeeded()
    }
    
    private func configureSubview(model: BetEvent) {
        let subview: BetEventSubview = .fromNib()
        subview.translatesAutoresizingMaskIntoConstraints = false
        contentSubview.addSubview(subview)
        let trailingConstraint = subview.trailingAnchor.constraint(equalTo: contentSubview.trailingAnchor)
        let leadingConstraint = subview.leadingAnchor.constraint(equalTo: contentSubview.leadingAnchor)
        let topConstraint = subview.topAnchor.constraint(equalTo: contentSubview.topAnchor)
        let bottomConstraint = subview.bottomAnchor.constraint(equalTo: contentSubview.bottomAnchor)
        contentSubview.addConstraints([trailingConstraint, leadingConstraint, topConstraint, bottomConstraint])
        subview.configure(model: model)
    }
    
    // MARK: - Actions
    
    @IBAction func followButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        
    }
}
