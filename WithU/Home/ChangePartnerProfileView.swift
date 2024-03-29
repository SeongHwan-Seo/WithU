//
//  ChangePartnerProfileView.swift
//  WithU
//
//  Created by seosh on 6/7/22.
//

import SwiftUI

struct ChangePartnerProfileView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var isShowingChangePartnerPopup: Bool
    @State var isShowingPopupview = false
    @State var choice = 2
    @State var name: String
    var body: some View {
        ZStack {
            VStack( spacing: 15) {
                if viewModel.uselectedImage == nil {
                    Image(uiImage: UIImage(named: "face_icon")!.withRenderingMode(.alwaysTemplate))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .foregroundColor(.ForegroundColor)
                    .onTapGesture {
                        isShowingPopupview.toggle()
                    }
                } else {
                    Image(uiImage: viewModel.uselectedImage ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: viewModel.uselectedImage == nil ? .fit : .fill)
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
                }
                
                VStack {
                    TextField("애칭을 입력하세요.", text: $name )
                        .frame(width: 250)
                        .foregroundColor(.ForegroundColor)
                    Divider()
                        .frame(width: 250, height: 1)
                        .background(Color.gray)
                    Button(action: {
                        viewModel.user.unickName = name
                        viewModel.updateUser()
                        withAnimation(.default) {
                            isShowingChangePartnerPopup.toggle()
                        }
                        
                    }, label: {
                        Text("확인")
                        
                            .fontWeight(.bold)
                            .foregroundColor(.buttonForeground)
                            .frame(width: 250, height: 30)
                    })
                    .frame(width: 250, height: 30)
                    .background(Color.buttonBackground)
                    .cornerRadius(12)
                }
                
            }
            .padding()
            .background(Color.popBackgroundColor)
            .cornerRadius(12)
        }
        
        VStack {
            Spacer()
            
            CustomActionSheetView(viewModel: viewModel, isShowingPopupview: $isShowingPopupview, selectedImage: $viewModel.uselectedImage, choice: $choice).offset(y: self.isShowingPopupview ? 0 : UIScreen.main.bounds.height)
        }.background(self.isShowingPopupview ? Color.black.opacity(0.3) : Color.clear)
            .edgesIgnoringSafeArea(.bottom)
        
        
        
        
    }
}


