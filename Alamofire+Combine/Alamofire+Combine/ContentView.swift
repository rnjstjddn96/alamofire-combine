//
//  ContentView.swift
//  Alamofire+Combine
//
//  Created by 권성우 on 2022/11/15.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var interactors: Interactors
    @EnvironmentObject var stores: Stores
    @State var todos: [TodoListDto] = []
    @State var error: APIError?
    
    var body: some View {
        VStack {
            ForEach(self.todos, id: \.self.id) { todo in
                LazyVStack {
                    Text(todo.title)
                }
            }
        }
        .padding()
        .onAppear {
            interactors.todoInteractor
                .getTodos(
                    todos: $todos,
                    error: $error
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Interactors(
                todoInteractor: TodoInteractor())
            )
            .environmentObject(Stores())
    }
}
