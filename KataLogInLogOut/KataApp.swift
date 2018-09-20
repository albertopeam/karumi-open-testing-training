//
//  KataApp.swift
//  KataLogInLogOut
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import Foundation

class KataApp {
    
    private let clock:Clock
    
    init(clock:Clock) {
        self.clock = clock
    }
    
    func logIn(username:String, password:String) -> Bool {
        if username.isEqual("admin") && password.isEqual("admin") {
            return true
        }
        return false
    }
    
    func logOut() -> Bool {
        let date = clock.now
        return Int(date.timeIntervalSince1970) % 2 == 0
    }
}
