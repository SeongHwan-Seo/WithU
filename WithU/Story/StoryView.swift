//
//  StoryView.swift
//  WithU
//
//  Created by seosh on 4/20/22.
//

import SwiftUI

struct StoryView: View {
    @StateObject var viewModel = StoryViewModel()
    @Environment(\.presentationMode) var presentationMode
    let userId = UserDefaults.standard.string(forKey: "id")!
    
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                Color.backgroundColor
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .imageScale(.large)
                                .foregroundColor(.ForegroundColor)
                        })
                        
                        Spacer()
                        
                        Text("스토리")
                            .font(.headline)
                            .foregroundColor(.ForegroundColor)
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: {
                                CreateStoryView(viewModel: viewModel)
                            },
                            label: {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                                    .foregroundColor(.ForegroundColor)
                            })
                        
                    }
                    .padding()
                    Divider()
                }
           
                
            }
            
            VStack {
                StoryItemView()
            }
            .offset(y: 61)
            .padding(.bottom, 20)
            
        }
        .onAppear{
            viewModel.loadStories(userId: userId)
        }
        
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
