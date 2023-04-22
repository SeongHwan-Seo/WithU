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
            ForEach(imagesURL, id:\.self) { url in
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
                            
                        }
                }
            }
            .padding()
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 300)
        .tabViewStyle(PageTabViewStyle())
        
    }
}


//struct ImageGridView: View {
//    let imagesURL: [URL]
//    @StateObject var  viewModel: StoryViewModel
//    var body: some View {
//        let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
//        LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
//            ForEach(imagesURL.indices, id: \.self) { index in
//                ZStack {
//                    if index <= 3 {
//                        KFImage(imagesURL[index])
//                            .placeholder({
//                                ProgressView()
//                            })
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: (getRect().width - 50) / 2 , height: 140)
//                            .clipShape(RoundedRectangle(cornerRadius: 12))
//
//
//                    }
//                    if imagesURL.count > 4 && index == 3 {
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color.black.opacity(0.3))
//
//                        let remainingImages =
//                        imagesURL.count - 4
//
//                        Text("+\(remainingImages)")
//                            .font(.title)
//                            .fontWeight(.heavy)
//                            .foregroundColor(.white)
//                    }
//
//                }
//
//            }
//        })
//        .background(Color.red)
//
//    }
//}

//struct ItemView: View {
//    let imagesURL: [URL]
//    @StateObject var  viewModel: StoryViewModel
//
//    var body: some View{
//
//
//
//        ScrollView(.horizontal, showsIndicators: false){
//            HStack(spacing: 0) {
//                ForEach(imagesURL.indices, id: \.self) { index in
//                    KFImage(imagesURL[index])
//                        .cancelOnDisappear(true)
//                        .placeholder({
//                            ProgressView()
//                        })
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: getRect().width , height: getRect().height / 2)
//                }
//            }
//        }
//        .onAppear {
//            //UIScrollView.appearance().isPagingEnabled = true
//        }
//    }
//}



//
//struct ImageGridView: View {
//    let storyImages: [UIImage]
//    let index: Int
//    @StateObject var viewModel: StoryViewModel
//    var body: some View {
//        VStack {
//            Button(action: {
//                withAnimation(.default) {
////                    viewModel.detailShowViewer.toggle()
////                    viewModel.detailSelectedImages = storyImages
////                    viewModel.detailSelectedImage = storyImages[index]
//                }
//
//            }, label: {
//                ZStack {
//                    if index <= 3 {
//                        Image(uiImage: storyImages[index])
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: (getRect().width - 50) / 2 , height: 140)
//                            .clipShape(RoundedRectangle(cornerRadius: 12))
//
//                    }
//
//                    if storyImages.count > 4 && index == 3 {
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color.black.opacity(0.3))
//
//                        let remainingImages =
//                        storyImages.count - 4
//
//                        Text("+\(remainingImages)")
//                            .font(.title)
//                            .fontWeight(.heavy)
//                            .foregroundColor(.white)
//                    }
//
//                }
//            })
//
//        }
//    }
//}
