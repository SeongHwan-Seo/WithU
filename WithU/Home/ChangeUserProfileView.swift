//
//  ChangeNicknameView.swift
//  WithU
//
//  Created by seosh on 6/6/22.
//

import SwiftUI

struct ChangeUserProfileView: View {
    @Binding var nickName: String
    @Binding var isShowingChangeUserPopup: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            Text("애칭")
            TextField("", text: $nickName )
                .frame(width: 200)
            Divider()
                .frame(width: 200, height: 1)
                .background(Color.gray)
            Button(action: {
                isShowingChangeUserPopup.toggle()
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


