//
//  ViewController.swift
//  TipsterDemo
//
//  Created by Alex on 18.01.2022.
//

import UIKit

class FastbetViewController: UIViewController {

    // MARK: - Vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
}

