//
//  Alamofire_CombineApp.swift
//  Alamofire+Combine
//
//  Created by 권성우 on 2022/11/15.
//

import SwiftUI

@main
struct Alamofire_CombineApp: App {
    let interactors = Interactors(todoInteractor: TodoInteractor())
    let stores = Stores()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(interactors)
                .environmentObject(stores)
                .onAppear {
                    configBuildEnvironments()
                }
        }
    }
}

extension Alamofire_CombineApp {
    private func configBuildEnvironments() {
        guard let infoDict = Bundle.main.infoDictionary else { return }
        NetworkConfig.HOST_URL = infoDict["ROOT_URL"] as? String
    }
}
