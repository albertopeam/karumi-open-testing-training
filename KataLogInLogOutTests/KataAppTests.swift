//
//  KataLogInLogOutTests.swift
//  KataLogInLogOutTests
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import XCTest
@testable import KataLogInLogOut

class KataAppTests: XCTestCase {
    
    private var sut:KataApp!
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_given_invalid_username_password_when_login_then_not_logged() {
        givenNow()
        XCTAssertEqual(false, sut.logIn(username: "", password: "admin"))
    }
    
    func test_given_valid_username_invalid_pass_when_login_then_not_logged() {
        givenNow()
        XCTAssertEqual(false, sut.logIn(username: "admin", password: ""))
    }
    
    func test_given_invalid_username_valid_pass_when_login_then_not_logged() {
        givenNow()
        XCTAssertEqual(false, sut.logIn(username: "", password: "admin"))
    }
    
    func test_given_valid_args_when_login_then_logged() {
        givenNow()
        XCTAssertEqual(true, sut.logIn(username: "admin", password: "admin"))
    }
    
    func test_given_valid_time_when_logout_then_logout(){
        let mockClock = MockClock(date: Date.init(timeIntervalSince1970: 2))
        givenNowIs(clock: mockClock)
        XCTAssertEqual(true, sut.logOut())
    }
    
    func test_given_invalid_time_when_logout_then_no_logout(){
        let mockClock = MockClock(date: Date.init(timeIntervalSince1970: 3))
        givenNowIs(clock: mockClock)
        XCTAssertEqual(false, sut.logOut())
    }
    
    // Mark : private
    func givenNowIs(clock:Clock) {
        sut = KataApp(clock: clock)
    }
    
    func givenNow() {
        sut = KataApp(clock: Clock())
    }
}

private class MockClock: Clock {
    
    let date:Date
    
    init(date:Date) {
        self.date = date
    }
    
    override var now: Date{
        return date
    }
}
