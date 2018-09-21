//
//  AccessPresenterTest.swift
//  KataLogInLogOutTests
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import XCTest
import Nimble
import BrightFutures
import Result
@testable import KataLogInLogOut

class AccessPresenterTests: XCTestCase {
    
    private let USERNAME = ""
    private let PASSWORD = ""
    private var sut:AccessPresenter!
    private var mockView:MockAccessView!
    private var mockKata:MockAccessUseCase!
    
    override func setUp() {
        super.setUp()
        mockKata = MockAccessUseCase()
        mockView = MockAccessView()
        sut = AccessPresenter(accessUseCase: mockKata)
        sut.view = mockView
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockView = nil
        mockKata = nil
    }
    
    // Mark: Login
    
    func test_given_valid_login_logic_when_login_then_logged() {
        givenLogInResult(result: LoginResult.success)
        sut.logIn(username: USERNAME, password: PASSWORD)
        XCTAssertTrue(mockView.hidedLogInForm)
        XCTAssertTrue(mockView.showedLogOutForm)
        XCTAssertNil(mockView.showedLoginForm)
        XCTAssertNil(mockView.hidedLogOutForm)
        XCTAssertNil(mockView.showedError)
    }
    
    func test_given_invalid_login_when_login_then_not_logged() {
        givenLogInResult(result: LoginResult.invalid)
        sut.logIn(username: USERNAME, password: PASSWORD)
        assertNotTouchedViewForm() //maybe over specificated
        XCTAssertEqual(mockView.showedError, "invalid login")
    }
    
    func test_given_invalid_chars_login_when_login_then_not_logged() {
        givenLogInResult(result: LoginResult.invalidChars)
        sut.logIn(username: USERNAME, password: PASSWORD)
        assertNotTouchedViewForm() //maybe over specificated
        XCTAssertEqual(mockView.showedError, "invalid chars in login")
    }
    
    //async
    func test_given_valid_login_logic_when_login_async_then_logged() {
        givenLoginResult(result: Result(value: USERNAME))
        sut.login(username: USERNAME, password: PASSWORD)
        expect(self.mockView.hidedLogInForm).toEventually(beTrue())
        expect(self.mockView.showedLogOutForm).toEventually(beTrue())
        expect(self.mockView.showedLoginForm).to(beNil())
        expect(self.mockView.hidedLogOutForm).to(beNil())
        expect(self.mockView.showedError).to(beNil())
    }
    
    func test_given_invalid_login_when_login_async_then_not_logged() {
        givenLoginResult(result: Result(error: LoginError.invalid))
        sut.login(username: USERNAME, password: PASSWORD)
        assertNotTouchedViewForm() //maybe over specificated
        expect(self.mockView.showedError).to(equal("invalid login"))
    }
    
    func test_given_invalid_chars_login_when_login_async_then_not_logged() {
        givenLoginResult(result: Result(error: LoginError.invalidChars))
        sut.login(username: USERNAME, password: PASSWORD)
        assertNotTouchedViewForm() //maybe over specificated
        expect(self.mockView.showedError).to(equal("invalid chars in login"))
    }
    
    // Mark: Logout
    
    func test_given_valid_logout_when_logout_then_logged_out() {
        givenLogoutResult(result: true)
        sut.logOut()
        XCTAssertNil(mockView.showedError)
        XCTAssertNil(mockView.showedLogOutForm)
        XCTAssertNil(mockView.hidedLogInForm)
        XCTAssertEqual(mockView.showedLoginForm, true)
        XCTAssertEqual(mockView.hidedLogOutForm, true)
    }
    
    func test_given_invalid_logout_when_logout_then_not_logged_out() {
        givenLogoutResult(result: false)
        sut.logOut()
        assertNotTouchedViewForm()
        XCTAssertEqual(mockView.showedError, "failed")
    }
    
    // Mark: private
    
    func givenLogInResult(result:LoginResult)  {
        mockKata.loginResult = result
    }

    func givenLoginResult(result: Result<String, LoginError>) {
        mockKata.result = result
    }
    
    func givenLogoutResult(result:Bool) {
        mockKata.logoutResult = result
    }
    
    func assertNotTouchedViewForm() {
        expect(self.mockView.hidedLogInForm).toEventually(beNil())
        expect(self.mockView.showedLogOutForm).toEventually(beNil())
        expect(self.mockView.showedLoginForm).toEventually(beNil())
        expect(self.mockView.hidedLogOutForm).toEventually(beNil())
    }
}

private class MockAccessUseCase: AccessUseCase {
    
    var result:Result<String, LoginError>!
    var loginResult:LoginResult!
    var logoutResult:Bool!
    
    init() {
        super.init(clock: Clock())
    }
    
    override func logIn(username: String, password: String) -> LoginResult {
        return loginResult
    }
    
    override func login(username: String, password: String) -> Future<String, LoginError> {
        return Future(result: result)
    }
    
    override func logOut() -> Bool {
        return logoutResult
    }
}

private class MockAccessView: AccessView {
    
    var showedLoginForm:Bool!
    var hidedLogInForm:Bool!
    var showedLogOutForm:Bool!
    var hidedLogOutForm:Bool!
    var showedError:String!
    
    func showLogInForm() {
        showedLoginForm = true
    }
    
    func hideLogInForm() {
        hidedLogInForm = true
    }
    
    func showLogOutForm() {
        showedLogOutForm = true
    }
    
    func hideLogOutForm() {
        hidedLogOutForm = true
    }
    
    func showError(error: String) {
        showedError = error
    }
    
}
