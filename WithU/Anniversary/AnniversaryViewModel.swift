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
    
    ///  기념일 삭제
    /// - Parameters:
    ///   - anniversaryId: 기념일 아이디
    ///   - userId: 유저 아이디
    func deleteAnniversary(anniversaryId: String, userId: String) {
        FirebaseService.deleteAnniversary(anniversaryId, userId)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    //self.loadAnniversaries(userId: userId)
                    return
                }
                
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
    
    //년월일 날짜 뽑아내기 date -> String
    func getOnlyDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date_string = formatter.string(from: date)
        return current_date_string
    }
    
    
    
    /// 기념일 D-day 계산
    /// - Parameter date: 기념일 날짜
    /// - Returns: 지난 기념일 + day /지나지 않은 기념일 - day
    func calCulDay(from date: Date) -> Int {
        
        if Date().toString() == date.toString() {
            return 0
        }
        
        let dayCount = Calendar.current.dateComponents([.day], from: Date(), to: date).day
        
        return Int(dayCount ?? 0) + 1
    }
    
    
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
            
    }
}

extension Date {
    func toString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
