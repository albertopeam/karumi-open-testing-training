//
//  KataApp.swift
//  KataLogInLogOut
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import Foundation

enum LoginResult:Equatable {
    case success
    case invalidChars
    case invalid
}

class AccessUseCase {
    
    private let clock:Clock
    
    init(clock:Clock) {
        self.clock = clock
    }
    
    func logIn(username:String, password:String) -> LoginResult {
        if checkInValidUsername(input: username){
            return LoginResult.invalidChars
        }
        if username.isEqual("admin") && password.isEqual("admin") {
            return LoginResult.success
        }
        return LoginResult.invalid
    }
    
    func logOut() -> Bool {
        let date = clock.now
        return Int(date.timeIntervalSince1970) % 2 == 0
    }
    
    private func checkInValidUsername(input:String) -> Bool {
        return input.contains(",") || input.contains(".") || input.contains(";")
    }
}
