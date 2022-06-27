//
//  ContentView.swift
//  WithU
//
//  Created by seosh on 4/13/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var isShowing = false
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    if isShowing {
                        MenuView(isShowing: $isShowing)
                        //.offset(y: 0)
                    }
                    HomeView(viewModel: viewModel)
                        .cornerRadius(isShowing ? 20 : 10)
                        .offset(x: isShowing ? 200 : 0, y: isShowing ? 30 : 0)
                        .scaleEffect(isShowing ? 0.8 : 1)
                        .navigationBarItems(leading: Button(
                            action: {
                                withAnimation(.spring()) {
                                    isShowing.toggle()
                                }
                            },
                            label: {
                                Image(systemName: "list.bullet")
                                    .foregroundColor(.black)
                            }))
                        .edgesIgnoringSafeArea(.all)
                }
                .onAppear {
                    if UserDefaults.standard.string(forKey: "id") == nil {
                        print("UserDefaults nil")
                        viewModel.setInitUser()
                        //viewModel.loadUser()
                    } else {
                        print("UserDefaults : OK")
                        viewModel.loadUser()
                    }
                    
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


