//
//  ItemCollectionViewCell.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/20/24.
//

import UIKit
import Then

protocol ItemCollectionViewCellDelegate: AnyObject {
    func heartButtonDidTapEvent(state: Bool, row: Int)
}

class ItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ItemCollectionViewCell"
    weak var delegate: ItemCollectionViewCellDelegate?
    
    var itemRow: Int?
    
    let itemImageView = UIImageView().then {
        $0.image = .contentDummy
        $0.layer.cornerRadius = 4
    }
    
    let itemNameLabel = UILabel().then {
        $0.text = "에어팟 프로"
        $0.font = .pretendard(weight: 400, size: 16)
    }
    
    let itemPriceLabel = UILabel().then {
        $0.text = "300,000원"
        $0.font = .pretendard(weight: 700, size: 15)
        $0.textColor = .daangn
    }
    
    let heartButton = UIButton().then {
        $0.setImage(.itemEmptyHeart, for: .normal)
        $0.setImage(.itemFilledHeart, for: .selected)
        $0.addTarget(self, action: #selector(heartButtonDidTap), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        heartButton.isSelected = false
    }
    
    private func setLayout() {
        [
            itemImageView,
            itemNameLabel,
            itemPriceLabel,
            heartButton
        ].forEach { contentView.addSubview($0) }
        
        itemImageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.height.equalTo(139)
        }
        itemNameLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(2)
            $0.left.equalTo(itemImageView).offset(4)
        }
        itemPriceLabel.snp.makeConstraints {
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(2)
            $0.left.equalTo(itemNameLabel)
        }
        heartButton.snp.makeConstraints {
            $0.bottom.right.equalTo(itemImageView).offset(-8)
            $0.width.height.equalTo(16)
        }
    }
    
    func dataBind(_ itemData: ItemModel, row: Int) {
        self.itemImageView.image = itemData.itemImg
        self.itemNameLabel.text = itemData.name
        self.itemPriceLabel.text = itemData.price
        self.heartButton.isSelected = itemData.isLiked
        self.itemRow = row
    }
    
    @objc
    private func heartButtonDidTap() {
        heartButton.isSelected.toggle()
        if let itemRow {
            self.delegate?.heartButtonDidTapEvent(
                state: self.heartButton.isSelected,
                row: itemRow
            )
        }
    }
}
