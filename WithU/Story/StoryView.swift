//
//  StoryView.swift
//  WithU
//
//  Created by seosh on 4/20/22.
//

import SwiftUI

struct StoryView: View {
    @StateObject var viewModel = StoryViewModel()
    let userId = UserDefaults.standard.string(forKey: "id")!
    
    var body: some View {
        
        ZStack(alignment: .top) {
            Color.backgroundColor
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            VStack {
                HeaderView(viewModel: viewModel)
                    .padding()
                Divider()
                
                if viewModel.isLoading {
                    GeometryReader { geometry in
                        ProgressView()
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                } else {
                        StoryItemView(viewModel: viewModel, userId: userId)
                }
            }
            if viewModel.detailShowViewer {
                ZStack {
                    DetailImagesView(viewModel: viewModel)
                }.zIndex(1)
                    
            }
            
        }
        .onAppear{
            if !viewModel.isUploading {
                viewModel.loadStories(userId: userId)
            }
        }
        
    }
}

struct HeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel:StoryViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
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
                        .foregroundColor(.ForegroundColor)
                })
            
        }
    }
}


struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
