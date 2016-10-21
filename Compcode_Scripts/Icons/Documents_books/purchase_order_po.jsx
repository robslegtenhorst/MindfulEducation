// Created using compCode v1.0.2
// 20160617 from composition "purchase_order_po" in project "/mindful_share/Courses/tre_aat-l2/unit_01/lesson_01/04_parts/part_03/02_after_effects/01_ae_build/v003/tre_aat-l2_u01_l01_p03.aep"
//
// aescripts.com/compCode

// compCode_20160617_153007();
function compCode_20160617_153007() {

app.beginUndoGroup("purchase_order_po");

try {

// Create Folder hierarchy
	var zcompcodescripts_folder = getItem("Z_Compcode_Scripts", FolderItem, app.project.rootFolder);
	if (zcompcodescripts_folder === null) {
		zcompcodescripts_folder = app.project.items.addFolder("Z_Compcode_Scripts");
	}
	var documentsbooks_folder = getItem("Documents_books", FolderItem, zcompcodescripts_folder);
	if (documentsbooks_folder === null) {
		documentsbooks_folder = app.project.items.addFolder("Documents_books");
		documentsbooks_folder.parentFolder = zcompcodescripts_folder;
	}
	var out_folder = getItem("OUT", FolderItem, documentsbooks_folder);
	if (out_folder === null) {
		out_folder = app.project.items.addFolder("OUT");
		out_folder.parentFolder = documentsbooks_folder;
	}
	var precomps_folder = getItem("PreComps", FolderItem, documentsbooks_folder);
	if (precomps_folder === null) {
		precomps_folder = app.project.items.addFolder("PreComps");
		precomps_folder.parentFolder = documentsbooks_folder;
	}

// Create Compositions
	var purchaseorderpo_comp = app.project.items.addComp("purchase_order_po", 412, 412, 1, 2.8, 25);
		purchaseorderpo_comp.time = 0;
		purchaseorderpo_comp.bgColor = [0,0,0];
		purchaseorderpo_comp.parentFolder = out_folder;
	var purchaseorderpoanimation_comp = getItem("purchase_order_po_animation", CompItem, precomps_folder);
	var purchaseorderpoanimation_comp_populate = false;
	if (purchaseorderpoanimation_comp === null) {
		purchaseorderpoanimation_comp = app.project.items.addComp("purchase_order_po_animation", 412, 412, 1, 1.24, 25);
		purchaseorderpoanimation_comp.time = 0;
		purchaseorderpoanimation_comp.bgColor = [0,0,0];
		purchaseorderpoanimation_comp.shutterPhase = -90;
		purchaseorderpoanimation_comp.motionBlur = true;
		purchaseorderpoanimation_comp.parentFolder = precomps_folder;
		purchaseorderpoanimation_comp_populate = true;
	}

// Working with comp "purchase_order_po", varName "purchaseorderpo_comp";
	purchaseorderpo_comp.openInViewer();
	// Add Shape Layer "Icon_bg_mask 2", varName "iconbgmask2";
	var iconbgmask2 = purchaseorderpo_comp.layers.addShape();
		iconbgmask2.name = "Icon_bg_mask 2";
		iconbgmask2.enabled = false;
		iconbgmask2.motionBlur = true;
		iconbgmask2.moveToEnd();
		iconbgmask2.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		iconbgmask2.property("ADBE Root Vectors Group").property(1).name = "chemicals Outlines - Group 22";
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Group");
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).property(1).name = "Group 22";
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var iconbgmask2Path = iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var iconbgmask2Path_newShape = new Shape();
			iconbgmask2Path_newShape.vertices = [[144, 0], [0, 144], [-144, 0], [0, -144]];
			iconbgmask2Path_newShape.inTangents = [[0, -79.5289916992188], [79.5289916992188, 0], [0, 79.5289916992188], [-79.5290069580078, 0]];
			iconbgmask2Path_newShape.outTangents = [[0, 79.5289916992188], [-79.5290069580078, 0], [0, -79.5289916992188], [79.5289916992188, 0]];
			iconbgmask2Path_newShape.closed = true;
		iconbgmask2Path.setValue(iconbgmask2Path_newShape);
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(12);
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Anchor").setValue([206,206]);
		iconbgmask2.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbgmask2.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		iconbgmask2.property("ADBE Root Vectors Group").property(2).name = "chemicals Outlines - Group 23";
		iconbgmask2.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Group");
		iconbgmask2.property("ADBE Root Vectors Group").property(2).property(2).property(1).name = "Group 23";
		iconbgmask2.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var iconbgmask2Path = iconbgmask2.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var iconbgmask2Path_newShape = new Shape();
			iconbgmask2Path_newShape.vertices = [[144, 0], [0, 144], [-144, 0], [0, -144]];
			iconbgmask2Path_newShape.inTangents = [[0, -79.5289916992188], [79.5289916992188, 0], [0, 79.5289916992188], [-79.5290069580078, 0]];
			iconbgmask2Path_newShape.outTangents = [[0, 79.5289916992188], [-79.5290069580078, 0], [0, -79.5289916992188], [79.5289916992188, 0]];
			iconbgmask2Path_newShape.closed = true;
		iconbgmask2Path.setValue(iconbgmask2Path_newShape);
		iconbgmask2.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		iconbgmask2.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(2).property("ADBE Vector Fill Color").setValue([0.1410000026226,0.6710000038147,0.88999998569489,1]);
		iconbgmask2.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbgmask2.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Anchor").setValue([206,206]);
		iconbgmask2.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbgmask2.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([206,206,0]);
		var iconbgmask2Scale = iconbgmask2.property("ADBE Transform Group").property("ADBE Scale");
			var iconbgmask2Scale_keyTimesArray = [0,0.4,2.4,2.76];
			var iconbgmask2Scale_valuesArray = [[0,0,100],[100,100,100],[100,100,100],[0,0,100]];
			iconbgmask2Scale.setValuesAtTimes(iconbgmask2Scale_keyTimesArray, iconbgmask2Scale_valuesArray);
			var iconbgmask2Scale_easeInSpeedArray = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
			var iconbgmask2Scale_easeInInfluArray = [[50,50,50],[50,50,50],[50,50,50],[50,50,50]];
			var iconbgmask2Scale_easeOutSpeedArray = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
			var iconbgmask2Scale_easeOutInfluArray = [[50,50,50],[50,50,50],[50,50,50],[50,50,50]];
			var iconbgmask2Scale_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var iconbgmask2Scale_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(iconbgmask2Scale, iconbgmask2Scale_keyTimesArray, [iconbgmask2Scale_easeInSpeedArray, iconbgmask2Scale_easeInInfluArray], [iconbgmask2Scale_easeOutSpeedArray, iconbgmask2Scale_easeOutInfluArray], [iconbgmask2Scale_keyInInterpolationType, iconbgmask2Scale_keyOutInterpolationType]);

		iconbgmask2.selected = false;
	// Add existing composition "purchase_order_po_animation", varName "purchaseorderpoanimation_comp";
	var purchaseorderpoanimation = purchaseorderpo_comp.layers.add(purchaseorderpoanimation_comp);
		purchaseorderpoanimation.outPoint = 1.24;
		purchaseorderpoanimation.motionBlur = true;
		purchaseorderpoanimation.moveToEnd();
		purchaseorderpoanimation.trackMatteType = TrackMatteType.ALPHA;
		purchaseorderpoanimation.timeRemapEnabled = true;
		purchaseorderpoanimation.outPoint = 70 / purchaseorderpoanimation.containingComp.frameRate;
		var purchaseorderpoanimationTimeRemap = purchaseorderpoanimation.property("ADBE Time Remapping");
			purchaseorderpoanimationTimeRemap.setValueAtTime(99999, purchaseorderpoanimationTimeRemap.keyValue(1));
			purchaseorderpoanimationTimeRemap.removeKey(2);
			purchaseorderpoanimationTimeRemap.removeKey(1);
			var purchaseorderpoanimationTimeRemap_keyTimesArray = [0,1.2,1.6,2.76];
			var purchaseorderpoanimationTimeRemap_valuesArray = [0,1.20000004768372,1.20000004768372,0];
			purchaseorderpoanimationTimeRemap.setValuesAtTimes(purchaseorderpoanimationTimeRemap_keyTimesArray, purchaseorderpoanimationTimeRemap_valuesArray);
			purchaseorderpoanimationTimeRemap.removeKey(purchaseorderpoanimationTimeRemap.nearestKeyIndex(99999));
		purchaseorderpoanimation.selected = false;
	// Add Shape Layer "Icon_bg_mask", varName "iconbgmask";
	var iconbgmask = purchaseorderpo_comp.layers.addShape();
		iconbgmask.name = "Icon_bg_mask";
		iconbgmask.enabled = false;
		iconbgmask.motionBlur = true;
		iconbgmask.moveToEnd();
		iconbgmask.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		iconbgmask.property("ADBE Root Vectors Group").property(1).name = "chemicals Outlines - Group 22";
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Group");
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).property(1).name = "Group 22";
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var iconbgmaskPath = iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var iconbgmaskPath_newShape = new Shape();
			iconbgmaskPath_newShape.vertices = [[144, 0], [0, 144], [-144, 0], [0, -144]];
			iconbgmaskPath_newShape.inTangents = [[0, -79.5289916992188], [79.5289916992188, 0], [0, 79.5289916992188], [-79.5290069580078, 0]];
			iconbgmaskPath_newShape.outTangents = [[0, 79.5289916992188], [-79.5290069580078, 0], [0, -79.5289916992188], [79.5289916992188, 0]];
			iconbgmaskPath_newShape.closed = true;
		iconbgmaskPath.setValue(iconbgmaskPath_newShape);
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(12);
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Anchor").setValue([206,206]);
		iconbgmask.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbgmask.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		iconbgmask.property("ADBE Root Vectors Group").property(2).name = "chemicals Outlines - Group 23";
		iconbgmask.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Group");
		iconbgmask.property("ADBE Root Vectors Group").property(2).property(2).property(1).name = "Group 23";
		iconbgmask.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var iconbgmaskPath = iconbgmask.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var iconbgmaskPath_newShape = new Shape();
			iconbgmaskPath_newShape.vertices = [[144, 0], [0, 144], [-144, 0], [0, -144]];
			iconbgmaskPath_newShape.inTangents = [[0, -79.5289916992188], [79.5289916992188, 0], [0, 79.5289916992188], [-79.5290069580078, 0]];
			iconbgmaskPath_newShape.outTangents = [[0, 79.5289916992188], [-79.5290069580078, 0], [0, -79.5289916992188], [79.5289916992188, 0]];
			iconbgmaskPath_newShape.closed = true;
		iconbgmaskPath.setValue(iconbgmaskPath_newShape);
		iconbgmask.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		iconbgmask.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(2).property("ADBE Vector Fill Color").setValue([0.1410000026226,0.6710000038147,0.88999998569489,1]);
		iconbgmask.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbgmask.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Anchor").setValue([206,206]);
		iconbgmask.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbgmask.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([206,206,0]);
		var iconbgmaskScale = iconbgmask.property("ADBE Transform Group").property("ADBE Scale");
			var iconbgmaskScale_keyTimesArray = [0,0.4,2.4,2.76];
			var iconbgmaskScale_valuesArray = [[0,0,100],[100,100,100],[100,100,100],[0,0,100]];
			iconbgmaskScale.setValuesAtTimes(iconbgmaskScale_keyTimesArray, iconbgmaskScale_valuesArray);
			var iconbgmaskScale_easeInSpeedArray = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
			var iconbgmaskScale_easeInInfluArray = [[50,50,50],[50,50,50],[50,50,50],[50,50,50]];
			var iconbgmaskScale_easeOutSpeedArray = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
			var iconbgmaskScale_easeOutInfluArray = [[50,50,50],[50,50,50],[50,50,50],[50,50,50]];
			var iconbgmaskScale_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var iconbgmaskScale_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(iconbgmaskScale, iconbgmaskScale_keyTimesArray, [iconbgmaskScale_easeInSpeedArray, iconbgmaskScale_easeInInfluArray], [iconbgmaskScale_easeOutSpeedArray, iconbgmaskScale_easeOutInfluArray], [iconbgmaskScale_keyInInterpolationType, iconbgmaskScale_keyOutInterpolationType]);

		iconbgmask.selected = false;
	// Add existing composition "purchase_order_po_animation", varName "purchaseorderpoanimation_comp";
	var shadow = purchaseorderpo_comp.layers.add(purchaseorderpoanimation_comp);
		shadow.name = "shadow";
		shadow.outPoint = 1.24;
		shadow.motionBlur = true;
		shadow.moveToEnd();
		shadow.trackMatteType = TrackMatteType.ALPHA;
		shadow.timeRemapEnabled = true;
		shadow.outPoint = 70 / shadow.containingComp.frameRate;
		var shadowTimeRemap = shadow.property("ADBE Time Remapping");
			shadowTimeRemap.setValueAtTime(99999, shadowTimeRemap.keyValue(1));
			shadowTimeRemap.removeKey(2);
			shadowTimeRemap.removeKey(1);
			var shadowTimeRemap_keyTimesArray = [0,1.2,1.6,2.76];
			var shadowTimeRemap_valuesArray = [0,1.20000004768372,1.20000004768372,0];
			shadowTimeRemap.setValuesAtTimes(shadowTimeRemap_keyTimesArray, shadowTimeRemap_valuesArray);
			shadowTimeRemap.removeKey(shadowTimeRemap.nearestKeyIndex(99999));
		shadow.property("ADBE Effect Parade").addProperty("ADBE Fill");
		shadow.property("ADBE Effect Parade").property(1).property("ADBE Fill-0002").setValue([0,0,0,1]);
		var shadowPosition = shadow.property("ADBE Transform Group").property("ADBE Position");
			var shadowPosition_keyTimesArray = [0.28,0.6,2.2,2.48];
			var shadowPosition_valuesArray = [[206,206,0],[227.5,218.5,0],[227.5,218.5,0],[206,206,0]];
			shadowPosition.setValuesAtTimes(shadowPosition_keyTimesArray, shadowPosition_valuesArray);
			var shadowPosition_inSpatialTangents = [[-3.58333325386047,-2.08333325386047,0],[-3.58333325386047,-2.08333325386047,0],[0,0,0],[3.58333325386047,2.08333325386047,0]];
			var shadowPosition_outSpatialTangents = [[3.58333325386047,2.08333325386047,0],[0,0,0],[-3.58333325386047,-2.08333325386047,0],[-3.58333325386047,-2.08333325386047,0]];
			applySpatialTangents(shadowPosition, shadowPosition_keyTimesArray, shadowPosition_inSpatialTangents, shadowPosition_outSpatialTangents);
			var shadowPosition_easeInSpeedArray = [0,0,0,0];
			var shadowPosition_easeInInfluArray = [16.666666667,50,50,16.666666667];
			var shadowPosition_easeOutSpeedArray = [0,0,0,0];
			var shadowPosition_easeOutInfluArray = [50,16.666666667,16.666666667,50];
			var shadowPosition_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var shadowPosition_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(shadowPosition, shadowPosition_keyTimesArray, [shadowPosition_easeInSpeedArray, shadowPosition_easeInInfluArray], [shadowPosition_easeOutSpeedArray, shadowPosition_easeOutInfluArray], [shadowPosition_keyInInterpolationType, shadowPosition_keyOutInterpolationType]);

		shadow.property("ADBE Transform Group").property("ADBE Opacity").setValue(20);
		shadow.selected = false;
	// Add Shape Layer "Icon_bg", varName "iconbg";
	var iconbg = purchaseorderpo_comp.layers.addShape();
		iconbg.name = "Icon_bg";
		iconbg.motionBlur = true;
		iconbg.moveToEnd();
		iconbg.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		iconbg.property("ADBE Root Vectors Group").property(1).name = "chemicals Outlines - Group 22";
		iconbg.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Group");
		iconbg.property("ADBE Root Vectors Group").property(1).property(2).property(1).name = "Group 22";
		iconbg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var iconbgPath = iconbg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var iconbgPath_newShape = new Shape();
			iconbgPath_newShape.vertices = [[144, 0], [0, 144], [-144, 0], [0, -144]];
			iconbgPath_newShape.inTangents = [[0, -79.5289916992188], [79.5289916992188, 0], [0, 79.5289916992188], [-79.5290069580078, 0]];
			iconbgPath_newShape.outTangents = [[0, 79.5289916992188], [-79.5290069580078, 0], [0, -79.5289916992188], [79.5289916992188, 0]];
			iconbgPath_newShape.closed = true;
		iconbgPath.setValue(iconbgPath_newShape);
		iconbg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		iconbg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		iconbg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(12);
		iconbg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		iconbg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		iconbg.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbg.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Anchor").setValue([206,206]);
		iconbg.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbg.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		iconbg.property("ADBE Root Vectors Group").property(2).name = "chemicals Outlines - Group 23";
		iconbg.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Group");
		iconbg.property("ADBE Root Vectors Group").property(2).property(2).property(1).name = "Group 23";
		iconbg.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var iconbgPath = iconbg.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var iconbgPath_newShape = new Shape();
			iconbgPath_newShape.vertices = [[144, 0], [0, 144], [-144, 0], [0, -144]];
			iconbgPath_newShape.inTangents = [[0, -79.5289916992188], [79.5289916992188, 0], [0, 79.5289916992188], [-79.5290069580078, 0]];
			iconbgPath_newShape.outTangents = [[0, 79.5289916992188], [-79.5290069580078, 0], [0, -79.5289916992188], [79.5289916992188, 0]];
			iconbgPath_newShape.closed = true;
		iconbgPath.setValue(iconbgPath_newShape);
		iconbg.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		iconbg.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(2).property("ADBE Vector Fill Color").setValue([0.1410000026226,0.6710000038147,0.88999998569489,1]);
		iconbg.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(2).property("ADBE Vector Fill Opacity").setValue(60);
		iconbg.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbg.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Anchor").setValue([206,206]);
		iconbg.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Position").setValue([206,206]);
		iconbg.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([206,206,0]);
		var iconbgScale = iconbg.property("ADBE Transform Group").property("ADBE Scale");
			var iconbgScale_keyTimesArray = [0,0.4,2.4,2.76];
			var iconbgScale_valuesArray = [[0,0,100],[100,100,100],[100,100,100],[0,0,100]];
			iconbgScale.setValuesAtTimes(iconbgScale_keyTimesArray, iconbgScale_valuesArray);
			var iconbgScale_easeInSpeedArray = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
			var iconbgScale_easeInInfluArray = [[50,50,50],[50,50,50],[50,50,50],[50,50,50]];
			var iconbgScale_easeOutSpeedArray = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
			var iconbgScale_easeOutInfluArray = [[50,50,50],[50,50,50],[50,50,50],[50,50,50]];
			var iconbgScale_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var iconbgScale_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(iconbgScale, iconbgScale_keyTimesArray, [iconbgScale_easeInSpeedArray, iconbgScale_easeInInfluArray], [iconbgScale_easeOutSpeedArray, iconbgScale_easeOutInfluArray], [iconbgScale_keyInInterpolationType, iconbgScale_keyOutInterpolationType]);

		iconbg.selected = false;
