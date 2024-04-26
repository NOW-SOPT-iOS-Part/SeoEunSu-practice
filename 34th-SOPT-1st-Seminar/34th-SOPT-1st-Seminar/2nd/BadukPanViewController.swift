//
//  BadukPanViewController.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/6/24.
//

import Foundation
import UIKit

/// 바둑판 Constraints 실습
class BadukPanViewController: UIViewController {
    private let 바둑알1: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: .init(width: 20, height: 20)))
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let 바둑알2: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: .init(width: 20, height: 20)))
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let 장애물: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        setLayout()
    }
    
    private func setLayout() {
        [
            바둑알1,
            바둑알2,
            장애물
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([바둑알1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
                                     바둑알1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
                                     바둑알1.widthAnchor.constraint(equalToConstant: 20),
                                     바둑알1.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([바둑알2.topAnchor.constraint(equalTo: self.바둑알1.bottomAnchor, constant: 40),
                                     바둑알2.leadingAnchor.constraint(equalTo: self.바둑알1.trailingAnchor, constant: 40),
                                     바둑알2.widthAnchor.constraint(equalToConstant: 20),
                                     바둑알2.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([장애물.leadingAnchor.constraint(equalTo: 바둑알2.trailingAnchor, constant: 20),
                                     장애물.topAnchor.constraint(equalTo: 바둑알2.bottomAnchor, constant: 20),
                                     장애물.widthAnchor.constraint(equalToConstant: 60),
                                     장애물.heightAnchor.constraint(equalToConstant: 20)])
    }
}
