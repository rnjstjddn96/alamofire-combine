//
//  ServiceProvider.swift
//  Alamofire+Combine
//
//  Created by 권성우 on 2022/11/15.
//

import Foundation

protocol ServiceProvider {
    var networkService: NetworkService { get }
}
