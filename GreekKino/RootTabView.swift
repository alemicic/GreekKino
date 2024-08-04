//
//  RootTabView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 3.8.24..
//

import SwiftUI

struct RootTabView: View {
    enum Tab {
        case home, live, results
    }
    
    enum ScreenNavigation: Hashable {
        case coupon
    }
    
    @State var homeNavigationPath: [ScreenNavigation] = []
    
    var body: some View {
        
        TabView() {
            NavigationStack {
                HomeView(viewModel: HomeViewModel())
            }
            .tabItem {
                Label("Home",
                      systemImage: "house.fill")
            }
            .tag(Tab.home)
            
            ContentView()
                .tabItem {
                    Label("Live",
                          systemImage: "tv.fill")
                }
                .tag(Tab.live)
            
            ContentView()
                .tabItem {
                    Label("Results",
                          systemImage: "list.bullet.clipboard.fill")
                }
                .tag(Tab.results)
        }
    }
}
#Preview {
    RootTabView()
}
