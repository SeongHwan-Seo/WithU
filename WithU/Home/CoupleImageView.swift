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
    @Binding var isShowingMenuView: Bool
    
    var body: some View {
        HStack {
            UserView(user: viewModel.user, viewModel: viewModel)
                .onTapGesture{
                    
                    if !isShowingMenuView {
                        isShowingChangeUserPopup.toggle()
                    }
                    
                }
            
            
            LottieHeartView(filename: "heart")
                .frame(width: 100, height: 100)
                .offset(y: -30)
            
            PartnerView(user: viewModel.user, viewModel: viewModel)
                .onTapGesture{
                    
                    if !isShowingMenuView {
                        isShowingChangePartnerPopup.toggle()
                    }
                    
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
            if viewModel.selectedImage == nil {
                Image(uiImage: UIImage(named: "face_icon")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
            } else {
                Image(uiImage: viewModel.selectedImage ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 7)
                    .foregroundColor(.ForegroundColor)
            }
             
            
            Text(user.nickName)
                .foregroundColor(.ForegroundColor)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
            
        }
    }
}

struct PartnerView: View {
    let user: User
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        VStack {
            if viewModel.uselectedImage == nil {
                Image(uiImage: UIImage(named: "face_icon")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
            }
            else {
                Image(uiImage: viewModel.uselectedImage ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 7)
                    .foregroundColor(.ForegroundColor)
            }
          
            
            Text(user.unickName)
                .foregroundColor(.ForegroundColor)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
        }
    }
}

