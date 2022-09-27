//
//  StoryItemView.swift
//  WithU
//
//  Created by SHSEO on 2022/09/17.
//

import SwiftUI
import Kingfisher

struct StoryItemView: View {
    @StateObject var viewModel: StoryViewModel
    @State var isShowingActionSheet = false
    let userId: String
    
    
    @State var param: Story = Story(id: "", date: "", content: "", images: [""])
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.stories, id: \.id) { story in
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(story.date) 토요일")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                        Spacer()
                        Button(action: {
                            
                            isShowingActionSheet.toggle()
                            param = Story(id: story.id, date: story.date, content: story.content, images: story.images)
                            print(story.content)
                        }, label: {
                            Image(systemName: "ellipsis")
                                .frame(width: 44, height: 44)
                                .foregroundColor(.ForegroundColor)
                        })
                        .confirmationDialog(
                                    "Are you sure you want to import this file?",
                                    isPresented: $isShowingActionSheet, presenting:
                                        param
                                ) { story in
                                    Button {
                                        // Handle import action.
                                    } label: {
                                        Text("수정")
                                    }
                                    
                                    Button {
                                        viewModel.deleteStory(story: story, userId: userId)
                                        viewModel.deleteStoryImage(story: story, userId: userId)
                                    } label: {
                                        Text("삭제")
                                    }
                                    
                                    
                                    Button("취소", role: .cancel) {
                                        isShowingActionSheet.toggle()
                                    }
                                }
                        
                    }
                    
                    
                    Text("\(story.content)")
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 70), count: 2)
                    
                    if  !viewModel.isLoading{
                        LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
                            
                            ForEach(viewModel.images[story.id] ?? [UIImage()], id: \.self) { data in
                                Image(uiImage: data)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: (getRect().width - 100) / 2 , height: 140)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .redacted(reason: viewModel.isLoading ? .placeholder : .init())
                            }
                            
                            
                        })
                        
                    }
                    
                }
//                .background(GeometryReader {
//                    // detect Pull-to-refresh
//                    Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .global).origin.y)
//                })
//                .onPreferenceChange(ViewOffsetKey.self) {
//                    print($0)
//                    if $0 < -124 && !viewModel.isLoading {
//                        viewModel.isLoading = true
//                        viewModel.stories = [Story]()
//                        viewModel.loadStories(userId: userId)
//                    }
//                }
                .padding()
                
                
                
            }
        }
//        .overlay(
//            VStack {
//                Spacer()
//
//                CustomActionSheet(isShowingActionSheet: $isShowingActionSheet)
//                    .offset(y: self.isShowingActionSheet ? 0 : UIScreen.main.bounds.height)
//            }
//                .background(self.isShowingActionSheet ? Color.black.opacity(0.3) : Color.clear)
//                .edgesIgnoringSafeArea(.bottom)
//
//        )
        
        
    }
}



struct CustomActionSheet: View {
    @Binding var isShowingActionSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Button(action: {
                } ) {
                    Image(systemName: "person.crop.rectangle")
                    Text("수정하기")
                    
                }
                .foregroundColor(Color.ForegroundColor)
                
                Spacer()
            }
            
            HStack {
                Button(action: {} ) {
                    Image(systemName: "camera")
                    Text("삭제")
                    
                }
                .foregroundColor(Color.ForegroundColor)
                Spacer()
            }
            HStack {
                Button(action: {
                    isShowingActionSheet.toggle()
                }) {
                    Image(systemName: "clear")
                    Text("취소")
                    
                }
                .foregroundColor(Color.ForegroundColor)
                Spacer()
            }
        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.horizontal)
            .padding(.top, 20)
            .background(Color.popBackgroundColor)
            .cornerRadius(20)
        
    }
    
}

//struct StoryItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryItemView(viewModel: StoryViewModel())
//    }
//}
