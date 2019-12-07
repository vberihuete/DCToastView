//
//  ToastMessage.swift
//  ToastView
//
//  Created by Vincent Berihuete on 11/17/18.
//  Copyright © 2018 devcorerd. All rights reserved.
//

import UIKit

class ToastMessage: UIView {
    
    
    private let container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .center
        container.distribution = .fill
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var messageLabel: UITextView = {
        let messageLabel = UITextView()
        messageLabel.font = .systemFont(ofSize: 17)
        messageLabel.textColor = .white
        messageLabel.isEditable = false
        messageLabel.isScrollEnabled = false
        messageLabel.isSelectable = !swipeDismiss
        messageLabel.isUserInteractionEnabled = swipeDismiss
        messageLabel.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        messageLabel.layer.borderWidth = 2
        messageLabel.textAlignment = .justified
        return messageLabel
    }()
    
    
    var color = UIColor.black
    var textColor = UIColor.white
    var message: String?
    var timeOut: Double?
    var toastPlace: ToastPlace = .down
    var roundness: ToastRoundness = .mid
    
    
    private var swipeDismiss = true
    
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
        ///inflate view
        container.addArrangedSubview(messageLabel)
        addSubview(container)
        setupConstraints()
        ///set
        messageLabel.text = message
        messageLabel.textColor = textColor
        messageLabel.backgroundColor = color
        messageLabel.layer.borderColor = color.cgColor
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(messageSwipe(gesture:)))
        swipeGesture.direction = .down
        messageLabel.addGestureRecognizer(swipeGesture)
        
        guard let timeOut = self.timeOut else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeOut) { [weak self] in
            guard self != nil else {
                return
            }
            ToastPresenter.shared.remove()
        }
        
    }
    
    private func setupConstraints() {
        container.anchor(to: self)
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
        //        setupConstraints()
        guard roundness != .none else {
            return
        }
        messageLabel.clipsToBounds = true
        messageLabel.layer.cornerRadius = ((frame.height + frame.width) / 2) / roundness.rawValue
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
    
    /// To react on message swipe
    /// - Parameter gesture: The gesture
    @objc private func messageSwipe(gesture: UISwipeGestureRecognizer) {
        guard swipeDismiss else { return }
        switch gesture.direction {
        case .down, .up:
            ToastPresenter.shared.remove()
        default: ()
        }
    }
}

private extension UIView {
    
    /// Anchors the current view to the given one using the given spacing
    /// - Parameters:
    ///   - to: The view to anchor to
    ///   - spacing: The spacing to be used
    func anchor(to view: UIView, spacing: CGFloat = 0) {
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: spacing).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: spacing).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: spacing).isActive = true
    }
}
