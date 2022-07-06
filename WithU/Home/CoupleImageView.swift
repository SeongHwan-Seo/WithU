//
//  CoupleImageView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct CoupleImageView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var isShowingChangeUserPopup: Bool
    @Binding var isShowingChangePartnerPopup: Bool
    
    var body: some View {
        HStack {
            UserView(user: viewModel.user, viewModel: viewModel)
                .onTapGesture{
                    print(viewModel.user.nickName)
                    isShowingChangeUserPopup.toggle()
                }
            
            
            LottieHeartView(filename: "heart")
                .frame(width: 100, height: 100)
                .offset(y: -30)
            
            PartnerView(user: viewModel.user, viewModel: viewModel)
                .onTapGesture{
                    isShowingChangePartnerPopup.toggle()
                }
            
        }
        .padding(.top, 10)
    }
}

struct UserView: View {
    let user: User
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        VStack {
            let image = viewModel.selectedImage == nil ? Image(systemName: "greaterthan") : Image(uiImage: viewModel.selectedImage ?? UIImage())
                image
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2)
                )
                .shadow(radius: 7)
                .foregroundColor(.ForegroundColor)
            
            Text(user.nickName)
                .foregroundColor(.ForegroundColor)
            
        }
    }
}

struct PartnerView: View {
    let user: User
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        VStack {
            let image = viewModel.uselectedImage == nil ? Image(systemName: "lessthan") : Image(uiImage: viewModel.uselectedImage ?? UIImage())
                image
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2)
                )
                .shadow(radius: 7)
                .foregroundColor(.ForegroundColor)
            
            Text(user.unickName)
                .foregroundColor(.ForegroundColor)
        }
    }
}

