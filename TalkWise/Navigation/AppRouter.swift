//
//  AppRouter.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 29.07.2025.
//

import SwiftUI

enum AppRoute: Hashable {
    case wordDetailView
    case testsView
    case learnedWordsView
    case freeConversationView

}


class AppRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func goTo(_ route: AppRoute) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func goToRoot() {
        path.removeLast(path.count)
    }
}
