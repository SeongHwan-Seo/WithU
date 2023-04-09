//
//  HomeViewModel.swift
//  WithU
//
//  Created by seosh on 6/7/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import Network
import Combine

class HomeViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var user: User = User()
    @Published var dayCount: Int = 1
    @Published var selectedImage: UIImage?
    @Published var uselectedImage: UIImage?
    @Published var bgSelectedImage: UIImage?
    @Published var isLoading: Bool = false
    var uid = ""
    
    var monitor = NWPathMonitor()
    let queue = DispatchQueue.global()
    @Published var isConnected = false
    
    let appId = "id6444006977"
    let storeURL = URL(string: "itms-apps://itunes.apple.com/app/id6444006977")!
    @Published var isShowingUpdateAlert = false
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "KST")
        return formatter
    }()
    
    init() {
        startMonitoring()
        login()
    }
    
    deinit {
        stopMonitoring()
    }
    
    
    /// 앱스토어 이동
    func goToStore() {
        UIApplication.shared.open(storeURL)
    }
    
    /// 버전체크 후 업데이트
    func checkForUpdate() {
            guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
                // 현재 앱 버전을 가져올 수 없는 경우 처리 로직
                return
            }
            print(currentVersion)
            guard let url = URL(string: "http://itunes.apple.com/kr/lookup?bundleId=com.seosh.WithU") else {
                // URL 형식이 잘못된 경우 처리 로직
                return
            }
            
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    // 데이터를 가져올 수 없는 경우 처리 로직
                    return
                }
                
                guard let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let results = result["results"] as? [[String: Any]],
                    let latestVersion = results.first?["version"] as? String else {
                        // 최신 버전을 가져올 수 없는 경우 처리 로직
                        return
                }
                print(latestVersion)
                // 최신 버전이 현재 버전보다 높은 경우 업데이트 알림을 띄움
                if latestVersion > currentVersion {
                    DispatchQueue.main.async {
                        self.isShowingUpdateAlert = true
                    }
                }
            }.resume()
        }
    
    // method working when you touch 'Check Status' button.
    func startMonitoring() {
        monitor = NWPathMonitor()
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
    }
    
    // method stop checking.
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func login() {
        FirebaseService.anonymousLogin()
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    if UserDefaults.standard.string(forKey: "id") == nil {
                        self.setInitUser(uid: self.uid)
                        
                    } else {
                        self.loadUser()
                    }
                    return
                }
            } receiveValue: { [weak self] uid in
                self?.uid = uid
            }
            .store(in: &cancellables)
    }
    
    //앱 첫 사용자 등록
    func setInitUser(uid: String) {
        var user = User()
        user.id = uid
        UserDefaults.standard.set(user.id, forKey: "id")// user.id 를 UserDeFaults에 저장
        UserDefaults.shared.set(user.date, forKey: "fromDate")
        
        FirebaseService.setUser(user)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    self.loadUser()
                    return
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    //유저정보 업데이트
    func updateUser() {
        UserDefaults.shared.set(user.date, forKey: "fromDate")
        
        FirebaseService.setUser(user)
        
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    
    //사용자 정보 불러오기
    func loadUser() {
        
        FirebaseService.fetchUser()
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    if self.user.imageString == "" && self.user.uimageString == "" && self.user.bgImageString == "" {
                        self.isLoading = true
                    } else {
                        self.setImage()
                    }
                    
                    //self.isLoading = true
                    return
                }
            } receiveValue: { [weak self] (user) in
                self?.user = user
            }
            .store(in: &cancellables)
    }
    
    //FireStore 프로필 사진 저장
    func uploadImage(img: UIImage, name: String) {
        FirebaseService.uploadImage(img: img, name: name, dic: user.id!)
            .sink{ (completion) in
                switch completion {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    
    
    //사귄날짜 ~ 오늘까지 일 수
    func days(from date: Date) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = dateFormatter.date(from: date.toString()!)
        let endDate = dateFormatter.date(from: Date().toString()!)
        let interval = endDate?.timeIntervalSince(startDate!)
        let dayCount = Int(interval! / 86400)
        
        // 0일 or 1일 부터 시작
        if UserDefaults.shared.bool(forKey: "check") {
            return dayCount + 1
        } else {
            return dayCount
        }
        
    }
    
    func setImage() {
        var chk = true
        if self.user.imageString != "" {
            FirebaseService.fetchImage(imageName: user.imageString, id: user.id!)
                .sink{ (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        return
                    case .finished:
                        if self.user.uimageString != "" {
                            chk = false
                        }
                        if chk { self.isLoading = true }
                        
                        return
                    }
                } receiveValue: { [weak self] (image) in
                    self?.selectedImage = image
                }
                .store(in: &cancellables)
        }
        
        if self.user.uimageString != "" {
            FirebaseService.fetchImage(imageName: user.uimageString, id: user.id!)
                .sink{ (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        return
                    case .finished:
                        if self.user.bgImageString != "" {
                            chk = false
                        }
                        if chk { self.isLoading = true }
                        
                        return
                    }
                } receiveValue: { [weak self] (image) in
                    self?.uselectedImage = image
                }
                .store(in: &cancellables)
        }
        
        if self.user.bgImageString != "" {
            FirebaseService.fetchImage(imageName: user.bgImageString, id: user.id!)
                .sink{ (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        return
                    case .finished:
                        self.isLoading = true
                        
                        return
                    }
                } receiveValue: { [weak self] (image) in
                    self?.bgSelectedImage = image
                }
                .store(in: &cancellables)
        }
        
        
    }
    
    /// 앱 종료하기
    func exitApplication() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
    }
    
    
}




