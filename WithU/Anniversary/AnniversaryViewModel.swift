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
    
    
    //기념일 가졍오기
    func loadAnniversaries(userId: String) {
        FirebaseService.fetchAnniversaries(userId)
            .sink{ (complition) in
                switch complition {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { [weak self] (anniversaries) in
                self?.anniversaries = anniversaries
            }
            .store(in: &cancellables)
    }
    
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
            } receiveValue: { _ in
            
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
