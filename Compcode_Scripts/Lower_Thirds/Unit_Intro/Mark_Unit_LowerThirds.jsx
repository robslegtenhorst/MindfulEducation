// Created using compCode v1.0.2// 20160721 from composition "Mark_Unit_LowerThirds" in project "/mindful_share/Courses/tre_aat-l2/unit_01/lesson_02/04_parts/part_01/02_after_effects/01_ae_build/tre_aat-l2_U01_L02_P01_v002.aep"//// aescripts.com/compCode// compCode_20160721_104016();function compCode_20160721_104016() {app.beginUndoGroup("Mark_Unit_LowerThirds");try {// Create Folder hierarchy	var zcompcodescripts_folder = getItem("Z_Compcode_Scripts", FolderItem, app.project.rootFolder);	if (zcompcodescripts_folder === null) {		zcompcodescripts_folder = app.project.items.addFolder("Z_Compcode_Scripts");	}	var lowerthirds_folder = getItem("LowerThirds", FolderItem, zcompcodescripts_folder);	if (lowerthirds_folder === null) {		lowerthirds_folder = app.project.items.addFolder("LowerThirds");		lowerthirds_folder.parentFolder = zcompcodescripts_folder;	}	var unitintro_folder = getItem("unit_intro", FolderItem, lowerthirds_folder);	if (unitintro_folder === null) {		unitintro_folder = app.project.items.addFolder("unit_intro");		unitintro_folder.parentFolder = lowerthirds_folder;	}// Create Compositions	var markunitlowerthirds_comp = app.project.items.addComp("Mark_Unit_LowerThirds", 1920, 1080, 1, 7.28, 25);		markunitlowerthirds_comp.time = 3.2;		markunitlowerthirds_comp.bgColor = [0,0,0];		markunitlowerthirds_comp.displayStartTime = 22.6800994873047;		markunitlowerthirds_comp.motionBlur = true;		markunitlowerthirds_comp.parentFolder = unitintro_folder;// Working with comp "Mark_Unit_LowerThirds", varName "markunitlowerthirds_comp";	markunitlowerthirds_comp.openInViewer();	var useOnSideCam = markunitlowerthirds_comp.layers.addText("Use on side cam");		useOnSideCam.guideLayer = true;		useOnSideCam.moveToEnd();		var useOnSideCam_TextProp = useOnSideCam.property("ADBE Text Properties").property("ADBE Text Document");		var useOnSideCam_TextDocument = useOnSideCam_TextProp.value;			useOnSideCam_TextDocument.font = "ArialMT";			useOnSideCam_TextDocument.fontSize = 30;			useOnSideCam_TextDocument.applyFill = true;			useOnSideCam_TextDocument.fillColor = [0,1,0.6941180229187];			useOnSideCam_TextDocument.applyStroke = false;			useOnSideCam_TextDocument.justification = ParagraphJustification.LEFT_JUSTIFY;			useOnSideCam_TextDocument.tracking = 0;			if (parseFloat(app.version) >= 13.2 ) {				useOnSideCam_TextDocument.verticalScale = 1;				useOnSideCam_TextDocument.horizontalScale = 1;				useOnSideCam_TextDocument.baselineShift = 1;				useOnSideCam_TextDocument.tsume = 0;				// These values are read-only. You have to set them manually in the comp.				// useOnSideCam_TextDocument.fauxBold = false;				// useOnSideCam_TextDocument.fauxItalic = false;				// useOnSideCam_TextDocument.allCaps = false;				// useOnSideCam_TextDocument.smallCaps = false;				// useOnSideCam_TextDocument.superscript = false;				// useOnSideCam_TextDocument.subscript = false;			}			useOnSideCam_TextProp.setValue(useOnSideCam_TextDocument);		useOnSideCam.property("ADBE Transform Group").property("ADBE Position").setValue([948,446,0]);		useOnSideCam.selected = false;	// Add Shape Layer "Shape Layer 1", varName "shapeLayer1";	var shapeLayer1 = markunitlowerthirds_comp.layers.addShape();		shapeLayer1.guideLayer = true;		shapeLayer1.moveToEnd();		shapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		shapeLayer1.property("ADBE Root Vectors Group").property(1).name = "Ellipse 5";		shapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Ellipse");		shapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Ellipse Size").setValue([348.5234375,278.0234375]);		shapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");		shapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");		shapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Fill Color").setValue([0.56887296788833,0.37883899165135,0.37883899165135,1]);		shapeLayer1.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([98.26171875,-98.98828125]);		shapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		shapeLayer1.property("ADBE Root Vectors Group").property(2).name = "Shape 4";		shapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Shape - Group");		var shapeLayer1Path = shapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).property(1).property("ADBE Vector Shape");		var shapeLayer1Path_newShape = new Shape();			shapeLayer1Path_newShape.vertices = [[16, -72], [-64, -72], [-100, -12], [-44, -12], [14, -18]];			shapeLayer1Path_newShape.closed = true;		shapeLayer1Path.setValue(shapeLayer1Path_newShape);		shapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Graphic - Stroke");		shapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Graphic - Fill");		shapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).property(3).property("ADBE Vector Fill Color").setValue([0.56887296788833,0.37883899165135,0.37883899165135,1]);		shapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		shapeLayer1.property("ADBE Root Vectors Group").property(3).name = "Shape 3";		shapeLayer1.property("ADBE Root Vectors Group").property(3).property(2).addProperty("ADBE Vector Shape - Group");		var shapeLayer1Path = shapeLayer1.property("ADBE Root Vectors Group").property(3).property(2).property(1).property("ADBE Vector Shape");		var shapeLayer1Path_newShape = new Shape();			shapeLayer1Path_newShape.vertices = [[-414, 50], [-276, 36]];			shapeLayer1Path_newShape.inTangents = [[-22, -28], [-22, 60]];			shapeLayer1Path_newShape.outTangents = [[22, 28], [22, -60]];			shapeLayer1Path_newShape.closed = false;		shapeLayer1Path.setValue(shapeLayer1Path_newShape);		shapeLayer1.property("ADBE Root Vectors Group").property(3).property(2).addProperty("ADBE Vector Graphic - Stroke");		shapeLayer1.property("ADBE Root Vectors Group").property(3).property(2).addProperty("ADBE Vector Graphic - Fill");		shapeLayer1.property("ADBE Root Vectors Group").property(3).property(2).property(3).property("ADBE Vector Fill Color").setValue([0.56887296788833,0.37883899165135,0.37883899165135,1]);		shapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		shapeLayer1.property("ADBE Root Vectors Group").property(4).name = "Ellipse 4";		shapeLayer1.property("ADBE Root Vectors Group").property(4).property(2).addProperty("ADBE Vector Shape - Ellipse");		shapeLayer1.property("ADBE Root Vectors Group").property(4).property(2).property(1).property("ADBE Vector Ellipse Size").setValue([54,60.328125]);		shapeLayer1.property("ADBE Root Vectors Group").property(4).property(2).addProperty("ADBE Vector Graphic - Stroke");		shapeLayer1.property("ADBE Root Vectors Group").property(4).property(2).addProperty("ADBE Vector Graphic - Fill");		shapeLayer1.property("ADBE Root Vectors Group").property(4).property(2).property(3).property("ADBE Vector Fill Color").setValue([0.56887296788833,0.37883899165135,0.37883899165135,1]);		shapeLayer1.property("ADBE Root Vectors Group").property(4).property(3).property("ADBE Vector Position").setValue([-269,-113.8359375]);		shapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		shapeLayer1.property("ADBE Root Vectors Group").property(5).name = "Ellipse 3";		shapeLayer1.property("ADBE Root Vectors Group").property(5).property(2).addProperty("ADBE Vector Shape - Ellipse");		shapeLayer1.property("ADBE Root Vectors Group").property(5).property(2).property(1).property("ADBE Vector Ellipse Size").setValue([69.0546875,49.671875]);		shapeLayer1.property("ADBE Root Vectors Group").property(5).property(2).addProperty("ADBE Vector Graphic - Stroke");		shapeLayer1.property("ADBE Root Vectors Group").property(5).property(2).addProperty("ADBE Vector Graphic - Fill");		shapeLayer1.property("ADBE Root Vectors Group").property(5).property(2).property(3).property("ADBE Vector Fill Color").setValue([0.56887296788833,0.37883899165135,0.37883899165135,1]);		shapeLayer1.property("ADBE Root Vectors Group").property(5).property(3).property("ADBE Vector Position").setValue([-447.47265625,-107.1640625]);		shapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		shapeLayer1.property("ADBE Root Vectors Group").property(6).name = "Shape 2";		shapeLayer1.property("ADBE Root Vectors Group").property(6).property(2).addProperty("ADBE Vector Shape - Group");		var shapeLayer1Path = shapeLayer1.property("ADBE Root Vectors Group").property(6).property(2).property(1).property("ADBE Vector Shape");		var shapeLayer1Path_newShape = new Shape();			shapeLayer1Path_newShape.vertices = [[-316, -190], [-208, -196]];			shapeLayer1Path_newShape.closed = false;		shapeLayer1Path.setValue(shapeLayer1Path_newShape);		shapeLayer1.property("ADBE Root Vectors Group").property(6).property(2).addProperty("ADBE Vector Graphic - Stroke");		shapeLayer1.property("ADBE Root Vectors Group").property(6).property(2).addProperty("ADBE Vector Graphic - Fill");		shapeLayer1.property("ADBE Root Vectors Group").property(6).property(2).property(3).property("ADBE Vector Fill Color").setValue([0.56887296788833,0.37883899165135,0.37883899165135,1]);		shapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		shapeLayer1.property("ADBE Root Vectors Group").property(7).name = "Shape 1";		shapeLayer1.property("ADBE Root Vectors Group").property(7).property(2).addProperty("ADBE Vector Shape - Group");		var shapeLayer1Path = shapeLayer1.property("ADBE Root Vectors Group").property(7).property(2).property(1).property("ADBE Vector Shape");		var shapeLayer1Path_newShape = new Shape();			shapeLayer1Path_newShape.vertices = [[-528, -175.933715820312], [-410, -182.041427612305]];			shapeLayer1Path_newShape.closed = false;		shapeLayer1Path.setValue(shapeLayer1Path_newShape);		shapeLayer1.property("ADBE Root Vectors Group").property(7).property(2).addProperty("ADBE Vector Graphic - Stroke");		shapeLayer1.property("ADBE Root Vectors Group").property(7).property(2).addProperty("ADBE Vector Graphic - Fill");		shapeLayer1.property("ADBE Root Vectors Group").property(7).property(2).property(3).property("ADBE Vector Fill Color").setValue([0.56887296788833,0.37883899165135,0.37883899165135,1]);		shapeLayer1.property("ADBE Root Vectors Group").property(7).property(3).property("ADBE Vector Scale").setValue([100,99.5874297752809]);		shapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		shapeLayer1.property("ADBE Root Vectors Group").property(8).name = "Ellipse 1";		shapeLayer1.property("ADBE Root Vectors Group").property(8).property(2).addProperty("ADBE Vector Shape - Ellipse");		shapeLayer1.property("ADBE Root Vectors Group").property(8).property(2).property(1).property("ADBE Vector Ellipse Size").setValue([505.90625,505.90625]);		shapeLayer1.property("ADBE Root Vectors Group").property(8).property(2).addProperty("ADBE Vector Graphic - Stroke");		shapeLayer1.property("ADBE Root Vectors Group").property(8).property(2).addProperty("ADBE Vector Graphic - Fill");		shapeLayer1.property("ADBE Root Vectors Group").property(8).property(2).property(3).property("ADBE Vector Fill Color").setValue([0.56887296788833,0.37883899165135,0.37883899165135,1]);		shapeLayer1.property("ADBE Root Vectors Group").property(8).property(3).property("ADBE Vector Position").setValue([-387.046875,-103.046875]);		shapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");		shapeLayer1.property("ADBE Root Vectors Group").property(9).name = "Ellipse 2";		shapeLayer1.property("ADBE Root Vectors Group").property(9).property(2).addProperty("ADBE Vector Shape - Ellipse");		shapeLayer1.property("ADBE Root Vectors Group").property(9).property(2).property(1).property("ADBE Vector Ellipse Size").setValue([494.765625,580.84375]);		shapeLayer1.property("ADBE Root Vectors Group").property(9).property(2).addProperty("ADBE Vector Graphic - Stroke");		shapeLayer1.property("ADBE Root Vectors Group").property(9).property(2).addProperty("ADBE Vector Graphic - Fill");		shapeLayer1.property("ADBE Root Vectors Group").property(9).property(2).property(3).property("ADBE Vector Fill Color").setValue([0.56887296788833,0.37883899165135,0.37883899165135,1]);		shapeLayer1.property("ADBE Root Vectors Group").property(9).property(3).property("ADBE Vector Position").setValue([-397.203125,368.671875]);		shapeLayer1.selected = false;	var businessLecturer = markunitlowerthirds_comp.layers.addText("Business Lecturer");		businessLecturer.startTime = 1.32;		businessLecturer.outPoint = 7.28;		businessLecturer.motionBlur = true;		businessLecturer.moveToEnd();		var businessLecturer_TextProp = businessLecturer.property("ADBE Text Properties").property("ADBE Text Document");		var businessLecturer_TextDocument = businessLecturer_TextProp.value;			businessLecturer_TextDocument.font = "OpenSans";			businessLecturer_TextDocument.fontSize = 65;			businessLecturer_TextDocument.applyFill = true;			businessLecturer_TextDocument.fillColor = [1,1,1];			businessLecturer_TextDocument.applyStroke = false;			businessLecturer_TextDocument.justification = ParagraphJustification.LEFT_JUSTIFY;			businessLecturer_TextDocument.tracking = 0;			if (parseFloat(app.version) >= 13.2 ) {				businessLecturer_TextDocument.verticalScale = 1;				businessLecturer_TextDocument.horizontalScale = 1;				businessLecturer_TextDocument.baselineShift = 0;				businessLecturer_TextDocument.tsume = 0;				// These values are read-only. You have to set them manually in the comp.				// businessLecturer_TextDocument.fauxBold = false;				// businessLecturer_TextDocument.fauxItalic = false;				// businessLecturer_TextDocument.allCaps = false;				// businessLecturer_TextDocument.smallCaps = false;				// businessLecturer_TextDocument.superscript = false;				// businessLecturer_TextDocument.subscript = false;			}			businessLecturer_TextProp.setValue(businessLecturer_TextDocument);		businessLecturer.property("ADBE Effect Parade").addProperty("ADBE Gaussian Blur");		var businessLecturerBlurriness = businessLecturer.property("ADBE Effect Parade").property(1).property("ADBE Gaussian Blur-0001");			var businessLecturerBlurriness_keyTimesArray = [8.2,9];			var businessLecturerBlurriness_valuesArray = [0,40];			businessLecturerBlurriness.setValuesAtTimes(businessLecturerBlurriness_keyTimesArray, businessLecturerBlurriness_valuesArray);			var businessLecturerBlurriness_easeInSpeedArray = [0,0];			var businessLecturerBlurriness_easeInInfluArray = [16.666666667,60];			var businessLecturerBlurriness_easeOutSpeedArray = [0,0];			var businessLecturerBlurriness_easeOutInfluArray = [60,16.666666667];			var businessLecturerBlurriness_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var businessLecturerBlurriness_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(businessLecturerBlurriness, businessLecturerBlurriness_keyTimesArray, [businessLecturerBlurriness_easeInSpeedArray, businessLecturerBlurriness_easeInInfluArray], [businessLecturerBlurriness_easeOutSpeedArray, businessLecturerBlurriness_easeOutInfluArray], [businessLecturerBlurriness_keyInInterpolationType, businessLecturerBlurriness_keyOutInterpolationType]);		businessLecturer.property("ADBE Transform Group").property("ADBE Position").setValue([1266.53045654297,978,0]);		var businessLecturerOpacity = businessLecturer.property("ADBE Transform Group").property("ADBE Opacity");			var businessLecturerOpacity_keyTimesArray = [1.32,2.16,8.2,9];			var businessLecturerOpacity_valuesArray = [0,100,100,0];			businessLecturerOpacity.setValuesAtTimes(businessLecturerOpacity_keyTimesArray, businessLecturerOpacity_valuesArray);			var businessLecturerOpacity_easeInSpeedArray = [0,0,0,0];			var businessLecturerOpacity_easeInInfluArray = [60,60,60,60];			var businessLecturerOpacity_easeOutSpeedArray = [0,0,0,0];			var businessLecturerOpacity_easeOutInfluArray = [60,60,60,16.666666667];			var businessLecturerOpacity_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var businessLecturerOpacity_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(businessLecturerOpacity, businessLecturerOpacity_keyTimesArray, [businessLecturerOpacity_easeInSpeedArray, businessLecturerOpacity_easeInInfluArray], [businessLecturerOpacity_easeOutSpeedArray, businessLecturerOpacity_easeOutInfluArray], [businessLecturerOpacity_keyInInterpolationType, businessLecturerOpacity_keyOutInterpolationType]);		businessLecturer.selected = false;	var markMckenna2 = markunitlowerthirds_comp.layers.addText("Mark McKenna");		markMckenna2.name = "Mark McKenna 2";		markMckenna2.motionBlur = true;		markMckenna2.moveToEnd();		var markMckenna2_TextProp = markMckenna2.property("ADBE Text Properties").property("ADBE Text Document");		var markMckenna2_TextDocument = markMckenna2_TextProp.value;			markMckenna2_TextDocument.font = "OpenSans-Semibold";			markMckenna2_TextDocument.fontSize = 65;			markMckenna2_TextDocument.applyFill = true;			markMckenna2_TextDocument.fillColor = [1,1,1];			markMckenna2_TextDocument.applyStroke = false;			markMckenna2_TextDocument.justification = ParagraphJustification.LEFT_JUSTIFY;			markMckenna2_TextDocument.tracking = 0;			if (parseFloat(app.version) >= 13.2 ) {				markMckenna2_TextDocument.verticalScale = 1;				markMckenna2_TextDocument.horizontalScale = 1;				markMckenna2_TextDocument.baselineShift = 0;				markMckenna2_TextDocument.tsume = 0;				// These values are read-only. You have to set them manually in the comp.				// markMckenna2_TextDocument.fauxBold = false;				// markMckenna2_TextDocument.fauxItalic = false;				// markMckenna2_TextDocument.allCaps = false;				// markMckenna2_TextDocument.smallCaps = false;				// markMckenna2_TextDocument.superscript = false;				// markMckenna2_TextDocument.subscript = false;			}			markMckenna2_TextProp.setValue(markMckenna2_TextDocument);		markMckenna2.property("ADBE Effect Parade").addProperty("ADBE Gaussian Blur");		var markMckenna2Blurriness = markMckenna2.property("ADBE Effect Parade").property(1).property("ADBE Gaussian Blur-0001");			var markMckenna2Blurriness_keyTimesArray = [8.2,9];			var markMckenna2Blurriness_valuesArray = [0,40];			markMckenna2Blurriness.setValuesAtTimes(markMckenna2Blurriness_keyTimesArray, markMckenna2Blurriness_valuesArray);			var markMckenna2Blurriness_easeInSpeedArray = [0,0];			var markMckenna2Blurriness_easeInInfluArray = [16.666666667,60];			var markMckenna2Blurriness_easeOutSpeedArray = [0,0];			var markMckenna2Blurriness_easeOutInfluArray = [60,16.666666667];			var markMckenna2Blurriness_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var markMckenna2Blurriness_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(markMckenna2Blurriness, markMckenna2Blurriness_keyTimesArray, [markMckenna2Blurriness_easeInSpeedArray, markMckenna2Blurriness_easeInInfluArray], [markMckenna2Blurriness_easeOutSpeedArray, markMckenna2Blurriness_easeOutInfluArray], [markMckenna2Blurriness_keyInInterpolationType, markMckenna2Blurriness_keyOutInterpolationType]);		markMckenna2.property("ADBE Transform Group").property("ADBE Position").setValue([1334.41589355469,898,0]);		var markMckenna2Opacity = markMckenna2.property("ADBE Transform Group").property("ADBE Opacity");			var markMckenna2Opacity_keyTimesArray = [0,0.84,8.2,9];			var markMckenna2Opacity_valuesArray = [0,100,100,0];			markMckenna2Opacity.setValuesAtTimes(markMckenna2Opacity_keyTimesArray, markMckenna2Opacity_valuesArray);			var markMckenna2Opacity_easeInSpeedArray = [0,0,0,0];			var markMckenna2Opacity_easeInInfluArray = [60,60,60,60];			var markMckenna2Opacity_easeOutSpeedArray = [0,0,0,0];			var markMckenna2Opacity_easeOutInfluArray = [60,60,60,16.666666667];			var markMckenna2Opacity_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var markMckenna2Opacity_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(markMckenna2Opacity, markMckenna2Opacity_keyTimesArray, [markMckenna2Opacity_easeInSpeedArray, markMckenna2Opacity_easeInInfluArray], [markMckenna2Opacity_easeOutSpeedArray, markMckenna2Opacity_easeOutInfluArray], [markMckenna2Opacity_keyInInterpolationType, markMckenna2Opacity_keyOutInterpolationType]);		markMckenna2.selected = false;markunitlowerthirds_comp.openInViewer();} catch(e) {	alert(e.toString() + "\nError on line: " + e.line.toString());}app.endUndoGroup();function getItem(itemName, itemInstanceName, locationObject) {	if (locationObject.numItems > 0) {		for (var i = 1; i <= locationObject.numItems; i ++) {			var curItem = locationObject.item(i);			if (curItem.name === itemName) {				if (curItem instanceof itemInstanceName || (curItem.mainSource !== "undefined" && curItem.mainSource instanceof itemInstanceName)) {					return curItem;				}			}		}	}	return null;}function applyEasing(property, keyTimesArray, easeInArray, easeOutArray, keyInterpolationArray) {	for (var i = 0; i < keyTimesArray.length; i ++) {		if (property.propertyValueType === PropertyValueType.TwoD) {			var easeIn0 = new KeyframeEase(easeInArray[0][i][0], easeInArray[1][i][0]);			var easeOut0 = new KeyframeEase(easeOutArray[0][i][0], easeOutArray[1][i][0]);			var easeIn1 = new KeyframeEase(easeInArray[0][i][1], easeInArray[1][i][1]);			var easeOut1 = new KeyframeEase(easeOutArray[0][i][1], easeOutArray[1][i][1]);			property.setTemporalEaseAtKey(i+1, [easeIn0, easeIn1], [easeOut0, easeOut1]);		} else if (property.propertyValueType === PropertyValueType.ThreeD) {			var easeIn0 = new KeyframeEase(easeInArray[0][i][0], easeInArray[1][i][0]);			var easeOut0 = new KeyframeEase(easeOutArray[0][i][0], easeOutArray[1][i][0]);			var easeIn1 = new KeyframeEase(easeInArray[0][i][1], easeInArray[1][i][1]);			var easeOut1 = new KeyframeEase(easeOutArray[0][i][1], easeOutArray[1][i][1]);			var easeIn2 = new KeyframeEase(easeInArray[0][i][2], easeInArray[1][i][2]);			var easeOut2 = new KeyframeEase(easeOutArray[0][i][2], easeOutArray[1][i][2]);			property.setTemporalEaseAtKey(i+1, [easeIn0, easeIn1, easeIn2], [easeOut0, easeOut1, easeOut2]);		} else {			var easeIn = new KeyframeEase(easeInArray[0][i], easeInArray[1][i]);			var easeOut = new KeyframeEase(easeOutArray[0][i], easeOutArray[1][i]);			if (keyInterpolationArray[1][i] !== KeyframeInterpolationType.HOLD) {				property.setTemporalEaseAtKey(i+1, [easeIn], [easeOut]);			} else {				property.setTemporalEaseAtKey(i+1, [easeIn]);			}		}		property.setInterpolationTypeAtKey(i+1, keyInterpolationArray[0][i], keyInterpolationArray[1][i]);	}}}