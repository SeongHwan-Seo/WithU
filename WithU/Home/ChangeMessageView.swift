//
//  ChangeMessageView.swift
//  WithU
//
//  Created by seosh on 7/4/22.
//

import SwiftUI
//체크박스 트일 토글
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 18, height: 18)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}

struct ChangeMessageView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var isShowingChangeMessagePopup: Bool
    @State var showDatePicker: Bool = false
    @State private var isToggle: Bool = UserDefaults.shared.bool(forKey: "check")
    @State var messageText: String
    @State var selectedDate: Date
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier:"ko_KR")
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }() //사용자에게 보이는 formatter
    var onlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier:"ko_KR")
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }() //파이어베이스 저장 formatter
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack() {
                    Image(systemName: "highlighter")
                        .foregroundColor(.ForegroundColor)
                    VStack {
                        TextField("문구를 입력해 주세요.", text: $messageText)
                            .frame(width: 150)
                    }
                    .foregroundColor(.ForegroundColor)
                    
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.ForegroundColor)
                    Text("\(selectedDate, formatter: formatter)")
                        .onTapGesture {
                            showDatePicker.toggle()
                        }
                        .foregroundColor(.ForegroundColor)
                }
                
                HStack {
                    Toggle(isOn: $isToggle) {
                        Text("1일부터 시작")
                            .foregroundColor(.ForegroundColor)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                }
                
                Button(action: {
                    viewModel.user.message = messageText
                    viewModel.user.date = selectedDate
                    viewModel.updateUser()
                    isShowingChangeMessagePopup.toggle()
                    UserDefaults.shared.set(self.isToggle, forKey: "check")
                }, label: {
                    Text("저장")
                        .fontWeight(.bold)
                        .foregroundColor(.buttonForeground)
                        .frame(width: 250, height: 30)
                })
                .frame(width: 250, height: 30)
                .background(Color.buttonBackground)
                .cornerRadius(12)
                .padding(.top, 15)
                
            }
            .frame(width: 250, height: 150)
            .padding(10)
            .background(Color.popBackgroundColor)
            .cornerRadius(12)
            
            if showDatePicker {
                DatePickerWithButtons(showDatePicker: $showDatePicker, selectedDate: $selectedDate)
            }
        }
        
    }
    
}

struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var selectedDate: Date
    var body: some View {
        
            VStack {
                DatePicker("Test", selection: $selectedDate, in: ...Date(), displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .environment(\.locale, Locale.init(identifier: "ko_KR"))
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
                        //savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("선택")
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


