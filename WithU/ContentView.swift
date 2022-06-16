//
//  ContentView.swift
//  WithU
//
//  Created by seosh on 4/13/22.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var viewModel = HomeViewModel()
    @State private var isShowing = false
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    if isShowing {
                        MenuView(isShowing: $isShowing)
                        //.offset(y: 0)
                    }
                    HomeView()
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
                    isShowing = false
                    
                }
                
                
            }
            
            if isLoading {
                LaunchScreen()
            }
            
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                isLoading.toggle()
            })
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}


