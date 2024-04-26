//
//  ChatViewController.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/20/24.
//

import UIKit

final class ChatViewController: UIViewController {
    
    private let chatList = ChatModel.dummy()
    private let tableViewRowHeight: CGFloat = 72
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.rowHeight = tableViewRowHeight
    }
    private lazy var nextButton = UIButton().then {
        $0.setTitle("Next", for: .normal)
        $0.backgroundColor = .daangn
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(presentNextVC), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setLayout()
        setDelegate()
        register()
    }
    
    private func setLayout() {
        [
            tableView,
            nextButton
        ].forEach { self.view.addSubview($0) }
         
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Int(tableViewRowHeight) * chatList.count)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(40)
        }
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func register() {
        tableView.register(
            ChatTableViewCell.self,
            forCellReuseIdentifier: ChatTableViewCell.identifier
        )
    }
    
    @objc
    private func presentNextVC() {
        let itemVC = ItemViewController()
        itemVC.modalPresentationStyle = .fullScreen
        itemVC.modalTransitionStyle = .coverVertical
        self.present(itemVC, animated: true)
    }
}

extension ChatViewController: UITableViewDelegate { }
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
        cell.dataBind(chatList[indexPath.row])
        return cell
    }
}
