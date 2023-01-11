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
                    .padding()
                    
                    Divider()
                }
                
                
                
            }
            
            VStack {
                if viewModel.isLoading {
                    GeometryReader { geometry in
                        ProgressView()
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 61)
                    }
                } else {
                    if viewModel.stories.count > 0 {
                        StoryItemView(viewModel: viewModel, userId: userId)
                    }
                }
                
            }
            .offset(y: 61)
            .padding(.bottom, 20)
            
            
        }
        .overlay(
            ZStack {
                if viewModel.detailShowViewer {
                    DetailImagesView(viewModel: viewModel)
                }
            }
        )
        .onAppear{
            if !viewModel.isUploading {
                viewModel.loadStories(userId: userId)
            }
        }
        
    }
}

public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