// Working with comp "purchase_order_po_animation", varName "purchaseorderpoanimation_comp";
if (purchaseorderpoanimation_comp_populate === true) {
	// Add Shape Layer "purchase_order_po Outlines - Group 3", varName "purchaseorderpoOutlinesGroup3";
	var purchaseorderpoOutlinesGroup3 = purchaseorderpoanimation_comp.layers.addShape();
		purchaseorderpoOutlinesGroup3.name = "purchase_order_po Outlines - Group 3";
		purchaseorderpoOutlinesGroup3.startTime = 0.08;
		purchaseorderpoOutlinesGroup3.inPoint = 0.88;
		purchaseorderpoOutlinesGroup3.outPoint = 1.4;
		purchaseorderpoOutlinesGroup3.motionBlur = true;
		purchaseorderpoOutlinesGroup3.moveToEnd();
		purchaseorderpoOutlinesGroup3.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		purchaseorderpoOutlinesGroup3.property("ADBE Root Vectors Group").property(1).name = "Group 3";
		purchaseorderpoOutlinesGroup3.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup3Path = purchaseorderpoOutlinesGroup3.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup3Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup3Path_newShape.vertices = [[2.17550659179688, -6.51699829101562], [3.73150634765625, -6.34999084472656], [5.45350646972656, -5.760986328125], [4.18849182128906, -3.13299560546875], [3.18649291992188, -3.54598999023438], [2.31649780273438, -3.68699645996094], [1.82049560546875, -3.47099304199219], [1.50749206542969, -2.65899658203125], [1.29649353027344, -1.65699768066406], [3.50250244140625, -1.65699768066406], [3.00149536132812, 0.79501342773438], [0.7864990234375, 0.79501342773438], [0.61149597167969, 1.62200927734375], [-0.00050354003906, 2.79501342773438], [-1.17350769042969, 3.61700439453125], [4.135498046875, 3.61700439453125], [3.50250244140625, 6.51701354980469], [-5.45350646972656, 6.51701354980469], [-4.89950561523438, 3.76600646972656], [-3.84049987792969, 3.33601379394531], [-3.2344970703125, 2.72401428222656], [-2.8695068359375, 1.63900756835938], [-2.68449401855469, 0.79501342773438], [-4.33749389648438, 0.79501342773438], [-3.83650207519531, -1.65699768066406], [-2.18350219726562, -1.65699768066406], [-1.98150634765625, -2.78999328613281], [-1.2344970703125, -4.92599487304688], [0.08749389648438, -6.13499450683594]];
			purchaseorderpoOutlinesGroup3Path_newShape.inTangents = [[-0.85501098632812, 0], [-0.51600646972656, -0.11099243164062], [-0.63200378417969, -0.281005859375], [0, 0], [0.281005859375, 0.09300231933594], [0.29800415039062, 0], [0.125, -0.14399719238281], [0.08200073242188, -0.39799499511719], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0.31399536132812, -0.34800720214844], [0.46900939941406, -0.19898986816406], [0, 0], [0, 0], [0, 0], [0, 0], [-0.26100158691406, 0.16400146484375], [-0.14399719238281, 0.24398803710938], [-0.09999084472656, 0.48100280761719], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [-0.34600830078125, 0.55101013183594], [-0.53498840332031, 0.25599670410156]];
			purchaseorderpoOutlinesGroup3Path_newShape.outTangents = [[0.52099609375, 0], [0.51499938964844, 0.11100769042969], [0, 0], [-0.38699340820312, -0.18199157714844], [-0.28199768066406, -0.093994140625], [-0.20500183105469, 0], [-0.12699890136719, 0.14300537109375], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [-0.093994140625, 0.43299865722656], [-0.31300354003906, 0.3489990234375], [0, 0], [0, 0], [0, 0], [0, 0], [0.44500732421875, -0.12300109863281], [0.25999450683594, -0.16500854492188], [0.14299011230469, -0.24200439453125], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0.15200805664062, -0.87300109863281], [0.34599304199219, -0.55099487304688], [0.53700256347656, -0.25399780273438]];
			purchaseorderpoOutlinesGroup3Path_newShape.closed = true;
		purchaseorderpoOutlinesGroup3Path.setValue(purchaseorderpoOutlinesGroup3Path_newShape);
		purchaseorderpoOutlinesGroup3.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		purchaseorderpoOutlinesGroup3.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Fill Color").setValue([0,0,0,1]);
		purchaseorderpoOutlinesGroup3.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([235.795196533203,225.815795898438]);
		purchaseorderpoOutlinesGroup3.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([235.795196533203,225.815795898438,0]);
		purchaseorderpoOutlinesGroup3.property("ADBE Transform Group").property("ADBE Position").setValue([235.795196533203,225.815795898438,0]);
		var purchaseorderpoOutlinesGroup3Opacity = purchaseorderpoOutlinesGroup3.property("ADBE Transform Group").property("ADBE Opacity");
			var purchaseorderpoOutlinesGroup3Opacity_keyTimesArray = [0.88,1.12];
			var purchaseorderpoOutlinesGroup3Opacity_valuesArray = [0,100];
			purchaseorderpoOutlinesGroup3Opacity.setValuesAtTimes(purchaseorderpoOutlinesGroup3Opacity_keyTimesArray, purchaseorderpoOutlinesGroup3Opacity_valuesArray);
			var purchaseorderpoOutlinesGroup3Opacity_easeInSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup3Opacity_easeInInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup3Opacity_easeOutSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup3Opacity_easeOutInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup3Opacity_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var purchaseorderpoOutlinesGroup3Opacity_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(purchaseorderpoOutlinesGroup3Opacity, purchaseorderpoOutlinesGroup3Opacity_keyTimesArray, [purchaseorderpoOutlinesGroup3Opacity_easeInSpeedArray, purchaseorderpoOutlinesGroup3Opacity_easeInInfluArray], [purchaseorderpoOutlinesGroup3Opacity_easeOutSpeedArray, purchaseorderpoOutlinesGroup3Opacity_easeOutInfluArray], [purchaseorderpoOutlinesGroup3Opacity_keyInInterpolationType, purchaseorderpoOutlinesGroup3Opacity_keyOutInterpolationType]);

		purchaseorderpoOutlinesGroup3.selected = false;
	// Add Shape Layer "purchase_order_po Outlines - Group 4", varName "purchaseorderpoOutlinesGroup4";
	var purchaseorderpoOutlinesGroup4 = purchaseorderpoanimation_comp.layers.addShape();
		purchaseorderpoOutlinesGroup4.name = "purchase_order_po Outlines - Group 4";
		purchaseorderpoOutlinesGroup4.inPoint = 0.8;
		purchaseorderpoOutlinesGroup4.outPoint = 1.32;
		purchaseorderpoOutlinesGroup4.motionBlur = true;
		purchaseorderpoOutlinesGroup4.moveToEnd();
		purchaseorderpoOutlinesGroup4.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		purchaseorderpoOutlinesGroup4.property("ADBE Root Vectors Group").property(1).name = "Group 4";
		purchaseorderpoOutlinesGroup4.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup4Path = purchaseorderpoOutlinesGroup4.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup4Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup4Path_newShape.vertices = [[2.17550659179688, -6.51701354980469], [3.73150634765625, -6.35000610351562], [5.45350646972656, -5.76100158691406], [4.18849182128906, -3.13301086425781], [3.18649291992188, -3.54600524902344], [2.31649780273438, -3.68701171875], [1.82049560546875, -3.47100830078125], [1.50749206542969, -2.65901184082031], [1.29649353027344, -1.65701293945312], [3.50250244140625, -1.65701293945312], [3.00149536132812, 0.79499816894531], [0.7864990234375, 0.79499816894531], [0.61149597167969, 1.62199401855469], [-0.00050354003906, 2.79499816894531], [-1.17350769042969, 3.61698913574219], [4.135498046875, 3.61698913574219], [3.50250244140625, 6.51699829101562], [-5.45350646972656, 6.51699829101562], [-4.89950561523438, 3.7659912109375], [-3.84049987792969, 3.33599853515625], [-3.2344970703125, 2.7239990234375], [-2.8695068359375, 1.63899230957031], [-2.68449401855469, 0.79499816894531], [-4.33749389648438, 0.79499816894531], [-3.83650207519531, -1.65701293945312], [-2.18350219726562, -1.65701293945312], [-1.98150634765625, -2.79000854492188], [-1.2344970703125, -4.92601013183594], [0.08749389648438, -6.135009765625]];
			purchaseorderpoOutlinesGroup4Path_newShape.inTangents = [[-0.85501098632812, 0], [-0.51600646972656, -0.11099243164062], [-0.63200378417969, -0.281005859375], [0, 0], [0.281005859375, 0.09300231933594], [0.29800415039062, 0], [0.125, -0.14399719238281], [0.08200073242188, -0.39799499511719], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0.31399536132812, -0.34800720214844], [0.46900939941406, -0.19898986816406], [0, 0], [0, 0], [0, 0], [0, 0], [-0.26100158691406, 0.16400146484375], [-0.14399719238281, 0.24398803710938], [-0.09999084472656, 0.48100280761719], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [-0.34600830078125, 0.55101013183594], [-0.53498840332031, 0.25599670410156]];
			purchaseorderpoOutlinesGroup4Path_newShape.outTangents = [[0.52099609375, 0], [0.51499938964844, 0.11100769042969], [0, 0], [-0.38699340820312, -0.18199157714844], [-0.28199768066406, -0.093994140625], [-0.20500183105469, 0], [-0.12699890136719, 0.14300537109375], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [-0.093994140625, 0.43299865722656], [-0.31300354003906, 0.3489990234375], [0, 0], [0, 0], [0, 0], [0, 0], [0.44500732421875, -0.12300109863281], [0.25999450683594, -0.16500854492188], [0.14299011230469, -0.24200439453125], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0.15200805664062, -0.87300109863281], [0.34599304199219, -0.55099487304688], [0.53700256347656, -0.25399780273438]];
			purchaseorderpoOutlinesGroup4Path_newShape.closed = true;
		purchaseorderpoOutlinesGroup4Path.setValue(purchaseorderpoOutlinesGroup4Path_newShape);
		purchaseorderpoOutlinesGroup4.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		purchaseorderpoOutlinesGroup4.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Fill Color").setValue([0,0,0,1]);
		purchaseorderpoOutlinesGroup4.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([240.795196533203,203.482818603516]);
		purchaseorderpoOutlinesGroup4.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([240.795196533203,203.482818603516,0]);
		purchaseorderpoOutlinesGroup4.property("ADBE Transform Group").property("ADBE Position").setValue([240.795196533203,203.482818603516,0]);
		var purchaseorderpoOutlinesGroup4Opacity = purchaseorderpoOutlinesGroup4.property("ADBE Transform Group").property("ADBE Opacity");
			var purchaseorderpoOutlinesGroup4Opacity_keyTimesArray = [0.8,1.04];
			var purchaseorderpoOutlinesGroup4Opacity_valuesArray = [0,100];
			purchaseorderpoOutlinesGroup4Opacity.setValuesAtTimes(purchaseorderpoOutlinesGroup4Opacity_keyTimesArray, purchaseorderpoOutlinesGroup4Opacity_valuesArray);
			var purchaseorderpoOutlinesGroup4Opacity_easeInSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup4Opacity_easeInInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup4Opacity_easeOutSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup4Opacity_easeOutInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup4Opacity_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var purchaseorderpoOutlinesGroup4Opacity_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(purchaseorderpoOutlinesGroup4Opacity, purchaseorderpoOutlinesGroup4Opacity_keyTimesArray, [purchaseorderpoOutlinesGroup4Opacity_easeInSpeedArray, purchaseorderpoOutlinesGroup4Opacity_easeInInfluArray], [purchaseorderpoOutlinesGroup4Opacity_easeOutSpeedArray, purchaseorderpoOutlinesGroup4Opacity_easeOutInfluArray], [purchaseorderpoOutlinesGroup4Opacity_keyInInterpolationType, purchaseorderpoOutlinesGroup4Opacity_keyOutInterpolationType]);

		purchaseorderpoOutlinesGroup4.selected = false;
	// Add Shape Layer "purchase_order_po Outlines - Group 5", varName "purchaseorderpoOutlinesGroup5";
	var purchaseorderpoOutlinesGroup5 = purchaseorderpoanimation_comp.layers.addShape();
		purchaseorderpoOutlinesGroup5.name = "purchase_order_po Outlines - Group 5";
		purchaseorderpoOutlinesGroup5.startTime = -0.08;
		purchaseorderpoOutlinesGroup5.inPoint = 0.72;
		purchaseorderpoOutlinesGroup5.outPoint = 1.24;
		purchaseorderpoOutlinesGroup5.motionBlur = true;
		purchaseorderpoOutlinesGroup5.moveToEnd();
		purchaseorderpoOutlinesGroup5.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		purchaseorderpoOutlinesGroup5.property("ADBE Root Vectors Group").property(1).name = "Group 5";
		purchaseorderpoOutlinesGroup5.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup5Path = purchaseorderpoOutlinesGroup5.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup5Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup5Path_newShape.vertices = [[2.17550659179688, -6.51699829101562], [3.73150634765625, -6.34999084472656], [5.45350646972656, -5.760986328125], [4.18849182128906, -3.13299560546875], [3.18649291992188, -3.54598999023438], [2.31649780273438, -3.68699645996094], [1.82049560546875, -3.47099304199219], [1.50749206542969, -2.65899658203125], [1.29649353027344, -1.65699768066406], [3.50250244140625, -1.65699768066406], [3.00149536132812, 0.79501342773438], [0.7864990234375, 0.79501342773438], [0.61149597167969, 1.62200927734375], [-0.00050354003906, 2.79501342773438], [-1.17350769042969, 3.61700439453125], [4.135498046875, 3.61700439453125], [3.50250244140625, 6.51701354980469], [-5.45350646972656, 6.51701354980469], [-4.89950561523438, 3.76600646972656], [-3.84049987792969, 3.33601379394531], [-3.2344970703125, 2.72401428222656], [-2.8695068359375, 1.63900756835938], [-2.68449401855469, 0.79501342773438], [-4.33749389648438, 0.79501342773438], [-3.83650207519531, -1.65699768066406], [-2.18350219726562, -1.65699768066406], [-1.98150634765625, -2.78999328613281], [-1.2344970703125, -4.92599487304688], [0.08749389648438, -6.13499450683594]];
			purchaseorderpoOutlinesGroup5Path_newShape.inTangents = [[-0.85501098632812, 0], [-0.51600646972656, -0.11099243164062], [-0.63200378417969, -0.281005859375], [0, 0], [0.281005859375, 0.09300231933594], [0.29800415039062, 0], [0.125, -0.14399719238281], [0.08200073242188, -0.39799499511719], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0.31399536132812, -0.34800720214844], [0.46900939941406, -0.19898986816406], [0, 0], [0, 0], [0, 0], [0, 0], [-0.26100158691406, 0.16400146484375], [-0.14399719238281, 0.24398803710938], [-0.09999084472656, 0.48100280761719], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [-0.34600830078125, 0.55101013183594], [-0.53498840332031, 0.25599670410156]];
			purchaseorderpoOutlinesGroup5Path_newShape.outTangents = [[0.52099609375, 0], [0.51499938964844, 0.11100769042969], [0, 0], [-0.38699340820312, -0.18199157714844], [-0.28199768066406, -0.093994140625], [-0.20500183105469, 0], [-0.12699890136719, 0.14300537109375], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [-0.093994140625, 0.43299865722656], [-0.31300354003906, 0.3489990234375], [0, 0], [0, 0], [0, 0], [0, 0], [0.44500732421875, -0.12300109863281], [0.25999450683594, -0.16500854492188], [0.14299011230469, -0.24200439453125], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0.15200805664062, -0.87300109863281], [0.34599304199219, -0.55099487304688], [0.53700256347656, -0.25399780273438]];
			purchaseorderpoOutlinesGroup5Path_newShape.closed = true;
		purchaseorderpoOutlinesGroup5Path.setValue(purchaseorderpoOutlinesGroup5Path_newShape);
		purchaseorderpoOutlinesGroup5.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		purchaseorderpoOutlinesGroup5.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Fill Color").setValue([0,0,0,1]);
		purchaseorderpoOutlinesGroup5.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([245.795196533203,181.149291992188]);
		purchaseorderpoOutlinesGroup5.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([245.795196533203,181.149291992188,0]);
		purchaseorderpoOutlinesGroup5.property("ADBE Transform Group").property("ADBE Position").setValue([245.795196533203,181.149291992188,0]);
		var purchaseorderpoOutlinesGroup5Opacity = purchaseorderpoOutlinesGroup5.property("ADBE Transform Group").property("ADBE Opacity");
			var purchaseorderpoOutlinesGroup5Opacity_keyTimesArray = [0.72,0.96];
			var purchaseorderpoOutlinesGroup5Opacity_valuesArray = [0,100];
			purchaseorderpoOutlinesGroup5Opacity.setValuesAtTimes(purchaseorderpoOutlinesGroup5Opacity_keyTimesArray, purchaseorderpoOutlinesGroup5Opacity_valuesArray);
			var purchaseorderpoOutlinesGroup5Opacity_easeInSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup5Opacity_easeInInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup5Opacity_easeOutSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup5Opacity_easeOutInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup5Opacity_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var purchaseorderpoOutlinesGroup5Opacity_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(purchaseorderpoOutlinesGroup5Opacity, purchaseorderpoOutlinesGroup5Opacity_keyTimesArray, [purchaseorderpoOutlinesGroup5Opacity_easeInSpeedArray, purchaseorderpoOutlinesGroup5Opacity_easeInInfluArray], [purchaseorderpoOutlinesGroup5Opacity_easeOutSpeedArray, purchaseorderpoOutlinesGroup5Opacity_easeOutInfluArray], [purchaseorderpoOutlinesGroup5Opacity_keyInInterpolationType, purchaseorderpoOutlinesGroup5Opacity_keyOutInterpolationType]);

		purchaseorderpoOutlinesGroup5.selected = false;
	// Add Shape Layer "purchase_order_po Outlines - Group 8", varName "purchaseorderpoOutlinesGroup8";
	var purchaseorderpoOutlinesGroup8 = purchaseorderpoanimation_comp.layers.addShape();
		purchaseorderpoOutlinesGroup8.name = "purchase_order_po Outlines - Group 8";
		purchaseorderpoOutlinesGroup8.startTime = 0.16;
		purchaseorderpoOutlinesGroup8.inPoint = 0.76;
		purchaseorderpoOutlinesGroup8.outPoint = 1.4;
		purchaseorderpoOutlinesGroup8.motionBlur = true;
		purchaseorderpoOutlinesGroup8.moveToEnd();
		purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).name = "Group 8";
		purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup8Path = purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup8Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup8Path_newShape.vertices = [[148.560501098633, 225.25], [216.560501098633, 225.25]];
			purchaseorderpoOutlinesGroup8Path_newShape.closed = false;
		purchaseorderpoOutlinesGroup8Path.setValue(purchaseorderpoOutlinesGroup8Path_newShape);
		purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8.55399990081787);
		purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Filter - Trim");
		var purchaseorderpoOutlinesGroup8End = purchaseorderpoOutlinesGroup8.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Trim End");
			var purchaseorderpoOutlinesGroup8End_keyTimesArray = [0.76,1];
			var purchaseorderpoOutlinesGroup8End_valuesArray = [0,100];
			purchaseorderpoOutlinesGroup8End.setValuesAtTimes(purchaseorderpoOutlinesGroup8End_keyTimesArray, purchaseorderpoOutlinesGroup8End_valuesArray);
			var purchaseorderpoOutlinesGroup8End_easeInSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup8End_easeInInfluArray = [16.666666667,65];
			var purchaseorderpoOutlinesGroup8End_easeOutSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup8End_easeOutInfluArray = [65,16.666666667];
			var purchaseorderpoOutlinesGroup8End_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var purchaseorderpoOutlinesGroup8End_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(purchaseorderpoOutlinesGroup8End, purchaseorderpoOutlinesGroup8End_keyTimesArray, [purchaseorderpoOutlinesGroup8End_easeInSpeedArray, purchaseorderpoOutlinesGroup8End_easeInInfluArray], [purchaseorderpoOutlinesGroup8End_easeOutSpeedArray, purchaseorderpoOutlinesGroup8End_easeOutInfluArray], [purchaseorderpoOutlinesGroup8End_keyInInterpolationType, purchaseorderpoOutlinesGroup8End_keyOutInterpolationType]);

		purchaseorderpoOutlinesGroup8.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([182.560501098633,225.25,0]);
		purchaseorderpoOutlinesGroup8.property("ADBE Transform Group").property("ADBE Position").setValue([182.560501098633,225.25,0]);
		purchaseorderpoOutlinesGroup8.selected = false;
	// Add Shape Layer "purchase_order_po Outlines - Group 10", varName "purchaseorderpoOutlinesGroup10";
	var purchaseorderpoOutlinesGroup10 = purchaseorderpoanimation_comp.layers.addShape();
		purchaseorderpoOutlinesGroup10.name = "purchase_order_po Outlines - Group 10";
		purchaseorderpoOutlinesGroup10.startTime = 0.08;
		purchaseorderpoOutlinesGroup10.inPoint = 0.68;
		purchaseorderpoOutlinesGroup10.outPoint = 1.32;
		purchaseorderpoOutlinesGroup10.motionBlur = true;
		purchaseorderpoOutlinesGroup10.moveToEnd();
		purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).name = "Group 10";
		purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup10Path = purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup10Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup10Path_newShape.vertices = [[153.560501098633, 203.25], [221.560501098633, 203.25]];
			purchaseorderpoOutlinesGroup10Path_newShape.closed = false;
		purchaseorderpoOutlinesGroup10Path.setValue(purchaseorderpoOutlinesGroup10Path_newShape);
		purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8.55399990081787);
		purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Filter - Trim");
		var purchaseorderpoOutlinesGroup10End = purchaseorderpoOutlinesGroup10.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Trim End");
			var purchaseorderpoOutlinesGroup10End_keyTimesArray = [0.68,0.92];
			var purchaseorderpoOutlinesGroup10End_valuesArray = [0,100];
			purchaseorderpoOutlinesGroup10End.setValuesAtTimes(purchaseorderpoOutlinesGroup10End_keyTimesArray, purchaseorderpoOutlinesGroup10End_valuesArray);
			var purchaseorderpoOutlinesGroup10End_easeInSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup10End_easeInInfluArray = [16.666666667,65];
			var purchaseorderpoOutlinesGroup10End_easeOutSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup10End_easeOutInfluArray = [65,16.666666667];
			var purchaseorderpoOutlinesGroup10End_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var purchaseorderpoOutlinesGroup10End_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(purchaseorderpoOutlinesGroup10End, purchaseorderpoOutlinesGroup10End_keyTimesArray, [purchaseorderpoOutlinesGroup10End_easeInSpeedArray, purchaseorderpoOutlinesGroup10End_easeInInfluArray], [purchaseorderpoOutlinesGroup10End_easeOutSpeedArray, purchaseorderpoOutlinesGroup10End_easeOutInfluArray], [purchaseorderpoOutlinesGroup10End_keyInInterpolationType, purchaseorderpoOutlinesGroup10End_keyOutInterpolationType]);

		purchaseorderpoOutlinesGroup10.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([187.560501098633,203.25,0]);
		purchaseorderpoOutlinesGroup10.property("ADBE Transform Group").property("ADBE Position").setValue([187.560501098633,203.25,0]);
		purchaseorderpoOutlinesGroup10.selected = false;
	// Add Shape Layer "purchase_order_po Outlines - Group 12", varName "purchaseorderpoOutlinesGroup12";
	var purchaseorderpoOutlinesGroup12 = purchaseorderpoanimation_comp.layers.addShape();
		purchaseorderpoOutlinesGroup12.name = "purchase_order_po Outlines - Group 12";
		purchaseorderpoOutlinesGroup12.startTime = 0.6;
		purchaseorderpoOutlinesGroup12.outPoint = 1.24;
		purchaseorderpoOutlinesGroup12.motionBlur = true;
		purchaseorderpoOutlinesGroup12.moveToEnd();
		purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).name = "Group 12";
		purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup12Path = purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup12Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup12Path_newShape.vertices = [[158.560501098633, 181.25], [226.560501098633, 181.25]];
			purchaseorderpoOutlinesGroup12Path_newShape.closed = false;
		purchaseorderpoOutlinesGroup12Path.setValue(purchaseorderpoOutlinesGroup12Path_newShape);
		purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8.55399990081787);
		purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Filter - Trim");
		var purchaseorderpoOutlinesGroup12End = purchaseorderpoOutlinesGroup12.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Trim End");
			var purchaseorderpoOutlinesGroup12End_keyTimesArray = [0.6,0.84];
			var purchaseorderpoOutlinesGroup12End_valuesArray = [0,100];
			purchaseorderpoOutlinesGroup12End.setValuesAtTimes(purchaseorderpoOutlinesGroup12End_keyTimesArray, purchaseorderpoOutlinesGroup12End_valuesArray);
			var purchaseorderpoOutlinesGroup12End_easeInSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup12End_easeInInfluArray = [16.666666667,65];
			var purchaseorderpoOutlinesGroup12End_easeOutSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup12End_easeOutInfluArray = [65,16.666666667];
			var purchaseorderpoOutlinesGroup12End_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var purchaseorderpoOutlinesGroup12End_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(purchaseorderpoOutlinesGroup12End, purchaseorderpoOutlinesGroup12End_keyTimesArray, [purchaseorderpoOutlinesGroup12End_easeInSpeedArray, purchaseorderpoOutlinesGroup12End_easeInInfluArray], [purchaseorderpoOutlinesGroup12End_easeOutSpeedArray, purchaseorderpoOutlinesGroup12End_easeOutInfluArray], [purchaseorderpoOutlinesGroup12End_keyInInterpolationType, purchaseorderpoOutlinesGroup12End_keyOutInterpolationType]);

		purchaseorderpoOutlinesGroup12.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([192.560501098633,181.25,0]);
		purchaseorderpoOutlinesGroup12.property("ADBE Transform Group").property("ADBE Position").setValue([192.560501098633,181.25,0]);
		purchaseorderpoOutlinesGroup12.selected = false;
	// Add Shape Layer "purchase_order_po Outlines - Group 1", varName "purchaseorderpoOutlinesGroup1";
	var purchaseorderpoOutlinesGroup1 = purchaseorderpoanimation_comp.layers.addShape();
		purchaseorderpoOutlinesGroup1.name = "purchase_order_po Outlines - Group 1";
		purchaseorderpoOutlinesGroup1.inPoint = 0.72;
		purchaseorderpoOutlinesGroup1.outPoint = 1.24;
		purchaseorderpoOutlinesGroup1.motionBlur = true;
		purchaseorderpoOutlinesGroup1.moveToEnd();
		purchaseorderpoOutlinesGroup1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		purchaseorderpoOutlinesGroup1.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup1Path = purchaseorderpoOutlinesGroup1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup1Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup1Path_newShape.vertices = [[5.23701477050781, -3.51951599121094], [4.32701110839844, -6.90748596191406], [1.68901062011719, -8.13050842285156], [-1.76499938964844, -6.53749084472656], [-4.27899169921875, -2.15348815917969], [-5.21798706054688, 3.55848693847656], [-1.42298889160156, 8.15049743652344], [1.92601013183594, 6.57548522949219], [4.35501098632812, 2.32450866699219]];
			purchaseorderpoOutlinesGroup1Path_newShape.inTangents = [[0, 2.11300659179688], [0.60699462890625, 0.81698608398438], [1.15199279785156, 0], [1.05101013183594, -1.06201171875], [0.62599182128906, -1.86001586914062], [0, -1.947998046875], [-2.52999877929688, 0], [-1.031005859375, 1.05101013183594], [-0.58900451660156, 1.78399658203125]];
			purchaseorderpoOutlinesGroup1Path_newShape.outTangents = [[0, -1.44198608398438], [-0.60800170898438, -0.81600952148438], [-1.25300598144531, 0], [-1.04998779296875, 1.06298828125], [-0.62699890136719, 1.8599853515625], [0, 3.06201171875], [1.20098876953125, 0], [1.03199768066406, -1.04998779296875], [0.5889892578125, -1.78302001953125]];
			purchaseorderpoOutlinesGroup1Path_newShape.closed = true;
		purchaseorderpoOutlinesGroup1Path.setValue(purchaseorderpoOutlinesGroup1Path_newShape);
		purchaseorderpoOutlinesGroup1.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup1Path = purchaseorderpoOutlinesGroup1.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup1Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup1Path_newShape.vertices = [[2.31500244140625, -14.2794952392578], [9.99099731445312, -11.4615020751953], [12.7330017089844, -3.59550476074219], [10.843994140625, 5.63648986816406], [5.635009765625, 12.0504913330078], [-2.0679931640625, 14.2794952392578], [-9.95199584960938, 11.4524841308594], [-12.7329864501953, 3.59651184082031], [-10.7789916992188, -5.64451599121094], [-5.45498657226562, -12.0684967041016]];
			purchaseorderpoOutlinesGroup1Path_newShape.inTangents = [[-2.93499755859375, 0], [-1.82798767089844, -1.87799072265625], [0, -3.364990234375], [1.260009765625, -2.78997802734375], [2.21499633789062, -1.48699951171875], [2.9219970703125, 0], [1.85200500488281, 1.885009765625], [0, 3.35197448730469], [-1.302001953125, 2.80801391601562], [-2.24600219726562, 1.4739990234375]];
			purchaseorderpoOutlinesGroup1Path_newShape.outTangents = [[3.28900146484375, 0], [1.8280029296875, 1.87899780273438], [0, 3.364990234375], [-1.25698852539062, 2.78900146484375], [-2.21200561523438, 1.48699951171875], [-3.40399169921875, 0], [-1.85398864746094, -1.88499450683594], [0, -3.35202026367188], [1.30299377441406, -2.80899047851562], [2.2449951171875, -1.47299194335938]];
			purchaseorderpoOutlinesGroup1Path_newShape.closed = true;
		purchaseorderpoOutlinesGroup1Path.setValue(purchaseorderpoOutlinesGroup1Path_newShape);
		purchaseorderpoOutlinesGroup1.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Filter - Merge");
		purchaseorderpoOutlinesGroup1.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		purchaseorderpoOutlinesGroup1.property("ADBE Root Vectors Group").property(1).property(2).property(4).property("ADBE Vector Fill Color").setValue([0,0,0,1]);
		purchaseorderpoOutlinesGroup1.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([246.419189453125,150.408706665039]);
		purchaseorderpoOutlinesGroup1.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([246.419189453125,150.408706665039,0]);
		purchaseorderpoOutlinesGroup1.property("ADBE Transform Group").property("ADBE Position").setValue([246.419189453125,150.408706665039,0]);
		var purchaseorderpoOutlinesGroup1Opacity = purchaseorderpoOutlinesGroup1.property("ADBE Transform Group").property("ADBE Opacity");
			var purchaseorderpoOutlinesGroup1Opacity_keyTimesArray = [0.72,0.96];
			var purchaseorderpoOutlinesGroup1Opacity_valuesArray = [0,100];
			purchaseorderpoOutlinesGroup1Opacity.setValuesAtTimes(purchaseorderpoOutlinesGroup1Opacity_keyTimesArray, purchaseorderpoOutlinesGroup1Opacity_valuesArray);
			var purchaseorderpoOutlinesGroup1Opacity_easeInSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup1Opacity_easeInInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup1Opacity_easeOutSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup1Opacity_easeOutInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup1Opacity_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var purchaseorderpoOutlinesGroup1Opacity_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(purchaseorderpoOutlinesGroup1Opacity, purchaseorderpoOutlinesGroup1Opacity_keyTimesArray, [purchaseorderpoOutlinesGroup1Opacity_easeInSpeedArray, purchaseorderpoOutlinesGroup1Opacity_easeInInfluArray], [purchaseorderpoOutlinesGroup1Opacity_easeOutSpeedArray, purchaseorderpoOutlinesGroup1Opacity_easeOutInfluArray], [purchaseorderpoOutlinesGroup1Opacity_keyInInterpolationType, purchaseorderpoOutlinesGroup1Opacity_keyOutInterpolationType]);

		purchaseorderpoOutlinesGroup1.selected = false;
	// Add Shape Layer "purchase_order_po Outlines - Group 2", varName "purchaseorderpoOutlinesGroup2";
	var purchaseorderpoOutlinesGroup2 = purchaseorderpoanimation_comp.layers.addShape();
		purchaseorderpoOutlinesGroup2.name = "purchase_order_po Outlines - Group 2";
		purchaseorderpoOutlinesGroup2.inPoint = 0.6;
		purchaseorderpoOutlinesGroup2.outPoint = 1.24;
		purchaseorderpoOutlinesGroup2.motionBlur = true;
		purchaseorderpoOutlinesGroup2.moveToEnd();
		purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").property(1).name = "Group 2";
		purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup2Path = purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup2Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup2Path_newShape.vertices = [[-0.91049194335938, -1.40451049804688], [0.28450012207031, -1.40451049804688], [3.07350158691406, -2.51449584960938], [4.13650512695312, -5.33248901367188], [3.45350646972656, -7.135498046875], [1.57550048828125, -7.8184814453125], [0.45550537109375, -7.8184814453125]];
			purchaseorderpoOutlinesGroup2Path_newShape.inTangents = [[0, 0], [0, 0], [-0.7080078125, 0.739990234375], [0, 1.13800048828125], [0.45599365234375, 0.45599365234375], [0.7969970703125, 0], [0, 0]];
			purchaseorderpoOutlinesGroup2Path_newShape.outTangents = [[0, 0], [1.1510009765625, 0], [0.70899963378906, -0.739990234375], [0, -0.74600219726562], [-0.45500183105469, -0.45498657226562], [0, 0], [0, 0]];
			purchaseorderpoOutlinesGroup2Path_newShape.closed = true;
		purchaseorderpoOutlinesGroup2Path.setValue(purchaseorderpoOutlinesGroup2Path_newShape);
		purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var purchaseorderpoOutlinesGroup2Path = purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Shape");
		var purchaseorderpoOutlinesGroup2Path_newShape = new Shape();
			purchaseorderpoOutlinesGroup2Path_newShape.vertices = [[11.5565032958984, -5.56048583984375], [8.30250549316406, 1.94451904296875], [-0.60650634765625, 4.66751098632812], [-2.23849487304688, 4.66751098632812], [-4.13749694824219, 13.8714904785156], [-11.5565032958984, 13.8714904785156], [-5.6925048828125, -13.8714904785156], [1.385498046875, -13.8714904785156], [8.92849731445312, -11.7174987792969]];
			purchaseorderpoOutlinesGroup2Path_newShape.inTangents = [[0, -2.66900634765625], [2.16999816894531, -1.81500244140625], [3.76901245117188, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [-1.75199890136719, -1.43600463867188]];
			purchaseorderpoOutlinesGroup2Path_newShape.outTangents = [[0, 3.18798828125], [-2.16999816894531, 1.81597900390625], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [3.2760009765625, 0], [1.75199890136719, 1.43600463867188]];
			purchaseorderpoOutlinesGroup2Path_newShape.closed = true;
		purchaseorderpoOutlinesGroup2Path.setValue(purchaseorderpoOutlinesGroup2Path_newShape);
		purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Filter - Merge");
		purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").property(1).property(2).property(4).property("ADBE Vector Fill Color").setValue([0,0,0,1]);
		purchaseorderpoOutlinesGroup2.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([219.681991577148,150.437713623047]);
		purchaseorderpoOutlinesGroup2.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([219.681991577148,150.437713623047,0]);
		purchaseorderpoOutlinesGroup2.property("ADBE Transform Group").property("ADBE Position").setValue([219.681991577148,150.437713623047,0]);
		var purchaseorderpoOutlinesGroup2Opacity = purchaseorderpoOutlinesGroup2.property("ADBE Transform Group").property("ADBE Opacity");
			var purchaseorderpoOutlinesGroup2Opacity_keyTimesArray = [0.6,0.84];
			var purchaseorderpoOutlinesGroup2Opacity_valuesArray = [0,100];
			purchaseorderpoOutlinesGroup2Opacity.setValuesAtTimes(purchaseorderpoOutlinesGroup2Opacity_keyTimesArray, purchaseorderpoOutlinesGroup2Opacity_valuesArray);
			var purchaseorderpoOutlinesGroup2Opacity_easeInSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup2Opacity_easeInInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup2Opacity_easeOutSpeedArray = [0,0];
			var purchaseorderpoOutlinesGroup2Opacity_easeOutInfluArray = [65,65];
			var purchaseorderpoOutlinesGroup2Opacity_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var purchaseorderpoOutlinesGroup2Opacity_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(purchaseorderpoOutlinesGroup2Opacity, purchaseorderpoOutlinesGroup2Opacity_keyTimesArray, [purchaseorderpoOutlinesGroup2Opacity_easeInSpeedArray, purchaseorderpoOutlinesGroup2Opacity_easeInInfluArray], [purchaseorderpoOutlinesGroup2Opacity_easeOutSpeedArray, purchaseorderpoOutlinesGroup2Opacity_easeOutInfluArray], [purchaseorderpoOutlinesGroup2Opacity_keyInInterpolationType, purchaseorderpoOutlinesGroup2Opacity_keyOutInterpolationType]);

		purchaseorderpoOutlinesGroup2.selected = false;
	// Add Shape Layer "Merged Shape Layer", varName "mergedShapeLayer";
	var mergedShapeLayer = purchaseorderpoanimation_comp.layers.addShape();
		mergedShapeLayer.name = "Merged Shape Layer";
		mergedShapeLayer.inPoint = 0.52;
		mergedShapeLayer.outPoint = 1.24;
		mergedShapeLayer.motionBlur = true;
		mergedShapeLayer.moveToEnd();
		mergedShapeLayer.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).name = "purchase_order_po Outlines - Group 6";
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Group");
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).property(1).name = "Group 6";
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var mergedShapeLayerPath = mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var mergedShapeLayerPath_newShape = new Shape();
			mergedShapeLayerPath_newShape.vertices = [[-15, 10], [10, 10], [15, -10], [-10, -10]];
			mergedShapeLayerPath_newShape.closed = true;
		mergedShapeLayerPath.setValue(mergedShapeLayerPath_newShape);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8.55399990081787);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(3).property("ADBE Vector Position").setValue([177.560501098633,150.25]);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Anchor").setValue([177.560501098633,150.25]);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([177.560501098633,150.25]);
		mergedShapeLayer.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		mergedShapeLayer.property("ADBE Root Vectors Group").property(2).name = "purchase_order_po Outlines - Group 7";
		mergedShapeLayer.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Group");
		mergedShapeLayer.property("ADBE Root Vectors Group").property(2).property(2).property(1).name = "Group 7";
		mergedShapeLayer.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var mergedShapeLayerPath = mergedShapeLayer.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var mergedShapeLayerPath_newShape = new Shape();
			mergedShapeLayerPath_newShape.vertices = [[-15, 10], [10, 10], [15, -10], [-10, -10]];
			mergedShapeLayerPath_newShape.closed = true;
		mergedShapeLayerPath.setValue(mergedShapeLayerPath_newShape);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		mergedShapeLayer.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(2).property("ADBE Vector Fill Color").setValue([0,0,0,1]);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(3).property("ADBE Vector Position").setValue([177.560501098633,150.25]);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Anchor").setValue([177.560501098633,150.25]);
		mergedShapeLayer.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Position").setValue([177.560501098633,150.25]);
		mergedShapeLayer.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([177.560501098633,150.25,0]);
		mergedShapeLayer.property("ADBE Transform Group").property("ADBE Position").setValue([177.560501098633,150.25,0]);
		var mergedShapeLayerScale = mergedShapeLayer.property("ADBE Transform Group").property("ADBE Scale");
			var mergedShapeLayerScale_keyTimesArray = [0.52,0.92];
			var mergedShapeLayerScale_valuesArray = [[0,0,100],[100,100,100]];
			mergedShapeLayerScale.setValuesAtTimes(mergedShapeLayerScale_keyTimesArray, mergedShapeLayerScale_valuesArray);
			var mergedShapeLayerScale_easeInSpeedArray = [[0,0,0],[0,0,0]];
			var mergedShapeLayerScale_easeInInfluArray = [[50,50,50],[50,50,50]];
			var mergedShapeLayerScale_easeOutSpeedArray = [[0,0,0],[0,0,0]];
			var mergedShapeLayerScale_easeOutInfluArray = [[50,50,50],[50,50,50]];
			var mergedShapeLayerScale_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var mergedShapeLayerScale_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(mergedShapeLayerScale, mergedShapeLayerScale_keyTimesArray, [mergedShapeLayerScale_easeInSpeedArray, mergedShapeLayerScale_easeInInfluArray], [mergedShapeLayerScale_easeOutSpeedArray, mergedShapeLayerScale_easeOutInfluArray], [mergedShapeLayerScale_keyInInterpolationType, mergedShapeLayerScale_keyOutInterpolationType]);

		mergedShapeLayer.selected = false;
	// Add Shape Layer "Merged Shape Layer", varName "mergedShapeLayer1";
	var mergedShapeLayer1 = purchaseorderpoanimation_comp.layers.addShape();
		mergedShapeLayer1.name = "Merged Shape Layer";
		mergedShapeLayer1.motionBlur = true;
		mergedShapeLayer1.moveToEnd();
		mergedShapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).name = "purchase_order_po Outlines - Group 14";
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Group");
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).name = "Group 14";
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var mergedShapeLayer1Path = mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var mergedShapeLayer1Path_newShape = new Shape();
			mergedShapeLayer1Path_newShape.vertices = [[63.4850006103516, -88.8119964599609], [-25.1829986572266, -88.8119964599609], [-47.0619964599609, -71.4069671630859], [-79.5890045166016, 66.9999847412109], [-62.3090057373047, 88.8119964599609], [15.0419921875, 88.8119964599609], [48.1549987792969, 62.7280120849609], [79.6849822998047, -68.2499847412109]];
			mergedShapeLayer1Path_newShape.inTangents = [[10.7799987792969, 0], [0, 0], [2.35099792480469, -10.1880187988281], [0, 0], [-11.4449920654297, 0], [0, 0], [-5.29600524902344, 19.6690063476562], [0, 0]];
			mergedShapeLayer1Path_newShape.outTangents = [[0, 0], [-10.4560089111328, 0], [0, 0], [-2.61898803710938, 11.1410217285156], [0, 0], [24.8560028076172, 0], [0, 0], [2.52301025390625, -10.4800109863281]];
			mergedShapeLayer1Path_newShape.closed = true;
		mergedShapeLayer1Path.setValue(mergedShapeLayer1Path_newShape);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(7.68100023269653);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(2).property(1).property(3).property("ADBE Vector Position").setValue([199.875106811523,200.57209777832]);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Anchor").setValue([199.918884277344,200.57209777832]);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([199.918884277344,200.57209777832]);
		mergedShapeLayer1.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).name = "purchase_order_po Outlines - Group 15";
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Group");
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).property(1).name = "Group 15";
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var mergedShapeLayer1Path = mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(1).property("ADBE Vector Shape");
		var mergedShapeLayer1Path_newShape = new Shape();
			mergedShapeLayer1Path_newShape.vertices = [[63.4850006103516, -88.8119964599609], [-25.1829986572266, -88.8119964599609], [-47.0619964599609, -71.4069671630859], [-79.5890045166016, 66.9999847412109], [-62.3090057373047, 88.8119964599609], [15.0419921875, 88.8119964599609], [48.1549987792969, 62.7280120849609], [79.6849822998047, -68.2499847412109]];
			mergedShapeLayer1Path_newShape.inTangents = [[10.7799987792969, 0], [0, 0], [2.35099792480469, -10.1880187988281], [0, 0], [-11.4449920654297, 0], [0, 0], [-5.29600524902344, 19.6690063476562], [0, 0]];
			mergedShapeLayer1Path_newShape.outTangents = [[0, 0], [-10.4560089111328, 0], [0, 0], [-2.61898803710938, 11.1410217285156], [0, 0], [24.8560028076172, 0], [0, 0], [2.52301025390625, -10.4800109863281]];
			mergedShapeLayer1Path_newShape.closed = true;
		mergedShapeLayer1Path.setValue(mergedShapeLayer1Path_newShape);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(2).property(2).property("ADBE Vector Fill Color").setValue([1,1,1,1]);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).property(2).property(1).property(3).property("ADBE Vector Position").setValue([199.875106811523,200.57209777832]);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Anchor").setValue([199.918884277344,200.57209777832]);
		mergedShapeLayer1.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Position").setValue([199.918884277344,200.57209777832]);
		mergedShapeLayer1.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([199.918884277344,200.57209777832,0]);
		mergedShapeLayer1.property("ADBE Transform Group").property("ADBE Position").setValue([199.918884277344,200.57209777832,0]);
		var mergedShapeLayer1Scale = mergedShapeLayer1.property("ADBE Transform Group").property("ADBE Scale");
			var mergedShapeLayer1Scale_keyTimesArray = [0.2,0.6];
			var mergedShapeLayer1Scale_valuesArray = [[0,0,100],[100,100,100]];
			mergedShapeLayer1Scale.setValuesAtTimes(mergedShapeLayer1Scale_keyTimesArray, mergedShapeLayer1Scale_valuesArray);
			var mergedShapeLayer1Scale_easeInSpeedArray = [[0,0,0],[0,0,0]];
			var mergedShapeLayer1Scale_easeInInfluArray = [[50,50,50],[50,50,50]];
			var mergedShapeLayer1Scale_easeOutSpeedArray = [[0,0,0],[0,0,0]];
			var mergedShapeLayer1Scale_easeOutInfluArray = [[50,50,50],[50,50,50]];
			var mergedShapeLayer1Scale_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var mergedShapeLayer1Scale_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(mergedShapeLayer1Scale, mergedShapeLayer1Scale_keyTimesArray, [mergedShapeLayer1Scale_easeInSpeedArray, mergedShapeLayer1Scale_easeInInfluArray], [mergedShapeLayer1Scale_easeOutSpeedArray, mergedShapeLayer1Scale_easeOutInfluArray], [mergedShapeLayer1Scale_keyInInterpolationType, mergedShapeLayer1Scale_keyOutInterpolationType]);

		mergedShapeLayer1.selected = false;
	// Apply parents
		purchaseorderpoOutlinesGroup3.setParentWithJump(mergedShapeLayer1);
		purchaseorderpoOutlinesGroup4.setParentWithJump(mergedShapeLayer1);
		purchaseorderpoOutlinesGroup5.setParentWithJump(mergedShapeLayer1);
		purchaseorderpoOutlinesGroup8.setParentWithJump(mergedShapeLayer1);
		purchaseorderpoOutlinesGroup10.setParentWithJump(mergedShapeLayer1);
		purchaseorderpoOutlinesGroup12.setParentWithJump(mergedShapeLayer1);
		purchaseorderpoOutlinesGroup1.setParentWithJump(mergedShapeLayer1);
		purchaseorderpoOutlinesGroup2.setParentWithJump(mergedShapeLayer1);
		mergedShapeLayer.setParentWithJump(mergedShapeLayer1);

}
purchaseorderpo_comp.openInViewer();

} catch(e) {
	alert(e.toString() + "\nError on line: " + e.line.toString());
}
app.endUndoGroup();


