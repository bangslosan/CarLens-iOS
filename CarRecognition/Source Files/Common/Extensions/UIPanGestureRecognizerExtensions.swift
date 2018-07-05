//
//  UIPanGestureRecognizerExtensions.swift
//  CarRecognition
//


import UIKit

/// Enum describing possible Pan Gesture directions
///
/// - undefined: undefined state
/// - bottomToTop: pan gesture from bottom to top
/// - topToBottom: pan gesture from top to bottom
/// - rightToLeft: pan gesture from right to left
/// - leftToRight: pan gesture from left to right
internal enum UIPanGestureRecognizerDirection {
    case undefined
    case bottomToTop
    case topToBottom
    case rightToLeft
    case leftToRight
}

internal extension UIPanGestureRecognizer {

    /// Holds information about the direction of Pan gesture
    var direction: UIPanGestureRecognizerDirection {
        let velocity = self.velocity(in: view)
        let isVertical = fabs(velocity.y) > fabs(velocity.x)

        let direction: UIPanGestureRecognizerDirection

        if isVertical {
            direction = velocity.y > 0 ? .topToBottom : .bottomToTop
        } else {
            direction = velocity.x > 0 ? .leftToRight : .rightToLeft
        }
        return direction
    }
}
