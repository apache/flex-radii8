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

package data {
	
	/**
	 * Layout of views and rules. 
	 * The items contains the list of views or child perspectives.
	 * Tab stops is the location of 
	 * */
	[Bindable]
	[RemoteClass]
	public class Perspective {
		
		public static const VERTICAL:String = "vertical";
		public static const HORIZONTAL:String = "horizontal";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const TOP:String = "top";
		public static const BOTTOM:String = "bottom";
		
		/**
		 * @constructor
		 * */
		public function Perspective() {
			
		}
		
		/**
		 * Name of perspective
		 * */
		public var name:String;
		
		/**
		 * Enabled
		 * */
		public var enabled:Boolean = true;
		
		/**
		 * horizontal or vertical
		 * */
		public var direction:String = VERTICAL;
		
		private var _items:Array = [];

		/**
		 * Items or perspectives
		 * */
		public function get items():Array {
			return _items;
		}

		/**
		 * @private
		 */
		public function set items(value:Array):void {
			_items = value;
		}

		
		private var _visibleItems:Array;

		/**
		 * Items or perspectives
		 * */
		public function get visibleItems():Array {
			
			return _visibleItems;
		}

		/**
		 * @private
		 */
		public function set visibleItems(value:Array):void {
			_visibleItems = value;
		}
		
		private var _types:Array = [];
		/**
		 * List of types
		 * */
		public function get types():Array {
			return _types;
		}
		/**
		 * List of types
		 * */
		public function set types(value:Array):void {
			_types = value;
			
		}

		
		/**
		 * List of column or row positions for each item.
		 * */
		public var tabStops:Array;
		
		/**
		 * Width in percent or number
		 * */
		public var width:Object;
		
		/**
		 * Height in percent or number
		 * */
		public var height:Object;
		
		/**
		 * If docked
		 * */
		public var docked:Boolean;
		
		/**
		 * Docked position
		 * */
		public var dockedPosition:String = LEFT;
		
	}
}