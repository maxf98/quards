//
//  DrawingView.swift
//  Quards
//
//  Created by Max Fest on 05.08.20.
//

import SwiftUI
import PencilKit

struct DrawingViewRepresentation: UIViewRepresentable {
	
	@Binding var drawing: PKDrawing
	@Binding var scaleFactor: CGFloat
	var toolPicker: PKToolPicker
	
	func makeUIView(context: Context) -> PKCanvasView {
		let view = PKCanvasView()
		view.drawing = drawing
		view.tool = toolPicker.selectedTool
		
		view.isOpaque = false
		view.backgroundColor = .clear
		view.delegate = context.coordinator
				
		view.minimumZoomScale = 1.0
		view.maximumZoomScale = 3.0
		view.contentSize = CGSize(width: 832, height: 1500)
		
		toolPicker.setVisible(true, forFirstResponder: view)
		toolPicker.addObserver(view)
		view.becomeFirstResponder()
				
		return view
	}
	
	func updateUIView(_ view: PKCanvasView, context: Context) {
		view.tool = toolPicker.selectedTool
	}
	
	static func dismantleUIView(_ uiView: PKCanvasView, coordinator: Coordinator) {
		coordinator.toolPicker.setVisible(false, forFirstResponder: uiView)
	}
	
	class Coordinator: NSObject, PKCanvasViewDelegate {
		@Binding var drawing: PKDrawing
		@Binding var scaleFactor: CGFloat
		var toolPicker: PKToolPicker
		
		init(drawing: Binding<PKDrawing>, scaleFactor: Binding<CGFloat>, toolPicker: PKToolPicker) {
			_drawing = drawing
			_scaleFactor = scaleFactor
			self.toolPicker = toolPicker
		}
		
		func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
			self.drawing = canvasView.drawing
		}
		
		func viewForZooming(in scrollView: UIScrollView) -> UIView? {
			return scrollView as! PKCanvasView
		}
		
		func scrollViewDidZoom(_ scrollView: UIScrollView) {
			scaleFactor = scrollView.zoomScale
		}
	}
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(drawing: $drawing, scaleFactor: $scaleFactor, toolPicker: toolPicker)
	}
	
}



