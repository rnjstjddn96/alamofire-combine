//
//  SessionManager.swift
//  RxSwift + Alamofire
//
//  Created by 권성우 on 2022/11/11.
//

import Foundation
import Alamofire

class SessionManager {
    static let shared: SessionManager = SessionManager()
    
    private init() { }
    
    var session: Session {
        let urlSessionConfiguration = URLSessionConfiguration.af.default
        urlSessionConfiguration.timeoutIntervalForRequest = 15
        urlSessionConfiguration.timeoutIntervalForResource = 15
        urlSessionConfiguration.waitsForConnectivity = true
        
        let apiLogger = NetworkLogger()
        
        return Session(
            configuration: urlSessionConfiguration,
            eventMonitors: [apiLogger]
        )
    }
}
