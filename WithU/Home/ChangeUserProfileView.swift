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
        ZStack {
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
        }
        
        VStack {
            Spacer()
            
            CustomActionSheet(isShowingPopupview: $isShowingPopupview).offset(y: self.isShowingPopupview ? 0 : UIScreen.main.bounds.height)
        }.background(self.isShowingPopupview ? Color.black.opacity(0.3) : Color.clear)
            .edgesIgnoringSafeArea(.bottom)
        
        
        
        
    }
}

//커스텀 액션시트
struct CustomActionSheet: View {
    @Binding var isShowingPopupview: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Button(action: {} ) {
                    Image(systemName: "person.crop.rectangle")
                    Text("앨범에서 선택하기")
                    
                }
                .foregroundColor(Color.black)
                Spacer()
            }
            
            HStack {
                Button(action: {} ) {
                    Image(systemName: "camera")
                    Text("카메라로 찍기")
                    
                }
                .foregroundColor(Color.black)
                Spacer()
            }
            HStack {
                Button(action: {
                    isShowingPopupview.toggle()
                }) {
                    Image(systemName: "clear")
                    Text("취소")
                    
                }
                .foregroundColor(Color.black)
                Spacer()
            }
        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.horizontal)
            .padding(.top, 20)
            .background(Color.white)
            .cornerRadius(20)
        
    }
}


