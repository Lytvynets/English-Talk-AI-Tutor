//
//  CustomTabBar.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 14.08.2025.
//

import SwiftUI

enum SelectedTab {
    case topics
    case words
    case profile
    case settings
}


class CustomTabBarObserver: ObservableObject {
    @Published var selectedTab: SelectedTab = .topics
}


struct CustomTabBar: View {
    
    @EnvironmentObject var customTabBarObserver: CustomTabBarObserver
    
    var body: some View {
        
        HStack(spacing: 30) {
            
            Button {
                customTabBarObserver.selectedTab = .topics
            } label: {
                VStack {
                    Image(customTabBarObserver.selectedTab == .topics ? "Vector-532745" : "Vector53523412")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    
                    Text("Topics")
                        .font(.custom("Montserrat-Light", size: 9))
                        .foregroundStyle(customTabBarObserver.selectedTab == .topics ? Color.white : Color(hex: "#4E566B") ?? .gray)
                }
            }
            .padding(.trailing)
            
            Button {
                customTabBarObserver.selectedTab = .words
            } label: {
                VStack {
                    Image(customTabBarObserver.selectedTab == .words ? "Vector-6457655" : "Vector-24564523")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    
                    Text("Words")
                        .font(.custom("Montserrat-Light", size: 9))
                        .foregroundStyle(customTabBarObserver.selectedTab == .words ? Color.white : Color(hex: "#4E566B") ?? .gray)
                }
            }
            .padding(.vertical)
            .padding(.trailing, 7.5)
            
            Button {
                customTabBarObserver.selectedTab = .profile
            } label: {
                VStack {
                    Image(customTabBarObserver.selectedTab == .profile ? "Vector-73454574" : "Vector-37686575")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    
                    Text("Profile")
                        .font(.custom("Montserrat-Light", size: 9))
                        .foregroundStyle(customTabBarObserver.selectedTab == .profile ? Color.white : Color(hex: "#4E566B") ?? .gray)
                }
            }
            .padding(.leading, 7.5)
            
            Button {
                customTabBarObserver.selectedTab = .settings
            } label: {
                VStack {
                    Image(customTabBarObserver.selectedTab == .settings ? "Vector-842353235" : "Vector-4870898")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    
                    Text("Settings")
                        .font(.custom("Montserrat-Light", size: 9))
                        .foregroundStyle(customTabBarObserver.selectedTab == .settings ? Color.white : Color(hex: "#4E566B") ?? .gray)
                }
            }
            .padding(.leading)
        }
        .frame(width: UIScreen.main.bounds.width / 1.1)
        .background(Color(hex: "#232A3A"))
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    CustomTabBar()
        .environmentObject(CustomTabBarObserver())
}
