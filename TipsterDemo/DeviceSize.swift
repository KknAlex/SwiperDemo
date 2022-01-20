//
//  DeviceSize.swift
//  TipsterDemo
//
//  Created by Alex on 20.01.2022.
//

import Foundation
import UIKit

class DeviceSize {
    static var isIphoneXOrLonger: Bool {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top
        return topPadding ?? 0 > 24
    }
}
