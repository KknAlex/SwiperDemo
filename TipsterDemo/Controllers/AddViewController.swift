//
//  AddViewController.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import UIKit

class AddViewController: UIViewController {

    // MARK: - Vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
