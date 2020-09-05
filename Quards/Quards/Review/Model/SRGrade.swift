//
//  SMGrade.swift
//  Quards
//
//  Created by Max Fest on 29.08.20.
//

import Foundation
import SwiftUI

public enum SRGrade: Int, CustomStringConvertible, CaseIterable {
	case bad
	case fail
	case pass
	case good
	case bright
	
	public var intervalMultiplier: Double {
		switch self {
		case .bad:
			return 0.5
		case .fail:
			return 0.666
		case .pass:
			return 1
		case .good:
			return 1.5
		case .bright:
			return 2
		}
	}
	
	public var color: Color {
		switch self {
		case .bad:
			return Color.red
		case .fail:
			return Color.orange
		case .pass:
			return Color.yellow
		case .good:
			return Color.green.opacity(0.5)
		case .bright:
			return Color.green
		}
	}
	
	public var description: String {
		switch self {
		case .bad:
			return "incorrect response; the correct one remembered"
		case .fail:
			return "incorrect response; where the correct one seemed easy to recall"
		case .pass:
			return "correct response recalled with serious difficulty"
		case .good:
			return "correct response after a hesitation"
		case .bright:
			return "perfect response"
		}
	}
}
