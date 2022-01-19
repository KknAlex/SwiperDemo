//
//  BetEventView.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import UIKit

class BetEventView: UIView {

    static let identifire = "BetEventView"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentSubview: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet var topLabels: [UILabel]!
    @IBOutlet var bottomLabels: [UILabel]!
    
    func configure(model: BetEvent) {
        if let user = model.user, let imageName = user.imageName {
            userImageView.image = UIImage(named: imageName)
            topLabels[0].text = user.name
            topLabels[1].text = "Picks \(user.picks ?? "") * Profit \(user.profit ?? "") * Yield \(user.yield ?? "")"
        }
        
        bottomLabels[0].text = model.betAmount
        bottomLabels[1].text = model.participants
    }
    
    private func configureSubview(model: BetEvent) {
        let subview: BetEventSubview = .fromNib()
        subview.translatesAutoresizingMaskIntoConstraints = false
        contentSubview.addSubview(subview)
        let verticalConstraint = subview.centerYAnchor.constraint(equalTo: contentSubview.centerYAnchor)
        let trailingConstraint = subview.trailingAnchor.constraint(equalTo: contentSubview.trailingAnchor)
        let leadingConstraint = subview.leadingAnchor.constraint(equalTo: contentSubview.leadingAnchor)
        contentSubview.addConstraints([trailingConstraint, verticalConstraint, leadingConstraint])
        subview.configure(model: model)
    }
    
    // MARK: - Actions
    
    @objc func followButtonPressed(_ sender: Any) {
        
    }
    
    @objc func shareButtonPressed(_ sender: Any) {
        
    }
}
