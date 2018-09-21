//
//  KataLogInLogOutTests.swift
//  KataLogInLogOutTests
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import XCTest
import Nimble
@testable import KataLogInLogOut

class AccessUseCaseTests: XCTestCase {
    
    private var sut:AccessUseCase!
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: login
    
    func test_given_invalid_username_password_when_login_then_not_logged() {
        givenNow()
        let result = sut.logIn(username: "", password: "admin")
        XCTAssertEqual(result, .invalid)
    }
    
    func test_given_valid_username_invalid_pass_when_login_then_not_logged() {
        givenNow()
        XCTAssertEqual(.invalid, sut.logIn(username: "admin", password: ""))
    }
    
    func test_given_invalid_username_valid_pass_when_login_then_not_logged() {
        givenNow()
        XCTAssertEqual(.invalid, sut.logIn(username: "", password: "admin"))
    }
    
    func test_given_valid_args_when_login_then_logged() {
        givenNow()
        XCTAssertEqual(.success, sut.logIn(username: "admin", password: "admin"))
    }
    
    func test_given_invalid_char_username_when_login_then_not_logged() {
        givenNow()
        let failureChars = [",", ".", ";"]
        for item in failureChars {
            XCTAssertEqual(.invalidChars, sut.logIn(username: item, password: "admin"))
        }
    }
    
    //async
    func test_given_invalid_username_password_when_login_async_then_not_logged() {
        givenNow()
        let result = sut.login(username: "", password: "admin")
        expect(result.error).toEventually(equal(.invalid))
    }
    
    func test_given_valid_username_invalid_pass_when_login_async_then_not_logged() {
        givenNow()
        let result = sut.login(username: "admin", password: "")
        expect(result.error).toEventually(equal(.invalid))
    }
    
    func test_given_invalid_username_valid_pass_when_login_async_then_not_logged() {
        givenNow()
        let result = sut.login(username: "", password: "admin")
        expect(result.error).toEventually(equal(.invalid))
    }
    
    func test_given_valid_args_when_login_async_then_logged() {
        givenNow()
        let uname = "admin"
        let result = sut.login(username: uname, password: "admin")
        expect(result.value).toEventually(equal(uname))
    }
    
    func test_given_invalid_char_username_when_login_async_then_not_logged() {
        givenNow()
        let failureChars = [",", ".", ";"]
        for item in failureChars {
            let result = sut.login(username: item, password: "admin")
            expect(result.error).toEventually(equal(.invalidChars))
        }
    }
    
    
    // MARK: logout
    
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
    
    // MARK : private
    func givenNowIs(clock:Clock) {
        sut = AccessUseCase(clock: clock)
    }
    
    func givenNow() {
        sut = AccessUseCase(clock: Clock())
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
