//
//  LoginViewController.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 3/30/24.
//

import Foundation
import UIKit

// Homework 1)
// 1. UIComponent들의 속성들을 추가해주세요! ✅
//     - 현재는 text, font, textColor.. 등등 정말 간단한 코드만 있을 거예요!
//     - 다양한 속성들이 많으니 찾아보고! 과제에 1~2개 정도만 추가해주세요!
// 2. 세미나에서는 UILabel, UIButton, UITextField만 다뤘어요! 그 외에 다른 것 하나를 추가해보고, 해당 컴포넌트에 대한 속성을 부여해주세요! ✅
// 3. 피그마에 있는 폰트와 이미지 에셋을 추가하고 적용해주세요 ✅
//     - 폰트는 Pretendard 폰트입니다
//     - 폰트 추가하는 법, 에셋 추가하는 법은 직접 찾아본 뒤 적용해주세요!

class LoginViewController: UIViewController {
    private let logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "daangnLogo"))
        image.frame = CGRect(x: 110, y: 87, width: 150, height: 150)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 69, y: 260, width: 236, height: 44))
        label.text = "동네라서 가능한 모든 것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black
        label.textAlignment = .center // 텍스트 중앙 정렬
        label.numberOfLines = 2 // 텍스트 2줄 제한
        label.font = UIFont.init(name: "Pretendard-Bold", size: 18)
        return label
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 276 + 80, width: 335, height: 52))
        textField.placeholder = "아이디"
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.font = UIFont.init(name: "Pretendard-Medium", size: 14)
//        textField.layer.cornerRadius = 3
        textField.borderStyle = .roundedRect // 위의 cornerRadius 설정 안 해도 코너를 적당히 둥글게 설정해줌
        textField.keyboardType = .emailAddress // email을 적을 때 필요한 문자가 있는 키보드로 띄워줌
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 335 + 80, width: 335, height: 52))
        textField.placeholder = "비밀번호"
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.font = UIFont.init(name: "Pretendard-Medium", size: 14)
//        textField.layer.cornerRadius = 3
        textField.borderStyle = .roundedRect // cornerRadius 안 해도 코너를 적당히 둥글게 설정해줌
        textField.isSecureTextEntry = true // 비밀번호이기 때문에 가려주었다
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 21, y: 422 + 80, width: 332, height: 58))
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
            logoImageView,
            titleLabel,
            idTextField,
            passwordTextField,
            loginButton
        ].forEach {
            view.addSubview($0) // root view에 우리가 정의한 subview 들을 추가해주겠다.
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
        let welcomeVC = WelcomeViewController()
        welcomeVC.modalPresentationStyle = .formSheet
        welcomeVC.id = idTextField.text
        self.present(welcomeVC, animated: true)
    }
    
    /// 아이디와 비번 텍스트 필드 내용을 삭제해 준다
    private func removeTextInTextField() {
        idTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func login() {
        guard let idData = idTextField.text else { return }
        guard let pwData = passwordTextField.text else { return }
        
        let req = LoginRequestModel(authenticationId: idData, password: pwData)
        
        UserService.shared.login(request: req) { res in
            switch res {
            case .success(let data):
                guard let data = data as? PlainResponseModel else { return }
                print("응답값! \(data)")
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
    
    /// 로그인 버튼 클릭 시 실행되는 액션 함수
    /// 다음 화면으로 이동됨
    /// 아이디랑 비번 텍스트 필드에 적은 내용 지워줌
    @objc
    private func loginButtonDidTap() {
        login()
//        presentWelcomeVC()
//        pushToWelcomeVC()
//        removeTextInTextField()
    }
}
