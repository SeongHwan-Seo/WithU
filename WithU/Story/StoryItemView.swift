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
        ScrollView(showsIndicators: true) {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.stories, id: \.id) { story in
                    VStack(alignment: .leading) {
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
                            }
                            
                            
                            Text("\(story.content)")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                            
                            
                        }
                        .padding([.top, .leading, .trailing], 10)
                        
                        ScrollView {
                            LazyHStack() {
                                ImageGridView(imagesURL: story.url ?? [URL](), viewModel: viewModel)
                            }
                        }
                        .padding(.bottom, 10)
                        
                    }
                }
            }
            
        }
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
        .fullScreenCover(isPresented: $isShowingSheet, content: {
            ModifyStoryView(story: param, text: param.content, images: viewModel.images[param.id]!, viewModel: viewModel)
        })
        
        
        
    }
    
    
}

struct ImageGridView: View {
    let imagesURL: [URL]
    @StateObject var  viewModel: StoryViewModel
    var body: some View {
        TabView {
            ForEach(Array(imagesURL.enumerated()), id:\.offset) { index, url in
                ZStack {
                    KFImage(url)
                        .placeholder({
                            ProgressView()
                        })
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width-20, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            viewModel.detailSelectedImages = imagesURL
                            viewModel.detailSelectedImage = imagesURL[index].absoluteString
                            withAnimation(.default) {
                                viewModel.detailShowViewer.toggle()
                            }
                            
                        }
                }
            }
            .padding()
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 300)
        .tabViewStyle(PageTabViewStyle())
        
    }
}
