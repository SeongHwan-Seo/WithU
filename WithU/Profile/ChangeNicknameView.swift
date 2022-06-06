//
//  ChangeNicknameView.swift
//  WithU
//
//  Created by seosh on 6/6/22.
//

import SwiftUI

struct ChangeNicknameView: View {
    @Binding var myNickName: String
    @Binding var showingPopup: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            Text("애칭")
            TextField("", text: $myNickName )
                .frame(width: 200)
            Divider()
                .frame(width: 200, height: 1)
                .background(Color.gray)
            Button(action: {
                showingPopup.toggle()
            }, label: {
                Text("저장")
                    
                    .fontWeight(.bold)
                    .foregroundColor(.buttonForeground)
            })
            
            .frame(width: 200, height: 30)
            .background(Color.buttonBackground)
            .cornerRadius(12)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct ChangeNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChangeNicknameView(myNickName: .constant(""), showingPopup: .constant(false))
    }
}
