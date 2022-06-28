//
//  ChangePartnerProfileView.swift
//  WithU
//
//  Created by seosh on 6/7/22.
//

import SwiftUI

struct ChangePartnerProfileView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @Binding var user: User
    @Binding var isShowingChangePartnerPopup: Bool
    @State var isShowingPopupview = false
    @Binding var selectedImage: UIImage?
    var body: some View {
        ZStack {
            VStack( spacing: 15) {
                Image(systemName: "lessthan")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 7)
                    .foregroundColor(.black)
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
                        viewModel.updateUser()
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


