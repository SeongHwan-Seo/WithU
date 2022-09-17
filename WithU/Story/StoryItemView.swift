//
//  StoryItemView.swift
//  WithU
//
//  Created by SHSEO on 2022/09/17.
//

import SwiftUI

struct StoryItemView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("2020-09-17 토요일")
                Spacer()
            }
            
                
            Text("테스트 내용")
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
            LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
                
            })
        }
        .padding()
    }
}

struct StoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        StoryItemView()
    }
}
