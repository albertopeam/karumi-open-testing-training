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
    
    override func setUp() {
        super.setUp()
        sut = KataApp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_given_invalid_username_password_when_login_then_not_logged() {
        XCTAssertEqual(false, sut.logIn(username: "", password: "admin"))
    }
    
    func test_given_valid_username_invalid_pass_when_login_then_not_logged() {
        XCTAssertEqual(false, sut.logIn(username: "admin", password: ""))
    }
    
    func test_given_invalid_username_valid_pass_when_login_then_not_logged() {
        XCTAssertEqual(false, sut.logIn(username: "", password: "admin"))
    }
    
    func test_given_valid_args_when_login_then_logged() {
        XCTAssertEqual(true, sut.logIn(username: "admin", password: "admin"))
    }
}
