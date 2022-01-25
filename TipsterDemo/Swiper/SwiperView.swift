//
//  SwiperView.swift
//  TipsterDemo
//
//  Created by Alex on 20.01.2022.
//

import UIKit

enum Side {
    case right
    case left
}

class SwiperView: UIView {

    @IBOutlet var contentViews: [UIView]!
    
    private var eventSubviews: [BetEventView] = [.fromNib(), .fromNib()]
    private let scrollView = UIView()
    private var activeViewIndex = 0

    override func layoutSubviews() {
        super.layoutSubviews()
        contentViews.forEach( {$0.round(radius: 24, shadowColor: DefaultColor.primaryDarkGray.withAlphaComponent(0.4).cgColor, shadowOffset: CGSize(width: 8, height: 8), shadowOpacity: 1, shadowRadius: 8)} )
    }
    
    func configure() {
        configureEventView()
        contentViews.forEach( {$0.backgroundColor = DefaultColor.primaryGray} )
        eventSubviews.forEach( {$0.delegate = self
            $0.addRecognizer()
        } )
    }
    
    // MARK: - Animations
    
    func animation(side: Side = .right) {
        let oldIndex = activeViewIndex

        var finishPoint: CGPoint = .zero
        var angle: CGFloat = 1
        switch side {
        case .left:
            finishPoint = CGPoint(x: eventSubviews[oldIndex].center.x - eventSubviews[oldIndex].frame.size.width * 2, y: eventSubviews[oldIndex].center.y)
            angle = -1
        default:
            finishPoint = CGPoint(x: eventSubviews[oldIndex].center.x + eventSubviews[oldIndex].frame.size.width * 2, y: eventSubviews[0].center.y)
            angle = 1
        }
        
        UIView.animate(withDuration: 0.8, animations: {() -> Void in
            self.animateCard(to: finishPoint, angle: angle, alpha: 1.0)
        }, completion: {(_ complete: Bool) -> Void in
            self.returnViewOriginalState(index: oldIndex)
        })
        
        activeViewIndex = activeViewIndex == 0 ? 1 : 0
    }
    
    private func animateCard(to center: CGPoint, angle: CGFloat = 0, alpha: CGFloat = 0) {
        eventSubviews[activeViewIndex].center = center
        eventSubviews[activeViewIndex].transform = CGAffineTransform(rotationAngle: angle)
    }
    
    // MARK: - Helpers
    
    private func configureEventView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
        contentViews[0].addSubview(scrollView)
        let centerXConstraint = scrollView.centerYAnchor.constraint(equalTo: contentViews[0].centerYAnchor)
        let trailingConstraint = scrollView.trailingAnchor.constraint(equalTo: contentViews[0].trailingAnchor)
        let topConstraint = scrollView.topAnchor.constraint(equalTo: contentViews[0].topAnchor)
        topConstraint.priority = .defaultLow
        let bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: contentViews[0].bottomAnchor)
        bottomConstraint.priority = .defaultLow
        let leadingConstraint = scrollView.leadingAnchor.constraint(equalTo: contentViews[0].leadingAnchor)
        contentViews[0].addConstraints([trailingConstraint, topConstraint, bottomConstraint, leadingConstraint, centerXConstraint])
        
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(0)
        eventSubviews[0].configure(model: TempGenerator().generateBetEvent())
        addSubview(1)
        eventSubviews[1].configure(model: TempGenerator().generateBetEvent())
        scrollView.sendSubviewToBack(eventSubviews[1])
    }
    
    private func addSubview(_ index: Int) {
        eventSubviews[index].translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(eventSubviews[index])
        let trailingConstraint = eventSubviews[index].trailingAnchor.constraint(equalTo: contentViews[0].trailingAnchor, constant: 0)
        let leadingConstraint = eventSubviews[index].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0)
        let topConstraint = eventSubviews[index].topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor)
        let bottomConstraint = eventSubviews[index].bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor)
        let widthConstraint = eventSubviews[index].widthAnchor.constraint(equalTo: contentViews[0].widthAnchor)
        contentViews[0].addConstraints([trailingConstraint, topConstraint, leadingConstraint, bottomConstraint, widthConstraint])
    }
    
    private func returnViewOriginalState(index: Int) {
        self.eventSubviews[index].center = CGPoint.zero
        self.eventSubviews[index].transform = CGAffineTransform(rotationAngle: 0)
        self.scrollView.sendSubviewToBack(self.eventSubviews[index])
        self.eventSubviews[index].configure(model: TempGenerator().generateBetEvent())
    }
}

extension SwiperView: BetEventViewDelegate {
    
    // MARK: - BetEventViewDelegate
    
    func viewDidEndSwipe(_ view: BetEventView, finishPoint: CGPoint) {
        let index = Int(eventSubviews.firstIndex(of: view) ?? 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.eventSubviews[index].center = finishPoint
        }, completion: {(_) in
            self.returnViewOriginalState(index: index)
        })
    
        activeViewIndex = activeViewIndex == 0 ? 1 : 0
    }
}
