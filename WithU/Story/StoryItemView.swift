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
    @State var isShowingSheet = false
    let userId: String
    
    
    
    @State var param: Story = Story(id: "", date: "", content: "", images: [""], createDate: "")
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.stories, id: \.id) { story in
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(story.date)")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        Spacer()
                        Button(action: {
                            
                            isShowingActionSheet.toggle()
                            param = Story(id: story.id, date: story.date, content: story.content, images: story.images, createDate: story.createDate)
                            
                        }, label: {
                            Image(systemName: "ellipsis")
                                .frame(width: 44, height: 44)
                                .foregroundColor(.ForegroundColor)
                        })
                        .actionSheet(isPresented: $isShowingActionSheet) {
                            ActionSheet(title: Text("스토리"),
                                        buttons:[.default(Text("글 수정"),
                                                            action: {
                                                                        isShowingSheet.toggle()
                                                                    }),
                                                .destructive(Text("삭제하기"),
                                                               action: {
                                                                    withAnimation(.spring()) {
                                                                                viewModel.deleteStory(story: param, userId: userId)
                                                                                viewModel.deleteStoryImage(story: param, userId: userId)
                                                                                }
                                                                        }),
                                                 .cancel(Text("취소"))] )
                        }
                        //                        .confirmationDialog(
                        //                            "",
                        //                            isPresented: $isShowingActionSheet, presenting:
                        //                                param
                        //                        ) { story in
                        //
                        //                            Button("수정") {
                        //                                isShowingSheet.toggle()
                        //                            }
                        //
                        //
                        //
                        //                            Button("삭제", role: .destructive) {
                        //                                withAnimation(.spring()) {
                        //                                    viewModel.deleteStory(story: story, userId: userId)
                        //                                    viewModel.deleteStoryImage(story: story, userId: userId)
                        //                                }
                        //                            }
                        //
                        //                            Button("취소", role: .cancel) {
                        //                                isShowingActionSheet.toggle()
                        //                            }
                        //                        }
                        
                    }
                    
                    
                    Text("\(story.content)")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
                    //var _ index = 0
                    if  !viewModel.isLoading{
                        LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
                            
                            ForEach(viewModel.images[story.id]?.indices ?? [UIImage()].indices, id: \.self) { index in
                                ImageGridView(storyImages: viewModel.images[story.id] ?? [UIImage()], index: index, viewModel: viewModel)
                                
                            }
                            
                        })
                        
                    }
                    
                }
                .padding()
                
                
                
            }
        }
        
        .fullScreenCover(isPresented: $isShowingSheet, content: {
            ModifyStoryView(story: param, text: param.content, images: viewModel.images[param.id]!, viewModel: viewModel)
        })
        
    }
}

struct ImageGridView: View {
    let storyImages: [UIImage]
    let index: Int
    @StateObject var viewModel: StoryViewModel
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.default) {
                    viewModel.detailShowViewer.toggle()
                    viewModel.detailSelectedImages = storyImages
                    viewModel.detailSelectedImage = storyImages[index]
                }
                
            }, label: {
                ZStack {
                    
                    if index <= 3 {
                        Image(uiImage: storyImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (getRect().width - 50) / 2 , height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    }
                    
                    if storyImages.count > 4 && index == 3 {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.3))
                        
                        let remainingImages =
                        storyImages.count - 4
                        
                        Text("+\(remainingImages)")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    }
                    
                }
            })
            
        }
    }
}



