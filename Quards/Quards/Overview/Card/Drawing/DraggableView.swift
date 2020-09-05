//
//  DraggableView.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import SwiftUI

enum DragState {
	case inactive
	case pressing
	case dragging(translation: CGSize)
	
	var translation: CGSize {
		switch self {
		case .inactive, .pressing:
			return .zero
		case .dragging(let translation):
			return translation
		}
	}
	
	var isPressing: Bool {
		switch self {
		case .pressing, .dragging:
			return true
		case .inactive:
			return false
		}
	}
}

struct DraggableView<Content>: View where Content: View {
	@GestureState private var dragState = DragState.inactive
	@State private var position = CGSize.zero
	
	@Binding var offset: CGFloat
	
	var content: () -> Content
	
	var body: some View {
		content()
			.opacity(dragState.isPressing ? 0.5 : 1.0)
			.offset(y: position.height + dragState.translation.height)
			.animation(.easeInOut)
			.gesture(
				LongPressGesture(minimumDuration: 0.3)
					.sequenced(before: DragGesture())
					.updating($dragState, body: { (value, state, transaction) in
						
						switch value {
						case .first(true):
							state = .pressing
						case .second(true, let drag):
							state = .dragging(translation: drag?.translation ?? .zero)
						default:
							break
						}
						
					})
					.onEnded({ (value) in
						print("drag ended")
						guard case .second(true, let drag?) = value else {
							return
						}
						
						self.position.height += drag.translation.height
						self.offset += self.position.height
						self.position.height = 0
					})
			)
	}
}

struct DraggableView_Previews: PreviewProvider {
	static var previews: some View {
		DraggableView(offset: .constant(0)) {
			Text("Swift")
				.font(.system(size: 50, weight: .bold, design: .rounded))
				.bold()
				.foregroundColor(.red)
		}
	}
}
