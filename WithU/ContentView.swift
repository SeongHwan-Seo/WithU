//
//  ContentView.swift
//  WithU
//
//  Created by seosh on 4/13/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var isShowingMenuView = false
    @State private var isShowingNetworkPopupView = false
    
    var body: some View {
        
        ZStack {
            if !viewModel.isLoading {
                LaunchScreen()
            } else {
                NavigationView {
                    ZStack {
                        if isShowingMenuView {
                            MenuView(isShowingMenuView: $isShowingMenuView)
                        }
                        HomeView(viewModel: viewModel, isShowingMenuView: $isShowingMenuView)
                            .cornerRadius(isShowingMenuView ? 20 : 0)
                            .offset(x: isShowingMenuView ? 200 : 0, y: isShowingMenuView ? 30 : 0)
                            .scaleEffect(isShowingMenuView ? 0.8 : 1)
                            .navigationBarItems(leading: Button(
                                action: {
                                    withAnimation(.spring()) {
                                        isShowingMenuView.toggle()
                                    }
                                },
                                label: {
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(.black)
                                }))
                            .edgesIgnoringSafeArea(.all)
                    }
                    
                }
            }
            if !viewModel.isConnected {
                ZStack {
                    GeometryReader { geometry in
                        NetworkPopupView(viewModel: viewModel)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    .background(
                        Color.black.opacity(0.65)
                            .edgesIgnoringSafeArea(.all)
                    )
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}


