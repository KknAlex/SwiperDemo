//
//  BetEvent.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import Foundation

enum Market {
    case total
    case win
    
    func name() -> String {
        switch self {
        case .total:
            return "Тотал матча"
        default:
            return "Победит команда"
        }
    }
}

class BetEvent {
    var title: String?
    var subtitle: String?
    var date: String?
    var time: String?
    var user: User?
    var market: Market?
    var outcome: String?
    var betAmount: String?
    var participants: String?
}
