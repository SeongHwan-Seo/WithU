//
//  CreateAnniversaryView.swift
//  WithU
//
//  Created by seosh on 7/20/22.
//

import SwiftUI

struct CreateAnniversaryView: View {
    @State var title = ""
    @State var selectedDate = Date()
    var body: some View {
        VStack {
            VStack {
                TextField("제목을 입력하세요.", text: $title)
                    .font(.system(size: 20))
                    .textFieldStyle(.plain)
                    .foregroundColor(.ForegroundColor)
                Divider()
                    .frame(maxWidth: .infinity)
                DatePicker(selection: $selectedDate,
                           in: Date()...,
                           displayedComponents: [.date]){}
                .labelsHidden()
                .datePickerStyle(.graphical)
                .accentColor(.buttonBackground)
            }
            .padding()
            Spacer()
            
            VStack {
                Button(
                    action: {
                        
                    },
                    label: {
                        Text("저장")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.buttonForeground)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                    })
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.buttonBackground)
                .cornerRadius(12)
                
            }
            .padding()
            
        }
        
    }
}

struct CreateAnniversaryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAnniversaryView()
    }
}
