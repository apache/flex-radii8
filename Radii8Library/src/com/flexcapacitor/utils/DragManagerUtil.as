////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////


package com.flexcapacitor.utils {
	import com.flexcapacitor.controller.Radiate;
	import com.flexcapacitor.events.DragDropEvent;
	import com.flexcapacitor.model.IDocument;
	import com.flexcapacitor.utils.supportClasses.ComponentDescription;
	import com.flexcapacitor.utils.supportClasses.DragData;
	import com.flexcapacitor.utils.supportClasses.TargetSelectionGroup;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.core.BitmapAsset;
	import mx.core.DragSource;
	import mx.core.FlexGlobals;
	import mx.core.FlexSprite;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.utils.NameUtil;
	
	import spark.components.Application;
	import spark.components.Image;
	import spark.components.SkinnableContainer;
	import spark.components.supportClasses.GroupBase;
	import spark.components.supportClasses.ItemRenderer;
	import spark.components.supportClasses.Skin;
	import spark.layouts.BasicLayout;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.TileLayout;
	import spark.layouts.VerticalLayout;
	import spark.layouts.supportClasses.DropLocation;
	import spark.layouts.supportClasses.LayoutBase;
	import spark.skins.spark.ApplicationSkin;
	import spark.skins.spark.ListDropIndicator;

	/**
	 * Drag over 
	 * */
	[Event(name="dragOver", type="com.flexcapacitor.radiate.events.DragDropEvent")]

	/**
	 * Drop event 
	 * */
	[Event(name="dragDrop", type="com.flexcapacitor.radiate.events.DragDropEvent")]

	/**
	 * Drop complete event 
	 * */
	[Event(name="dragDropComplete", type="com.flexcapacitor.radiate.events.DragDropEvent")]
	
	/**
	 * Enables drag and drop of UIComponent. 
	 * I don't know if this has a drag cancel event. 
	 * That is, if you don't find a place to drop then what happens? 
	 * Could listen for stage mouse up or mouse up outside. 
	 * */
	public class DragManagerUtil extends EventDispatcher {
		
		
		public function DragManagerUtil():void {
			
		}
		
		/**
		 * Used during drag and drop to indicate the target destination for the dragged element
		 * */
		public var dropIndicator:IFactory;
		
		/**
		 * The distance of the mouse pointer location from the edge of the dragged element
		 * */
		private var offset:Point = new Point;
		
		[Bindable] 
		public var showSelectionBox:Boolean = true;
		public var showListDropIndicator:Boolean = true;
		public var showMousePositionLines:Boolean = true;
		public var showSelectionBoxOnApplication:Boolean;
		
		public var swfRoot:DisplayObject;
		
		/**
		 * Reference to the document
		 * */
		public var targetApplication:Application;
		
		public var selectionGroup:ItemRenderer = new TargetSelectionGroup();
		public var mouseLocationLines:IFlexDisplayObject = new ListDropIndicator();
		public var lastTargetCandidate:Object;
		public var dropTarget:Object;
		public var groupBase:GroupBase;
		public var dropLayout:LayoutBase;
		
		[Bindable] 
		public var dropTargetName:String;
		
		/**
		 * X and Y location of dragged object
		 * */
		[Bindable] 
		public var dropTargetLocation:String;
		
		public var startingPoint:Point;
		
		public var includeSkins:Boolean;
		public var applicationGroups:Dictionary;
		
		/**
		 * How many pixels the mouse has to move before a drag operation is started
		 * */
		public var dragStartTolerance:int = 5;
		
		public var dragInitiator:IUIComponent;
		private var dropLocation:DropLocation;
		public var dragData:DragData;
		
		
		public var showDropIndicator:Boolean = true;
		private var systemManager:Object;
		private var dragListener:DisplayObjectContainer;
		
		private var targetsUnderPoint:Array;
		public var adjustMouseOffset:Boolean = true;
		public var draggedItem:Object;
		private var topLevelApplication:Application;
		
		
		/**
		 * Sets up a target to listen for drag like behavior. 
		 * There is a little bit of resistance before a drag is started. 
		 * This can be set in the dragStartTolerance
		 * @param dragInitiator the component that will be dragged
		 * @param parentApplication the application of the component being dragged
		 * @param event Mouse event from the mouse down event
		 * @param draggedItem The item or data to be dragged. If null then this is the dragInitiator.
		 * */
		public function listenForDragBehavior(dragInitiator:IUIComponent, document:IDocument, event:MouseEvent, draggedItem:Object = null):void {
			startingPoint = new Point();
			this.dragInitiator = dragInitiator;
			this.targetApplication = Application(document.instance);
			systemManager = targetApplication.systemManager;
			topLevelApplication = Application(FlexGlobals.topLevelApplication);
			
			//componentTree = DisplayObjectUtils.getComponentDisplayList(documentApplication);
			componentTree = document.componentDescription;
			
			// either the component to add or the component to move
			if (arguments[3]) {
				this.draggedItem = draggedItem;
			}
			else {
				this.draggedItem = dragInitiator;
			}
			
			// if selection is offset then check if using system manager sandbox root or top level root
			var systemManager:ISystemManager = ISystemManager(topLevelApplication.systemManager);
			
			// no types so no dependencies
			var marshallPlanSystemManager:Object = systemManager.getImplementation("mx.managers.IMarshallPlanSystemManager");
			var targetCoordinateSpace:DisplayObject;
			
			if (marshallPlanSystemManager && marshallPlanSystemManager.useSWFBridge()) {
				targetCoordinateSpace = Sprite(systemManager.getSandboxRoot());
			}
			else {
				targetCoordinateSpace = Sprite(topLevelApplication);
			}
			
			swfRoot = targetCoordinateSpace;
			
			startingPoint.x = event.stageX;
			startingPoint.y = event.stageY;
			
			
			updateDropTargetLocation(targetApplication, event);
			
			dragInitiator.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			swfRoot.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		/**
		 * Updates the drop target location property with the x and y values of the dragged item.
		 * Format is "XxY", so for example, "100x50".
		 * */
		private function updateDropTargetLocation(rootDisplayObject:DisplayObject, event:MouseEvent):void {
			var mousePoint:Point = new Point(event.stageX, event.stageY);
			var applicationLocationPoint:Point = DisplayObject(rootDisplayObject).localToGlobal(new Point());
			
			//var point2:Point = new Point(-event.stageX, -event.stageY);
			//var newPoint:Point = DisplayObject(rootDisplayObject).localToGlobal(mousePoint);
			//var newPoint1:Point = DisplayObject(rootDisplayObject).localToGlobal(point2);
			
			// this one works 
			//var newPoint3:Point = DisplayObject(rootDisplayObject).globalToLocal(mousePoint);
			//var newPoint4:Point = DisplayObject(rootDisplayObject).globalToLocal(point2);
			
			var newX:Number = mousePoint.x - applicationLocationPoint.x - offset.x;
			var newY:Number = mousePoint.y - applicationLocationPoint.y - offset.y;
			//var newX2:Number = targetApplication.contentMouseX - offset.x;
			//var newY2:Number = targetApplication.contentMouseY - offset.y;
			
			var out:String = newX + "x" + newY;
			// Find the registration point of the owner
	        /*var sandboxRoot:DisplayObject = systemManager.getSandboxRoot();
	        var regPoint:Point = owner.localToGlobal(new Point());
	        regPoint = sandboxRoot.globalToLocal(regPoint);*/
	        //var regPoint:Point = rootDisplayObject.localToGlobal(new Point());
	        //regPoint = rootDisplayObject.globalToLocal(regPoint);
			
			if (dropTargetLocation!=out) {
				dropTargetLocation = out;
			}
		}
		
		/**
		 * Mouse move handler that listens to see if the mouse has moved past the drag tolerance amount.
		 * If the mouse has moved past the drag tolerance then dragging is started.
		 * */
		protected function mouseMoveHandler(event:MouseEvent):void {
			var dragToleranceMet:Boolean;
			dragToleranceMet = Math.abs(startingPoint.x - event.stageX) >= dragStartTolerance;
			dragToleranceMet = !dragToleranceMet ? Math.abs(startingPoint.y - event.stageY)  >= dragStartTolerance: true;
			
			updateDropTargetLocation(targetApplication, event);
			
			if (dragToleranceMet) {
				dragInitiator.visible = hideDragInitiatorOnDrag ? false : true; // hide from view
				removeMouseHandlers(dragInitiator);
				startDrag(dragInitiator, targetApplication, event);
			}
			
		}
		
		/**
		 * Start dragging
		 * */
		public function startDrag(dragInitiator:IUIComponent, application:Application, event:MouseEvent):void {
			var dragSource:DragSource = new DragSource();
			var snapshot:BitmapAsset;

			this.dragInitiator = dragInitiator;
			this.targetApplication = application;
			this.systemManager = application.systemManager;
			
			// set the object that will listen for drag events
			dragListener = DisplayObjectContainer(application);
			
			distanceFromLeft = dragInitiator.localToGlobal(new Point).x;
			distanceFromTop = dragInitiator.localToGlobal(new Point).y;
			
			// TODO = READ 
			// Flex coordinate systems
			// http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf69084-7de0.html
			var scale:Number = application.scaleX;
			
			// store distance of mouse point to top left of display object
			if (scale!=1 && !isNaN(scale)) {
				offset.x = event.stageX - distanceFromLeft;// * scale;
				offset.y = event.stageY - distanceFromTop;// * scale;
			}
			else {
				offset.x = event.stageX - distanceFromLeft;
				offset.y = event.stageY - distanceFromTop;
			}
			
			updateDropTargetLocation(targetApplication, event);
			
			addGroupListeners(application);
			addDragListeners(dragInitiator, dragListener);
			
			// creates an instance of the bounding box that will be shown around the drop target
			if (!selectionGroup) {
				selectionGroup = new TargetSelectionGroup();
				selectionGroup.mouseEnabled = false;
				selectionGroup.mouseChildren = false;
			}
			
			// show selection / bounding box 
			if (showSelectionBox) {
				// RangeError: Error #2006: The supplied index is out of bounds.
				PopUpManager.addPopUp(selectionGroup, swfRoot);
				selectionGroup.visible = false;
				selectionGroup.addEventListener(DragEvent.DRAG_OVER, dragOverHandler);
			}
			
			// show mouse location lines
			if (showListDropIndicator && mouseLocationLines) {
				PopUpManager.addPopUp(mouseLocationLines, swfRoot);
				mouseLocationLines.visible = false;
			}
			
			// SecurityError: Error #2123: Security sandbox violation: 
			//BitmapData.draw: http://www.radii8.com/debug-build/RadiateExample.swf cannot access http://www.google.com/intl/en_com/images/srpr/logo3w.png. No policy files granted access.
			if (dragInitiator is Image && !Image(dragInitiator).trustedSource) {
				snapshot = null;
			}
			else {
				snapshot = DisplayObjectUtils.getBitmapAssetSnapshot2(dragInitiator as DisplayObject);
				//snapshot = DisplayObjectUtils.getSpriteSnapshot(dragInitiator as DisplayObject);
			}
			
			if (addDropShadow) {
				snapshot.filters = [dropShadowFilter];
			}
			
			dragSource.addData(draggedItem, "UIComponent");
			
			if (setDragManagerOffset) {
				DragManager.doDrag(dragInitiator, dragSource, event, snapshot, -offset.x, -offset.y, 1);
			}
			else {
				DragManager.doDrag(dragInitiator, dragSource, event, snapshot, 0, 0, 1);
			}
			
			
		}
		
		private function dragEnterHandler(event:DragEvent):void {
			DragManager.acceptDragDrop(event.target as IUIComponent);
			//trace("Drag Enter:" + event.target);
		}
		
		protected function dragExitHandler(event:DragEvent):void {
			//trace("Drag Exit:" + event.target);
		}
		
		/**
		 * Dispatched during a drag over event. Dispatched multiple times. 
		 * */
		protected function dragOverHandler(event:DragEvent):void {
			var eventTarget:FlexSprite = FlexSprite(event.target);
			var description:ComponentDescription;
			var topLeftEdgePoint:Point;
			var rectangle:Rectangle;
			var isHorizontal:Boolean;
			var isApplication:Boolean;
			var isVertical:Boolean;
			var isBasic:Boolean;
			var isTile:Boolean;
			var target:Object;
			var length:int;
			
			
			/*
			// get targets under mouse pointer
			if (adjustMouseOffset) {
				topLeftEdgePoint = new Point(event.stageX-offset.x, event.stageY-offset.y);
			}
			else {
				topLeftEdgePoint = new Point(event.stageX, event.stageY);
			}
			
			// get items under point
			targetsUnderPoint = topLevelApplication.getObjectsUnderPoint(topLeftEdgePoint);
			length = targetsUnderPoint.length;

			// start from highest component and go back to application
			targetsUnderPoint = targetsUnderPoint.reverse();
			
			// update location properties
			updateDropTargetLocation(event.stageX, event.stageY);
			
			if (target is mx.containers.GridItem) {
				trace("break");
			}
			
			////////////////////////////////////////////////////////////
			// find drop target
			////////////////////////////////////////////////////////////
			
			componentTreeLoop:
			
			// loop through items under point until we find one on the *component* tree
			for (var i:int;i<length;i++) {
				target = targetsUnderPoint[i];
				
				if (!parentApplication.contains(DisplayObject(target))) {
					continue;
				}
				
				// check if target is self
				if (target==draggedItem) {
					continue;
				}
				
				// check if target is child of self
				if ("contains" in draggedItem && draggedItem.contains(target)) {
					continue;
				}
				
				// as soon as we find a visual element we can find the owner
				if (target is IVisualElement) {
					description = DisplayObjectUtils.getVisualElementContainerFromElement(IVisualElement(target), componentTree);
					
					if (description) {
						target = description.instance;
						break;
					}
				}
			}
			
			
			// check if target is self
			if (target==draggedItem) {
				target = parentApplication;
				Radiate.log.info("Cannot drag onto self");
				return;
				//continue;
			}
			
			// check if target is child of self
			if ("contains" in draggedItem && target && 
				draggedItem.contains(target)) {
				Radiate.log.info("Cannot drag into child of self");
				return;
			}
			
			// this shouldn't be here but if document is not set then we get all sorts of targets
			if (target && target != parentApplication && !parentApplication.contains(DisplayObject(target))) {
				return;
			}
			
			// check if target is a group
			if (target is GroupBase) {
				targetGroup = target as GroupBase;
				
				// skip skins
				if (target is Skin && !includeSkins) {
					//throw new Error("target cannot be a skin");
					target = parentApplication;
				}
					
				// skip skins (for groups in checkbox skin for example)
				if ("owner" in target && target.owner is Skin && !includeSkins) {
					//continue;
					target = parentApplication;
				}
				
				// we found a group
				dropTarget = target;
				
				// check the type
				if (targetGroup) {
					targetGroupLayout = targetGroup.layout;
					
					// reset group layout values
					isTile = isVertical = isHorizontal = false;
					
					if (targetGroupLayout is HorizontalLayout) {
						isHorizontal = true;
					}
					else if (targetGroupLayout is VerticalLayout) {
						isVertical = true;
					}
					else if (targetGroupLayout is TileLayout) {
						isTile = true;
					}
				}
			}
			*/
			
			dragData = findDropTarget(event, true, targetApplication.scaleX);
			
			if (dragData==null) return;
			
			
			dropTarget = dragData.target;
			isApplication = dragData.isApplication;
			isTile = dragData.isTile;
			isVertical = dragData.isVertical;
			isBasic = dragData.isBasicLayout;
			isHorizontal = dragData.isHorizontal;
			dropLocation = dragData.dropLocation;
			dropLayout = dragData.layout;
			
			////////////////////////////////////////////////////////////
			// show selection box
			////////////////////////////////////////////////////////////
			if (showSelectionBox) {
				
				// get bounds
				if (!dropTarget || 
					(isApplication && !showSelectionBoxOnApplication)) {
					
					// set values to zero
					if (!rectangle) {
						rectangle = new Rectangle();
					}
					
					// hide selection group
					if (selectionGroup.visible) {
						selectionGroup.visible = false;
					}
				}
				else {
					
					// draw the selection rectangle only if it's changed
					//if (lastTargetCandidate!=dropTarget) {
						
						// if selection is offset then check if using system manager sandbox root or top level root
						var systemManager:ISystemManager = ISystemManager(topLevelApplication.systemManager);
						
						// no types so no dependencies
						var marshallPlanSystemManager:Object = systemManager.getImplementation("mx.managers.IMarshallPlanSystemManager");
						var targetCoordinateSpace:DisplayObject;
						
						if (marshallPlanSystemManager && marshallPlanSystemManager.useSWFBridge()) {
							targetCoordinateSpace = Sprite(systemManager.getSandboxRoot());
						}
						else {
							targetCoordinateSpace = Sprite(topLevelApplication);
						}
						
						// get target bounds
						rectangle = DisplayObject(dropTarget).getBounds(targetCoordinateSpace);
						
						// size and position fill
						selectionGroup.width = rectangle.width;
						selectionGroup.height = rectangle.height;
						selectionGroup.x = rectangle.x;
						selectionGroup.y = rectangle.y;
						
						// show target selection group
						if (!selectionGroup.visible) {
							selectionGroup.visible = true;
						}
						
						selectionGroup.data = dropTarget;
					//}
					
				}
				
			}
			
			
			
			////////////////////////////////////////////////////////////
			// show drop indicator
			////////////////////////////////////////////////////////////
			if (showDropIndicator) {
				
				// remove previous drop indicator
				if (lastTargetCandidate && 
					lastTargetCandidate!=dropTarget && 
					lastTargetCandidate is IVisualElementContainer) {
					
					// hide drop indicator
					lastTargetCandidate.layout.hideDropIndicator();
					
					// Hide focus
					//targetGroup.drawFocus(false);
					//targetGroup.drawFocusAnyway = false;
					
					// Destroy the dropIndicator instance
					destroyDropIndicator();
				}
				
				// if drop indicator is needed
				if (isHorizontal || isVertical || isTile) {
					// get drop indicator location
					//dropLocation = targetGroupLayout.calculateDropLocation(event);
					
					if (dropLocation) {
						//DragManager.acceptDragDrop(parentApplication);
						DragManager.acceptDragDrop(targetApplication);
						
						// Create the dropIndicator instance. The layout will take care of
						// parenting, sizing, positioning and validating the dropIndicator.
						dropLayout.dropIndicator = createDropIndicator();
						
						// Show focus
						//drawFocusAnyway = true;
						//targetGroup.drawFocus(true);
						
						// Notify manager we can drop
						DragManager.showFeedback(event.ctrlKey ? DragManager.COPY : DragManager.MOVE);
						
						// Show drop indicator
						dropLayout.showDropIndicator(dropLocation);
					}
					else {
						// drop location is null
						// hide drop indicator
						DragManager.showFeedback(DragManager.NONE);
						
						// hide drop indicator
						dropLayout.hideDropIndicator();
						
						// Hide focus
						//targetGroup.drawFocus(false);
						//targetGroup.drawFocusAnyway = false;
						
						// Destroy the dropIndicator instance
						destroyDropIndicator();
					}
					
				}
					// target group is basic layout
					// does not need drop indicator
				else if (dropLayout) {
					if (lastTargetCandidate && "layout" in lastTargetCandidate) {
						lastTargetCandidate.layout.hideDropIndicator();
					}
					
					// Hide if previously showing
					dropLayout.hideDropIndicator();
					
					// Hide focus
					//targetGroup.drawFocus(false);
					//targetGroup.drawFocusAnyway = false;
					
					// Destroy the dropIndicator instance
					destroyDropIndicator();
				}
				
			}
			
			// store the last target
			lastTargetCandidate = dropTarget;
			
			dropTargetName = NameUtil.getUnqualifiedClassName(dropTarget);
			
			event.updateAfterEvent();
			
			
			if (hasEventListener(DragDropEvent.DRAG_OVER)) {
				dispatchEvent(new DragDropEvent(DragDropEvent.DRAG_OVER));
			}
			
			
			return;
			
			
			
			
			////////////////////////////////////////////////////////////
			// show mouse lines
			////////////////////////////////////////////////////////////
			/*if (showListDropIndicator) {
				mouseLocationLines.x = topLeftEdgePoint.x;
				mouseLocationLines.y = topLeftEdgePoint.y;
				mouseLocationLines.width = 1;
				mouseLocationLines.height = parentApplication.height;
				
				// show mouse location
				if (!mouseLocationLines.visible) {
					mouseLocationLines.visible = true;
				}
			}
			
			
			// store the last target
			lastTargetCandidate = dropTarget;
			
			dropTargetName = NameUtil.getUnqualifiedClassName(dropTarget);
			
			//trace("target: " + dropTargetName);
			event.updateAfterEvent();*/
		}
		
		
		/**
		 * Find the target under mouse pointer
		 * */
		public function findDropTarget(event:DragEvent, draggingOver:Boolean = true, applicationScale:Number = 1):DragData {
			/*var eventTarget:FlexSprite = FlexSprite(event.target); */
			var visualElementContainer:IVisualElementContainer;
			var skinnableContainer:SkinnableContainer;
			var description:ComponentDescription;
			var isSkinnableContainer:Boolean;
			var topLeftEdgePoint:Point;
			var isApplication:Boolean;
			var isBasicLayout:Boolean;
			var isHorizontal:Boolean;
			var isVertical:Boolean;
			var isGroup:Boolean;
			var isBasic:Boolean;
			var isTile:Boolean;
			var layout:LayoutBase;
			var targetsLength:int;
			var target:Object;
			var debug:Boolean;
			var dropIndex:int;
			var location:DropLocation;
			var offscreen:Boolean;
			
			dragData = new DragData();
			
			// get targets under mouse pointer
			if (adjustMouseOffset) {
				var adjustedX:Number = event.stageX-(offset.x * applicationScale);
				var adjustedY:Number = event.stageY-(offset.y * applicationScale);
				topLeftEdgePoint = new Point(adjustedX, adjustedY);
			}
			else {
				topLeftEdgePoint = new Point(event.stageX, event.stageY);
			}
			
			// get items under point
			targetsUnderPoint = topLevelApplication.getObjectsUnderPoint(topLeftEdgePoint);
			targetsLength = targetsUnderPoint.length;

			// start from highest component and go back to application
			targetsUnderPoint = targetsUnderPoint.reverse();
			
			// update location properties
			updateDropTargetLocation(targetApplication, event);
			
			/*if (target is mx.containers.GridItem) {
				trace("break");
			}*/
			
			////////////////////////////////////////////////////////////
			// find drop target
			////////////////////////////////////////////////////////////
			
			componentTreeLoop:
			
			// loop through items under point until we find one on the *component* tree
			for (var i:int;i<targetsLength;i++) {
				target = targetsUnderPoint[i];
				// if parent application does not contain the target
				if (!targetApplication.contains(DisplayObject(target))) {
					continue;
				}
				
				// check if target is self
				if (target==draggedItem) {
					continue;
				}
				
				// check if target is child of self
				if ("contains" in draggedItem && draggedItem.contains(target)) {
					continue;
				}
				
				// as soon as we find a visual element we can find the owner
				if (target is IVisualElement) {
					description = DisplayObjectUtils.getVisualElementContainerFromElement(IVisualElement(target), componentTree);
					
					if (description) {
						target = description.instance;
						break;
					}
				}
			}
			
			
			// check if target is self
			if (target==draggedItem) {
				target = targetApplication;
				if (debug) Radiate.log.info("Cannot drag onto self");
				if (draggingOver) return null;
				//continue;
			}
			
			// check if target is child of self
			if (target && "contains" in draggedItem && 
				draggedItem.contains(target)) {
				if (debug) Radiate.log.info("Cannot drag into child of self");
				if (draggingOver) return null;
				//return null;
			}
			
			// this shouldn't be here but if document is not set then we get all sorts of targets
			if (target && 
				target != targetApplication && 
				!targetApplication.contains(DisplayObject(target))) {
				if (debug) Radiate.log.info("Target application doesn't contain drop target");
				if (draggingOver) return null;
				//return null;
			}
			
			// still no target then we are on the application (most likely)
			if (!target) {
				target = targetApplication;
			}
			
			if (target==targetApplication) {
				isApplication = true;
			}
			
			// check if target is a group
			if (target is IVisualElementContainer) {
				
				dropIndex = -1;
				
				// skip skins
				if (target is Skin && !includeSkins) {
					//throw new Error("target cannot be a skin");
					target = targetApplication;
				}
				
				// skip skins (for groups in checkbox skin for example)
				if ("owner" in target && target.owner is Skin && !includeSkins) {
					target = targetApplication;
				}
				
				visualElementContainer = target as IVisualElementContainer;
				groupBase = target as GroupBase;
				skinnableContainer = target as SkinnableContainer;
				
				//isGroup = groupBase!=null;
				//isSkinnableContainer = skinnableContainer!=null;
				
				// ReferenceError: Error #1069: Property layout not found on mx.containers.TabNavigator and there is no default value.
				layout = "layout" in target ? target.layout : null;
				
				
				if (!layout) return null;
				// we found a group
				//dropTarget = target;
		
				// TypeError: Error #1009: Cannot access a property or method of a null object reference.
				// get drop indicator location
				location = layout.calculateDropLocation(event);
				
				var stagePoint:Point = new Point(event.stageX, event.stageY);
				offscreen = location.dropPoint.equals(stagePoint);
				
				if (location) {
					dropIndex = location.dropIndex;
				}
				
				// reset group layout values
				isBasic = isTile = isVertical = isHorizontal = false;
				
				// check the type
				//if (targetGroup) {
				//	targetGroupLayout = targetGroup.layout;
				
				if (layout is BasicLayout) {
					isBasic = true;
				}
				else if (layout is HorizontalLayout) {
					isHorizontal = true;
				}
				else if (layout is VerticalLayout) {
					isVertical = true;
				}
				else if (layout is TileLayout) {
					isTile = true;
				}
				//}
			}
			
			dragData.target = target;
			dragData.offscreen = offscreen;
			dragData.dropLocation = location;
			dragData.dropIndex = dropIndex;
			dragData.description = description;
			dragData.isApplication = isApplication;
			dragData.isHorizontal = isHorizontal;
			dragData.isVertical = isVertical;
			dragData.isTile = isTile;
			dragData.isBasicLayout = isBasic;
			dragData.layout = layout;
			dragData.isGroup = groupBase!=null;
			dragData.isSkinnableContainer = skinnableContainer!=null;
			dragData.isVisualElementContainer = visualElementContainer!=null;
			
			return dragData;
		}
		
		
		/**
		 * Drag drop event
		 * */
		protected function dragDropHandler(event:DragEvent):void {
			var targetSkinnableContainer:SkinnableContainer;
			var isVisualElementContainer:Boolean;
			var isSkinnableContainer:Boolean;
			var targetsUnderPoint:Array;
			var dragEvent:DragDropEvent;
			var topLeftEdgePoint:Point;
			var isApplication:Boolean;
			var isBasicLayout:Boolean;
			var isHorizontal:Boolean;
			var isVertical:Boolean;
			var isGroup:Boolean;
			var isTile:Boolean;
			var offscreen:Boolean;
			var dropIndex:int;
			var target:Object;
			var point:Point;
			var length:int;
			
			/*
			target = getContainerUnderPoint(event, parentApplication, true, offset);
			
			// get point from upper left edge of drag proxy
			if (adjustMouseOffset) {
				topLeftEdgePoint = new Point(event.stageX-offset.x, event.stageY-offset.y);
			}
			else {
				topLeftEdgePoint = new Point(event.stageX, event.stageY);
			}
			
			// get items under point
			targetsUnderPoint = topLevelApplication.getObjectsUnderPoint(topLeftEdgePoint);
			
			// start at the top
			targetsUnderPoint = targetsUnderPoint.reverse();
			
			// update location
			updateDropTargetLocation(event.stageX, event.stageY);
			
			// reset drop location
			dropLocation = null;
			
			// get length of targets
			length = targetsUnderPoint.length;
			
			// loop through objects under pointer from the highest to the lowest
			outerloop: 
			
			////////////////////////////////////////////////////////////
			// find first available group
			////////////////////////////////////////////////////////////
			for (var i:int;i<length;i++) {
				isGroup = false;
				
				target = targetsUnderPoint[i];
				//trace(i + " of " + length+ " target:"+NameUtil.getUnqualifiedClassName(target));
				
				if (parentApplication.contains(DisplayObject(target))) {
					//trace(i + " parent application is " + parentApplication);
					//trace(i + " parent application contains " + target);
				}
				else {
					//trace(i + " parent application does not contain " + target);
					continue;
				}
				
				// check if target is self
				if (target==draggedItem) {
					continue;
				}
				
				// check if target is child of self
				if ("contains" in draggedItem && draggedItem.contains(target)) {
					continue;
				}
				
				
				
				// check if target is a group
				if (target is GroupBase || target is SkinnableContainer) {
					dropIndex = -1;
					
					// skip skins
					if (target is ApplicationSkin) {
						target = target.owner;
					}
					
					// skip skins
					if (target is Skin && !includeSkins) {
						continue;
					}
					
					// skip skins (for groups in checkbox skin for example)
					if ("owner" in target && target.owner is Skin && !includeSkins) {
						continue;
					}
					
					isGroup = target is GroupBase ? true : false;
					isSkinnableContainer = target is SkinnableContainer ? true : false;
					targetGroup = target as GroupBase;
					targetSkinnableContainer = target as SkinnableContainer;
					
					// we found a group
					dropTarget = target;
					
					// check the type
					if (target) { // may not need this check
						targetGroupLayout = target.layout;
						
						// get drop indicator location
						dropLocation = targetGroupLayout.calculateDropLocation(event);
						
						if (dropLocation) {
							dropIndex = dropLocation.dropIndex;
						}
						
						// reset group layout values
						isTile = isVertical = isHorizontal = false;
						
						if (targetGroupLayout is HorizontalLayout) {
							isHorizontal = true;
						}
						else if (targetGroupLayout is VerticalLayout) {
							isVertical = true;
						}
						else if (targetGroupLayout is TileLayout) {
							isTile = true;
						}
						else if (targetGroupLayout is BasicLayout) {
							isBasicLayout = true;
						}
					}
					
					//trace("found target " + targetCandidate);
					// found a target break
					break;
				}
				
			}// end loop to find target
			*/
			
			
			// check document, parentDocument, owner and parent
			// GROUP in CHECKBOX
			// document = spark.skins.spark.CheckBoxSkin
			// isDocument = false;
			// owner = spark.skins.spark.CheckBoxSkin
			// parent = spark.skins.spark.CheckBoxSkin
			// parentDocument = spark.skins.spark.CheckBoxSkin
			// systemManager = _application_mx_managers_SystemManager (@118f03ba1)
			
			// GROUP on Application
			// document = spark.skins.spark.ApplicationSkin;
			// isDocument = false;
			// owner = application
			// parent = spark.components.Group
			// parentDocument = spark.skins.spark.ApplicationSkin
			// systemManager = _application_mx_managers_SystemManager (@118f03ba1)
			
			
			/*if (dropTarget is CheckBox) {
				//trace("is checkbox");
			}
			else {
				//trace("is group");
			}*/
			
			
			/*if (!dropTarget) {
				dropTarget = parentApplication;
			}*/
			
			dragData = findDropTarget(event, false);
			
			dropTarget 			= dragData.target;
			dropIndex 			= dragData.dropIndex;
			dropLocation		= dragData.dropLocation;
			dropLayout		 	= dragData.layout;
			isApplication 		= dragData.isApplication;
			isTile		 		= dragData.isTile;
			isVertical 			= dragData.isVertical;
			isBasicLayout 		= dragData.isBasicLayout;
			isHorizontal 		= dragData.isHorizontal;
			isGroup				= dragData.isGroup;
			isSkinnableContainer= dragData.isSkinnableContainer;
			isVisualElementContainer= dragData.isVisualElementContainer;
			offscreen			= dragData.offscreen;
			
			removeDragListeners(dragListener);
			removeDragDisplayObjects();
			removeGroupListeners(targetApplication);
			
			// Hide if previously showing
			if (dropLayout) {
				dropLayout.hideDropIndicator();
			}
			
			// Hide if previously showing
			if (lastTargetCandidate && "layout" in lastTargetCandidate) {
				lastTargetCandidate.layout.hideDropIndicator();
			}
			
			// hide drop indicator
			DragManager.showFeedback(DragManager.NONE);
			
			// Destroy the dropIndicator instance
			destroyDropIndicator();
			
			// store the last target
			lastTargetCandidate = dropTarget;
			
			dropTargetName = NameUtil.getUnqualifiedClassName(dropTarget);
			
			//trace("target: " + dropTargetName);
			event.updateAfterEvent();
			
			dragEvent = new DragDropEvent(DragDropEvent.DRAG_DROP, false, true);
			dragEvent.offsetPoint 			= offset;
			dragEvent.dragEvent				= event;
			dragEvent.dropTarget 			= dropTarget;
			dragEvent.dragInitiator 		= event.dragInitiator;
			dragEvent.dragSource 			= event.dragSource;
			dragEvent.draggedItem 			= draggedItem;
			dragEvent.dropLocation 			= dropLocation;
			dragEvent.dropPoint 			= dropLocation ? dropLocation.dropPoint : new Point(event.localX, event.localY);
			dragEvent.isGroup 				= isGroup;
			dragEvent.isTile 				= isTile;
			dragEvent.isVertical 			= isVertical;
			dragEvent.isHorizontal 			= isHorizontal;
			dragEvent.isBasicLayout			= isBasicLayout;
			dragEvent.isSkinnableContainer	= isSkinnableContainer;
			dragEvent.isDropTargetParent 	= (dropTarget == draggedItem.parent);
			dragEvent.isDropTargetOwner 	= (dropTarget == draggedItem.owner);
			
			dispatchEvent(dragEvent);
			
			if (dragEvent.isDefaultPrevented()) return;

			
			// SHOULD BE MOVED TO SELECTION CLASS?!?!
			// continue drop
			var index:int = -1;
			var dropPoint:Point;
			var addResult:String;
			var move:Boolean;
			var width:int;
			var height:int;
			
			//sm = SystemManagerGlobals.topLevelSystemManagers[0];
			
			// THE Following code may be causing this error:
			// TypeError: Error #1009: Cannot access a property or method of a null object reference.
			//	at mx.managers.dragClasses::DragProxy/mouseUpHandler()[E:\dev\4.y\frameworks\projects\framework\src\mx\managers\dragClasses\DragProxy.as:640]
			//  - the parent property is null for some reason
			//  solution maybe to add a try catch block if possible
			//  or monkey patch DragProxy and remove animation effect (that causes error)
			
			// it seems to happen when dragging and dropping rapidly
			// stops the drop not accepted animation
			var dragManagerImplementation:Object = mx.managers.DragManagerImpl.getInstance();
			var dragProxy:Object = dragManagerImplementation.dragProxy;
			//var startPoint:Point = new Point(dragProxy.startX, dragProxy.startY);
			Object(dragManagerImplementation).endDrag(); 
			//DragManager.endDrag();
			
			if (dropLocation) {
				
				if (isHorizontal || isVertical || isTile) {
					index = dropLocation.dropIndex;
				}
				else if (isGroup || isSkinnableContainer) {
					dropPoint = offscreen ? new Point(event.localX, event.localY) : dropLocation.dropPoint;
				}
			}
			
			var eventDescription:String = "Move";
			
			if (draggedItem.parent==null) {
				eventDescription = "Add";
			}
			
			// attempt to add or move
			//addResult = Radiate.requestAddDisplayItems(draggedItem, dropTarget, null, eventDescription, null, index);
			
			
			draggedItem.visible = true;
			
			// setPositionFromXY(target, startPoint, endPoint);
			if (isBasicLayout) {
				var dropX:Number;
				var dropY:Number;
				var values:Object = new Object();
				var properties:Array = [];
				var styles:Array = [];
				var verticalCenter:int;
				var horizontalCenter:int;
				var setVerticalCenter:Boolean;
				var setHorizontalCenter:Boolean;
				var setBottom:Boolean;
				var setRight:Boolean;
				var setLeft:Boolean;
				var setTop:Boolean;
				var setX:Boolean;
				var setY:Boolean;
				var bottom:int;
				var right:int;
				var left:int;
				var top:int;
				var x:int;
				var y:int;
				var scaleX:Number = targetApplication.scaleX;
				var scaleY:Number = targetApplication.scaleY;
				
				
				var distanceFromLeftEdge:Number = targetApplication.localToGlobal(new Point).x;
				var distanceFromTopEdge:Number = targetApplication.localToGlobal(new Point).y;
				
				// check for scaling
				if (scaleX!=1 && !isNaN(scaleX)) {
					//dropX = (dropPoint.x*scaleX) - offset.x; //45.6875
					//dropY = (dropPoint.y*scaleY) - offset.y;
					dropX = dropPoint.x - offset.x; //45.6875
					dropY = dropPoint.y - offset.y;
				}
				else {
					dropX = dropPoint.x - offset.x;
					dropY = dropPoint.y - offset.y;
				}
				
				
				////////////////////////////////////////
				// X and Y
				////////////////////////////////////////
				setX = true;
				x = dropX;
				values["x"] = x;
				
				setY = true;
				y = dropY;
				values["y"] = y;
				
				
				////////////////////////////////////////
				// Top and bottom
				////////////////////////////////////////
				if (draggedItem.top!=undefined) {
					setTop = true;
					top = dropY;
					values["top"] = top;
					delete values["y"];
				}
				
				if (draggedItem.bottom!=undefined) {
					setBottom = true;
					bottom = Number(draggedItem.parent.height) - Number(draggedItem.height) - Number(dropY);
					values["bottom"] = bottom;
					
				}
				
				////////////////////////////////////////
				// Left and Right
				////////////////////////////////////////
				if (draggedItem.left!=undefined) {
					setLeft = true;
					left = dropX;
					values["left"] = left;
					delete values["x"];
				}
				
				if (draggedItem.right!=undefined) {
					setRight = true;
					right = Number(draggedItem.parent.width) - Number(draggedItem.width) - Number(dropX);
					values["right"] = right;
				}
				
				////////////////////////////////////////
				// Vertical and Horizontal Center
				////////////////////////////////////////
				if (draggedItem.verticalCenter!=undefined) {
					setVerticalCenter = true;
					verticalCenter = dropY - draggedItem.parent.height /2;
					values["verticalCenter"] = verticalCenter;
					delete values["y"];
					//delete values["top"]; need to test
					//delete values["bottom"];
				}
				
				if (draggedItem.horizontalCenter!=undefined) {
					setHorizontalCenter = true;
					horizontalCenter = dropX - draggedItem.parent.width/2;
					values["horizontalCenter"] = horizontalCenter;
					delete values["x"];
					//delete values["left"];
					//delete values["right"];
				}
				
				// build affected properties array
				for (var propertyName:String in values) {
					properties.push(propertyName);
				}
				
				var moveResult:String;
				
				if (draggedItem.parent==null) {
					addResult = Radiate.addElement(draggedItem, dropTarget, properties, styles, values, eventDescription);
				}
				else {
					moveResult = Radiate.moveElement(draggedItem, dropTarget, properties, styles, values, eventDescription);
				}
				
			}
			// tile, vertical or horizontal layout
			else {
				
				if (draggedItem.parent==null) {
					addResult = Radiate.addElement(draggedItem, dropTarget, null, null, null, eventDescription, null, null, index);
				}
				else {
					moveResult = Radiate.moveElement(draggedItem, dropTarget, null, null, null, eventDescription, null, null, index);
				}
			}
			
			
			var dragCompleteEvent:DragDropEvent = new DragDropEvent(DragDropEvent.DRAG_DROP_COMPLETE, false, true);
			dragCompleteEvent.offsetPoint 			= offset;
			dragCompleteEvent.dragEvent				= event;
			dragCompleteEvent.dropTarget 			= dropTarget;
			dragCompleteEvent.dragInitiator 		= event.dragInitiator;
			dragCompleteEvent.dragSource 			= event.dragSource;
			dragCompleteEvent.draggedItem 			= draggedItem;
			dragCompleteEvent.dropLocation 			= dropLocation;
			dragCompleteEvent.dropPoint 			= dropLocation ? dropLocation.dropPoint : new Point(event.localX, event.localY);
			dragCompleteEvent.isGroup 				= isGroup;
			dragCompleteEvent.isTile 				= isTile;
			dragCompleteEvent.isVertical 			= isVertical;
			dragCompleteEvent.isHorizontal 			= isHorizontal;
			dragCompleteEvent.isBasicLayout			= isBasicLayout;
			dragCompleteEvent.isSkinnableContainer	= isSkinnableContainer;
			dragCompleteEvent.isDropTargetParent 	= (dropTarget == draggedItem.parent);
			dragCompleteEvent.isDropTargetOwner 	= (dropTarget == draggedItem.owner);
			
			dispatchEvent(dragCompleteEvent);
			
		}
		
		protected function dragCompleteHandler(event:DragEvent):void {
			removeDragListeners(dragListener);
			removeDragDisplayObjects();
			removeGroupListeners(targetApplication);
			event.currentTarget.removeEventListener(DragEvent.DRAG_COMPLETE, dragCompleteHandler);	
		}
		
		private function addDragListeners(dragInitiator:IUIComponent, dragListener:DisplayObject):void {
			
			dragListener.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
			dragListener.addEventListener(DragEvent.DRAG_EXIT, dragExitHandler);
			dragListener.addEventListener(DragEvent.DRAG_OVER, dragOverHandler);
			dragListener.addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
			
			dragInitiator.addEventListener(DragEvent.DRAG_COMPLETE, dragCompleteHandler);			
		}
		
		private function removeDragListeners(dragListener:DisplayObject):void {
			dragListener.removeEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
			dragListener.removeEventListener(DragEvent.DRAG_EXIT, dragExitHandler);
			dragListener.removeEventListener(DragEvent.DRAG_OVER, dragOverHandler);
			dragListener.removeEventListener(DragEvent.DRAG_DROP, dragDropHandler);
			
			dragInitiator.removeEventListener(DragEvent.DRAG_COMPLETE, dragCompleteHandler);	
		}
		
		private function removeDragDisplayObjects():void {
			destroyDropIndicator();
			selectionGroup.width = 0;
			selectionGroup.height = 0;
			
			PopUpManager.removePopUp(selectionGroup);
			
			PopUpManager.removePopUp(mouseLocationLines);
			
			if (mouseLocationLines) {
				mouseLocationLines.width = 0;
				mouseLocationLines.height = 0;
			}
			
		}
		
		/**
		 * Remove listeners from selected target
		 * */
		protected function mouseUpHandler(event:Event):void {
			removeMouseHandlers(IUIComponent(event.currentTarget));
		}
		
		/**
		 * Remove listeners from selected target and swfroot. 
		 * */
		protected function removeMouseHandlers(target:IUIComponent):void {
			
			target.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			swfRoot.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		
		public function createDropIndicator():DisplayObject
		{
			// Do we have a drop indicator already?
			if (dropIndicator)
				return DisplayObject(dropIndicator);
			
			var dropIndicatorInstance:DisplayObject;
			var dropIndicatorClass:Class;
			
			if (dropIndicator) {
				//dropIndicatorInstance = DisplayObject(parentApplication.createDynamicPartInstance("dropIndicator"));
				dropIndicatorInstance = DisplayObject(dropIndicator.newInstance());
			}
			else {
				dropIndicatorClass = spark.skins.spark.ListDropIndicator;
				
				if (dropIndicatorClass) {
					dropIndicatorInstance = new dropIndicatorClass();
				}
			}
			
			if (dropIndicatorInstance is IVisualElement) {
				IVisualElement(dropIndicatorInstance).owner = targetApplication;
			}
			
			// Set it in the layout
			//layout.dropIndicator = dropIndicatorInstance;
			return dropIndicatorInstance;
		}
		
		public function destroyDropIndicator():DisplayObject {
			var dropIndicatorInstance:DisplayObject = dropIndicator as DisplayObject;
			
			if (!dropIndicatorInstance)
				return null;
			
			// Release the reference from the layout
			dropIndicator = null;
			
			// Release it if it's a dynamic skin part
			/*var count:int = parentApplication.numDynamicParts("dropIndicator");
			
			for (var i:int = 0; i < count; i++) {
			if (dropIndicatorInstance == parentApplication.getDynamicPartAt("dropIndicator", i)) {
			// This was a dynamic part, remove it now:
			parentApplication.removeDynamicPartInstance("dropIndicator", dropIndicatorInstance);
			break;
			}
			}*/
			return dropIndicatorInstance;
		}
		
		
		/**
		 * Finds the first visual element container
		 * */
		public static function getContainerUnderPoint(event:Object, topLevelContainer:DisplayObjectContainer, adjustMouseOffset:Boolean = true, offset:Point = null):* {
			var topLevelApplication:Object = FlexGlobals.topLevelApplication;
			var adjustMouseOffset:Boolean;
			var targetsUnderPoint:Array;
			var topLeftEdgePoint:Point;
			var isHorizontal:Boolean;
			var rectangle:Rectangle;
			var isVertical:Boolean;
			var dropTarget:Object;
			var isTile:Boolean;
			var isGroup:Boolean;
			var isBasicLayout:Boolean;
			var isVerticalLayout:Boolean;
			var isHorizontalLayout:Boolean;
			var includeSkins:Boolean;
			var dropIndex:int = -1;
			var target:Object;
			var length:int;
			
			
			// get targets under point
			if (adjustMouseOffset) {
				topLeftEdgePoint = new Point(event.stageX-offset.x, event.stageY-offset.y);
			}
			else {
				topLeftEdgePoint = new Point(event.stageX, event.stageY);
			}
			
			// get items under point
			//targetsUnderPoint = topLevelApplication.getObjectsUnderPoint(topLeftEdgePoint);
			targetsUnderPoint = topLevelContainer.getObjectsUnderPoint(topLeftEdgePoint);
			
			length = targetsUnderPoint.length;
			
			targetsUnderPoint = targetsUnderPoint.reverse();
			
			// loop through objects under pointer from the highest to the lowest
			outerloop: 
			
			////////////////////////////////////////////////////////////
			// find first available group
			////////////////////////////////////////////////////////////
			for (var i:int;i<length;i++) {
				target = targetsUnderPoint[i];
				
				if (DisplayObjectContainer(topLevelContainer).contains(DisplayObject(target))) {
					//trace(i + " parent application is " + parentApplication);
					//trace(i + " parent application contains " + target);
				}
				else {
					//trace(i + " parent application does not contain " + target);
					//continue;
					// if the top level container doesn't contain 
					break;
				}
				
				
				// check if target is self
				/*if (target==draggedItem) {
					continue;
				}
				
				// check if target is child of self
				if ("contains" in draggedItem && draggedItem.contains(target)) {
					continue;
				}*/
				
				isGroup = false;
				
				// check if target is a group
				if (target is GroupBase || target is SkinnableContainer) {
					dropIndex = -1;
					
					
					// skip skins
					if (target is ApplicationSkin) {
						target = target.owner;
					}
					
					// skip skins
					if (target is Skin && !includeSkins) {
						continue;
					}
					
					isGroup = target is GroupBase ? true : false;
					
					var isSkinnableContainer:Object = target is SkinnableContainer ? true : false;
					var targetGroup:Object = target as GroupBase;
					var targetSkinnableContainer:Object = target as SkinnableContainer;
					
					// we found a group
					dropTarget = target;
					
					// check the type
					if (target) { // may not need this check
						var targetGroupLayout:Object = target.layout;
						
						// get drop indicator location
						var dropLocation:Object = targetGroupLayout.calculateDropLocation(event);
						
						if (dropLocation) {
							dropIndex = dropLocation.dropIndex;
						}
						
						// reset group layout values
						isTile = isVertical = isHorizontal = false;
						
						if (targetGroupLayout is HorizontalLayout) {
							isHorizontal = true;
						}
						else if (targetGroupLayout is VerticalLayout) {
							isVertical = true;
						}
						else if (targetGroupLayout is TileLayout) {
							isTile = true;
						}
						else if (targetGroupLayout is BasicLayout) {
							isBasicLayout = true;
						}
					}
					
					//trace("found target " + targetCandidate);
					// found a target break
					break;
				}
				
			}
			
			// end loop to find target
			if (!dropTarget) {
				//trace("Group not found. Setting to application");
				dropTarget = topLevelContainer;
			}
			
			return dropTarget;
		}

		/**
		 * Finds the first visual element under the point
		 * */
		public function findTargetUnderPoint(event:MouseEvent):IVisualElement {
			var topLeftEdgePoint:Point;
			var rectangle:Rectangle;
			var isHorizontal:Boolean;
			var isVertical:Boolean;
			var isTile:Boolean;
			var target:Object;
			var length:int;
			
			// get targets under point
			if (adjustMouseOffset) {
				topLeftEdgePoint = new Point(event.stageX-offset.x, event.stageY-offset.y);
			}
			else {
				topLeftEdgePoint = new Point(event.stageX, event.stageY);
			}
			
			// get items under point
			targetsUnderPoint = topLevelApplication.getObjectsUnderPoint(topLeftEdgePoint);
			
			length = targetsUnderPoint.length;
			
			targetsUnderPoint = targetsUnderPoint.reverse();
			
			// loop through objects under pointer from the highest to the lowest
			outerloop: 
			
			////////////////////////////////////////////////////////////
			// find first available group
			////////////////////////////////////////////////////////////
			for (var i:int;i<length;i++) {
				target = targetsUnderPoint[i];
				//trace(i + " of " + length+ " target:"+NameUtil.getUnqualifiedClassName(target));
				
				if (targetApplication.contains(DisplayObject(target))) {
					//trace(i + " parent application is " + parentApplication);
					//trace(i + " parent application contains " + target);
				}
				else {
					//trace(i + " parent application does not contain " + target);
					continue;
				}
				
				// check if target is a group
				if (target is GroupBase) {
					groupBase = target as GroupBase;
					
					// skip skins
					if (target is Skin && !includeSkins) {
						continue;
					}
					
					// we found a group
					dropTarget = target;
					
					// check the type
					if (groupBase) {
						dropLayout = groupBase.layout;
						
						// reset group layout values
						isTile = isVertical = isHorizontal = false;
						
						if (dropLayout is HorizontalLayout) {
							isHorizontal = true;
						}
						else if (dropLayout is VerticalLayout) {
							isVertical = true;
						}
						else if (dropLayout is TileLayout) {
							isTile = true;
						}
					}
					
					//trace("found target " + targetCandidate);
					// found a target break
					break;
				}
			}
			
			// end loop to find target
			
			if (!dropTarget) {
				//trace("Group not found. Setting to application");
				dropTarget = targetApplication;
			}
			else {
				//trace("Target found. Target is " + targetCandidate);
			}
			
			return dropTarget as IVisualElement;
		}
		
		private var _displayList:Array;
		private var setDragManagerOffset:Boolean = false;
		
		public var hideDragInitiatorOnDrag:Boolean;
		public var dropShadowFilter:DropShadowFilter = new DropShadowFilter(4, 45, 0, 1, 2, 2, .3);
		public var addDropShadow:Boolean = false;

		public var componentTree:ComponentDescription;

		private var distanceFromLeft:int;

		private var distanceFromTop:int;

		
		/**
		 * Gets the display list. The parentApplication needs to be set
		 * or this returns null. 
		 * */
		public function get displayList():Array {
			
			return _displayList; 
		}
		
		/**
		 * @private
		 * */
		public function set displayList(value:Array):void {
			if (_displayList == value)
				return;
			_displayList = value;
		}
		
		public function addGroupListeners(element:IVisualElement):void {
			//enableDragBehaviorOnDisplayList(displayObject);
			applicationGroups = DisplayObjectUtils.enableDragBehaviorOnDisplayList(element, true);
		}
		
		public function removeGroupListeners(element:IVisualElement):void {
			//enableDragBehaviorOnDisplayList(displayObject, null, 0, false);
			applicationGroups = DisplayObjectUtils.enableDragBehaviorOnDisplayList(element, false, applicationGroups);
		}
				
		public static function addGroupMouseSupport(group:GroupBase, applicationGroups:Dictionary):void {
			DisplayObjectUtils.addGroupMouseSupport(group, applicationGroups);
			//applicationGroups[group] = new GroupOptions(group.mouseEnabledWhereTransparent);
			//group.mouseEnabledWhereTransparent = true;
			//group.addEventListener(MouseEvent.MOUSE_OUT, enableGroupMouseHandler, false, 0, true);
		}
		
		public static function removeGroupMouseSupport(group:GroupBase, applicationGroups:Dictionary):void {
			DisplayObjectUtils.removeGroupMouseSupport(group, applicationGroups);
			//group.mouseEnabledWhereTransparent = applicationGroups[group].mouseEnabledWhereTransparent;
			//group.removeEventListener(MouseEvent.MOUSE_OUT, enableGroupMouseHandler);
			//applicationGroups[group] = null;
		}
		
		public static function enableGroupMouseHandler(event:MouseEvent):void
		{
			// this is used to enable mouse events where transparent 
		}
		
		/**
		 * Gets the display list
		 * */
		public function getDisplayList(element:Object, parentItem:Object = null, depth:int = 0):Object {
			
			/* 
			if (displayList.length <= depth) {
			displayList.push(new ArrayCollection());
			} */
			
			
			if (!parentItem) {
				parentItem = {name:"root", element:element.parent, children:new ArrayCollection()};
			}
			
			
			if ("numElements" in element) {
				var length:int = element.numElements;
				
				for (var i:int; i < length; i++) {
					var child:Object = element.getElementAt(i);
					var item:Object = {name:"test", element:child, children:new ArrayCollection()};
					
					parentItem.children.addItem(item);
					
					if ("numElements" in child) {
						getDisplayList(child, item, depth + 1);
					}
					
					
					//displayList[depth].push(object);
					
				}
			}
			return parentItem;
		}
	}
}
