//
//  UserInfoResponseModel.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/27/24.
//

import Foundation

// MARK: - UserInfoResponseModel

struct UserInfoResponseModel: Codable {
    let code: Int
    let message: String
    let data: DataClass
}

// MARK: - DataClass

struct DataClass: Codable {
    let authenticationId, nickname, phone: String
}
