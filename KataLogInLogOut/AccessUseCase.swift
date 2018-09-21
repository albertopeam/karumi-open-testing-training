//
//  KataApp.swift
//  KataLogInLogOut
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import Foundation
import BrightFutures

class AccessUseCase {
    
    private let clock:Clock
    
    init(clock:Clock) {
        self.clock = clock
    }
    
    func login(username:String, password:String) -> Future<String, LoginError> {
        return Future { complete in
            DispatchQueue.global().async {
                if self.checkInValidUsername(input: username){
                    complete(.failure(LoginError.invalidChars))
                }
                if username.isEqual("admin") && password.isEqual("admin") {
                    complete(.success("admin"))
                }
                complete(.failure(LoginError.invalid))
            }
        }
    }
    
    func logOut() -> Bool {
        let date = clock.now
        return Int(date.timeIntervalSince1970) % 2 == 0
    }
    
    private func checkInValidUsername(input:String) -> Bool {
        return input.contains(",") || input.contains(".") || input.contains(";")
    }
}

enum LoginError: Error {
    case invalid, invalidChars
}
