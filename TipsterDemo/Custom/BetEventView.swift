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
    
    // MARK: - Actions
    
    @objc func followButtonPressed(_ sender: Any) {
        
    }
    
    @objc func shareButtonPressed(_ sender: Any) {
        
    }
}
