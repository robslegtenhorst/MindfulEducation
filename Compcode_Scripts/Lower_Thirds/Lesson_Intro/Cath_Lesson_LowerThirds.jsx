// Created using compCode v1.0.2// 20160721 from composition "Cath_Lesson_LowerThirds" in project "/mindful_share/Courses/tre_aat-l2/unit_01/lesson_02/04_parts/part_01/02_after_effects/01_ae_build/tre_aat-l2_U01_L02_P01_v002.aep"//// aescripts.com/compCode// compCode_20160721_103808();function compCode_20160721_103808() {app.beginUndoGroup("Cath_Lesson_LowerThirds");try {// Create Folder hierarchy	var zcompcodescripts_folder = getItem("Z_Compcode_Scripts", FolderItem, app.project.rootFolder);	if (zcompcodescripts_folder === null) {		zcompcodescripts_folder = app.project.items.addFolder("Z_Compcode_Scripts");	}	var lowerthirds_folder = getItem("LowerThirds", FolderItem, zcompcodescripts_folder);	if (lowerthirds_folder === null) {		lowerthirds_folder = app.project.items.addFolder("LowerThirds");		lowerthirds_folder.parentFolder = zcompcodescripts_folder;	}	var lessonintro_folder = getItem("lesson_intro", FolderItem, lowerthirds_folder);	if (lessonintro_folder === null) {		lessonintro_folder = app.project.items.addFolder("lesson_intro");		lessonintro_folder.parentFolder = lowerthirds_folder;	}// Create Compositions	var cathlessonlowerthirds_comp = app.project.items.addComp("Cath_Lesson_LowerThirds", 1920, 1080, 1, 57.8, 25);		cathlessonlowerthirds_comp.time = 26.8;		cathlessonlowerthirds_comp.bgColor = [0,0,0];		cathlessonlowerthirds_comp.shutterPhase = -90;		cathlessonlowerthirds_comp.label = 11;		cathlessonlowerthirds_comp.parentFolder = lessonintro_folder;// Working with comp "Cath_Lesson_LowerThirds", varName "cathlessonlowerthirds_comp";	cathlessonlowerthirds_comp.openInViewer();	var accountingLecturer = cathlessonlowerthirds_comp.layers.addText("Accounting Lecturer");		accountingLecturer.label = 14;		accountingLecturer.startTime = -0.4;		accountingLecturer.inPoint = 0;		accountingLecturer.outPoint = 57.8;		accountingLecturer.motionBlur = true;		accountingLecturer.moveToEnd();		var accountingLecturer_TextProp = accountingLecturer.property("ADBE Text Properties").property("ADBE Text Document");		var accountingLecturer_TextDocument = accountingLecturer_TextProp.value;			accountingLecturer_TextDocument.font = "OpenSans";			accountingLecturer_TextDocument.fontSize = 20;			accountingLecturer_TextDocument.applyFill = true;			accountingLecturer_TextDocument.fillColor = [1,1,1];			accountingLecturer_TextDocument.applyStroke = false;			accountingLecturer_TextDocument.justification = ParagraphJustification.LEFT_JUSTIFY;			accountingLecturer_TextDocument.tracking = 0;			if (parseFloat(app.version) >= 13.2 ) {				accountingLecturer_TextDocument.verticalScale = 1;				accountingLecturer_TextDocument.horizontalScale = 1;				accountingLecturer_TextDocument.baselineShift = 0;				accountingLecturer_TextDocument.tsume = 0;				// These values are read-only. You have to set them manually in the comp.				// accountingLecturer_TextDocument.fauxBold = false;				// accountingLecturer_TextDocument.fauxItalic = false;				// accountingLecturer_TextDocument.allCaps = false;				// accountingLecturer_TextDocument.smallCaps = false;				// accountingLecturer_TextDocument.superscript = false;				// accountingLecturer_TextDocument.subscript = false;			}			accountingLecturer_TextProp.setValue(accountingLecturer_TextDocument);		accountingLecturer.property("ADBE Effect Parade").addProperty("ADBE Gaussian Blur");		accountingLecturer.property("ADBE Effect Parade").property(1).property("ADBE Gaussian Blur-0001").setValue(0.08870568025698);		accountingLecturer.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([-2.218994140625,-21.817626953125,0]);		accountingLecturer.property("ADBE Transform Group").property("ADBE Position").setValue([103.526467715975,955.182059268853,0]);		accountingLecturer.property("ADBE Transform Group").property("ADBE Scale").setValue([264.705882352941,264.705882352941,100]);		var accountingLecturerOpacity = accountingLecturer.property("ADBE Transform Group").property("ADBE Opacity");			var accountingLecturerOpacity_keyTimesArray = [21.24,22.48,31.76,33];			var accountingLecturerOpacity_valuesArray = [0,99.7782357993575,99.7782357993575,0];			accountingLecturerOpacity.setValuesAtTimes(accountingLecturerOpacity_keyTimesArray, accountingLecturerOpacity_valuesArray);			var accountingLecturerOpacity_easeInSpeedArray = [0,0,0,0];			var accountingLecturerOpacity_easeInInfluArray = [16.666666667,60,60,60];			var accountingLecturerOpacity_easeOutSpeedArray = [0,0,0,0];			var accountingLecturerOpacity_easeOutInfluArray = [60,16.666666667,60,16.666666667];			var accountingLecturerOpacity_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			var accountingLecturerOpacity_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];			applyEasing(accountingLecturerOpacity, accountingLecturerOpacity_keyTimesArray, [accountingLecturerOpacity_easeInSpeedArray, accountingLecturerOpacity_easeInInfluArray], [accountingLecturerOpacity_easeOutSpeedArray, accountingLecturerOpacity_easeOutInfluArray], [accountingLecturerOpacity_keyInInterpolationType, accountingLecturerOpacity_keyOutInterpolationType]);		accountingLecturer.selected = false;cathlessonlowerthirds_comp.openInViewer();} catch(e) {	alert(e.toString() + "\nError on line: " + e.line.toString());}app.endUndoGroup();function getItem(itemName, itemInstanceName, locationObject) {	if (locationObject.numItems > 0) {		for (var i = 1; i <= locationObject.numItems; i ++) {			var curItem = locationObject.item(i);			if (curItem.name === itemName) {				if (curItem instanceof itemInstanceName || (curItem.mainSource !== "undefined" && curItem.mainSource instanceof itemInstanceName)) {					return curItem;				}			}		}	}	return null;}function applyEasing(property, keyTimesArray, easeInArray, easeOutArray, keyInterpolationArray) {	for (var i = 0; i < keyTimesArray.length; i ++) {		if (property.propertyValueType === PropertyValueType.TwoD) {			var easeIn0 = new KeyframeEase(easeInArray[0][i][0], easeInArray[1][i][0]);			var easeOut0 = new KeyframeEase(easeOutArray[0][i][0], easeOutArray[1][i][0]);			var easeIn1 = new KeyframeEase(easeInArray[0][i][1], easeInArray[1][i][1]);			var easeOut1 = new KeyframeEase(easeOutArray[0][i][1], easeOutArray[1][i][1]);			property.setTemporalEaseAtKey(i+1, [easeIn0, easeIn1], [easeOut0, easeOut1]);		} else if (property.propertyValueType === PropertyValueType.ThreeD) {			var easeIn0 = new KeyframeEase(easeInArray[0][i][0], easeInArray[1][i][0]);			var easeOut0 = new KeyframeEase(easeOutArray[0][i][0], easeOutArray[1][i][0]);			var easeIn1 = new KeyframeEase(easeInArray[0][i][1], easeInArray[1][i][1]);			var easeOut1 = new KeyframeEase(easeOutArray[0][i][1], easeOutArray[1][i][1]);			var easeIn2 = new KeyframeEase(easeInArray[0][i][2], easeInArray[1][i][2]);			var easeOut2 = new KeyframeEase(easeOutArray[0][i][2], easeOutArray[1][i][2]);			property.setTemporalEaseAtKey(i+1, [easeIn0, easeIn1, easeIn2], [easeOut0, easeOut1, easeOut2]);		} else {			var easeIn = new KeyframeEase(easeInArray[0][i], easeInArray[1][i]);			var easeOut = new KeyframeEase(easeOutArray[0][i], easeOutArray[1][i]);			if (keyInterpolationArray[1][i] !== KeyframeInterpolationType.HOLD) {				property.setTemporalEaseAtKey(i+1, [easeIn], [easeOut]);			} else {				property.setTemporalEaseAtKey(i+1, [easeIn]);			}		}		property.setInterpolationTypeAtKey(i+1, keyInterpolationArray[0][i], keyInterpolationArray[1][i]);	}}}