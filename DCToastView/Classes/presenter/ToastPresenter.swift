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
    
    
    /// The shared instance for the toast presenter
    ///
    /// if needed more instances of the presenter can be created but it is adviced to use
    /// this shared instance.
    public static let shared = ToastPresenter()
    
    private var currentToast: ToastMessage?
    
    
    /// This tells the current toast instance to show a toast with the given configuration
    ///
    /// - Parameters:
    ///   - view: The view in which the toast is going to be presented
    ///   - message: The message that the toast will show
    ///   - toastPlace: The place which can be .down or .up
    ///   - backgroundColor: The background color of the toast; defaults to black
    ///   - textColor: The text color of the message; defaults to white
    ///   - timeOut: The amount of seconds for the toast to dismiss if not provided it means that the toast will be sticky (will remain until touched); defaults to nil
    ///   - roundness: How round the toast will be: .none, .low, .mid, .high; defaults to .mid
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


/// This enum classifies the toast in places
///
/// - up: To display the toast in the top centered side of the specified view
/// - down: To display the toast in the down centered side of the specified view
public enum ToastPlace{
    case up
    case down
}


/// This enum specifies the amount of roundness of the toast
///
/// - none: When the corners of the toast are plain straight with 0 roundness
/// - low: When the corners of the toast are a little bit rounded
/// - mid: When the corners of the toast are fairly rounded
/// - high: When the corners of the toast are highly rounded
public enum ToastRoundness: CGFloat{
    case none = 1
    case low = 20
    case mid = 10
    case high = 8
    
}
