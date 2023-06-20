//
//  MessageComposeView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/20.
//

import SwiftUI
import MessageUI

struct MessageComposeView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MFMessageComposeViewController
    
    let recipients: [String]
    let messageBody: String
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.recipients = recipients
        controller.body = messageBody
        controller.messageComposeDelegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {
        // 필요한 경우 업데이트 처리
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true)
        }
    }
}
