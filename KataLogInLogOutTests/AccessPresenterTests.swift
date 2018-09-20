//
//  AccessPresenterTest.swift
//  KataLogInLogOutTests
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import XCTest
import Nimble
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
        sut = AccessPresenter(kata: mockKata)
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
        givenLoginResult(result: LoginResult.success)
        sut.logIn(username: USERNAME, password: PASSWORD)
        XCTAssertTrue(mockView.hidedLogInForm)
        XCTAssertTrue(mockView.showedLogOutForm)
        XCTAssertNil(mockView.showedLoginForm)
        XCTAssertNil(mockView.hidedLogOutForm)
        XCTAssertNil(mockView.showedError)
    }
    
    func test_given_invalid_login_when_login_then_not_logged() {
        givenLoginResult(result: LoginResult.invalid)
        sut.logIn(username: USERNAME, password: PASSWORD)
        assertNotTouchedViewForm() //maybe over specificated
        XCTAssertEqual(mockView.showedError, "invalid login")
    }
    
    func test_given_invalid_chars_login_when_login_then_not_logged() {
        givenLoginResult(result: LoginResult.invalidChars)
        sut.logIn(username: USERNAME, password: PASSWORD)
        assertNotTouchedViewForm() //maybe over specificated
        XCTAssertEqual(mockView.showedError, "invalid chars in login")
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
    
    func givenLoginResult(result:LoginResult)  {
        mockKata.loginResult = result
    }
    
    func givenLogoutResult(result:Bool) {
        mockKata.logoutResult = result
    }
    
    func assertNotTouchedViewForm() {
        XCTAssertNil(mockView.hidedLogInForm)
        XCTAssertNil(mockView.showedLogOutForm)
        XCTAssertNil(mockView.showedLoginForm)
        XCTAssertNil(mockView.hidedLogOutForm)
    }
    
    
    //async: Future? tipo de double:
    //Fake: respeta el comportamiento original, pero cambia el detalle de impl. pej: una db que se fakea con una 'db' en mem
        // en prod -> codigo async
        // en tests -> codigo sync del hilo del test
        // usan execution handlers como en su lib: Rosie
            //el prod va async
            //en test va sync
        //puedo usar queues
    //swift:
        //lib: Future, Bright
        //success, failure..
        //tool de testing: nimble
            //expect(future.result).toEventually(eq: xXXX)
    //solución:
        //https://github.com/Karumi/KataLogInLogOutSwift
    //Bright lib
    //Usan either
    //estrategias:
        //1.
        //2.
    //Nimble mañana + testing integración
}

private class MockAccessUseCase: AccessUseCase {
    
    var loginResult:LoginResult!
    var logoutResult:Bool!
    
    init() {
        super.init(clock: Clock())
    }
    
    override func logIn(username: String, password: String) -> LoginResult {
        return loginResult
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
