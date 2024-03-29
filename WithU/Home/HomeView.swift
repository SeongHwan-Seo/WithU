//
//  HomeView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State var isShowingChangeUserPopup = false
    @State var isShowingChangePartnerPopup = false
    @State var isShowingChangeMessagePopup = false
    @State var isShowingPopupview = false
    @State var choice = 3
    @Binding var isShowingMenuView: Bool
    
    var body: some View {
            ZStack {
                ZStack {
                    Color.backgroundColor
                    
                    VStack {
                        BgImageView(viewModel: viewModel)
                            .onTapGesture {
                                if !isShowingMenuView {
                                    isShowingPopupview.toggle()
                                }
                            }
                        CoupleImageView(viewModel: viewModel, isShowingChangeUserPopup: $isShowingChangeUserPopup, isShowingChangePartnerPopup: $isShowingChangePartnerPopup, isShowingMenuView: $isShowingMenuView)
                        DdayCountView(viewModel: viewModel, isShowingChangeMessagePopup: $isShowingChangeMessagePopup, isShowingMenuView: $isShowingMenuView)
                        
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        
                        CustomActionSheetView(viewModel: viewModel, isShowingPopupview: $isShowingPopupview, selectedImage: $viewModel.bgSelectedImage, choice: $choice).offset(y: self.isShowingPopupview ? 0 : UIScreen.main.bounds.height)
                    }
                    .background(self.isShowingPopupview ? Color.black.opacity(0.3)
                                : Color.clear
                                
                    )
                    .edgesIgnoringSafeArea(.bottom)
                    .onTapGesture {
                        isShowingPopupview.toggle()
                    }
                    
                }
                
                if self.isShowingChangeUserPopup{
                    GeometryReader { geometry in
                        ChangeUserProfileView(viewModel: viewModel, isShowingChangeUserPopup: $isShowingChangeUserPopup, name: viewModel.user.nickName
                        )
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }.background(
                        Color.black.opacity(0.65)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation(.default) {
                                    isShowingChangeUserPopup.toggle()
                                }
                                
                            }
                    )
                    .zIndex(1)
                    
                }
                
                if self.isShowingChangePartnerPopup{
                    GeometryReader { geometry in
                        ChangePartnerProfileView(viewModel: viewModel, isShowingChangePartnerPopup: $isShowingChangePartnerPopup, name: viewModel.user.unickName)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }.background(
                        Color.black.opacity(0.65)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation(.default) {
                                    isShowingChangePartnerPopup.toggle()
                                }
                                
                            }
                    )
                    .zIndex(1)
                    
                }
                
                if self.isShowingChangeMessagePopup {
                    GeometryReader { geometry in
                        ChangeMessageView(viewModel: viewModel, isShowingChangeMessagePopup: $isShowingChangeMessagePopup,messageText: viewModel.user.message, selectedDate: viewModel.user.date ?? Date())
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }.background(
                        Color.black.opacity(0.65)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation(.default) {
                                    isShowingChangeMessagePopup.toggle()
                                }
                                
                            }
                    )
                    .zIndex(1)
                    
                }
                
            }
        
    }
    
}


