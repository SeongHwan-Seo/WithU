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
    
    var body: some View {
        ZStack {
            ZStack {
                Color.backgroundColor
                VStack {
                    EmptyImageView()
                    CoupleImageView(viewModel: viewModel, isShowingChangeUserPopup: $isShowingChangeUserPopup, isShowingChangePartnerPopup: $isShowingChangePartnerPopup)
                    DdayCountView(viewModel: viewModel, isShowingChangeMessagePopup: $isShowingChangeMessagePopup)
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
            }
            
            if self.isShowingChangeUserPopup{
                GeometryReader { geometry in
                    ChangeUserProfileView(viewModel: viewModel, isShowingChangeUserPopup: $isShowingChangeUserPopup
                    )
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                )
                
            }
            
            if self.isShowingChangePartnerPopup{
                GeometryReader { geometry in
                    ChangePartnerProfileView(viewModel: viewModel, isShowingChangePartnerPopup: $isShowingChangePartnerPopup)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                )
                
            }
            
            if self.isShowingChangeMessagePopup {
                GeometryReader { geometry in
                    ChangeMessageView(viewModel: viewModel, isShowingChangeMessagePopup: $isShowingChangeMessagePopup)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                )
                
            }
            
        }
        
        
        
    }
}


