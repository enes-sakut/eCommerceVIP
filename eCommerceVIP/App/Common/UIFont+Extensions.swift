//
//  UIFont+Extensions.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 17.04.2023.
//

import UIKit

extension UIFont {
    
    public static var latoBold10: UIFont { get { return font("Lato-Bold", size: 10) } }
    public static var latoBold12: UIFont { get { return font("Lato-Bold", size: 12) } }
    public static var latoBold14: UIFont { get { return font("Lato-Bold", size: 14) } }
    public static var latoBold16: UIFont { get { return font("Lato-Bold", size: 16) } }
    public static var latoBold18: UIFont { get { return font("Lato-Bold", size: 18) } }
    public static var latoBold20: UIFont { get { return font("Lato-Bold", size: 20) } }
    
    public static var latoHairline10: UIFont { get { return font("Lato-Hairline", size: 10) } }
    public static var latoHairline12: UIFont { get { return font("Lato-Hairline", size: 12) } }
    public static var latoHairline14: UIFont { get { return font("Lato-Hairline", size: 14) } }
    public static var latoHairline16: UIFont { get { return font("Lato-Hairline", size: 16) } }
    public static var latoHairline18: UIFont { get { return font("Lato-Hairline", size: 18) } }
    public static var latoHairline20: UIFont { get { return font("Lato-Hairline", size: 20) } }
    
    public static var latoLight10: UIFont { get { return font("Lato-Light", size: 10) } }
    public static var latoLight12: UIFont { get { return font("Lato-Light", size: 12) } }
    public static var latoLight14: UIFont { get { return font("Lato-Light", size: 14) } }
    public static var latoLight16: UIFont { get { return font("Lato-Light", size: 16) } }
    public static var latoLight18: UIFont { get { return font("Lato-Light", size: 18) } }
    public static var latoLight20: UIFont { get { return font("Lato-Light", size: 20) } }
    
    public static var latoMedium10: UIFont { get { return font("Lato-Medium", size: 10) } }
    public static var latoMedium12: UIFont { get { return font("Lato-Medium", size: 12) } }
    public static var latoMedium14: UIFont { get { return font("Lato-Medium", size: 14) } }
    public static var latoMedium16: UIFont { get { return font("Lato-Medium", size: 16) } }
    public static var latoMedium18: UIFont { get { return font("Lato-Medium", size: 18) } }
    public static var latoMedium20: UIFont { get { return font("Lato-Medium", size: 20) } }
    
    public static var latoRegular10: UIFont { get { return font("Lato-Regular", size: 10) } }
    public static var latoRegular12: UIFont { get { return font("Lato-Regular", size: 12) } }
    public static var latoRegular14: UIFont { get { return font("Lato-Regular", size: 14) } }
    public static var latoRegular16: UIFont { get { return font("Lato-Regular", size: 16) } }
    public static var latoRegular18: UIFont { get { return font("Lato-Regular", size: 18) } }
    public static var latoRegular20: UIFont { get { return font("Lato-Regular", size: 20) } }
    
    public static var latoSemiBold10: UIFont { get { return font("Lato-Semibold", size: 10) } }
    public static var latoSemiBold12: UIFont { get { return font("Lato-Semibold", size: 12) } }
    public static var latoSemiBold14: UIFont { get { return font("Lato-Semibold", size: 14) } }
    public static var latoSemiBold16: UIFont { get { return font("Lato-SemiBold", size: 16) } }
    public static var latoSemiBold18: UIFont { get { return font("Lato-SemiBold", size: 18) } }
    public static var latoSemiBold20: UIFont { get { return font("Lato-SemiBold", size: 20) } }
    public static var latoSemiBold22: UIFont { get { return font("Lato-SemiBold", size: 22) } }
    public static var latoSemiBold24: UIFont { get { return font("Lato-SemiBold", size: 24) } }
    
    public static var latoThin10: UIFont { get { return font("Lato-Thin", size: 10) } }
    public static var latoThin12: UIFont { get { return font("Lato-Thin", size: 12) } }
    public static var latoThin14: UIFont { get { return font("Lato-Thin", size: 14) } }
    public static var latoThin16: UIFont { get { return font("Lato-Thin", size: 16) } }
    public static var latoThin18: UIFont { get { return font("Lato-Thin", size: 18) } }
    public static var latoThin20: UIFont { get { return font("Lato-Thin", size: 20) } }

    fileprivate class func font(_ name: String, size: CGFloat) -> UIFont {
        if let font = UIFont(name: name, size: size) { return font }
        fatalError("Font with name \(name) not found in project configration.")
    }
    
}
