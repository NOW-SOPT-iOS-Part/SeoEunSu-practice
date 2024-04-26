//
//  ItemModel.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/26/24.
//

import UIKit

struct ItemModel {
    let itemImg: UIImage
    let name: String
    let price: String
    var isLiked: Bool
}

extension ItemModel {
    static func dummy() -> [ItemModel] {
        return [
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false),
            ItemModel(itemImg: .productDummy, name: "류희재", price: "22,000원", isLiked: false)
        ]
    }
}
