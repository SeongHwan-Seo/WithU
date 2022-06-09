//
//  ChangeNicknameView.swift
//  WithU
//
//  Created by seosh on 6/6/22.
//

import SwiftUI
import ExytePopupView

struct ChangeUserProfileView: View {
    @Binding var user: User
    @Binding var isShowingChangeUserPopup: Bool
    @State var isShowingPopupview = false
    
    var body: some View {
        VStack( spacing: 15) {
            ZStack {
                Color.gray
                    .frame(width: 250, height: 250)
                    .opacity(0.2)
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
                    .foregroundColor(.black)
            }
            .onTapGesture {
                isShowingPopupview.toggle()
            }
            VStack {
                TextField("애칭을 입력하세요.", text: $user.nickName )
                    .frame(width: 250)
                    .foregroundColor(.black)
                Divider()
                    .frame(width: 250, height: 1)
                    .background(Color.gray)
                Button(action: {
                    setUserInfo(user: user)
                    isShowingChangeUserPopup.toggle()
                }, label: {
                    Text("확인")
                    
                        .fontWeight(.bold)
                        .foregroundColor(.buttonForeground)
                })
                .frame(width: 250, height: 30)
                .background(Color.buttonBackground)
                .cornerRadius(12)
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .popup(isPresented: $isShowingPopupview, type: .default, position: .bottom, closeOnTap: false, closeOnTapOutside: true) {
            Text("The popup")
                .frame(width: 200, height: 60)
                .background(Color(red: 0.85, green: 0.8, blue: 0.95))
                .cornerRadius(30.0)
        }
        
    }
}


