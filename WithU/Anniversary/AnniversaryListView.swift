//
//  AnniversaryListView.swift
//  WithU
//
//  Created by seosh on 7/26/22.
//

import SwiftUI

struct AnniversaryListView: View {
    let anniversary: Anniversary
    
    var body: some View {
        ZStack {
            Color.backgroundColor
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(anniversary.title)")
                        .font(.title2)
                    Text("\(anniversary.date)")
                }
                
                
                
                Spacer()
                
                Text("D-200")
                    .font(.title2)
            }
            .padding()
            .modifier(CardModifier())
        }
        .padding()
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 1, x: 1, y: 1)
                    .opacity(0.3)
            )
    }
}


