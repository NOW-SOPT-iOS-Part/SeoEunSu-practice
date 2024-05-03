//
//  UserService.swift
//  34th-SOPT-1st-Seminar
//
//  Created by 서은수 on 4/27/24.
//

import Foundation

import Moya

final class UserService {
    static let shared = UserService()
    private var userProvider = MoyaProvider<UserTargetType>(plugins: [MoyaLoggingPlugin()])
    
    private init() {}
}

extension UserService {
    /// 회원가입 요청 전송 및 응답 확인
    func signUp(request: SignUpRequestModel, completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.signUp(request: request)) { result in
            switch result {
            // 1 - 응답이 잘 왔는지 안 왔는지
            case .success(let response):
                print("🫶 memberID는 \(String(describing: response.response?.allHeaderFields["Location"]))")
                
                let statusCode = response.statusCode
                let data = response.data
                print("헤더값 확인 \(response.response?.allHeaderFields)")
                
                // 2 - 응답 코드 확인 (200인지 400인지 500인지)
                let networkResult = self.judgeStatus(by: statusCode, data, PlainResponseModel.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getUserInfo(memberId: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.getUserInfo(memberId: memberId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, UserInfoResponseModel.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func login(request: LoginRequestModel, completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.login(request: request)) { result in
            switch result {
            case .success(let res):
                let statusCode = res.statusCode
                let data = res.data
                
                let networkRes = self.judgeStatus(by: statusCode, data, PlainResponseModel.self)
                completion(networkRes)
            case .failure:
                print("실패")
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        switch statusCode {
        case 200..<205:
            // 3 - 내가 사용할 수 있는 형식으로 디코딩이 잘 됐는지 아닌지
            return isValidData(data: data, T.self)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData<T: Codable>(data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️ \(self)에서 디코딩 오류가 발생했습니다 ⛔️")
            return .pathErr }
        
        return .success(decodedData as Any)
    }
}
