//
//  TodoService.swift
//  Alamofire+Combine
//
//  Created by 권성우 on 2022/11/15.
//

import Foundation
import Alamofire
import Combine

protocol TodoService: ServiceProvider {
    
}

extension TodoService {
    var todos: AnyPublisher<APIResult<[TodoListDto]>, APIError> {
        return networkService.request(APIs.TODOS)
            .eraseToAnyPublisher()
    }
}
