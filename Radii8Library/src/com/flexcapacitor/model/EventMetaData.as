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
	
	
	/**
	 * Contains information on style metadata
	 * */
	public class EventMetaData extends MetaData {
		
		
		public function EventMetaData(item:XML = null, target:* = null)
		{
			if (item) unmarshall(item, target);
		}
		
		
		/**
		 * Import metadata XML Style node into this instance
		 * */
		override public function unmarshall(item:XML, target:* = null, getValue:Boolean = true):void {
			super.unmarshall(item, target, getValue);
			/*
			var args:XMLList = item.arg;
			var keyName:String;
			var keyValue:String;
			
			
			for each (var arg:XML in args) {
				keyName = arg.@key;
				
				if (keyName=="inherit") {
					inherit = keyValue=="no";
					break;
				}
				
			}*/
			
			/*
			
			// this shows if it's defined at all 
			definedInline = target && target is IStyleClient && target.getStyle(name)!==undefined;
			
			if (!definedInline) {
				inheritedValue = target.getStyle(name);
				nonInheritedValue = undefined;
				value = inheritedValue;
				textValue = "" + inheritedValue;
			}
			else {
				inheritedValue = undefined; // don't know how to get this value
				nonInheritedValue = target.getStyle(name);
				value = nonInheritedValue;
				textValue = "" + nonInheritedValue;
			}*/
			
			
			
		}
	}
}