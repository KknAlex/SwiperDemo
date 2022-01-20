//
//  User.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import Foundation

class User {
    var name: String?
    var picks: String?
    var profit: String?
    var yield: String?
    var money: String?
    var someCount: String?
    var imageName: String?
    
    static func current() -> User {
        let user = User()
        user.name = "kobebryant"
        user.imageName = "temp_kobe"
        user.money = "143.33$"
        user.someCount = "4300"
        return user
    }
}
