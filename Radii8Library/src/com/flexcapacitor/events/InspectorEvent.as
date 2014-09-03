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





package com.flexcapacitor.events {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class InspectorEvent extends Event {
		
		public static const CHANGE:String = "change";
		public static const HIGHLIGHT:String = "highlight";
		public static const SELECT:String = "select";
		
		public var targetItem:Object;
		
		public function InspectorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, target:Object = null) {
			super(type, bubbles, cancelable);
			
			targetItem = target;
		}
		
		
		// override the inherited clone() method
		override public function clone():Event {
			return new InspectorEvent(type, bubbles, cancelable, targetItem);
		}
	}
}
