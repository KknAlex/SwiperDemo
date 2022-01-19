//
//  BetEventSubview.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import UIKit

class BetEventSubview: UIView {
    
    static let identifire = "BetEventSubview"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var partLabel: UILabel!
    @IBOutlet var partViews: [UIView]!
    @IBOutlet var partImageViews: [UIImageView]!
    @IBOutlet var bottomLabels: [UILabel]!

    func configure(model: BetEvent) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        
    }
}
