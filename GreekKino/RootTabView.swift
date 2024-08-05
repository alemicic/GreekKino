//
//  RootTabView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 3.8.24..
//

import SwiftUI

class RootTabViewModel: ObservableObject {
    @Published var client: Client<DrawEndpoint>
    var drawService: DrawService
    
    init(client: Client<DrawEndpoint> = Client<DrawEndpoint>()) {
        self.client = client
        self.drawService = DrawService(client: client)
    }
}

struct RootTabView: View {
    enum Tab {
        case home, live, results
    }
    
    @StateObject var router: Router
    @StateObject var viewModel: RootTabViewModel
    
    var body: some View {
        TabView() {
            NavigationStack(path: $router.homeNavigationStack) {
                HomeView(viewModel: HomeViewModel(service: viewModel.drawService), router: router)
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
            
            ResultsView(viewModel: ResultsViewModel())
                .tabItem {
                    Label("Results",
                          systemImage: "list.bullet.clipboard.fill")
                }
                .tag(Tab.results)
        }
    }
}
