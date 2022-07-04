//
//  ChangeMessageView.swift
//  WithU
//
//  Created by seosh on 7/4/22.
//

import SwiftUI

struct ChangeMessageView: View {
    //@StateObject var viewModel: HomeViewModel
    @State var message = "With U"
    @State var dDay = Date()
    private var formatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "highlighter")
                TextField("문구를 입력해 주세요.", text: $message)
            }
            
            HStack {
                Image(systemName: "calendar")
                Text("\(dDay, formatter: formatter)")
            }
            Button(action: {
                
            }, label: {
                Text("저장")
                
                    .fontWeight(.bold)
                    .foregroundColor(.buttonForeground)
            })
            .frame(width: 250, height: 30)
            .background(Color.buttonBackground)
            .cornerRadius(12)
//            DatePicker(selection: $dDay, in: ...Date(), displayedComponents: .date) {
//                Text("날짜를 선택하세요.")
//            }
//            .environment(\.locale, Locale.init(identifier: "ko"))
            
        }
        .padding(10)
    }
}

struct ChangeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeMessageView()
    }
}
