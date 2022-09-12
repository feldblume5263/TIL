//
//  ViewModel.swift
//  Combine_PasswordApp
//
//  Created by Noah Park on 2022/09/12.
//

import Foundation
import Combine

class ViewModel {
    @Published var passwordInput: String = ""
    @Published var passwordConfirmInput: String = ""
    
    lazy var isMatchPasswordInput: AnyPublisher<Bool, Never> = Publishers
        .CombineLatest($passwordInput, $passwordConfirmInput)
        .map{ (password: String, passwordConfirm: String) in
            if password == "" || passwordConfirm == "" {
                return false
            }
            if password == passwordConfirm {
                return true
            } else {
                return false
            }
        }
        .eraseToAnyPublisher()
}
