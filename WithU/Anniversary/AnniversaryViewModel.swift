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
    @Published var standardFromDay = 100
    
    init() {
        //loadStandardAnniversaries()
    }
    func loadStandardAnniversaries() -> [Anniversary] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let userDate = UserDefaults.shared.object(forKey: "fromDate") as? Date,
              let startDate = dateFormatter.date(from: userDate.toString() ?? "") else {
                  return []
              }
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        let check = UserDefaults.shared.bool(forKey: "check")
        
        var anniversaries = [Anniversary]()
        for i in stride(from: 100, through: 10000, by: 100) {
            let value = check ? i - 1 : i
            if let futureDate = calendar.date(byAdding: .day, value: value, to: startDate) {
                let anniversary = Anniversary(id: UUID().uuidString, title: "\(i)일", date: dateFormatter.string(from: futureDate))
                anniversaries.append(anniversary)
            }
        }
        
        let today = dateFormatter.string(from: currentDate)
        return !UserDefaults.standard.bool(forKey: "AnniversaryToggle") ? anniversaries.filter { $0.date ?? "" >= today } : anniversaries
    }
    
    //기념일 가져오기
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
                var standardArr = self?.loadStandardAnniversaries()
                standardArr?.append(contentsOf: anniversaries)
                
                self?.anniversaries = standardArr ?? []
                self?.anniversaries.sort(by: { ($0.date ?? Date().toString())! < $1.date ?? Date().toString()! })
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
        if Int(dayCount ?? 0) + 1 > 0 {
            return Int(dayCount ?? 0) + 1
        } else  {
            return Int(dayCount ?? 0)
        }
    }
    
}




