//
//  UserTargetType.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/27/24.
//

import Foundation

import Moya

enum UserTargetType {
    case signUp(request: SignUpRequestModel)
    case getUserInfo(memberId: String)
    case login(request: LoginRequestModel)
}

/// 2. 요청서 작성 - 요청에 대한 디테일한 부분을 정의한다.
extension UserTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/member/join"
        case .getUserInfo(memberId: let memberId):
            return "/member/info"
        case .login:
            return "/member/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp, .login:
            return .post
        case .getUserInfo:
            return .get
        }
    }
    
    // 어떤 방식으로 통신할 것인지
    var task: Moya.Task {
        switch self {
        case .signUp(let request):
            // 우리는 Encodable한 body를 요청시 보내줄 것이기 때문에
            // .requestJSONEncodable에 SignUpRequsetModel 타입의 객체를 인자로 넣어줍니다
            return .requestJSONEncodable(request)
        case .getUserInfo:
            // 인코딩할 body가 없기 때문에 그냥 plain으로
            return .requestPlain
        case .login(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUp, .login:
            return ["Content-Type": "application/json"]
        case .getUserInfo(let memberId):
            return ["Content-Type": "application/json",
                    "memberId" : memberId]
        }
        
    }
}

