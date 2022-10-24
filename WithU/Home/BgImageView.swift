//
//  EmptyImageView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct BgImageView: View {
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        if viewModel.bgSelectedImage == nil {
            VStack(alignment: .center,spacing: 10) {
                HStack {
                    Spacer()
                }
                
                Image(systemName: "photo.artframe")
                    .resizable()
                    .frame(width: 200, height: 150)
                    .foregroundColor(.gray)
                Text("배경 이미지가 없어요!")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                Text("탭하여 아름다운 배경을 추가해 보세요.")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                
            }
            .frame(maxWidth: .infinity, maxHeight: 400)
            .background(Color.gray)
            .opacity(0.3)
            .aspectRatio(contentMode: .fit)
            
        } else {
            
            VStack {
                
                Image(uiImage: viewModel.bgSelectedImage ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width , height: 400, alignment: .center)
                    .clipped()
                    
                    
            } //VStack
            
            
        }
    }
}

struct BgImageView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: HomeViewModel = HomeViewModel()
        BgImageView(viewModel: viewModel)
    }
}
