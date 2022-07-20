//
//  AnniversaryView.swift
//  WithU
//
//  Created by seosh on 4/20/22.
//

import SwiftUI
import ExytePopupView

struct AnniversaryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Color.backgroundColor
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .padding()
                            .foregroundColor(.ForegroundColor)
                    })
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: {
                            CreateAnniversaryView()
                        },
                        label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .padding()
                                .foregroundColor(.ForegroundColor)
                        })
                }
            }
            
            
        }
        
        
    }
}

struct AnniversaryView_Previews: PreviewProvider {
    static var previews: some View {
        AnniversaryView()
    }
}
