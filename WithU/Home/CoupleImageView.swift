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
            UserView(user: viewModel.user)
                .onTapGesture{
                    print(viewModel.user.nickName)
                    isShowingChangeUserPopup.toggle()
                }
            
            
            LottieHeartView(filename: "heart")
                .frame(width: 100, height: 100)
                .offset(y: -30)
            
            PartnerView(user: viewModel.user)
                .onTapGesture{
                    isShowingChangePartnerPopup.toggle()
                }
            
        }
        .padding(.top, 10)
    }
}

struct UserView: View {
    let user: User
    var body: some View {
        VStack {
            Image(systemName: "greaterthan")
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2)
                )
                .shadow(radius: 7)
                .foregroundColor(.black)
            
            Text(user.nickName)
                .foregroundColor(.black)
            
        }
    }
}

struct PartnerView: View {
    let user: User
    var body: some View {
        VStack {
            Image(systemName: "lessthan")
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2)
                )
                .shadow(radius: 7)
                .foregroundColor(.black)
            
            Text(user.unickName)
                .foregroundColor(.black)
        }
    }
}

