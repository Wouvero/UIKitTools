//
//
//
// Created by: Patrik Drab on 19/12/2024
// Copyright (c) 2024 CarExpenseCalculator 
//
//         

import UIKit

/// randomRGB
/// fromRGB
/// fromHSB
/// fromHex
@available(iOS 11.0, *)
extension UIColor {
    /// Creates a UIColor object with random red, green, and blue components in the range 0.0 to 1.0.
    /// If `includeAlpha` is true, a random alpha (transparency) value is also generated; otherwise, the alpha defaults to 1.0 (fully opaque).
    ///
    /// - Parameters:
    ///   - includeAlpha: A Boolean indicating whether to include a random alpha value. Defaults to `false`.
    /// - Returns: A UIColor object with randomized RGB components and optional transparency.
    ///
    /// - Example:
    ///   ```swift
    ///   let opaqueColor = UIColor.randomRGB() // Fully opaque random color
    ///   let transparentColor = UIColor.randomRGB(includeAlpha: true) // Random color with transparency
    ///   ```
    public static func randomRGB(includeAlpha: Bool = false) -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: includeAlpha ? .random(in: 0...1) : 1
        )
    }
    
    /// Creates a UIColor object from RGB values in the range 0 to 255.
    /// The input values for `red`, `green`, and `blue` are normalized to the 0.0 to 1.0 range required by UIColor.
    /// The optional `alpha` parameter defaults to 1.0 (fully opaque).
    ///
    /// - Parameters:
    ///   - red: The red component, ranging from 0 to 255.
    ///   - green: The green component, ranging from 0 to 255.
    ///   - blue: The blue component, ranging from 0 to 255.
    ///   - alpha: The alpha (transparency) value, ranging from 0.0 to 1.0. Defaults to 1.0.
    /// - Returns: A UIColor object with the specified color and transparency.
    ///
    /// - Example:
    ///   ```swift
    ///   let color = UIColor.fromRGB(red: 255, green: 128, blue: 64) // Fully opaque orange
    ///   let semiTransparentColor = UIColor.fromRGB(red: 50, green: 100, blue: 150, alpha: 0.5) // Semi-transparent blue
    ///   ```
    public static func fromRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: red / 255.0,
            green: green / 255.0,
            blue: blue / 255.0,
            alpha: alpha
        )
    }
    
    
    /// Creates a UIColor object from HSB (Hue, Saturation, Brightness) values in the range 0.0 to 1.0.
    /// The optional `alpha` parameter controls the transparency and defaults to 1.0 (fully opaque).
    ///
    /// - Parameters:
    ///   - hue: The hue value, representing the color on the color wheel, ranging from 0.0 to 1.0.
    ///   - saturation: The saturation value, representing the intensity of the color, ranging from 0.0 to 1.0.
    ///   - brightness: The brightness value, representing the lightness of the color, ranging from 0.0 to 1.0.
    ///   - alpha: The alpha (transparency) value, ranging from 0.0 (fully transparent) to 1.0 (fully opaque). Defaults to 1.0.
    /// - Returns: A UIColor object with the specified hue, saturation, brightness, and transparency.
    ///
    /// - Example:
    ///   ```swift
    ///   let vibrantColor = UIColor.fromHSB(H: 0.5, S: 0.8, B: 0.9) // Bright blue-green
    ///   let mutedTransparentColor = UIColor.fromHSB(H: 0.2, S: 0.5, B: 0.4, alpha: 0.3) // Transparent olive-green
    ///   ```
    public static func fromHSB(H hue: CGFloat, S saturation: CGFloat, B brightness: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: alpha
        )
    }
    
    /// Creates a UIColor object from a hexadecimal color string.
    /// The string can optionally start with a `#` and must be exactly 6 characters long (e.g., `#RRGGBB` or `RRGGBB`).
    /// The optional `alpha` parameter specifies the transparency and defaults to 1.0 (fully opaque).
    ///
    /// - Parameters:
    ///   - hex: A string representing the hexadecimal color value (e.g., `#FF5733` or `FF5733`).
    ///   - alpha: The alpha (transparency) value, ranging from 0.0 (fully transparent) to 1.0 (fully opaque). Defaults to 1.0.
    /// - Returns: A UIColor object with the specified color and transparency, or `nil` if the input string is invalid.
    ///
    /// - Example:
    ///   ```swift
    ///   let color = UIColor.fromHex("#FF5733") // Bright orange
    ///   let semiTransparentColor = UIColor.fromHex("4287f5", alpha: 0.5) // Semi-transparent blue
    ///   let invalidColor = UIColor.fromHex("FFF") // Returns nil (invalid input)
    ///   ```
    public static func fromHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        // Ensure the string is valid
        guard hexSanitized.count == 6 else { return nil }
        
        // Convert hex string to RGB components
        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
