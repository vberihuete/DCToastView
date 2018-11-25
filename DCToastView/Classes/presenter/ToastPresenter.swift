//
//  ToastPresenter.swift
//  ToastView
//
//  Created by Vincent Berihuete on 11/17/18.
//  Copyright © 2018 devcorerd. All rights reserved.
//

import Foundation
import UIKit

public class ToastPresenter {
    
    public static let shared = ToastPresenter()
    
    private var currentToast: ToastMessage?
    
    public func show(in view: UIView, message: String, place toastPlace: ToastPlace = .down, backgroundColor: UIColor = .black, textColor: UIColor = .white, timeOut: Double? = nil, roundness: ToastRoundness = .mid){

        let toast = ToastMessage(backgroundColor: backgroundColor, message: message, timeOut: timeOut, textColor: textColor, roundness: roundness)
        toast.alpha = 0
        if let currentToast = currentToast{
            currentToast.dismiss {
                self.add(toast, to: view)
                toast.constraint(in: view, place: toastPlace)
                self.slide(up: toast)
            }
        }else{
            self.add(toast, to: view)
            toast.constraint(in: view, place: toastPlace)
            slide(up: toast)
        }
    }
    
    
    /// Removes the current showing toast
    public func remove(){
        currentToast?.dismiss()
        currentToast = nil
        
    }
    
    private func add(_ toast: ToastMessage, to view: UIView){
        self.currentToast = toast
        view.addSubview(toast)
    }
    
    private func slide(up view: UIView){
        UIView.animate(withDuration: 0.2){
            view.alpha = 1
            view.center.y -= 10
        }
    }
}

public enum ToastPlace{
    case up
    case down
}

public enum ToastRoundness: CGFloat{
    case none = 1
    case low = 20
    case mid = 10
    case high = 8
    
}
