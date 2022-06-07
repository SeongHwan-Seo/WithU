//
//  CoupleImageView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct CoupleImageView: View {
    @Binding var user: User
    @Binding var partner: Partner
    @Binding var isShowingChangeUserPopup: Bool
    @Binding var isShowingChangePartnerPopup: Bool
    
    var body: some View {
        HStack {
            UserView(user: user)
                .onTapGesture{
                    isShowingChangeUserPopup.toggle()
                }
            
            
            LottieHeartView(filename: "heart")
                .frame(width: 100, height: 100)
                .offset(y: -30)
            
            PartnerView(partner: partner)
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
            user.image
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 4))
            
            Text(user.nickName)
            
        }
    }
}

struct PartnerView: View {
    let partner: Partner
    var body: some View {
        VStack {
            partner.image
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 4))
            
            Text(partner.nickName)
        }
    }
}

