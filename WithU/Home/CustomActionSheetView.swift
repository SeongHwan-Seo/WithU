//
//  CustomActionSheetView.swift
//  WithU
//
//  Created by seosh on 6/12/22.
//

import SwiftUI

struct CustomActionSheetView: View {
    @Binding var isShowingPopupview: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Button(action: {} ) {
                    Image(systemName: "person.crop.rectangle")
                    Text("앨범에서 선택하기")
                    
                }
                .foregroundColor(Color.black)
                Spacer()
            }
            
            HStack {
                Button(action: {} ) {
                    Image(systemName: "camera")
                    Text("카메라로 찍기")
                    
                }
                .foregroundColor(Color.black)
                Spacer()
            }
            HStack {
                Button(action: {
                    isShowingPopupview.toggle()
                }) {
                    Image(systemName: "clear")
                    Text("취소")
                    
                }
                .foregroundColor(Color.black)
                Spacer()
            }
        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.horizontal)
            .padding(.top, 20)
            .background(Color.white)
            .cornerRadius(20)
        
    }
}

struct CustomActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomActionSheetView(isShowingPopupview: .constant(true))
    }
}
