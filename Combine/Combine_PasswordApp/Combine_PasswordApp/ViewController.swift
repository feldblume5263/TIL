//
//  ViewController.swift
//  Combine_PasswordApp
//
//  Created by Noah Park on 2022/09/12.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var passwordConfirmTextField: UITextField!
    @IBOutlet weak private var submitButton: UIButton!
    private var viewModel: ViewModel!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        
        passwordTextField
            .passwordTextPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.passwordInput, on: viewModel)
            .store(in: &subscriptions)
        
        passwordConfirmTextField
            .passwordTextPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.passwordConfirmInput, on: viewModel)
            .store(in: &subscriptions)
        
        viewModel.isMatchPasswordInput
            .print()
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: submitButton)
            .store(in: &subscriptions)
    }
}

extension UITextField {
    var passwordTextPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap{ $0.object as? UITextField }
            .map{ $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    var isValid: Bool {
        get {
            backgroundColor == .yellow
        }
        set {
            backgroundColor = newValue ? .yellow : .lightGray
            isEnabled = newValue
            setTitleColor(newValue ? .blue : .white, for: .normal)
        }
    }
}

