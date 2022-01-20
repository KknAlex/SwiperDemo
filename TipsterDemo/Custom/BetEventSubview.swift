//
//  BetEventSubview.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import UIKit

class BetEventSubview: UIView {

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
        dateLabel.text = model.date
        timeLabel.text = model.time
        partLabel.text = "\(model.parts?[0].name ?? "") - \(model.parts?[1].name ?? "")"
        partImageViews[0].image = UIImage(named: model.parts?[0].imageName ?? "")
        partImageViews[1].image = UIImage(named: model.parts?[1].imageName ?? "")
        bottomLabels[0].text = model.market?.name()
        bottomLabels[1].text = model.outcome
        
        partViews.forEach( {$0.round(radius: partViews[0].bounds.height, corners: .allCorners, borderWidth: 2, borderColor: UIColor(hex: 0x271D34).cgColor)} )
    }
}
