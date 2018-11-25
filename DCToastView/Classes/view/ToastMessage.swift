//
//  ToastMessage.swift
//  ToastView
//
//  Created by Vincent Berihuete on 11/17/18.
//  Copyright © 2018 devcorerd. All rights reserved.
//

import UIKit

class ToastMessage: UIView {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    var color = UIColor.black
    var textColor = UIColor.white
    var message: String?
    var timeOut: Double?
    var toastPlace: ToastPlace = .down
    var roundness: ToastRoundness = .mid
    
    
    private var touchDismiss = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    init(backgroundColor color: UIColor = .black, message: String, timeOut: Double? = nil, textColor: UIColor, roundness: ToastRoundness = .mid) {
        super.init(frame: CGRect.zero)
        self.color = color
        self.message = message
        self.timeOut = timeOut
        self.textColor = textColor
        self.roundness = roundness
        setup()
    }
    
    
    /// Setups the view
    func setup(){
        //inflate view
        let bundle = Bundle(for: self.classForCoder)
        bundle.loadNibNamed(String(describing: type(of: self)), owner: self)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //set
        contentView.backgroundColor = color
        messageLabel.text = message
        messageLabel.textColor = textColor
        
        if let timeOut = self.timeOut{
            DispatchQueue.main.asyncAfter(deadline: .now() + timeOut) { [weak self] in
                guard self != nil else {
                    return
                }
                ToastPresenter.shared.remove()
            }
        }
    }
    
    /// Dismiss the current toast message
    ///
    /// - Parameters:
    ///   - animated: whether this will be dismissed animated or not
    ///   - handler: provided once the view has been removed
    func dismiss(animated: Bool = true, completionHandler handler:  @escaping () -> () = { }){
        self.isUserInteractionEnabled = false
        UIView.animate(withDuration: animated ? 0.2 : 0, animations: {
            self.alpha = 0
            self.center.y += 10
        }, completion: { (_) in
            self.isUserInteractionEnabled = true
            handler()
            self.removeFromSuperview()
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard roundness != .none else {
            return
        }
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = contentView.frame.height / roundness.rawValue
    }
    
    /// Assigns auto layout anchor constraints with the given parameters based on the toast place
    ///
    /// - Parameters:
    ///   - view: The view to constraint against
    ///   - toastPlace: the place where the toast is being constrained
    ///   - size: the size of the desired constraints
    func constraint(in view: UIView, place toastPlace: ToastPlace){
        let distance: CGFloat = 60
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.safeAreaInsets.left + 10).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (view.safeAreaInsets.right + 10) * -1).isActive = true
        self.toastPlace = toastPlace
        if toastPlace == .down{
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (view.safeAreaInsets.bottom + distance) * -1).isActive = true
        }else if toastPlace == .up{
            topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + distance).isActive = true
        }
    }
    
    /// Touches began function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchDismiss else{
            return
        }
        ToastPresenter.shared.remove()
    }
}
