//
//  LoginRequestModel.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/27/24.
//

import Foundation

/// 로그인 요청 바디
struct LoginRequestModel: Encodable {
    let authenticationId : String
    let password : String
}
