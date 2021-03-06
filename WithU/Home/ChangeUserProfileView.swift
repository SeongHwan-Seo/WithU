//
//  ChangeNicknameView.swift
//  WithU
//
//  Created by seosh on 6/6/22.
//

import SwiftUI

struct ChangeUserProfileView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var isShowingChangeUserPopup: Bool
    @State var isShowingPopupview = false
    @State var choice = 1
    
    
    var body: some View {
        ZStack {
            VStack( spacing: 15) {
//                Image(systemName: "greaterthan")
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
                    .onTapGesture {
                        isShowingPopupview.toggle()
                    }
                VStack {
                    TextField("애칭을 입력하세요.", text: $viewModel.user.nickName)
                        .frame(width: 250)
                        .foregroundColor(.ForegroundColor)
                    Divider()
                        .frame(width: 250, height: 1)
                        .background(Color.gray)
                    Button(action: {
                        viewModel.updateUser()
                        isShowingChangeUserPopup.toggle()
                    }, label: {
                        Text("확인")
                            .fontWeight(.bold)
                            .foregroundColor(.buttonForeground)
                            .frame(width: 250, height: 30)
                    })
                    .frame(width: 250, height: 30)
                    .background(Color.buttonBackground)
                    .cornerRadius(12)
                    //.disabled(viewModel.user.nickName.isEmpty)
                }
                
            }
            .padding()
            .background(Color.popBackgroundColor)
            .cornerRadius(12)
        }
        
        VStack {
            Spacer()
            
            CustomActionSheetView(viewModel: viewModel, isShowingPopupview: $isShowingPopupview, selectedImage: $viewModel.selectedImage, choice: $choice).offset(y: self.isShowingPopupview ? 0 : UIScreen.main.bounds.height)
        }.background(self.isShowingPopupview ? Color.black.opacity(0.3) : Color.clear)
            .edgesIgnoringSafeArea(.bottom)
        
        
        
        
    }
    
}



