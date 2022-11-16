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
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    ForEach(self.todos, id: \.self.id) { todo in
                        NavigationLink {
                            TodoDetailView(todo: todo)
                        } label: {
                            LazyVStack(alignment: .leading) {
                                HStack {
                                    Text(todo.title)
                                        .padding(.vertical)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    Text(todo.completed ? "✔️" : " ")
                                }
                                
                                Divider()
                            }
                        }
                    }
                }
                .padding()
                
                if todos.isEmpty {
                    ProgressView()
                }
            }
            .navigationTitle("TODOs")
        }
        .onAppear {
            interactors.todoInteractor
                .getTodos(
                    todos: $todos,
                    error: $error
                )
        }
    }
}

struct TodoDetailView: View {
    var todo: TodoListDto
    
    var body: some View {
        VStack {
            Text(todo.title)
        }
        .padding()
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
