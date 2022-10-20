//
//  AnniversaryListView.swift
//  WithU
//
//  Created by seosh on 7/26/22.
//

import SwiftUI

struct AnniversaryListView: View {
    @StateObject var viewModel: AnniversaryViewModel
    
    var body: some View {
        
        List {
            ForEach(viewModel.anniversaries, id: \.id) { anniversary in
                
                let dDay = viewModel.calCulDay(from: anniversary.date.toDate() ?? Date())
                
                ZStack {
                    
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Text("\(anniversary.title)")
                                .font(.system(size: 17, weight: .medium, design: .rounded))
                                .padding(.bottom, 3)
                            Text("\(anniversary.date)")
                                .font(.system(size: 14, weight: .thin))
                        }
                        
                        
                        Spacer()
                        
                        if dDay == 0 {
                            Text("D-Day")
                                .font(.system(.title2, design: .rounded))
                        } else if dDay > 0 {
                            Text("D-\(dDay)")
                                .font(.system(.title2, design: .rounded))
                        } else if dDay < 0 {
                            Text("D+\(abs(dDay))")
                                .font(.system(.title2, design: .rounded))
                        }
                        
                            
                    }
                    
                }
            }
            .onDelete(perform: deleteItems)
            .listStyle(PlainListStyle())
            
        }
        
        .onAppear{
            //UITableView.appearance().backgroundColor = UIColor(.backgroundColor)
        }
        
        
    }
    
    
}


extension AnniversaryListView {
    
    /// 기념일삭제
    /// - Parameter offsets: 기념일 배열 인덱스
    func deleteItems(at offsets: IndexSet) {
        offsets.map{ viewModel.anniversaries[$0] }.forEach { anniversary in
            viewModel.deleteAnniversary(anniversaryId: anniversary.id
                                        , userId: UserDefaults.standard.string(forKey: "id") ?? "")
            
            
        
            if let index:Int = viewModel.anniversaries.firstIndex(where: {$0.id == anniversary.id}) {
                viewModel.anniversaries.remove(at: index)
            }
        }
        
    }
}


struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.popBackgroundColor)
                    .shadow(color: .gray, radius: 1, x: 1, y: 1)
                    .opacity(1)
                
            )
        
    }
}


