//
//  AnniversaryViewModel.swift
//  WithU
//
//  Created by seosh on 7/20/22.
//


import SwiftUI
import Combine

class AnniversaryViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var anniversaries = [Anniversary]()
    @Published var isSuccess = false
    
    //기념일 생성
    func createAnniversary(anniversary: Anniversary, userId: String) {
        
        FirebaseService.createAnniversary(anniversary, userId)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { value in
                self.isSuccess = value
            }
            .store(in: &cancellables)
            
        
        
    }
    
    //년월일 날짜 뽑아내기
    func getOnlyDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date_string = formatter.string(from: date)
        return current_date_string
    }
    
}
