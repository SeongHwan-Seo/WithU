//
//  DetailImagesView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/04.
//

import SwiftUI

struct DetailImagesView: View {
    @StateObject var viewModel: StoryViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            TabView(selection: $viewModel.detailSelectedIndex, content: {
                ForEach(viewModel.detailSelectedImages, id: \.self) { image in
                    Image(uiImage: image)
                    
                }
            })
        }
    }
}

struct DetailImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImagesView(viewModel: StoryViewModel())
    }
}
