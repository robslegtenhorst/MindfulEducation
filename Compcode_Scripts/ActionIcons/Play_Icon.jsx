// Created using compCode v1.0.2// 20160628 from composition "PlayBtn" in project "/mindful_share/Courses/Tresham/CMI/Unit 1 Personal Development as a Manager and Leader/Lesson 4/AE/TRE_CMI-L5_U01_L04_P03/AE/TRE_CMI-L5_U01_L04_P03_v008.aep"//// aescripts.com/compCode// compCode_20160628_180208();function compCode_20160628_180208() {app.beginUndoGroup("PlayBtn");try {// Create Folder hierarchy	var zcompcodescripts_folder = getItem("Z_Compcode_Scripts", FolderItem, app.project.rootFolder);	if (zcompcodescripts_folder === null) {		zcompcodescripts_folder = app.project.items.addFolder("Z_Compcode_Scripts");	}	var actionicons_folder = getItem("ActionIcons", FolderItem, zcompcodescripts_folder);	if (actionicons_folder === null) {		actionicons_folder = app.project.items.addFolder("ActionIcons");		actionicons_folder.parentFolder = zcompcodescripts_folder;	}// Create Compositions	var playbtn_comp = app.project.items.addComp("PlayBtn", 600, 400, 1, 7.72, 25);		playbtn_comp.time = 1.12;		playbtn_comp.bgColor = [0,0,0];		playbtn_comp.motionBlur = true;		playbtn_comp.parentFolder = actionicons_folder;// Working with comp "PlayBtn", varName "playbtn_comp";	playbtn_comp.openInViewer();	// Add Shape Layer "Play", varName "play";	var play = playbtn_comp.layers.addShape();		play.name = "Play";		play.startTime = 0.4;		play.moveToEnd();		play.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		play.property("ADBE Root Vectors Group").property(1).name = "Polystar 1";		play.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Star");		play.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Star Type").setValue(2);		play.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Star Points").setValue(3);		play.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Star Rotation").setValue(-30);		play.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Star Outer Radius").setValue(173.854537231457);		play.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Filter - RC");		play.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector RoundCorner Radius").setValue(56);		play.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");		play.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Stroke Color").setValue([0.30196078431373,0.30196078431373,0.30196078431373,1]);		play.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Stroke Width").setValue(16);		play.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");		play.property("ADBE Root Vectors Group").property(1).property(2).property(4).enabled = false;		play.property("ADBE Root Vectors Group").property(1).property(2).property(4).property("ADBE Vector Fill Color").setValue([1,1,1,1]);		play.property("ADBE Root Vectors Group").property(1).property(2).property(4).property("ADBE Vector Fill Opacity").setValue(40);		play.property("ADBE Root Vectors Group").addProperty("ADBE Vector Filter - Trim");		var playEnd = play.property("ADBE Root Vectors Group").property(2).property("ADBE Vector Trim End");			var playEnd_keyTimesArray = [0.4,1.2];			var playEnd_valuesArray = [0,100];			playEnd.setValuesAtTimes(playEnd_keyTimesArray, playEnd_valuesArray);			var playEnd_easeInSpeedArray = [0,0];			var playEnd_easeInInfluArray = [60,60];			var playEnd_easeOutSpeedArray = [0,0];			var playEnd_easeOutInfluArray = [60,60];			var playEnd_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var playEnd_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(playEnd, playEnd_keyTimesArray, [playEnd_easeInSpeedArray, playEnd_easeInInfluArray], [playEnd_easeOutSpeedArray, playEnd_easeOutInfluArray], [playEnd_keyInInterpolationType, playEnd_keyOutInterpolationType]);		var playOffset = play.property("ADBE Root Vectors Group").property(2).property("ADBE Vector Trim Offset");			var playOffset_keyTimesArray = [0.4,1.2];			var playOffset_valuesArray = [0,88];			playOffset.setValuesAtTimes(playOffset_keyTimesArray, playOffset_valuesArray);			var playOffset_easeInSpeedArray = [0,0];			var playOffset_easeInInfluArray = [60,60];			var playOffset_easeOutSpeedArray = [0,0];			var playOffset_easeOutInfluArray = [60,60];			var playOffset_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var playOffset_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(playOffset, playOffset_keyTimesArray, [playOffset_easeInSpeedArray, playOffset_easeInInfluArray], [playOffset_easeOutSpeedArray, playOffset_easeOutInfluArray], [playOffset_keyInInterpolationType, playOffset_keyOutInterpolationType]);		play.property("ADBE Transform Group").property("ADBE Position").setValue([297.866492742936,200,0]);		play.property("ADBE Transform Group").property("ADBE Scale").setValue([90.0373558617083,90.0373558617083,100]);		play.selected = false;	// Add Shape Layer "bgLine", varName "bgline";	var bgline = playbtn_comp.layers.addShape();		bgline.name = "bgLine";		bgline.moveToEnd();		bgline.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		bgline.property("ADBE Root Vectors Group").property(1).name = "Rectangle 1";		bgline.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Rect");		bgline.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Rect Size").setValue([582,388]);		bgline.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Rect Roundness").setValue(129);		bgline.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");		bgline.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0.30196078431373,0.30196078431373,0.30196078431373,1]);		bgline.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8);		bgline.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");		bgline.property("ADBE Root Vectors Group").property(1).property(2).property(3).enabled = false;		bgline.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Fill Color").setValue([1,1,1,1]);		bgline.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Fill Opacity").setValue(40);		bgline.property("ADBE Root Vectors Group").addProperty("ADBE Vector Filter - Trim");		var bglineEnd = bgline.property("ADBE Root Vectors Group").property(2).property("ADBE Vector Trim End");			var bglineEnd_keyTimesArray = [0,0.8];			var bglineEnd_valuesArray = [0,100];			bglineEnd.setValuesAtTimes(bglineEnd_keyTimesArray, bglineEnd_valuesArray);			var bglineEnd_easeInSpeedArray = [0,0];			var bglineEnd_easeInInfluArray = [60,60];			var bglineEnd_easeOutSpeedArray = [0,0];			var bglineEnd_easeOutInfluArray = [60,60];			var bglineEnd_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var bglineEnd_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(bglineEnd, bglineEnd_keyTimesArray, [bglineEnd_easeInSpeedArray, bglineEnd_easeInInfluArray], [bglineEnd_easeOutSpeedArray, bglineEnd_easeOutInfluArray], [bglineEnd_keyInInterpolationType, bglineEnd_keyOutInterpolationType]);		var bglineOffset = bgline.property("ADBE Root Vectors Group").property(2).property("ADBE Vector Trim Offset");			var bglineOffset_keyTimesArray = [0,0.8];			var bglineOffset_valuesArray = [0,88];			bglineOffset.setValuesAtTimes(bglineOffset_keyTimesArray, bglineOffset_valuesArray);			var bglineOffset_easeInSpeedArray = [0,0];			var bglineOffset_easeInInfluArray = [60,60];			var bglineOffset_easeOutSpeedArray = [0,0];			var bglineOffset_easeOutInfluArray = [60,60];			var bglineOffset_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var bglineOffset_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(bglineOffset, bglineOffset_keyTimesArray, [bglineOffset_easeInSpeedArray, bglineOffset_easeInInfluArray], [bglineOffset_easeOutSpeedArray, bglineOffset_easeOutInfluArray], [bglineOffset_keyInInterpolationType, bglineOffset_keyOutInterpolationType]);		bgline.selected = false;	// Add Shape Layer "bg", varName "bg";	var bg = playbtn_comp.layers.addShape();		bg.name = "bg";		bg.startTime = 0.4;		bg.moveToEnd();		bg.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		bg.property("ADBE Root Vectors Group").property(1).name = "Rectangle 1";		bg.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Rect");		bg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Rect Size").setValue([582,388]);		bg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Rect Roundness").setValue(129);		bg.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");		bg.property("ADBE Root Vectors Group").property(1).property(2).property(2).enabled = false;		bg.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0.30196078431373,0.30196078431373,0.30196078431373,1]);		bg.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8);		bg.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");		bg.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Fill Color").setValue([1,1,1,1]);		bg.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Fill Opacity").setValue(40);		var bgOpacity = bg.property("ADBE Transform Group").property("ADBE Opacity");			var bgOpacity_keyTimesArray = [0.4,1.2];			var bgOpacity_valuesArray = [0,100];			bgOpacity.setValuesAtTimes(bgOpacity_keyTimesArray, bgOpacity_valuesArray);			var bgOpacity_easeInSpeedArray = [0,0];			var bgOpacity_easeInInfluArray = [60,60];			var bgOpacity_easeOutSpeedArray = [0,0];			var bgOpacity_easeOutInfluArray = [60,60];			var bgOpacity_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var bgOpacity_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(bgOpacity, bgOpacity_keyTimesArray, [bgOpacity_easeInSpeedArray, bgOpacity_easeInInfluArray], [bgOpacity_easeOutSpeedArray, bgOpacity_easeOutInfluArray], [bgOpacity_keyInInterpolationType, bgOpacity_keyOutInterpolationType]);		bg.selected = false;playbtn_comp.openInViewer();} catch(e) {	alert(e.toString() + "\nError on line: " + e.line.toString());}app.endUndoGroup();function getItem(itemName, itemInstanceName, locationObject) {	if (locationObject.numItems > 0) {		for (var i = 1; i <= locationObject.numItems; i ++) {			var curItem = locationObject.item(i);			if (curItem.name === itemName) {				if (curItem instanceof itemInstanceName || (curItem.mainSource !== "undefined" && curItem.mainSource instanceof itemInstanceName)) {					return curItem;				}			}		}	}	return null;}function applyEasing(property, keyTimesArray, easeInArray, easeOutArray, keyInterpolationArray) {	for (var i = 0; i < keyTimesArray.length; i ++) {		if (property.propertyValueType === PropertyValueType.TwoD) {			var easeIn0 = new KeyframeEase(easeInArray[0][i][0], easeInArray[1][i][0]);			var easeOut0 = new KeyframeEase(easeOutArray[0][i][0], easeOutArray[1][i][0]);			var easeIn1 = new KeyframeEase(easeInArray[0][i][1], easeInArray[1][i][1]);			var easeOut1 = new KeyframeEase(easeOutArray[0][i][1], easeOutArray[1][i][1]);			property.setTemporalEaseAtKey(i+1, [easeIn0, easeIn1], [easeOut0, easeOut1]);		} else if (property.propertyValueType === PropertyValueType.ThreeD) {			var easeIn0 = new KeyframeEase(easeInArray[0][i][0], easeInArray[1][i][0]);			var easeOut0 = new KeyframeEase(easeOutArray[0][i][0], easeOutArray[1][i][0]);			var easeIn1 = new KeyframeEase(easeInArray[0][i][1], easeInArray[1][i][1]);			var easeOut1 = new KeyframeEase(easeOutArray[0][i][1], easeOutArray[1][i][1]);			var easeIn2 = new KeyframeEase(easeInArray[0][i][2], easeInArray[1][i][2]);			var easeOut2 = new KeyframeEase(easeOutArray[0][i][2], easeOutArray[1][i][2]);			property.setTemporalEaseAtKey(i+1, [easeIn0, easeIn1, easeIn2], [easeOut0, easeOut1, easeOut2]);		} else {			var easeIn = new KeyframeEase(easeInArray[0][i], easeInArray[1][i]);			var easeOut = new KeyframeEase(easeOutArray[0][i], easeOutArray[1][i]);			if (keyInterpolationArray[1][i] !== KeyframeInterpolationType.HOLD) {				property.setTemporalEaseAtKey(i+1, [easeIn], [easeOut]);			} else {				property.setTemporalEaseAtKey(i+1, [easeIn]);			}		}		property.setInterpolationTypeAtKey(i+1, keyInterpolationArray[0][i], keyInterpolationArray[1][i]);	}}}