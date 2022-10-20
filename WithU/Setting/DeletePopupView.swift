//
//  DeletePopupView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/20.
//

import SwiftUI

struct DeletePopupView: View {
    @StateObject var viewModel: SettingViewModel
    @Binding var isShowingPopup: Bool
    var body: some View {
        VStack {
            Text("입력하신 기념일과 스토리 등 모든 정보가 삭제됩니다. 삭제하신 후에는 \n앱이 종료됩니다. 삭제 하시겠습니까?")
                .font(.system(size: 17, weight: .medium, design: .rounded))
                .frame(width: 200)
                .foregroundColor(Color.ForegroundColor)
            HStack {
                
                Button(action: {
                    isShowingPopup.toggle()
                }, label: {
                    Text("취소")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .frame(width: 100, height: 50)
                        .background(Color.secondary)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                })
                
                Button(action: {
                    viewModel.deleteAll(userId: UserDefaults.standard.string(forKey: "id")!)
                    isShowingPopup.toggle()
                }, label: {
                    Text("삭제")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .frame(width: 100, height: 50)
                        .background(Color.buttonBackground)
                        .foregroundColor(Color.buttonForeground)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }).buttonStyle(PlainButtonStyle())
                
                
                
            }
        }
        
        .padding()
        .background(Color.backgroundColor)
        .cornerRadius(12)
        
    }
}

struct DeletePopupView_Previews: PreviewProvider {
    static var previews: some View {
        
        DeletePopupView(viewModel: SettingViewModel(),isShowingPopup: .constant(true))
    }
}
