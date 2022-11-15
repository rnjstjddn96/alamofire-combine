//
//  TodoInteractors.swift
//  Alamofire+Combine
//
//  Created by 권성우 on 2022/11/15.
//

import Foundation
import Combine
import SwiftUI

protocol TodoInteractorInterface {
    func getTodos(todos: Binding<[TodoListDto]>,
                  error: Binding<APIError?>)
}

class TodoInteractor: TodoInteractorInterface, TodoService {
    var networkService = NetworkService()
    var cancellableBag: Set<AnyCancellable> = []
    
    func getTodos(todos: Binding<[TodoListDto]>,
                  error: Binding<APIError?>) {
        self.todos
            .sink { completion in
                if case .failure(let apiError) = completion {
                    error.wrappedValue = apiError
                }
            } receiveValue: { result in
                if let value = result.value {
                    todos.wrappedValue = value
                }
            }
            .store(in: &cancellableBag)
    }
}
