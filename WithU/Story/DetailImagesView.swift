//
//  DetailImagesView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/04.
//

import SwiftUI
import Kingfisher

struct DetailImagesView: View {
    @StateObject var viewModel: StoryViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            TabView(selection: $viewModel.detailSelectedImage) {
                ForEach(viewModel.detailSelectedImages, id: \.self) { imageURL in
                    KFImage(imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .overlay(
                Button(action: {
                    withAnimation(.default) {
                        viewModel.detailShowViewer.toggle()
                    }
                    
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.35))
                        .clipShape(Circle())
                })
                .padding()
                ,alignment: .topLeading
            )
        }
    }
}

struct DetailImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImagesView(viewModel: StoryViewModel())
    }
}
