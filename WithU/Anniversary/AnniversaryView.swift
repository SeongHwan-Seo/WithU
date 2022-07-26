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
                    
                    Text("기념일")
                        .font(.headline)
                    
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
            
            ScrollView {
                VStack {
                    ForEach(0..<15, id: \.self) { i in
                        AnniversaryListView()
                    }
                }
            }
            .offset(y: 50)
            
        }
        
        
    }
}

struct AnniversaryView_Previews: PreviewProvider {
    static var previews: some View {
        AnniversaryView()
    }
}
