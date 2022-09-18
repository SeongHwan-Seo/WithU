//
//  StoryItemView.swift
//  WithU
//
//  Created by SHSEO on 2022/09/17.
//

import SwiftUI

struct StoryItemView: View {
    @StateObject var viewModel: StoryViewModel
    
    
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.stories, id: \.id) { story in
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(story.date) 토요일")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                        Spacer()
                        Button(action: {
                            
                            print("story : ", viewModel.images)
                            
                            
                        }, label: {
                            Image(systemName: "ellipsis")
                                .frame(width: 44, height: 44)
                                .foregroundColor(.ForegroundColor)
                        })
                    }
                    
                    
                    Text("\(story.content)")
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                    
                    if story.images.count > 0  && viewModel.isLoading{
                        LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
                            ForEach(viewModel.images[story.id]!, id: \.self){
                                url in
                                AsyncImage(url: url)
                                    
                            }
                            
                        })
                       
                        
                        
                    }
                    
                    //if viewModel.images.count > 0 {

//                        LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
//                            ForEach(viewModel.images[story.id] ?? [UIImage](), id: \.self) { img in
//                                Image(uiImage: img)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: (getRect().width - 100) / 2 , height: 120)
//                                    .clipShape(RoundedRectangle(cornerRadius: 12))
//
//                            }
//                        })
                        
                        
                    //}
                    
                }
                .padding()
                
            }
        }
        
        
    }
}

struct StoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        StoryItemView(viewModel: StoryViewModel())
    }
}
