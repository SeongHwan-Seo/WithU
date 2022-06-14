//
//  HomeView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State var isShowingChangeUserPopup = false
    @State var isShowingChangePartnerPopup = false
    
    var body: some View {
        ZStack {
            ZStack {
                Color(.white)
                VStack {
                    EmptyImageView()
                    CoupleImageView(user: $viewModel.user, isShowingChangeUserPopup: $isShowingChangeUserPopup, isShowingChangePartnerPopup: $isShowingChangePartnerPopup)
                    DdayCountView(dDay: $viewModel.dDay)
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
            }
            
            if self.isShowingChangeUserPopup{
                GeometryReader { geometry in
                    ChangeUserProfileView(viewModel: viewModel, user: $viewModel.user, isShowingChangeUserPopup: $isShowingChangeUserPopup,
                                          selectedImage: $viewModel.selectedImage
                    )
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                )
                
            }
            
            if self.isShowingChangePartnerPopup{
                GeometryReader { geometry in
                    ChangePartnerProfileView(user: $viewModel.user, isShowingChangePartnerPopup: $isShowingChangePartnerPopup,selectedImage: $viewModel.selectedImage)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                )
                
            }
            
        }
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
