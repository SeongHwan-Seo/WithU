//
//  MenuHeadView.swift
//  WithU
//
//  Created by seosh on 4/13/22.
//

import SwiftUI
import Lottie

struct MenuHeadView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Button(action: {
                withAnimation(.spring()) {
                    isShowing.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .padding()
            })
                
            
            VStack(alignment: .leading) {
                
                Text("서성환")
                    .font(.system(size: 24, weight: .semibold))
                
                Text("@배추릅")
                    .font(.system(size: 14))
                    .padding(.bottom, 20)
                
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Text("D-day").bold()
                        Text("78")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top, 80)
            .foregroundColor(.white)
        .padding()
        }
    }
}

struct MenuHeadView_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeadView(isShowing: .constant(true))
    }
}
