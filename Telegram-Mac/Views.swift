//
//  Views.swift
//  Telegram
//
//  Created by keepcoder on 07/06/2017.
//  Copyright © 2017 Telegram. All rights reserved.
//

import Cocoa
import TGUIKit

class RestrictionWrappedView : View {
    let textView: TextView = TextView()
    let text:String
    required init(frame frameRect: NSRect) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ text:String) {
        self.text = text
        super.init()
        addSubview(textView)
        textView.userInteractionEnabled = false
        updateLocalizationAndTheme()
    }
    
    override func updateLocalizationAndTheme() {
        self.backgroundColor = theme.colors.background
        let layout = TextViewLayout(.initialize(string: text, color: theme.colors.grayText, font: .normal(.text)), maximumNumberOfLines: 2, alignment: .center)
        textView.update(layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        super.layout()
        textView.layout?.measure(width: frame.width - 40)
        textView.update(textView.layout)
        textView.center()
    }
}

class VideoDurationView : View {
    private var textNode:(TextNodeLayout, TextNode)
    init(_ textNode:(TextNodeLayout, TextNode)) {
        self.textNode = textNode
        super.init()
        self.backgroundColor = .clear
    }
    
    func updateNode(_ textNode:(TextNodeLayout, TextNode)) {
        self.textNode = textNode
        needsDisplay = true
    }
    
    override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
    }
    
    func sizeToFit() {
        setFrameSize(textNode.0.size.width + 10, textNode.0.size.height + 6)
        needsDisplay = true
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        
        ctx.setFillColor(NSColor(0x000000, 0.8).cgColor)
        ctx.round(frame.size, 4)
        ctx.fill(bounds)
        
        let f = focus(textNode.0.size)
        textNode.1.draw(f, in: ctx, backingScaleFactor: backingScaleFactor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame frameRect: NSRect) {
        fatalError("init(frame:) has not been implemented")
    }
}
