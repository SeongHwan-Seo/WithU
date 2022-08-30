//
//  StoryView.swift
//  WithU
//
//  Created by seosh on 4/20/22.
//

import SwiftUI

struct StoryView: View {
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
                    
                    Text("스토리")
                        .font(.headline)
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: {
                            //CreateAnniversaryView()
                        },
                        label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .padding()
                                .foregroundColor(.ForegroundColor)
                        })
                }
            }
            
            
        }    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
