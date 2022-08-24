//
//  AnniversaryListView.swift
//  WithU
//
//  Created by seosh on 7/26/22.
//

import SwiftUI

struct AnniversaryListView: View {
    let anniversary: Anniversary
    @State var offset = 0.0
    
    var body: some View {
        
        ZStack {
            Color.backgroundColor
            
            HStack {
                
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.red)
                        .frame(width: 60, height: 60)
                })
                
                
                
            }
            
            
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
            .offset(x: offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            
        }
        
        .padding([.top, .horizontal])
    }
    
    func onChanged(value: DragGesture.Value) {
        //anniversary.
        
        
        offset = value.translation.width
        
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut){
            if -offset > 50 {
                offset = -60
            }
            else {
                offset = 0
            }
        }
        
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.popBackgroundColor)
                    .shadow(color: .gray, radius: 1, x: 1, y: 1)
                    .opacity(1)
                
            )
        
    }
}


