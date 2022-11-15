//
//  Interactors.swift
//  Alamofire+Combine
//
//  Created by 권성우 on 2022/11/15.
//

import Foundation

class Interactors: ObservableObject {
    @Published var todoInteractor: TodoInteractorInterface
    
    init(todoInteractor: TodoInteractorInterface) {
        self.todoInteractor = todoInteractor
    }
}
