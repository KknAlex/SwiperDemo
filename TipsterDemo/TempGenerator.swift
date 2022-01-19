//
//  TempGenerator.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import Foundation

class TempGenerator {
    
    // MARK: - User
    
    private func firstUser() -> User {
        let user = User()
        user.name = "first111"
        user.picks = "2448"
        user.profit = "+4000"
        user.yield = "+35%"
        user.imageName = "temp_arni"
        return user
    }
    
    private func secondUser() -> User {
        let user = User()
        user.name = "second222"
        user.picks = "4567"
        user.profit = "+1789"
        user.yield = "+15%"
        user.imageName = "temp_vin"
        return user
    }
    
    func generateUser() -> User {
        if let user = [firstUser(), secondUser()].randomElement() {
            return user
        } else {
            return firstUser()
        }
    }
    
    func currentUser() -> User {
        User.current()
    }
    
    // MARK: - Bet part
    
    private func firstPart() -> BetPart {
        let part = BetPart()
        part.name = "FC Real Madrid"
        part.imageName = "temp_real"
        return part
    }
    
    private func secondPart() -> BetPart {
        let part = BetPart()
        part.name = "FC Barcelona"
        part.imageName = "temp_fcb"
        return part
    }
    
    // MARK: - Bet event
    
    private func firstEvent() -> BetEvent {
        let event = BetEvent()
        event.title = "FOOTBALL"
        event.subtitle = "Champions Legue"
        event.date = "20 янв"
        event.time = "19:00"
        event.user = generateUser()
        event.market = .total
        event.outcome = "Больше 1.5"
        event.betAmount = "100000000$"
        event.participants = "700"
        event.parts = [firstPart(), secondPart()]
        return event
    }
    
    private func secondEvent() -> BetEvent {
        let event = BetEvent()
        event.title = "FOOTBALL"
        event.subtitle = "Champions Legue"
        event.date = "22 янв"
        event.time = "22:00"
        event.user = generateUser()
        event.market = .win
        event.outcome = "2"
        event.betAmount = "1347540$"
        event.participants = "543"
        event.parts = [secondPart(), firstPart()]
        return event
    }
    
    func generateBetEvent() -> BetEvent {
        if let event = [firstEvent(), secondEvent()].randomElement() {
            return event
        } else {
            return firstEvent()
        }
    }
    
    func generateEvents(count: Int) -> [BetEvent] {
        var index = 0
        var events = [BetEvent]()
        while index != count {
            index += 1
            events.append(generateBetEvent())
        }
        return events
    }
}
