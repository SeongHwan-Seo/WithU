//
//  OpenSourceView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/26.
//

import SwiftUI

struct OpenSourceView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea([.top, .bottom])
                .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                    
                    if(value.startLocation.x < 20 && value.translation.width > 100) {
                        self.mode.wrappedValue.dismiss()
                    }
                    
                }))
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(OpenSourceViewModel.allCases, id: \.self) { option in
                        Text("* \(option.lib)")
                        Link("\(option.url)", destination: URL(string: option.url)!)
                    }
                    
                    
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.ForegroundColor)
            })
        }
        
        
        
    }
}

struct OpenSourceView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceView()
    }
}
