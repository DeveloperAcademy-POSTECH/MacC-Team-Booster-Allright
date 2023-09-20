//
//  LottieAnimation.swift
//  Allright
//
//  Created by 최진용 on 2023/09/20.
//

import Foundation
import Lottie
import SwiftUI
import UIKit

struct LottieView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var fileName : String = "micAnimation"
    var loopMode: LottieLoopMode = .loop
    var animationView = LottieAnimationView()
    @Binding var isPlay: Bool
    
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        let animation = LottieAnimation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !isPlay {
            context.coordinator.parent.animationView.stop()
        } else {
            context.coordinator.parent.animationView.play()
        }
    }
    
    class Coordinator: NSObject {
            var parent: LottieView

            init(_ parent: LottieView) {
                self.parent = parent
            }
        }
}
