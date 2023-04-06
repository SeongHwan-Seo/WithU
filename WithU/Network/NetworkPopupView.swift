//
//  NetworkPopupView.swift
//  WithU
//
//  Created by SHSEO on 2023/04/05.
//

import SwiftUI

struct NetworkPopupView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Text("네트워크에 접속할 수 없습니다.\n네트워크 연결 상태를 확인해주세요.")
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .medium, design: .rounded))
                .foregroundColor(Color.ForegroundColor)
            HStack {
                
                Button(action: {
                    viewModel.exitApplication()
                }, label: {
                    Text("취소")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .frame(width: (UIScreen.main.bounds.width - 120) / 2, height: 50)
                        .background(Color.secondary)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                })
                
                Button(action: {
                    viewModel.isConnected = true
                    viewModel.stopMonitoring()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        viewModel.startMonitoring()
                    })
                    
                }, label: {
                    Text("재시도")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .frame(width: (UIScreen.main.bounds.width - 120) / 2, height: 50)
                        .background(Color.buttonBackground)
                        .foregroundColor(Color.buttonForeground)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }).buttonStyle(PlainButtonStyle())
                
                
                
            }
        }
        .frame(width: UIScreen.main.bounds.width - 120)
        .padding()
        .background(Color.backgroundColor)
        .cornerRadius(12)
        
    }
}

struct NetworkPopupView_Previews: PreviewProvider {
    static var previews: some View {
        
        NetworkPopupView(viewModel: HomeViewModel())
    }
}
