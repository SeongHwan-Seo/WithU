//
//  LottieHeartView.swift
//  WithU
//
//  Created by seosh on 4/18/22.
//

import SwiftUI
import Lottie
import UIKit

struct LottieHeartView: UIViewRepresentable {
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieHeartView>) -> UIView {
        let view = UIView(frame: .zero)
        
        //add animation
        let animationView = AnimationView()
        // 사용자 애니메이션 파일명
        animationView.animation = Animation.named(filename)
        
        //애니메이션 크기가 적절하게 조정될 수 있도록
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        
        animationView.backgroundBehavior = .pauseAndRestore
        //애니메이션 재생
        animationView.play()
        
        //컨테이너 너비와 높이를 자동으로 지정할 수 있도록
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        //자동완성 기능
        NSLayoutConstraint.activate([
            //레이아웃의 높이와 넓이의 제약
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieHeartView>) {
        //do nothing
    }
}
