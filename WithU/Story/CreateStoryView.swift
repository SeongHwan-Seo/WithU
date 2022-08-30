//
//  CreateStoryView.swift
//  WithU
//
//  Created by SHSEO on 2022/08/30.
//

import SwiftUI

struct CreateStoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.backgroundColor
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            VStack{
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("취소")
                            .font(.headline)
                            .foregroundColor(.ForegroundColor)
                    })
                    
                    Spacer()
                    
                    Text("기념일 등록")
                        .font(.headline)
                        .foregroundColor(.ForegroundColor)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        
                    }, label: {
                        Text("저장")
                            .font(.headline)
                            .foregroundColor(.buttonBackground)
                    })
                }
                .padding()
                
                Divider()
            }
            
        }
    }
}

struct CreateStoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateStoryView()
    }
}
