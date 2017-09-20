//
//  BackgroundColorProvider.swift
//  Factoids
//
//  Created by Thomas Le on 8/31/17.
//  Copyright © 2017 Thomas Le. All rights reserved.
//

import GameKit
import ChameleonFramework

struct BackgroundColorProvider {
    let colors = [
        // divide by 255.0 to get floating pt number
        UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), //teal color
        UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), //yellow color
        UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0), //red color
        UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), //orange color
        UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), //dark color
        UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), //purple color
        UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0), //green color
        UIColor(red: 173/255, green: 116/255, blue: 201/255, alpha: 1.0), // purple
        UIColor(red: 90/255, green: 155/255, blue: 144/255, alpha: 1.0),
        UIColor(red: 255/255, green: 206/255, blue: 147/255, alpha: 1.0), /* #ffce93 */
        UIColor(red: 178/255, green: 103/255, blue: 124/255, alpha: 1.0),
        UIColor(red: 255/255, green: 147/255, blue: 149/255, alpha: 1.0),
        UIColor(red: 147/255, green: 224/255, blue: 255/255, alpha: 1.0),
        UIColor(red: 136/255, green: 232/255, blue: 134/255, alpha: 1.0),
        UIColor(red: 252/255, green: 146/255, blue: 194/255, alpha: 1.0),
        UIColor(red: 153/255, green: 216/255, blue: 125/255, alpha: 1.0),
        UIColor(red: 234/255, green: 181/255, blue: 46/255, alpha: 1.0),
        UIColor(red: 96/255, green: 193/255, blue: 190/255, alpha: 1.0),
        UIColor(red: 219/255, green: 219/255, blue: 109/255, alpha: 1.0),
        UIColor(red: 173/255, green: 137/255, blue: 86/255, alpha: 1.0),
        UIColor(red: 204/255, green: 229/255, blue: 114/255, alpha: 1.0),
        UIColor.flatRed(),
        UIColor.flatBlue(),
        UIColor.flatOrange(),
        UIColor.flatYellow(),
        UIColor.flatNavyBlue(),
        UIColor.flatMagenta(),
        UIColor.flatTeal(),
        UIColor.flatSkyBlue(),
        UIColor.flatGreen(),
        UIColor.flatMint(),
        UIColor.flatGray(),
        UIColor.flatForestGreen(),
        UIColor.flatPurple(),
        UIColor.flatBrown(),
        UIColor.flatPlum(),
        UIColor.flatWatermelon(),
        UIColor.flatLime(),
        UIColor.flatPink(),
        UIColor.flatMaroon(),
        UIColor.flatCoffee(),
        UIColor.flatPowderBlue(),
        UIColor.flatRedColorDark(),
        UIColor.flatBlueColorDark(),
        UIColor.flatOrangeColorDark(),
        UIColor.flatYellowColorDark(),
        UIColor.flatNavyBlueColorDark(),
        UIColor.flatMagentaColorDark(),
        UIColor.flatTealColorDark(),
        UIColor.flatSkyBlueColorDark(),
        UIColor.flatGreenColorDark(),
        UIColor.flatMintColorDark(),
        UIColor.flatGrayColorDark(),
        UIColor.flatForestGreenColorDark(),
        UIColor.flatPurpleColorDark(),
        UIColor.flatBrownColorDark(),
        UIColor.flatPlumColorDark(),
        UIColor.flatWatermelonColorDark(),
        UIColor.flatLimeColorDark(),
        UIColor.flatPinkColorDark(),
        UIColor.flatMaroonColorDark(),
        UIColor.flatCoffeeColorDark(),
        UIColor.flatPowderBlueColorDark()
    ]
    
    func randomColors() -> UIColor {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: colors.count)
        return colors[randomNumber]!
    }
}
