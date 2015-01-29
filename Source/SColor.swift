// Copyright (c) 2015 Benoit Layer
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

// Because I can't force anyone to use the 'Color' type, this us only used internally.
#if os(iOS)
    import UIKit
    typealias Color = UIColor
    #else
    import AppKit
    typealias Color = NSColor
#endif

// Internal struct to keep a tuple of color and its step (could have used tuple, but better readability here).
internal struct ColorStep {
    let color: Color
    let step: CGFloat
    
    init(color: Color, step: CGFloat) {
        self.color = color
        self.step = step
    }
}

public class SColor {
    
    private var stepColorMap: Dictionary<CGFloat, Color> = [:]
    
#if os(iOS)
    public convenience init(colors: [UIColor], steps: [CGFloat]? = nil) {
        self.init(colors: colors, steps)
    }
    
    public convenience init(colors: UIColor...) {
        self.init(colors: colors, nil)
    }
    
    public func colorForStep(step: CGFloat) -> UIColor {
        return colorForStep(step: step)
    }
#else
    public convenience init(colors: [NSColor], steps: [CGFloat]? = nil) {
        self.init(colors: colors, steps)
    }
    
    public convenience init(colors: NSColor...) {
        self.init(colors: colors, nil)
    }
    
    public func colorForStep(step: CGFloat) -> NSColor {
        return colorForStep(step: step)
    }
#endif
    
    private convenience init(colors: [Color], _ steps: [CGFloat]? = nil)
    {
        var stepColors: [ColorStep] = []
        assert(colors.count > 0, "You must provide at least one color.")
        if let unwrappedSteps = steps {
            assert(unwrappedSteps.count == colors.count, "You must provide the same numbers of colors and steps.")
            
            for (index, color) in enumerate(colors) {
                stepColors.append((ColorStep(color: color, step: unwrappedSteps[index])))
            }
        } else {
            // Create default steps
            for (index, color) in enumerate(colors) {
                stepColors.append((ColorStep(color: color, step: CGFloat(index)/CGFloat(colors.count))))
            }
        }
        self.init(colors: stepColors)
    }
    
    private init(colors: [ColorStep]) {
        for colorStep in colors {
            stepColorMap[colorStep.step] = colorStep.color
        }
    }
    
    private func colorForStep(#step: CGFloat) -> Color {
        var step = min(1, max(0, step))
        
        var previousColor: ColorStep!
        var nextColor: ColorStep!
        
        // Enumerate all keys
        let sortedKeys = sorted(stepColorMap.keys, <)
        for (index, key) in enumerate(sortedKeys) {
            if step > key {
                previousColor = ColorStep(color: stepColorMap[key]!, step: key)
                if index+1 < sortedKeys.count {
                    let nextKey = sortedKeys[index+1]
                    nextColor = ColorStep(color: stepColorMap[nextKey]!, step: nextKey)
                }
                break;
            }
        }
        
        // If no previous color, return the first color
        if previousColor == nil {
            return stepColorMap[sortedKeys.first!]!
        }
        
        // If no previous color, take the last color
        if nextColor == nil {
            return stepColorMap[sortedKeys.last!]!
        }
        
        let colorsStepDelta = nextColor.step - previousColor.step
        let wantedColorStepDelta = CGFloat(step) - CGFloat(previousColor.step)
        let stepRatio = CGFloat(wantedColorStepDelta)/CGFloat(colorsStepDelta)
        
        var previousRed = CGFloat(0), previousGreen = CGFloat(0), previousBlue = CGFloat(0), previousAlpha = CGFloat(0)
        previousColor.color.getRed(&previousRed, green: &previousGreen, blue: &previousBlue, alpha: &previousAlpha)
        var nextRed = CGFloat(0), nextGreen = CGFloat(0), nextBlue = CGFloat(0), nextAlpha = CGFloat(0)
        nextColor.color.getRed(&nextRed, green: &nextGreen, blue: &nextBlue, alpha: &nextAlpha)
        
        var retRed = previousRed + (nextRed - previousRed)*stepRatio
        var retGreen = previousGreen + (nextGreen - previousGreen)*stepRatio
        var retBlue = previousBlue + (nextBlue - previousBlue)*stepRatio
        var retAlpha = previousAlpha + (nextAlpha - previousAlpha)*stepRatio
        
        return Color(red: retRed, green: retGreen, blue: retBlue, alpha: retAlpha)
    }
}

