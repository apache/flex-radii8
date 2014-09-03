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

package com.flexcapacitor.model {
	import mx.styles.IStyleClient;
	
	/**
	 * Contains information on style metadata
	 * */
	public class StyleMetaData extends MetaData {
		
		/**
		 * Constructor
		 * */
		public function StyleMetaData(item:XML = null, target:* = null) {
			if (item) unmarshall(item, target);
		}
		
		/**
		 * 
		 * */
		public var inherit:Boolean;
		
		/**
		 * Set to true if style is defined on the target. 
		 * In other words the user set it in MXML or AS3 and it is not inherited.
		 * styleClient.getStyle(thisStyle)!==undefined. 
		 * */
		public var definedInline:Boolean;
		
		/**
		 * 
		 * */
		public var inheritedValue:*;
		
		/**
		 * 
		 * */
		public var nonInheritedValue:*;
		
		/**
		 * Import metadata XML Style node into this instance
		 * */
		override public function unmarshall(item:XML, target:* = null, getValue:Boolean = true):void {
			super.unmarshall(item, target, getValue);
			
			var args:XMLList = item.arg;
			var keyName:String;
			var keyValue:String;
			
			
			for each (var arg:XML in args) {
				keyName = arg.@key;
				
				if (keyName=="inherit") {
					inherit = keyValue=="no";//bug?
					break;
				}
				
			}
			
			// this shows if it's defined at all 
			definedInline = target && target is IStyleClient && target.getStyle(name)!==undefined;
			
			if (!definedInline) {
				inheritedValue = target.getStyle(name);
				nonInheritedValue = undefined;
				value = inheritedValue;
				textValue = "" + inheritedValue;
			}
			else {
				// don't know how to get this value -
				// UPDATE: there is CSS code in MiniInspector to check if a value is 
				// set inline or inherited
				// we also have the inheritedStyles and nonInherited object on IStyleClient
				inheritedValue = undefined;
				nonInheritedValue = target.getStyle(name);
				value = nonInheritedValue;
				textValue = "" + nonInheritedValue;
			}
			
			
			
		}
	}
}