function getItem(itemName, itemInstanceName, locationObject) {
	if (locationObject.numItems > 0) {
		for (var i = 1; i <= locationObject.numItems; i ++) {
			var curItem = locationObject.item(i);
			if (curItem.name === itemName) {
				if (curItem instanceof itemInstanceName || (curItem.mainSource !== "undefined" && curItem.mainSource instanceof itemInstanceName)) {
					return curItem;
				}
			}
		}
	}
	return null;
}

function applyEasing(property, keyTimesArray, easeInArray, easeOutArray, keyInterpolationArray) {
	for (var i = 0; i < keyTimesArray.length; i ++) {
		if (property.propertyValueType === PropertyValueType.TwoD) {
			var easeIn0 = new KeyframeEase(easeInArray[0][i][0], easeInArray[1][i][0]);
			var easeOut0 = new KeyframeEase(easeOutArray[0][i][0], easeOutArray[1][i][0]);
			var easeIn1 = new KeyframeEase(easeInArray[0][i][1], easeInArray[1][i][1]);
			var easeOut1 = new KeyframeEase(easeOutArray[0][i][1], easeOutArray[1][i][1]);
			property.setTemporalEaseAtKey(i+1, [easeIn0, easeIn1], [easeOut0, easeOut1]);
		} else if (property.propertyValueType === PropertyValueType.ThreeD) {
			var easeIn0 = new KeyframeEase(easeInArray[0][i][0], easeInArray[1][i][0]);
			var easeOut0 = new KeyframeEase(easeOutArray[0][i][0], easeOutArray[1][i][0]);
			var easeIn1 = new KeyframeEase(easeInArray[0][i][1], easeInArray[1][i][1]);
			var easeOut1 = new KeyframeEase(easeOutArray[0][i][1], easeOutArray[1][i][1]);
			var easeIn2 = new KeyframeEase(easeInArray[0][i][2], easeInArray[1][i][2]);
			var easeOut2 = new KeyframeEase(easeOutArray[0][i][2], easeOutArray[1][i][2]);
			property.setTemporalEaseAtKey(i+1, [easeIn0, easeIn1, easeIn2], [easeOut0, easeOut1, easeOut2]);
		} else {
			var easeIn = new KeyframeEase(easeInArray[0][i], easeInArray[1][i]);
			var easeOut = new KeyframeEase(easeOutArray[0][i], easeOutArray[1][i]);
			if (keyInterpolationArray[1][i] !== KeyframeInterpolationType.HOLD) {
				property.setTemporalEaseAtKey(i+1, [easeIn], [easeOut]);
			} else {
				property.setTemporalEaseAtKey(i+1, [easeIn]);
			}
		}
		property.setInterpolationTypeAtKey(i+1, keyInterpolationArray[0][i], keyInterpolationArray[1][i]);
	}
}

function applySpatialTangents(property, keyTimesArray, inSpatialTangentsArray, outSpatialTangentsArray) {
	for (var sp = 0; sp < keyTimesArray.length; sp ++) {
		property.setSpatialTangentsAtKey(sp+1, inSpatialTangentsArray[sp], outSpatialTangentsArray[sp]);
	}
}
}

