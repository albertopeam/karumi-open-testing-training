//
//  AccessPresenter.swift
//  KataLogInLogOut
//
//  Created by Alberto on 20/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import Foundation

protocol AccessView {
    func showLogInForm()
    func hideLogInForm()
    func showLogOutForm()
    func hideLogOutForm()
    func showError(error:String)
}

class AccessPresenter {
    
    private let kataApp:KataApp
    var view:AccessView?
    
    init(kata:KataApp = KataApp(clock: Clock())) {
        self.kataApp = kata
    }
    
    func logIn(username:String, password:String) {
        let loggedIn = kataApp.logIn(username: username, password: password)
        switch loggedIn {
        case .success:
            view?.hideLogInForm()
            view?.showLogOutForm()
        case .invalidChars:
            view?.showError(error: "invalid chars in login")
        case .invalid:
            view?.showError(error: "invalid login")
        }
    }
    
    func logOut() {
        if kataApp.logOut() {
            view?.showLogInForm()
            view?.hideLogOutForm()
        }else{
            view?.showError(error: "failed")
        }
    }
}
