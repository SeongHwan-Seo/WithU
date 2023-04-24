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
    @GestureState var draggingOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(viewModel.detailBgOpacity)
                .ignoresSafeArea()
            
            ScrollView(.init()) {
                TabView(selection: $viewModel.detailSelectedImage) {
                    ForEach(viewModel.detailSelectedImages.map{ $0.absoluteString }, id: \.self) { imageURL in
                        
                        KFImage(URL(string: imageURL))
                            .placeholder({
                                ProgressView()
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .offset(y: draggingOffset.height)
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            }
            .ignoresSafeArea()
            
            

            
        }
        .gesture(DragGesture().updating($draggingOffset, body: { (value, outValue, _) in
            outValue = value.translation
            viewModel.onChange(value: draggingOffset)
            
        }).onEnded(viewModel.onEnd(value:)))
    }
}

struct DetailImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImagesView(viewModel: StoryViewModel())
    }
}
