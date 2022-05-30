//
//  EmptyImageView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct EmptyImageView: View {
    var body: some View {
        VStack(alignment: .center,spacing: 10) {
            HStack {
                Spacer()
            }
            //Spacer()
            Image(systemName: "photo.artframe")
                .resizable()
                .frame(width: 200, height: 150)
                .foregroundColor(.gray)
            Text("배경 이미지가 없어요!")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.black)
            Text("탭하여 아름다운 배경을 추가해 보세요.")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
            //Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 400)
        .background(.gray)
        .opacity(0.3)
        .aspectRatio(contentMode: .fit)
        .onTapGesture {
            print("Tapped emptyImageView")
        }
        
    }
}

struct EmptyImageView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyImageView()
    }
}
