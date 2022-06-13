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
    @State var isShowingPopupview = false
    @Binding var selectedImage: UIImage?
    @Binding var imagePickerPresented: Bool
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
                    TextField("애칭을 입력하세요.", text: $user.unickName )
                        .frame(width: 250)
                        .foregroundColor(.black)
                    Divider()
                        .frame(width: 250, height: 1)
                        .background(Color.gray)
                    Button(action: {
                        setUserInfo(user: user)
                        isShowingChangePartnerPopup.toggle()
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
            
            CustomActionSheetView(isShowingPopupview: $isShowingPopupview, selectedImage: $selectedImage).offset(y: self.isShowingPopupview ? 0 : UIScreen.main.bounds.height)
        }.background(self.isShowingPopupview ? Color.black.opacity(0.3) : Color.clear)
            .edgesIgnoringSafeArea(.bottom)
        
        
        
        
    }
}


