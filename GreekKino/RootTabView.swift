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
    
    @StateObject var router = Router()
    
    var body: some View {
        TabView() {
            NavigationStack(path: $router.homeNavigationStack) {
                HomeView(viewModel: HomeViewModel(), router: router)
                    .navigationDestination(for: ScreenNavigation.self) { screen in
                        switch screen {
                            case .draw(drawModel: let drawModel):
                                DrawView(viewModel: DrawViewModel(item: drawModel))
                        }
                    }
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
