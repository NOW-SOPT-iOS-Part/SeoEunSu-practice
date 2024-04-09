//
//  LoginViewController_SnapKit.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/6/24.
//

import Foundation
import UIKit
import SnapKit

/// SnapKit을 사용한 Auto Layout 적용
class LoginViewController_SnapKit: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "동네라서 가능한 모든 것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black
        label.textAlignment = .center // 텍스트 중앙 정렬
        label.numberOfLines = 2 // 텍스트 2줄 제한
        label.font = UIFont.init(name: "Pretendard-Bold", size: 18)
        return label
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.font = UIFont.init(name: "Pretendard-Medium", size: 14)
//        textField.layer.cornerRadius = 3
        textField.borderStyle = .roundedRect // 위의 cornerRadius 설정 안 해도 코너를 적당히 둥글게 설정해줌
        textField.keyboardType = .emailAddress // email을 적을 때 필요한 문자가 있는 키보드로 띄워줌
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.font = UIFont.init(name: "Pretendard-Medium", size: 14)
//        textField.layer.cornerRadius = 3
        textField.borderStyle = .roundedRect // cornerRadius 안 해도 코너를 적당히 둥글게 설정해줌
        textField.isSecureTextEntry = true // 비밀번호이기 때문에 가려주었다
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 21, y: 422 + 80, width: 332, height: 58))
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Bold", size: 18) // 버튼의 폰트를 설정할 때에는 titleLabel을 참조하기~
        button.layer.cornerRadius = 6 // 모서리 둥글게
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        [
            titleLabel,
            idTextField,
            passwordTextField,
            loginButton
        ].forEach {
            view.addSubview($0) // root view에 우리가 정의한 subview 들을 추가해주겠다.
        }
        setLayout()
    }
    
    /// 2주차
    /// Auto Layout 적용하기 - using SnapKit
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(161)
            $0.centerX.equalToSuperview()
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(71)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(58)
        }
    }
    
    /// 네비게이션의 push 방식을 통해 다음 화면으로 이동
    private func pushToWelcomeVC() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.id = idTextField.text
        self.navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    /// 모달의 present 방식을 통해 다음 화면으로 이동
    private func presentWelcomeVC() {
        let welcomeVC = WelcomeViewController_SnapKit()
        welcomeVC.modalPresentationStyle = .formSheet
        welcomeVC.id = idTextField.text
        self.present(welcomeVC, animated: true)
    }
    
    /// 아이디와 비번 텍스트 필드 내용을 삭제해 준다
    private func removeTextInTextField() {
        idTextField.text = ""
        passwordTextField.text = ""
    }
    
    /// 로그인 버튼 클릭 시 실행되는 액션 함수
    /// 다음 화면으로 이동됨
    /// 아이디랑 비번 텍스트 필드에 적은 내용 지워줌
    @objc
    private func loginButtonDidTap() {
        presentWelcomeVC()
//        pushToWelcomeVC()
        removeTextInTextField()
    }
}
