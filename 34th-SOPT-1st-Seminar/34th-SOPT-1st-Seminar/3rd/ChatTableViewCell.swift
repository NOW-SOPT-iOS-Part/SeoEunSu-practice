//
//  ChatTableViewCell.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/20/24.
//

import UIKit
import Then

class ChatTableViewCell: UITableViewCell {
    
    static let identifier = "ChatTableViewCell"
    
    let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profileDummy")
        $0.layer.cornerRadius = 20
    }
    
    let nicknameLabel = UILabel().then {
        $0.text = "요이키"
        $0.font = .pretendard(weight: 700, size: 15)
    }
    
    let locationLabel = UILabel().then {
        $0.text = "문정동"
        $0.font = .pretendard(weight: 400, size: 12)
        $0.textColor = .gray
        
    }
    let lastChatLabel = UILabel().then {
        $0.text = "확인함 ㄱㅅ"
        $0.font = .pretendard(weight: 400, size: 14)
    }
    
    let contentImageView = UIImageView().then {
        $0.image = UIImage(named: "contentDummy")
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [
            profileImageView,
            nicknameLabel, locationLabel,
            lastChatLabel,
            contentImageView
        ].forEach {
            contentView.addSubview($0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(nicknameLabel)
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(4)
        }
        lastChatLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.bottom.equalTo(profileImageView)
        }
        contentImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
    }
}

extension ChatTableViewCell {
    
    func dataBind(_ chatData: ChatModel) {
        profileImageView.image = chatData.profileImg
        nicknameLabel.text = chatData.name
        locationLabel.text = chatData.place
        lastChatLabel.text = chatData.message
        contentImageView.image = chatData.itemImg
    }
}
