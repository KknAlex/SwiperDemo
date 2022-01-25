//
//  BetEventView.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import UIKit

protocol BetEventViewDelegate: AnyObject {
    func viewDidEndSwipe(_ view: BetEventView)
}

class BetEventView: UIView {
    
    weak var delegate: BetEventViewDelegate?

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentSubview: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet var topLabels: [UILabel]!
    @IBOutlet var bottomLabels: [UILabel]!
    @IBOutlet var bottomViews: [UIView]!
    
    private var centerX: CGFloat = 0.0
    private var centerY: CGFloat = 0.0
    private var originalPoint = CGPoint.zero
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        bottomViews[0].round(radius: 16, corners: [.bottomLeft, .topLeft])
        bottomViews[1].round(radius: 16, corners: [.bottomRight, .topRight])
    }
    
    func configure(model: BetEvent) {
        if let user = model.user, let imageName = user.imageName {
            userImageView.image = UIImage(named: imageName)
            topLabels[0].text = user.name
            topLabels[1].attributedText = getAttString(user: user)
        }
        
        bottomLabels[0].text = model.betAmount
        bottomLabels[1].text = model.participants
        
        userImageView.round(radius: 24, corners: .allCorners)
        
        configureSubview(model: model)
        
        layoutIfNeeded()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.beingDragged))
        panGestureRecognizer.delegate = self
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: - Actions
    
    @IBAction func followButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        
    }
    
    // MARK: - Helpers
    
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
    
    private func getAttString(user: User) -> NSMutableAttributedString {
        let mutableString = NSMutableAttributedString(string: "Picks \(user.picks ?? "") \u{00B7} Profit \(user.profit ?? "") \u{00B7} Yield \(user.yield ?? "")")
        let location1 = "Picks ".count
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: 0xEAEFF7), range: NSRange(location: location1, length: user.picks?.count ?? 0))
        let location2 = location1 + (user.picks?.count ?? 0) + " \u{00B7} Profit ".count
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: 0xEAEFF7), range: NSRange(location: location2, length: user.profit?.count ?? 0))
        let location3 = location2 + (user.profit?.count ?? 0) + " \u{00B7} Yield ".count
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: 0xEAEFF7), range: NSRange(location: location3, length: user.yield?.count ?? 0))
        return mutableString
    }
    
   
    private func afterSwipeAction() {
        let margin = (UIScreen.main.bounds.size.width / 2) * 0.75
        
        if centerX > margin {
            cardGoesRight()
        } else if centerX < -margin {
            cardGoesLeft()
        } else {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
    
    private func cardGoesRight() {
        let finishPoint = CGPoint(x: frame.size.width * 2, y: 2 * centerY + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.delegate?.viewDidEndSwipe(self)
        })
    }
    
    private func cardGoesLeft() {
        let finishPoint = CGPoint(x: -frame.size.width * 2, y: 2 * centerY + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.delegate?.viewDidEndSwipe(self)
        })
    }
}

extension BetEventView: UIGestureRecognizerDelegate {
    
    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @objc private func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        centerX = gestureRecognizer.translation(in: self).x
        centerY = gestureRecognizer.translation(in: self).y
        switch gestureRecognizer.state {
        case .began:
            originalPoint = self.center
            break
        case .changed:
            let rotationStrength = min(centerX / UIScreen.main.bounds.size.width, 1)
            let rotationAngel = .pi/8 * rotationStrength
            let scale = max(1 - abs(rotationStrength) / 4, 0.9)
            center = CGPoint(x: originalPoint.x + centerX, y: originalPoint.y + centerY)
            let transforms = CGAffineTransform(rotationAngle: rotationAngel)
            let scaleTransform: CGAffineTransform = transforms.scaledBy(x: scale, y: scale)
            self.transform = scaleTransform
            break
        case .ended:
            afterSwipeAction()
            break
        case .possible:break
        case .cancelled:break
        case .failed:break
        @unknown default:
            fatalError()
        }
    }
}
