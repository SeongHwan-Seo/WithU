//
//  DdayCountView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct DdayCountView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var isShowingChangeMessagePopup: Bool
    @Binding var isShowingMenuView: Bool
    
    var body: some View {
        VStack {
            Text(viewModel.user.message)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.ForegroundColor)
            Text("\(viewModel.days(from: viewModel.user.date ?? Date()))일")
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundColor(.ForegroundColor)
        }
        .padding(.top, 30)
        .onTapGesture {
            if !isShowingMenuView {
                isShowingChangeMessagePopup.toggle()
            }
            
        }
    }
}


