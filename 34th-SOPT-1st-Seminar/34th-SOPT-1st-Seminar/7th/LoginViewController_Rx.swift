//
//  LoginViewController_Rx.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 5/25/24.
//

import UIKit
import SnapKit

import RxSwift
import RxCocoa
import RxRelay

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, disposeBag: RxSwift.DisposeBag) -> Output
}

final class LoginViewModel_Rx: ViewModelType {

    private var idText: String?
    private var passwordText: String?
    
    struct Input {
        let idTextFieldDidChangeEvent: Observable<String?>
        let passwordTextFieldDidChangeEvent: Observable<String?>
        let loginButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
        var isValid = PublishRelay<Void>()
        var errMessage = PublishRelay<String>()
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.idTextFieldDidChangeEvent.subscribe(onNext: { [weak self] id in
            self?.idText = id
        }).disposed(by: disposeBag)
        
        input.passwordTextFieldDidChangeEvent.subscribe(onNext: { [weak self] password in
            self?.passwordText = password
        }).disposed(by: disposeBag)
        
        input.loginButtonDidTapEvent.subscribe(onNext: { [weak self] _ in
            guard let id = self?.idText else {
                output.errMessage.accept("아이디가 비어있습니다.")
                return
            }
            guard let password = self?.passwordText else {
                output.errMessage.accept("비밀번호가 비어있습니다.")
                return
            }
            
            let idRegEx = "[A-Za-z0-9]{5,13}"
            let pwRegEx = "[A-Za-z0-9!_@$%^&+=]{8,20}"
            
            guard let _ = id.range(of: idRegEx, options: .regularExpression) else {
                output.errMessage.accept("아이디가 유효하지 않습니다.")
                return
            }
            
            guard let _ = password.range(of: pwRegEx, options: .regularExpression) else {
                output.errMessage.accept("비밀번호가 유효하지 않습니다.")
                return
            }
            output.isValid.accept(Void())
        }).disposed(by: disposeBag)
        
        return output
    }
}

final class LoginViewController_Rx: UIViewController {
    
    private let rootView = LoginView()
    private let viewModel: LoginViewModel_Rx
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = rootView
    }
    
    init(viewModel: LoginViewModel_Rx) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = LoginViewModel_Rx.Input(
            idTextFieldDidChangeEvent: rootView.idTextField.rx.text.asObservable(),
            passwordTextFieldDidChangeEvent: rootView.passwordTextField.rx.text.asObservable(),
            loginButtonDidTapEvent: rootView.loginButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.isValid.subscribe(onNext: { _ in
            print(#function)
            self.pushToWelcomeVC()
        }).disposed(by: disposeBag)
        
        output.errMessage.subscribe(onNext: { errMessage in
            self.showToast(errMessage)
        }).disposed(by: disposeBag)
    }
    
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    func showToast(_ message: String,
                   bottomInset: CGFloat = 86
    ) {
        guard let view else { return }
//        Toast().show(
//            message: message,
//            view: view,
//            bottomInset: bottomInset
//        )
    }
}
