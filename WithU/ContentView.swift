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
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    if isShowingMenuView {
                        MenuView(isShowingMenuView: $isShowingMenuView)
                        //.offset(y: 0)
                    }
                    HomeView(viewModel: viewModel, isShowingMenuView: $isShowingMenuView)
                        .cornerRadius(isShowingMenuView ? 20 : 10)
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
            
            if !viewModel.isLoading {
                LaunchScreen()
            }
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}


