//
//  ScrollExViewController.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/6/24.
//

import Foundation
import UIKit
import SnapKit

/// 스크롤뷰 실습
class ScrollExViewController: UIViewController {
    var id: String? // 이전 화면에서 입력한 아이디가 이 변수에 들어가게 됨
    var recViewHeight = 337 // 네모네모 뷰들의 세로 길이
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    private let orangeView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    private let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    private let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            redView,
            orangeView,
            yellowView,
            greenView,
            blueView,
            purpleView
        ].forEach {
            contentView.addSubview($0)
        }
        setLayout()
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(recViewHeight * 3)
        }
        redView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.equalTo(self.view.snp.centerX)
            $0.height.equalTo(recViewHeight)
        }
        orangeView.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.centerX)
            $0.top.trailing.equalToSuperview()
            $0.height.equalTo(recViewHeight)
        }
        yellowView.snp.makeConstraints {
            $0.top.equalTo(redView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(redView)
            $0.height.equalTo(recViewHeight)
        }
        greenView.snp.makeConstraints {
            $0.top.equalTo(orangeView.snp.bottom)
            $0.leading.equalTo(orangeView)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(recViewHeight)
        }
        blueView.snp.makeConstraints {
            $0.top.equalTo(yellowView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(yellowView)
            $0.height.equalTo(recViewHeight)
        }
        purpleView.snp.makeConstraints {
            $0.top.equalTo(greenView.snp.bottom)
            $0.leading.equalTo(greenView)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(recViewHeight)
        }
    }
}
