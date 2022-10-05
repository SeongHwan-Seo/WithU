//
//  ModifyStoryView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/05.
//

import SwiftUI

struct ModifyStoryView: View {
    let story: Story
    @State var text = ""
    var body: some View {
        VStack {
            TextField("내용을 입력하세요.", text: $text)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .textFieldStyle(.plain)
                .foregroundColor(.ForegroundColor)
//                .onChange(of: text) { text in
//                    if text.isEmpty {
//                        isDisable = true
//                    } else {
//                        isDisable = false
//                    }
//
//                }
        }
    }
}


