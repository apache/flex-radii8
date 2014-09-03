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

package com.flexcapacitor.views.supportClasses {
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.core.IVisualElementContainer;
	
	import spark.components.Application;
	
	/**
	 * Describes how project data is displayed in a tree
	 * */
	public class LayersDataDescriptor extends DefaultDataDescriptor {
		
		
		public function LayersDataDescriptor() {
			super();
		}
		
		/**
		 * Get documents for now
		 * */
		/*override public function getChildren(node:Object, model:Object = null):ICollectionView {
			if ("documents" in node) {
				return node.documents;
			}
			
			return null;
		}*/
		
	
	    /**
	     *  Tests a node for termination.
	     *  Branches are non-terminating but are not required to have any leaf nodes.
	     *  If the node is XML, returns <code>true</code> if the node has children
	     *  or a <code>true isBranch</code> attribute.
	     *  If the node is an object, returns <code>true</code> if the node has a
	     *  (possibly empty) <code>children</code> field.
	     *
	     *  @param node The node object currently being evaluated.
	     *  @param model The collection that contains the node; ignored by this class.
	     *  
	     *  @return <code>true</code> if this node is non-terminating.
	     *  
	     *  @langversion 3.0
	     *  @playerversion Flash 9
	     *  @playerversion AIR 1.1
	     *  @productversion Flex 3
	     */
	    override public function isBranch(node:Object, model:Object = null):Boolean
	    {
	        if (node == null)
	            return false;
	            
	        var branch:Boolean = false;
	            
			if (node is Object)
	        {
	            try
	            {
	                if (node.instance is IVisualElementContainer || node.instance is Application)
	                {
	                    branch = true;
	                }
	            }
	            catch(e:Error)
	            {
	            }
	        }
	        return branch;
	    }

	}
}