//
//  ChangePartnerProfileView.swift
//  WithU
//
//  Created by seosh on 6/7/22.
//

import SwiftUI

struct ChangePartnerProfileView: View {
    @Binding var user: User
    @Binding var isShowingChangePartnerPopup: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            Text("애칭")
                .foregroundColor(.black)
            TextField("", text: $user.unickName )
                .frame(width: 200)
                .foregroundColor(.black)
            Divider()
                .frame(width: 200, height: 1)
                .background(Color.gray)
            Button(action: {
                setUserInfo(user: user)
                isShowingChangePartnerPopup.toggle()
            }, label: {
                Text("확인")
                    
                    .fontWeight(.bold)
                    .foregroundColor(.buttonForeground)
            })
            
            .frame(width: 200, height: 30)
            .background(Color.buttonBackground)
            .cornerRadius(12)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}


