//
//  LoginViewController_DI.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 5/25/24.
//

import UIKit
import SnapKit

class ObservablePattern<T> { // --- a
    var value: T? { // --- b
        didSet {
            self.listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
       
    private var listener: ((T?) -> Void)? // --- c
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)    // 생략 가능, 여기선 시작되는 순간부터 초기값을 갖고 동작하기 위해 사용
        self.listener = listener
    }
}

protocol LoginViewModelType {
    var isValid: ObservablePattern<Bool> { get }
    var errMessage: ObservablePattern<String> { get }
    
    func checkValid(id: String?, password: String?)
}

final class LoginViewModel_DI: LoginViewModelType {
    var isValid: ObservablePattern<Bool> = .init(false)
    var errMessage: ObservablePattern<String> = .init(nil)
    
    func checkValid(id: String?, password: String?) {
        guard let id else {
            errMessage.value = "아이디가 비어있습니다."
            return
        }
        guard let password else {
            errMessage.value = "비밀번호가 비어있습니다."
            return
        }
        
        let idRegEx = "[A-Za-z0-9]{5,13}"
        let pwRegEx = "[A-Za-z0-9!_@$%^&+=]{8,20}"
        
        guard let _ = id.range(of: idRegEx, options: .regularExpression) else {
            errMessage.value = "아이디가 유효하지 않습니다."
            return
        }
        guard let _ = password.range(of: pwRegEx, options: .regularExpression) else {
            errMessage.value = "비밀번호가 유효하지 않습니다."
            return
        }
        
        isValid.value = true
    }
}

final class LoginViewController_DI: UIViewController {
    
    private let rootView = LoginView()
    
}
