//
//  WelcomeViewController_Closure.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/6/24.
//

import Foundation
import UIKit

/// Closure을 이용한 데이터 전달
class WelcomeViewController_Closure: UIViewController {
    var id: String? // 이전 화면에서 입력한 아이디가 이 변수에 들어가게 됨
    
    /// 별칭 정하기 -> 오른쪽의 내용을 왼쪽 단어로 간단하게 사용 가능
    typealias Handler = ((String) -> (Void))
    var completionHandler: Handler?
    
    private let rabbitImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "rabbit"))
        image.frame = CGRect(x: 112, y: 87, width: 150, height: 150)
        return image
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 35, y: 295, width: 300, height: 70))
        label.text = "???님\n반가워요!"
        label.textColor = .black
        label.textAlignment = .center // 위에서 정한 CGRect 네모 안에서 텍스트가 정중앙 정렬된다는 뜻
        label.numberOfLines = 2 // 2줄 제한
        label.lineBreakMode = .byTruncatingMiddle // 뷰의 크기 제한으로 인해 텍스트가 잘릴 때 ... 처리가 되는데 가운데 부분이 그렇게 된다는 뜻
        label.font = UIFont.init(name: "Pretendard-Black", size: 25)
        return label
    }()
    
    private lazy var goToMainButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 426, width: 335, height: 58))
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("메인으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6 // 코너 부분 둥글게~
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(goToMainButtonDidTap), for: .touchUpInside) // 심심하니 클릭 시 실행될 액션 추가
        return button
    }()
    
    private lazy var retryLoginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 498, width: 335, height: 58))
        button.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        button.setTitle("다시 로그인", for: .normal)
        button.setTitleColor(UIColor(red: 172/255, green: 176/255, blue: 185/255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        [
            rabbitImageView,
            welcomeLabel,
            goToMainButton,
            retryLoginButton
        ].forEach {
            view.addSubview($0)
        }
        
        bindID()
    }
    
    /// id 변수값을 welcomeLabel의 텍스트로 추가해줌
    func bindID() {
        guard let id = id else { return } // id 값이 nil이면 else에 걸려서 이곳에서 함수 종료됨
        // id 값이 nil이 아닐 때에만 아래 코드가 실행됨
        self.welcomeLabel.text = "\(id)님,\n반가워요!"
    }
    
    /// id 값을 함수를 통해 전달 받음
    func setLabelText(id: String?) {
        self.id = id
    }
    
    /// 메인으로 버튼 클릭 시 실행되는 액션 함수
    /// print문 찍힘
    @objc
    private func goToMainButtonDidTap() {
        print("메인으로 가고 싶으면 아요를 더 열심히 하도록")
    }
    
    /// 다시 로그인 버튼 클릭 시 실행되는 액션 함수
    /// 이전 화면으로 이동됨
    @objc
    private func backToLoginButtonDidTap() {
        guard let id else { return }
        /// 클로저 호출
        /// input으로 id라는 String 데이터를 담아준다 ( WelcomeVC -> LoginVC 으로 데이터 전달 )
        completionHandler?(id)
        
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
