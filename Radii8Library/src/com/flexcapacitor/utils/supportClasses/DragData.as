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

package com.flexcapacitor.utils.supportClasses {
	import flash.geom.Point;
	
	import spark.components.supportClasses.GroupBase;
	import spark.layouts.supportClasses.DropLocation;
	import spark.layouts.supportClasses.LayoutBase;
	
	/**
	 * 
	 * */
	public class DragData {
		
		
		public function DragData()
		{
			
		}
		
		public var offscreen:Boolean;
		public var isApplication:Boolean;
		public var isGroup:Boolean;
		public var isSkinnableContainer:Boolean;
		public var isVisualElementContainer:Boolean;
		public var isBasicLayout:Boolean;
		public var isTile:Boolean;
		public var isVertical:Boolean;
		public var isHorizontal:Boolean;
		public var targetGroupLayout:LayoutBase;
		public var targetGroup:GroupBase;
		public var target:Object;
		public var targetsUnderPoint:Array;
		public var topLeftEdgePoint:Point;
		public var description:ComponentDescription;
		public var dropLocation:DropLocation;
		public var dropIndex:int;
		public var dropPoint:Point;
		public var layout:LayoutBase;
	}
}