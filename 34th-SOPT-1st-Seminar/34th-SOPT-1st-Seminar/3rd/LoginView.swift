//
//  LoginView.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/20/24.
//

import UIKit
import Then

final class LoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("LoginView Error!")
    }
    
    // MARK: - Subviews
    
    private let titleLabel = UILabel().then {
        $0.text = "동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요."
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont.init(name: "Pretendard-Bold", size: 18)
    }
    
    private let idTextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        $0.font = UIFont.init(name: "Pretendard-Medium", size: 14)
        $0.borderStyle = .roundedRect // 위의 cornerRadius 설정 안 해도 코너를 적당히 둥글게 설정해줌
        $0.keyboardType = .emailAddress // email을 적을 때 필요한 문자가 있는 키보드로 띄워줌
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        $0.font = UIFont.init(name: "Pretendard-Medium", size: 14)
        $0.borderStyle = .roundedRect // cornerRadius 안 해도 코너를 적당히 둥글게 설정해줌
        $0.isSecureTextEntry = true // 비밀번호이기 때문에 가려주었다
    }
    
    private lazy var loginButton = UIButton().then {
        $0.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        $0.setTitle("로그인하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.init(name: "Pretendard-Bold", size: 18) // 버튼의 폰트를 설정할 때에는 titleLabel을 참조하기~
        $0.layer.cornerRadius = 6 // 모서리 둥글게
    }
    
    // MARK: - Functions
    
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
}
