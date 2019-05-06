//
//  String++.swift
//  SwiftPusher
//
//  Created by Abdullah Selek on 06/05/2019.
//  Copyright © 2019 Abdullah Selek. All rights reserved.
//

import Foundation

internal extension StringProtocol {

    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }

}

internal extension String {

    var hexaToDecimal: Int {
        return Int(strtoul(self, nil, 16))
    }

}
