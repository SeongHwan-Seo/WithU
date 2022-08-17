//
//  CreateAnniversaryView.swift
//  WithU
//
//  Created by seosh on 7/20/22.
//

import SwiftUI

struct CreateAnniversaryView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: AnniversaryViewModel
    @State var title = ""
    @State var selectedDate = Date()
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                Color.backgroundColor
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                VStack{
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("취소")
                                .font(.headline)
                                .foregroundColor(.ForegroundColor)
                        })
                        
                        Spacer()
                        
                        Text("기념일 등록")
                            .font(.headline)
                            .foregroundColor(.ForegroundColor)
                        
                        Spacer()
                        
                        Button(action: {
                            
                            viewModel.createAnniversary(anniversary: Anniversary(id: UUID().uuidString, title: title, date: viewModel.getOnlyDate(date: selectedDate)), userId: UserDefaults.standard.string(forKey: "id") ?? "") 
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("저장")
                                .font(.headline)
                                .foregroundColor(.buttonBackground)
                        })
                    }
                    .padding()
                    
                    Divider()
                }
                
            }
            
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
            .offset(y: 60)
            
        }
        
        
        
        
        
        
        
        
        
    }
}
