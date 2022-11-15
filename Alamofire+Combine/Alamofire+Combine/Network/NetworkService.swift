//
//  NetworkService.swift
//  RxSwift + Alamofire
//
//  Created by 권성우 on 2022/11/11.
//

import Foundation
import Alamofire
import Combine

protocol NetworkServiceInterface: AnyObject {
    func request<T>(
        _ request: RequestBuilder,
        _ decoder: JSONDecoder
    ) -> AnyPublisher<APIResult<T>, APIError> where T : Decodable
}

final class NetworkService: NetworkServiceInterface {
    func request<T>(
        _ request: RequestBuilder,
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<APIResult<T>, APIError> where T : Decodable {
        let authenticator = TokenAuthenticator()
        let credential = TokenCredential(
            accessToken: "set access token here",
            refreshToken: "set refresh token here"
        )
        
        let interceptor = AuthenticationInterceptor(
            authenticator: authenticator,
            credential: credential
        )
        
        return SessionManager.shared
            .session
            .request(
                request.url,
                method: request.method,
                parameters: request.parameters,
                encoding: request.parameterEncoding,
                headers: request.headers,
                interceptor: interceptor
            )
            .validate()
            .publishData()
            .tryMap { result -> APIResult<T> in
                if let data = result.data {
                // 응답이 성공이고 result가 있을 때
                    let value = try decoder.decode(T.self, from: data)
                    return APIResult(code: .SUCCESS, value: value)
                } else {
                // 응답이 성공이고 result가 없을 때 Empty를 리턴
                    return APIResult(code: .SUCCESS, value: nil)
                }
            }
            .mapError({ (error) -> APIError in
                if let afError = error as? AFError {
                    return .HTTP(afError)
                } else {
                    return .UNKNOWN
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


