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
    //@State var dDay: Date? = Date()
    @State var showDatePicker: Bool = false
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    var onlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack() {
                    Image(systemName: "highlighter")
                        .foregroundColor(.ForegroundColor)
                    VStack {
                        TextField("문구를 입력해 주세요.", text: $viewModel.user.message)
                            .frame(width: 150)
                    }
                    .foregroundColor(.ForegroundColor)
                    
                }
                
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.ForegroundColor)
                    Text("\(viewModel.user.date ?? Date(), formatter: formatter)")
                        .onTapGesture {
                            showDatePicker.toggle()
                        }
                        .foregroundColor(.ForegroundColor)
                }
                
                
                
                
                Button(action: {
                    viewModel.updateUser()
                    isShowingChangeMessagePopup.toggle()
                    print(onlyDateFormatter.string(from: viewModel.user.date ?? Date()))
                    
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
            .background(Color.popBackgroundColor)
            .cornerRadius(12)
            
            
            if showDatePicker {
                DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $viewModel.user.date, selectedDate: viewModel.user.date ?? Date())
            }
        }
        
    }
}

struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
//    var formatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY-MM-dd"
//        return formatter
//    }()
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
                    .foregroundColor(Color.ForegroundColor)
                    
                    Spacer()
                    
                    Button(action: {
                        savedDate = selectedDate
                        showDatePicker = false
                        //print(formatter.string(from: savedDate ?? Date()))
                    }, label: {
                        Text("선택".uppercased())
                            .bold()
                    })
                    .foregroundColor(Color.ForegroundColor)
                }
                .padding(.horizontal)
                
            }
            .padding()
            .background(
                Color.popBackgroundColor
                    .cornerRadius(30)
            )
            .frame(width: 330, height: 280)
            
            
        
        
    }
}


