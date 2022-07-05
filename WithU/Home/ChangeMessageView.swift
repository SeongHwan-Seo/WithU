//
//  ChangeMessageView.swift
//  WithU
//
//  Created by seosh on 7/4/22.
//

import SwiftUI

struct ChangeMessageView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var isShowingChangeMessagePopup: Bool
    @State var message = "With U"
    @State var dDay: Date? = Date()
    @State var showDatePicker: Bool = false
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack() {
                    Image(systemName: "highlighter")
                        .foregroundColor(.black)
                    VStack {
                        TextField("문구를 입력해 주세요.", text: $message)
                            .frame(width: 150)
                    }
                    .foregroundColor(.black)
                    
                }
                
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                    Text("\(dDay ?? Date(), formatter: formatter)")
                        .onTapGesture {
                            showDatePicker.toggle()
                        }
                        .foregroundColor(.black)
                }
                
                
                
                
                Button(action: {
                    isShowingChangeMessagePopup.toggle()
                }, label: {
                    Text("저장")
                    
                        .fontWeight(.bold)
                        .foregroundColor(.buttonForeground)
                })
                .frame(width: 250, height: 30)
                .background(Color.buttonBackground)
                .cornerRadius(12)
                .padding(.top, 25)
                
            }
            .frame(width: 250, height: 150)
            .padding(10)
            .background(.white)
            .cornerRadius(12)
            
            
            if showDatePicker {
                DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $dDay, selectedDate: dDay ?? Date())
            }
        }
        
    }
}

struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    
    var body: some View {
        
            
            
            VStack {
                DatePicker("Test", selection: $selectedDate, in: ...Date(), displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    
                    .accentColor(Color.buttonBackground)
                    
                
                Divider()
                HStack {
                    
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("취소")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("선택".uppercased())
                            .bold()
                    })
                    
                }
                .padding(.horizontal)
                
            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(30)
            )
            .frame(width: 330, height: 280)
            
            
        
        
    }
}


