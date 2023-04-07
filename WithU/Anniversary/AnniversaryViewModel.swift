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
    
    init() {
        //loadStandardAnniversaries()
    }
    func loadStandardAnniversaries() -> [Anniversary] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let startDateString = "2017-07-12"
        let startDate = dateFormatter.date(from: startDateString)!

        let currentDate = Date()

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day], from: startDate, to: currentDate)
        let daysSinceStart = dateComponents.day! + 1 // 시작일을 1일로 계산하기 위해 1을 더해줍니다.

        print("17년 7월 12일부터 오늘까지 \(daysSinceStart)일이 지났습니다.")
        var anniversaries = [Anniversary]()
        for i in stride(from: 100, through: 10000, by: 100) {
            if let futureDate = calendar.date(byAdding: .day, value: i-1, to: startDate) { // 시작일을 1일로 계산하기 위해 1을 빼줍니다.
                let dateComponents = calendar.dateComponents([.day], from: startDate, to: futureDate)
                let daysSinceStart = dateComponents.day! + 1 // 시작일을 1일로 계산하기 위해 1을 더해줍니다.
                //print("\(i)일 후 날짜: \(dateFormatter.string(from: futureDate)), 17년 7월 12일부터 \(daysSinceStart)일이 지났습니다.")
                
                let anniversary = Anniversary(id: UUID().uuidString, title: "\(i)일", date: "\(dateFormatter.string(from: futureDate))")
                //print(anniversary)
                anniversaries.append(anniversary)
            }
        }
        return anniversaries
    }
    
    //기념일 가져오기
    func loadAnniversaries(userId: String) {
        print("loadAnniversaries")
        FirebaseService.fetchAnniversaries(userId)
            .sink{ (complition) in
                switch complition {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    print(self.anniversaries)
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




