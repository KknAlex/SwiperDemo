//
//  SwiperView.swift
//  TipsterDemo
//
//  Created by Alex on 20.01.2022.
//

import UIKit

class SwiperView: UIView {

    @IBOutlet var contentViews: [UIView]!
    
    private let subview: BetEventView = .fromNib()

    override func layoutSubviews() {
        super.layoutSubviews()
        contentViews.forEach( {$0.round(radius: 24, shadowColor: DefaultColor.primaryDarkGray.withAlphaComponent(0.4).cgColor, shadowOffset: CGSize(width: 8, height: 8), shadowOpacity: 1, shadowRadius: 8)} )
    }
    
    func configure() {
        configureSwiperView()
        contentViews.forEach( {$0.backgroundColor = DefaultColor.primaryGray} )
    }
    
    private func configureSwiperView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        contentViews[0].addSubview(scrollView)
        let cxc = scrollView.centerYAnchor.constraint(equalTo: contentViews[0].centerYAnchor)
        let tc = scrollView.trailingAnchor.constraint(equalTo: contentViews[0].trailingAnchor)
        let topc = scrollView.topAnchor.constraint(equalTo: contentViews[0].topAnchor)
        topc.priority = .defaultLow
        let bc = scrollView.bottomAnchor.constraint(equalTo: contentViews[0].bottomAnchor)
        bc.priority = .defaultLow
        let lc = scrollView.leadingAnchor.constraint(equalTo: contentViews[0].leadingAnchor)
        contentViews[0].addConstraints([tc, topc, bc, lc, cxc])
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(subview)
        let trailingConstraint = subview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0)
        let leadingConstraint = subview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0)
        let topConstraint = subview.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor)
        let bottomConstraint = subview.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor)
        let widthConstraint = subview.widthAnchor.constraint(equalTo: contentViews[0].widthAnchor)
        contentViews[0].addConstraints([trailingConstraint, topConstraint, leadingConstraint, bottomConstraint, widthConstraint])
        
        subview.configure(model: TempGenerator().generateBetEvent())
    }
}
