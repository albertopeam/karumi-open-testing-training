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
    
    private let accessUseCase:AccessUseCase
    var view:AccessView?
    
    init(accessUseCase:AccessUseCase = AccessUseCase(clock: Clock())) {
        self.accessUseCase = accessUseCase
    }
    
    func login(username:String, password:String) {
        accessUseCase.login(username: username, password: password)
            .onSuccess { _ in
                self.view?.hideLogInForm()
                self.view?.showLogOutForm()
            }.onFailure { error in
                switch error {
                case .invalidChars:
                    self.view?.showError(error: "invalid chars in login")
                case .invalid:
                    self.view?.showError(error: "invalid login")
                }
            }
    }
    
    func logOut() {
        if accessUseCase.logOut() {
            view?.showLogInForm()
            view?.hideLogOutForm()
        }else{
            view?.showError(error: "failed")
        }
    }
}
