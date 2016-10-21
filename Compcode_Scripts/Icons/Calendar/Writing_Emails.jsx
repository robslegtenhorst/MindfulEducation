// Created using compCode v1.0.2
// 20160617 from composition "Writing_Emails" in project "/mindful_share/Courses/tre_aat-l2/unit_01/lesson_01/04_parts/part_03/02_after_effects/01_ae_build/v003/tre_aat-l2_u01_l01_p03.aep"
//
// aescripts.com/compCode

// compCode_20160617_143558();
function compCode_20160617_143558() {

app.beginUndoGroup("Writing_Emails");

try {

// Create Folder hierarchy
	var zcompcodescripts_folder = getItem("Z_Compcode_Scripts", FolderItem, app.project.rootFolder);
	if (zcompcodescripts_folder === null) {
		zcompcodescripts_folder = app.project.items.addFolder("Z_Compcode_Scripts");
	}
	var calendar_folder = getItem("Calendar", FolderItem, zcompcodescripts_folder);
	if (calendar_folder === null) {
		calendar_folder = app.project.items.addFolder("Calendar");
		calendar_folder.parentFolder = zcompcodescripts_folder;
	}
	var out_folder = getItem("OUT", FolderItem, calendar_folder);
	if (out_folder === null) {
		out_folder = app.project.items.addFolder("OUT");
		out_folder.parentFolder = calendar_folder;
	}
	var precomps_folder = getItem("PreComps", FolderItem, calendar_folder);
	if (precomps_folder === null) {
		precomps_folder = app.project.items.addFolder("PreComps");
		precomps_folder.parentFolder = calendar_folder;
	}
	var solids_folder = getItem("Solids", FolderItem, app.project.rootFolder);
	if (solids_folder === null) {
		solids_folder = app.project.items.addFolder("Solids");
	}

// Create Compositions
	var writingemails_comp = app.project.items.addComp("Writing_Emails", 412, 412, 1, 2.8, 25);
		writingemails_comp.time = 0;
		writingemails_comp.bgColor = [0,0,0];
		writingemails_comp.parentFolder = out_folder;
	var writingemailsanimation_comp = getItem("Writing_Emails_animation", CompItem, precomps_folder);
	var writingemailsanimation_comp_populate = false;
	if (writingemailsanimation_comp === null) {
		writingemailsanimation_comp = app.project.items.addComp("Writing_Emails_animation", 412, 412, 1, 1.24, 25);
		writingemailsanimation_comp.time = 0;
		writingemailsanimation_comp.bgColor = [0,0,0];
		writingemailsanimation_comp.shutterPhase = -90;
		writingemailsanimation_comp.motionBlur = true;
		writingemailsanimation_comp.parentFolder = precomps_folder;
		writingemailsanimation_comp_populate = true;
	}
	var writingemailsslant_comp = getItem("Writing_Emails_Slant", CompItem, precomps_folder);
	var writingemailsslant_comp_populate = false;
	if (writingemailsslant_comp === null) {
		writingemailsslant_comp = app.project.items.addComp("Writing_Emails_Slant", 412, 412, 1, 1.6, 25);
		writingemailsslant_comp.time = 0;
		writingemailsslant_comp.bgColor = [0,0,0];
		writingemailsslant_comp.shutterPhase = -90;
		writingemailsslant_comp.motionBlur = true;
		writingemailsslant_comp.parentFolder = precomps_folder;
		writingemailsslant_comp_populate = true;
	}

// Create Null Layers
	var null6_null = getItem("Null 6", SolidSource, solids_folder);
	if (null6_null === null) {
		var null6_tempNull = writingemails_comp.layers.addNull();
			null6_null = null6_tempNull.source;
			null6_null.name = "Null 6";
			null6_null.mainSource.color = [1,1,1];
			null6_null.parentFolder = solids_folder;
		null6_tempNull.remove();
	}

// Working with comp "Writing_Emails", varName "writingemails_comp";
	writingemails_comp.openInViewer();
	// Add Shape Layer "Icon_bg_mask 2", varName "iconbgmask2";
	var iconbgmask2 = writingemails_comp.layers.addShape();
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
	// Add existing composition "Writing_Emails_animation", varName "writingemailsanimation_comp";
	var writingemailsanimation = writingemails_comp.layers.add(writingemailsanimation_comp);
		writingemailsanimation.outPoint = 1.24;
		writingemailsanimation.motionBlur = true;
		writingemailsanimation.moveToEnd();
		writingemailsanimation.trackMatteType = TrackMatteType.ALPHA;
		writingemailsanimation.timeRemapEnabled = true;
		writingemailsanimation.outPoint = 70 / writingemailsanimation.containingComp.frameRate;
		var writingemailsanimationTimeRemap = writingemailsanimation.property("ADBE Time Remapping");
			writingemailsanimationTimeRemap.setValueAtTime(99999, writingemailsanimationTimeRemap.keyValue(1));
			writingemailsanimationTimeRemap.removeKey(2);
			writingemailsanimationTimeRemap.removeKey(1);
			var writingemailsanimationTimeRemap_keyTimesArray = [0,1.2,1.6,2.76];
			var writingemailsanimationTimeRemap_valuesArray = [0,1.20000004768372,1.20000004768372,0];
			writingemailsanimationTimeRemap.setValuesAtTimes(writingemailsanimationTimeRemap_keyTimesArray, writingemailsanimationTimeRemap_valuesArray);
			writingemailsanimationTimeRemap.removeKey(writingemailsanimationTimeRemap.nearestKeyIndex(99999));
		writingemailsanimation.selected = false;
	// Add Shape Layer "Icon_bg_mask", varName "iconbgmask";
	var iconbgmask = writingemails_comp.layers.addShape();
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
	// Add existing composition "Writing_Emails_animation", varName "writingemailsanimation_comp";
	var shadow = writingemails_comp.layers.add(writingemailsanimation_comp);
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
	var iconbg = writingemails_comp.layers.addShape();
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
// Working with comp "Writing_Emails_animation", varName "writingemailsanimation_comp";
if (writingemailsanimation_comp_populate === true) {
	// Add existing composition "Writing_Emails_Slant", varName "writingemailsslant_comp";
	var writingemailsslant = writingemailsanimation_comp.layers.add(writingemailsslant_comp);
		writingemailsslant.outPoint = 1.24;
		writingemailsslant.motionBlur = true;
		writingemailsslant.moveToEnd();
		writingemailsslant.property("ADBE Effect Parade").addProperty("CC Slant");
		writingemailsslant.property("ADBE Effect Parade").property(1).property("CC Slant-0001").setValue(21);
		writingemailsslant.property("ADBE Effect Parade").property(1).property("CC Slant-0004").setValue([202.75,261.75]);
		writingemailsslant.property("ADBE Transform Group").property("ADBE Position").setValue([205,206,0]);
		var writingemailsslantScale = writingemailsslant.property("ADBE Transform Group").property("ADBE Scale");
			var writingemailsslantScale_keyTimesArray = [0.2,0.6];
			var writingemailsslantScale_valuesArray = [[0,0,100],[100,100,100]];
			writingemailsslantScale.setValuesAtTimes(writingemailsslantScale_keyTimesArray, writingemailsslantScale_valuesArray);
			var writingemailsslantScale_easeInSpeedArray = [[0,0,0],[0,0,0]];
			var writingemailsslantScale_easeInInfluArray = [[50,50,50],[50,50,50]];
			var writingemailsslantScale_easeOutSpeedArray = [[0,0,0],[0,0,0]];
			var writingemailsslantScale_easeOutInfluArray = [[50,50,50],[50,50,50]];
			var writingemailsslantScale_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var writingemailsslantScale_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(writingemailsslantScale, writingemailsslantScale_keyTimesArray, [writingemailsslantScale_easeInSpeedArray, writingemailsslantScale_easeInInfluArray], [writingemailsslantScale_easeOutSpeedArray, writingemailsslantScale_easeOutInfluArray], [writingemailsslantScale_keyInInterpolationType, writingemailsslantScale_keyOutInterpolationType]);

		writingemailsslant.selected = false;
}
// Working with comp "Writing_Emails_Slant", varName "writingemailsslant_comp";
if (writingemailsslant_comp_populate === true) {
	// Add Shape Layer "Layer 6 Outlines 4", varName "layer6Outlines4";
	var layer6Outlines4 = writingemailsslant_comp.layers.addShape();
		layer6Outlines4.name = "Layer 6 Outlines 4";
		layer6Outlines4.enabled = false;
		layer6Outlines4.inPoint = 0.6;
		layer6Outlines4.outPoint = 1.6;
		layer6Outlines4.motionBlur = true;
		layer6Outlines4.moveToEnd();
		layer6Outlines4.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var layer6Outlines4Path = layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var layer6Outlines4Path_newShape = new Shape();
			layer6Outlines4Path_newShape.vertices = [[8.12001037597656, -45.5290222167969], [-7.79899597167969, -45.5469970703125], [-70.5, -0.00001525878906], [-7.79899597167969, 45.5469970703125], [8.12001037597656, 45.5289916992188], [70.4999847412109, -0.00001525878906]];
			layer6Outlines4Path_newShape.inTangents = [[0, 0], [4.74800109863281, -3.44900512695312], [0, 0], [0, 0], [-4.74000549316406, 3.46000671386719], [0, 0]];
			layer6Outlines4Path_newShape.outTangents = [[-4.74000549316406, -3.45999145507812], [0, 0], [0, 0], [4.74800109863281, 3.44900512695312], [0, 0], [0, 0]];
			layer6Outlines4Path_newShape.closed = true;
		layer6Outlines4Path.setValue(layer6Outlines4Path_newShape);
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(7.90899991989136);
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - G-Fill");
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Grad Start Pt").setValue([50,-39]);
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Grad End Pt").setValue([50,50]);
		layer6Outlines4.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([90.2724761962891,68.7685012817383]);
		layer6Outlines4.property("ADBE Mask Parade").addProperty("ADBE Mask Atom");
		layer6Outlines4.property("ADBE Mask Parade").property(1).color = [0.90588235294118,0.75686274509804,0.61960784313725];
		layer6Outlines4.property("ADBE Mask Parade").property(1).maskMode = MaskMode.SUBTRACT;
		var layer6Outlines4MaskPath = layer6Outlines4.property("ADBE Mask Parade").property(1).property("ADBE Mask Shape");
		var layer6Outlines4MaskPath_newShape = new Shape();
			layer6Outlines4MaskPath_newShape.vertices = [[1.42724609375, 0.47666931152344], [-0.15457153320312, 0.47666931152344], [-0.15457153320312, 1.40774536132812], [1.42724609375, 1.40774536132812]];
			layer6Outlines4MaskPath_newShape.closed = true;
		layer6Outlines4MaskPath.setValue(layer6Outlines4MaskPath_newShape);
		layer6Outlines4.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([90.2724914550781,66.0184936523438,0]);
		layer6Outlines4.property("ADBE Transform Group").property("ADBE Position").setValue([195.249992370605,183.119003295898,0]);
		layer6Outlines4.property("ADBE Transform Group").property("ADBE Scale").setValue([-100,100,100]);
		layer6Outlines4.property("ADBE Transform Group").property("ADBE Rotate Z").setValue(-180);
		layer6Outlines4.selected = false;
	var compcode2 = writingemailsslant_comp.layers.addText("@");
		compcode2.name = "@ 2";
		compcode2.startTime = -0.08;
		compcode2.inPoint = 0.84;
		compcode2.outPoint = 1.24;
		compcode2.motionBlur = true;
		compcode2.moveToEnd();
		compcode2.trackMatteType = TrackMatteType.ALPHA;
		var compcode2_TextProp = compcode2.property("ADBE Text Properties").property("ADBE Text Document");
		var compcode2_TextDocument = compcode2_TextProp.value;
			compcode2_TextDocument.font = "OpenSans-Extrabold";
			compcode2_TextDocument.fontSize = 56;
			compcode2_TextDocument.applyFill = true;
			compcode2_TextDocument.fillColor = [1,1,1];
			compcode2_TextDocument.applyStroke = false;
			compcode2_TextDocument.justification = ParagraphJustification.LEFT_JUSTIFY;
			compcode2_TextDocument.tracking = 0;
			if (parseFloat(app.version) >= 13.2 ) {
				compcode2_TextDocument.verticalScale = 1;
				compcode2_TextDocument.horizontalScale = 1;
				compcode2_TextDocument.baselineShift = 0;
				compcode2_TextDocument.tsume = 0;
				// These values are read-only. You have to set them manually in the comp.
				// compcode2_TextDocument.fauxBold = false;
				// compcode2_TextDocument.fauxItalic = false;
				// compcode2_TextDocument.allCaps = false;
				// compcode2_TextDocument.smallCaps = false;
				// compcode2_TextDocument.superscript = false;
				// compcode2_TextDocument.subscript = false;
			}
			compcode2_TextProp.setValue(compcode2_TextDocument);
		compcode2.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([25.115234375,-18.142578125,0]);
		var compcode2Position = compcode2.property("ADBE Transform Group").property("ADBE Position");
			var compcode2Position_keyTimesArray = [0.84,1.2];
			var compcode2Position_valuesArray = [[194.5,257.396484375,0],[194.5,180.896484375,0]];
			compcode2Position.setValuesAtTimes(compcode2Position_keyTimesArray, compcode2Position_valuesArray);
			var compcode2Position_inSpatialTangents = [[0,12.75,0],[0,12.75,0]];
			var compcode2Position_outSpatialTangents = [[0,-12.75,0],[0,-12.75,0]];
			applySpatialTangents(compcode2Position, compcode2Position_keyTimesArray, compcode2Position_inSpatialTangents, compcode2Position_outSpatialTangents);
			var compcode2Position_easeInSpeedArray = [0,0];
			var compcode2Position_easeInInfluArray = [65,65];
			var compcode2Position_easeOutSpeedArray = [0,0];
			var compcode2Position_easeOutInfluArray = [65,16.666666667];
			var compcode2Position_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var compcode2Position_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(compcode2Position, compcode2Position_keyTimesArray, [compcode2Position_easeInSpeedArray, compcode2Position_easeInInfluArray], [compcode2Position_easeOutSpeedArray, compcode2Position_easeOutInfluArray], [compcode2Position_keyInInterpolationType, compcode2Position_keyOutInterpolationType]);

		compcode2.selected = false;
	// Add Shape Layer "Layer 6 Outlines 5", varName "layer6Outlines5";
	var layer6Outlines5 = writingemailsslant_comp.layers.addShape();
		layer6Outlines5.name = "Layer 6 Outlines 5";
		layer6Outlines5.enabled = false;
		layer6Outlines5.inPoint = 0.6;
		layer6Outlines5.outPoint = 1.6;
		layer6Outlines5.motionBlur = true;
		layer6Outlines5.moveToEnd();
		layer6Outlines5.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var layer6Outlines5Path = layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var layer6Outlines5Path_newShape = new Shape();
			layer6Outlines5Path_newShape.vertices = [[8.12001037597656, -45.5290222167969], [-7.79899597167969, -45.5469970703125], [-70.5, -0.00001525878906], [-7.79899597167969, 45.5469970703125], [8.12001037597656, 45.5289916992188], [70.4999847412109, -0.00001525878906]];
			layer6Outlines5Path_newShape.inTangents = [[0, 0], [4.74800109863281, -3.44900512695312], [0, 0], [0, 0], [-4.74000549316406, 3.46000671386719], [0, 0]];
			layer6Outlines5Path_newShape.outTangents = [[-4.74000549316406, -3.45999145507812], [0, 0], [0, 0], [4.74800109863281, 3.44900512695312], [0, 0], [0, 0]];
			layer6Outlines5Path_newShape.closed = true;
		layer6Outlines5Path.setValue(layer6Outlines5Path_newShape);
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(7.90899991989136);
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - G-Fill");
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Grad Start Pt").setValue([50,-39]);
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Grad End Pt").setValue([50,50]);
		layer6Outlines5.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([90.2724761962891,68.7685012817383]);
		layer6Outlines5.property("ADBE Mask Parade").addProperty("ADBE Mask Atom");
		layer6Outlines5.property("ADBE Mask Parade").property(1).color = [0.90588235294118,0.75686274509804,0.61960784313725];
		layer6Outlines5.property("ADBE Mask Parade").property(1).maskMode = MaskMode.SUBTRACT;
		var layer6Outlines5MaskPath = layer6Outlines5.property("ADBE Mask Parade").property(1).property("ADBE Mask Shape");
		var layer6Outlines5MaskPath_newShape = new Shape();
			layer6Outlines5MaskPath_newShape.vertices = [[1.42724609375, 0.47666931152344], [-0.15457153320312, 0.47666931152344], [-0.15457153320312, 1.40774536132812], [1.42724609375, 1.40774536132812]];
			layer6Outlines5MaskPath_newShape.closed = true;
		layer6Outlines5MaskPath.setValue(layer6Outlines5MaskPath_newShape);
		layer6Outlines5.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([90.2724914550781,66.0184936523438,0]);
		layer6Outlines5.property("ADBE Transform Group").property("ADBE Position").setValue([195.249992370605,183.119003295898,0]);
		layer6Outlines5.property("ADBE Transform Group").property("ADBE Scale").setValue([-100,100,100]);
		layer6Outlines5.property("ADBE Transform Group").property("ADBE Rotate Z").setValue(-180);
		layer6Outlines5.selected = false;
	var compcode = writingemailsslant_comp.layers.addText("@");
		compcode.startTime = -0.08;
		compcode.inPoint = 0.84;
		compcode.outPoint = 1.24;
		compcode.motionBlur = true;
		compcode.moveToEnd();
		compcode.trackMatteType = TrackMatteType.ALPHA;
		var compcode_TextProp = compcode.property("ADBE Text Properties").property("ADBE Text Document");
		var compcode_TextDocument = compcode_TextProp.value;
			compcode_TextDocument.font = "OpenSans-Extrabold";
			compcode_TextDocument.fontSize = 56;
			compcode_TextDocument.applyFill = true;
			compcode_TextDocument.fillColor = [0,0,0];
			compcode_TextDocument.applyStroke = false;
			compcode_TextDocument.justification = ParagraphJustification.LEFT_JUSTIFY;
			compcode_TextDocument.tracking = 0;
			if (parseFloat(app.version) >= 13.2 ) {
				compcode_TextDocument.verticalScale = 1;
				compcode_TextDocument.horizontalScale = 1;
				compcode_TextDocument.baselineShift = 0;
				compcode_TextDocument.tsume = 0;
				// These values are read-only. You have to set them manually in the comp.
				// compcode_TextDocument.fauxBold = false;
				// compcode_TextDocument.fauxItalic = false;
				// compcode_TextDocument.allCaps = false;
				// compcode_TextDocument.smallCaps = false;
				// compcode_TextDocument.superscript = false;
				// compcode_TextDocument.subscript = false;
			}
			compcode_TextProp.setValue(compcode_TextDocument);
		compcode.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([25.115234375,-18.142578125,0]);
		compcode.property("ADBE Transform Group").property("ADBE Position").setValue([28.865234375,-14.392578125,0]);
		compcode.property("ADBE Transform Group").property("ADBE Opacity").setValue(50);
		compcode.selected = false;
	//Create new Null layer "nullControl" and replace its source with varName "null6_null";
	var nullControl = writingemailsslant_comp.layers.addNull();
	var nullControl_source = nullControl.source;
		nullControl.replaceSource(null6_null, true);
		nullControl_source.remove();
		nullControl.name = "NULL CONTROL";
		nullControl.label = 9;
		nullControl.inPoint = 0.6;
		nullControl.outPoint = 1.6;
		nullControl.motionBlur = true;
		nullControl.moveToEnd();
		nullControl.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([60,60,0]);
		nullControl.property("ADBE Transform Group").property("ADBE Position").setValue([195.249984741211,179.119003295898,0]);
		var nullControlScale = nullControl.property("ADBE Transform Group").property("ADBE Scale");
			var nullControlScale_keyTimesArray = [0.6,1.04];
			var nullControlScale_valuesArray = [[100,100,100],[100,-100,100]];
			nullControlScale.setValuesAtTimes(nullControlScale_keyTimesArray, nullControlScale_valuesArray);
			var nullControlScale_easeInSpeedArray = [[0,0,0],[0,0,0]];
			var nullControlScale_easeInInfluArray = [[65,65,65],[65,65,65]];
			var nullControlScale_easeOutSpeedArray = [[0,0,0],[0,0,0]];
			var nullControlScale_easeOutInfluArray = [[65,65,65],[65,65,65]];
			var nullControlScale_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var nullControlScale_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(nullControlScale, nullControlScale_keyTimesArray, [nullControlScale_easeInSpeedArray, nullControlScale_easeInInfluArray], [nullControlScale_easeOutSpeedArray, nullControlScale_easeOutInfluArray], [nullControlScale_keyInInterpolationType, nullControlScale_keyOutInterpolationType]);

		nullControl.selected = false;
	// Add Shape Layer "Layer 3 Outlines", varName "layer3Outlines";
	var layer3Outlines = writingemailsslant_comp.layers.addShape();
		layer3Outlines.name = "Layer 3 Outlines";
		layer3Outlines.outPoint = 0.84;
		layer3Outlines.motionBlur = true;
		layer3Outlines.moveToEnd();
		layer3Outlines.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer3Outlines.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var layer3OutlinesPath = layer3Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var layer3OutlinesPath_newShape = new Shape();
			layer3OutlinesPath_newShape.vertices = [[-70.5, -24.3690032958984], [-7.79901123046875, 20.6780090332031], [8.1199951171875, 20.9100036621094], [70.5, -24.3690032958984]];
			layer3OutlinesPath_newShape.inTangents = [[0, 0], [0, 0], [-4.74099731445312, 3.45899963378906], [0, 0]];
			layer3OutlinesPath_newShape.outTangents = [[0, 0], [4.74800109863281, 3.44898986816406], [0, 0], [0, 0]];
			layer3OutlinesPath_newShape.closed = true;
		layer3OutlinesPath.setValue(layer3OutlinesPath_newShape);
		layer3Outlines.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer3Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer3Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8);
		layer3Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer3Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer3Outlines.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([90.5,44.3690032958984]);
		layer3Outlines.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Shape - Group");
		var layer3OutlinesPath = layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(1).property("ADBE Vector Shape");
		var layer3OutlinesPath_newShape = new Shape();
			layer3OutlinesPath_newShape.vertices = [[-70.5, -24.3690032958984], [-7.79901123046875, 20.6780090332031], [8.1199951171875, 20.9100036621094], [70.5, -24.3690032958984]];
			layer3OutlinesPath_newShape.inTangents = [[0, 0], [0, 0], [-4.74099731445312, 3.45899963378906], [0, 0]];
			layer3OutlinesPath_newShape.outTangents = [[0, 0], [4.74800109863281, 3.44898986816406], [0, 0], [0, 0]];
			layer3OutlinesPath_newShape.closed = true;
		layer3OutlinesPath.setValue(layer3OutlinesPath_newShape);
		layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Group");
		layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(2).property(2).addProperty("ADBE Vector Shape - Group");
		var layer3OutlinesPath = layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(2).property(2).property(1).property("ADBE Vector Shape");
		var layer3OutlinesPath_newShape = new Shape();
			layer3OutlinesPath_newShape.vertices = [[-195.25, 205.630996704102], [216.75, 205.630996704102], [216.75, -206.369003295898], [-195.25, -206.369003295898]];
			layer3OutlinesPath_newShape.closed = true;
		layer3OutlinesPath.setValue(layer3OutlinesPath_newShape);
		layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(2).property(2).addProperty("ADBE Vector Shape - Group");
		var layer3OutlinesPath = layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(2).property(2).property(2).property("ADBE Vector Shape");
		var layer3OutlinesPath_newShape = new Shape();
			layer3OutlinesPath_newShape.vertices = [[-195.25, -206.369003295898], [216.75, -206.369003295898], [216.75, 205.630996704102], [-195.25, 205.630996704102]];
			layer3OutlinesPath_newShape.closed = true;
		layer3OutlinesPath.setValue(layer3OutlinesPath_newShape);
		layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Filter - Merge");
		layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(3).property("ADBE Vector Merge Type").setValue(4);
		layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Graphic - Fill");
		layer3Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(4).property("ADBE Vector Fill Color").setValue([1,1,1,1]);
		layer3Outlines.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Position").setValue([90.5,44.3690032958984]);
		layer3Outlines.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([90.5,16.1189956665039,0]);
		layer3Outlines.property("ADBE Transform Group").property("ADBE Position").setValue([60,60,0]);
		layer3Outlines.selected = false;
	// Add Shape Layer "Layer 7 Outlines 3", varName "layer7Outlines3";
	var layer7Outlines3 = writingemailsslant_comp.layers.addShape();
		layer7Outlines3.name = "Layer 7 Outlines 3";
		layer7Outlines3.enabled = false;
		layer7Outlines3.inPoint = 0.6;
		layer7Outlines3.outPoint = 1.6;
		layer7Outlines3.motionBlur = true;
		layer7Outlines3.moveToEnd();
		layer7Outlines3.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var layer7Outlines3Path = layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var layer7Outlines3Path_newShape = new Shape();
			layer7Outlines3Path_newShape.vertices = [[-70.5, 22.66650390625], [0.5, -22.66650390625], [70.5, 22.66650390625]];
			layer7Outlines3Path_newShape.closed = true;
		layer7Outlines3Path.setValue(layer7Outlines3Path_newShape);
		layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8);
		layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Fill Color").setValue([1,1,1,1]);
		layer7Outlines3.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([90.5,73.3335037231445]);
		layer7Outlines3.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Shape - Group");
		var layer7Outlines3Path = layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(2).property(1).property("ADBE Vector Shape");
		var layer7Outlines3Path_newShape = new Shape();
			layer7Outlines3Path_newShape.vertices = [[-70.5, 38], [70.5, 38], [70.5, -38], [-70.5, -38]];
			layer7Outlines3Path_newShape.closed = true;
		layer7Outlines3Path.setValue(layer7Outlines3Path_newShape);
		layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8);
		layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Graphic - Fill");
		layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(2).property(3).property("ADBE Vector Fill Color").setValue([1,1,1,1]);
		layer7Outlines3.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Position").setValue([90.75,58]);
		layer7Outlines3.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([90.625,58,0]);
		layer7Outlines3.property("ADBE Transform Group").property("ADBE Position").setValue([195.375,220,0]);
		layer7Outlines3.selected = false;
	// Add Shape Layer "Layer 6 Outlines 3", varName "layer6Outlines3";
	var layer6Outlines3 = writingemailsslant_comp.layers.addShape();
		layer6Outlines3.name = "Layer 6 Outlines 3";
		layer6Outlines3.inPoint = 0.6;
		layer6Outlines3.outPoint = 1.6;
		layer6Outlines3.motionBlur = true;
		layer6Outlines3.moveToEnd();
		layer6Outlines3.trackMatteType = TrackMatteType.ALPHA;
		layer6Outlines3.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var layer6Outlines3Path = layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var layer6Outlines3Path_newShape = new Shape();
			layer6Outlines3Path_newShape.vertices = [[8.12001037597656, -45.5290222167969], [-7.79899597167969, -45.5469970703125], [-70.5, -0.00001525878906], [-7.79899597167969, 45.5469970703125], [8.12001037597656, 45.5289916992188], [70.4999847412109, -0.00001525878906]];
			layer6Outlines3Path_newShape.inTangents = [[0, 0], [4.74800109863281, -3.44900512695312], [0, 0], [0, 0], [-4.74000549316406, 3.46000671386719], [0, 0]];
			layer6Outlines3Path_newShape.outTangents = [[-4.74000549316406, -3.45999145507812], [0, 0], [0, 0], [4.74800109863281, 3.44900512695312], [0, 0], [0, 0]];
			layer6Outlines3Path_newShape.closed = true;
		layer6Outlines3Path.setValue(layer6Outlines3Path_newShape);
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(7.90899991989136);
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - G-Fill");
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Grad Start Pt").setValue([50,-39]);
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Grad End Pt").setValue([50,50]);
		layer6Outlines3.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([90.2724761962891,68.7685012817383]);
		layer6Outlines3.property("ADBE Mask Parade").addProperty("ADBE Mask Atom");
		layer6Outlines3.property("ADBE Mask Parade").property(1).color = [0.90588235294118,0.75686274509804,0.61960784313725];
		layer6Outlines3.property("ADBE Mask Parade").property(1).maskMode = MaskMode.SUBTRACT;
		var layer6Outlines3MaskPath = layer6Outlines3.property("ADBE Mask Parade").property(1).property("ADBE Mask Shape");
		var layer6Outlines3MaskPath_newShape = new Shape();
			layer6Outlines3MaskPath_newShape.vertices = [[1.42724609375, 0.47666931152344], [-0.15457153320312, 0.47666931152344], [-0.15457153320312, 1.40774536132812], [1.42724609375, 1.40774536132812]];
			layer6Outlines3MaskPath_newShape.closed = true;
		layer6Outlines3MaskPath.setValue(layer6Outlines3MaskPath_newShape);
		layer6Outlines3.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([90.2724914550781,66.0184936523438,0]);
		layer6Outlines3.property("ADBE Transform Group").property("ADBE Position").setValue([195.249992370605,183.119003295898,0]);
		layer6Outlines3.property("ADBE Transform Group").property("ADBE Scale").setValue([-100,100,100]);
		layer6Outlines3.property("ADBE Transform Group").property("ADBE Rotate Z").setValue(-180);
		layer6Outlines3.selected = false;
	// Add Shape Layer "Layer 7 Outlines 2", varName "layer7Outlines2";
	var layer7Outlines2 = writingemailsslant_comp.layers.addShape();
		layer7Outlines2.name = "Layer 7 Outlines 2";
		layer7Outlines2.enabled = false;
		layer7Outlines2.inPoint = 0.84;
		layer7Outlines2.outPoint = 1.6;
		layer7Outlines2.motionBlur = true;
		layer7Outlines2.moveToEnd();
		layer7Outlines2.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var layer7Outlines2Path = layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var layer7Outlines2Path_newShape = new Shape();
			layer7Outlines2Path_newShape.vertices = [[-70.5, 22.66650390625], [0.5, -22.66650390625], [70.5, 22.66650390625]];
			layer7Outlines2Path_newShape.closed = true;
		layer7Outlines2Path.setValue(layer7Outlines2Path_newShape);
		layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8);
		layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Fill Color").setValue([1,1,1,1]);
		layer7Outlines2.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([90.5,73.3335037231445]);
		layer7Outlines2.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Shape - Group");
		var layer7Outlines2Path = layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(2).property(1).property("ADBE Vector Shape");
		var layer7Outlines2Path_newShape = new Shape();
			layer7Outlines2Path_newShape.vertices = [[-70.5, 38], [70.5, 38], [70.5, -38], [-70.5, -38]];
			layer7Outlines2Path_newShape.closed = true;
		layer7Outlines2Path.setValue(layer7Outlines2Path_newShape);
		layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8);
		layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Graphic - Fill");
		layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(2).property(3).property("ADBE Vector Fill Color").setValue([1,1,1,1]);
		layer7Outlines2.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Position").setValue([90.75,58]);
		layer7Outlines2.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([90.625,58,0]);
		layer7Outlines2.property("ADBE Transform Group").property("ADBE Position").setValue([195.375,220,0]);
		layer7Outlines2.selected = false;
	// Add Shape Layer "Layer 6 Outlines", varName "layer6Outlines";
	var layer6Outlines = writingemailsslant_comp.layers.addShape();
		layer6Outlines.name = "Layer 6 Outlines";
		layer6Outlines.inPoint = 0.84;
		layer6Outlines.outPoint = 1.6;
		layer6Outlines.motionBlur = true;
		layer6Outlines.moveToEnd();
		layer6Outlines.trackMatteType = TrackMatteType.ALPHA_INVERTED;
		layer6Outlines.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var layer6OutlinesPath = layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var layer6OutlinesPath_newShape = new Shape();
			layer6OutlinesPath_newShape.vertices = [[8.12001037597656, -45.5290222167969], [-7.79899597167969, -45.5469970703125], [-70.5, -0.00001525878906], [-7.79899597167969, 45.5469970703125], [8.12001037597656, 45.5289916992188], [70.4999847412109, -0.00001525878906]];
			layer6OutlinesPath_newShape.inTangents = [[0, 0], [4.74800109863281, -3.44900512695312], [0, 0], [0, 0], [-4.74000549316406, 3.46000671386719], [0, 0]];
			layer6OutlinesPath_newShape.outTangents = [[-4.74000549316406, -3.45999145507812], [0, 0], [0, 0], [4.74800109863281, 3.44900512695312], [0, 0], [0, 0]];
			layer6OutlinesPath_newShape.closed = true;
		layer6OutlinesPath.setValue(layer6OutlinesPath_newShape);
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(7.90899991989136);
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - G-Fill");
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Grad Start Pt").setValue([50,-50]);
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Grad End Pt").setValue([50,50]);
		layer6Outlines.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([90.2724761962891,68.7685012817383]);
		layer6Outlines.property("ADBE Mask Parade").addProperty("ADBE Mask Atom");
		layer6Outlines.property("ADBE Mask Parade").property(1).color = [0.90588235294118,0.75686274509804,0.61960784313725];
		layer6Outlines.property("ADBE Mask Parade").property(1).maskMode = MaskMode.SUBTRACT;
		var layer6OutlinesMaskPath = layer6Outlines.property("ADBE Mask Parade").property(1).property("ADBE Mask Shape");
		var layer6OutlinesMaskPath_newShape = new Shape();
			layer6OutlinesMaskPath_newShape.vertices = [[1.42724609375, 0.47666931152344], [-0.15457153320312, 0.47666931152344], [-0.15457153320312, 1.40774536132812], [1.42724609375, 1.40774536132812]];
			layer6OutlinesMaskPath_newShape.closed = true;
		layer6OutlinesMaskPath.setValue(layer6OutlinesMaskPath_newShape);
		layer6Outlines.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([90.2724914550781,66.0184936523438,0]);
		var layer6OutlinesPosition = layer6Outlines.property("ADBE Transform Group").property("ADBE Position");
			var layer6OutlinesPosition_keyTimesArray = [0.6,1.04];
			var layer6OutlinesPosition_valuesArray = [[60.0000076293945,65,0],[60.0000076293945,61.75,0]];
			layer6OutlinesPosition.setValuesAtTimes(layer6OutlinesPosition_keyTimesArray, layer6OutlinesPosition_valuesArray);
			var layer6OutlinesPosition_inSpatialTangents = [[0,0.54166668653488,0],[0,0.54166668653488,0]];
			var layer6OutlinesPosition_outSpatialTangents = [[0,-0.54166668653488,0],[0,-0.54166668653488,0]];
			applySpatialTangents(layer6OutlinesPosition, layer6OutlinesPosition_keyTimesArray, layer6OutlinesPosition_inSpatialTangents, layer6OutlinesPosition_outSpatialTangents);
			var layer6OutlinesPosition_easeInSpeedArray = [0,0];
			var layer6OutlinesPosition_easeInInfluArray = [65,65];
			var layer6OutlinesPosition_easeOutSpeedArray = [0,0];
			var layer6OutlinesPosition_easeOutInfluArray = [65,65];
			var layer6OutlinesPosition_keyInInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			var layer6OutlinesPosition_keyOutInterpolationType = [KeyframeInterpolationType.BEZIER,KeyframeInterpolationType.BEZIER];
			applyEasing(layer6OutlinesPosition, layer6OutlinesPosition_keyTimesArray, [layer6OutlinesPosition_easeInSpeedArray, layer6OutlinesPosition_easeInInfluArray], [layer6OutlinesPosition_easeOutSpeedArray, layer6OutlinesPosition_easeOutInfluArray], [layer6OutlinesPosition_keyInInterpolationType, layer6OutlinesPosition_keyOutInterpolationType]);

		layer6Outlines.property("ADBE Transform Group").property("ADBE Scale").setValue([-100,100,100]);
		layer6Outlines.property("ADBE Transform Group").property("ADBE Rotate Z").setValue(-180);
		layer6Outlines.selected = false;
	// Add Shape Layer "Layer 7 Outlines", varName "layer7Outlines";
	var layer7Outlines = writingemailsslant_comp.layers.addShape();
		layer7Outlines.name = "Layer 7 Outlines";
		layer7Outlines.motionBlur = true;
		layer7Outlines.moveToEnd();
		layer7Outlines.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer7Outlines.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Shape - Group");
		var layer7OutlinesPath = layer7Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(1).property("ADBE Vector Shape");
		var layer7OutlinesPath_newShape = new Shape();
			layer7OutlinesPath_newShape.vertices = [[-70.5, 22.66650390625], [0.5, -22.66650390625], [70.5, 22.66650390625]];
			layer7OutlinesPath_newShape.closed = true;
		layer7OutlinesPath.setValue(layer7OutlinesPath_newShape);
		layer7Outlines.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer7Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer7Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8);
		layer7Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer7Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer7Outlines.property("ADBE Root Vectors Group").property(1).property(2).addProperty("ADBE Vector Graphic - Fill");
		layer7Outlines.property("ADBE Root Vectors Group").property(1).property(2).property(3).property("ADBE Vector Fill Color").setValue([1,1,1,1]);
		layer7Outlines.property("ADBE Root Vectors Group").property(1).property(3).property("ADBE Vector Position").setValue([90.5,73.3335037231445]);
		layer7Outlines.property("ADBE Root Vectors Group").addProperty("ADBE Vector Group");
		layer7Outlines.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Shape - Group");
		var layer7OutlinesPath = layer7Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(1).property("ADBE Vector Shape");
		var layer7OutlinesPath_newShape = new Shape();
			layer7OutlinesPath_newShape.vertices = [[-70.5, 38], [70.5, 38], [70.5, -38], [-70.5, -38]];
			layer7OutlinesPath_newShape.closed = true;
		layer7OutlinesPath.setValue(layer7OutlinesPath_newShape);
		layer7Outlines.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Graphic - Stroke");
		layer7Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Color").setValue([0,0,0,1]);
		layer7Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Width").setValue(8);
		layer7Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Line Cap").setValue(2);
		layer7Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(2).property("ADBE Vector Stroke Line Join").setValue(2);
		layer7Outlines.property("ADBE Root Vectors Group").property(2).property(2).addProperty("ADBE Vector Graphic - Fill");
		layer7Outlines.property("ADBE Root Vectors Group").property(2).property(2).property(3).property("ADBE Vector Fill Color").setValue([1,1,1,1]);
		layer7Outlines.property("ADBE Root Vectors Group").property(2).property(3).property("ADBE Vector Position").setValue([90.75,58]);
		layer7Outlines.property("ADBE Transform Group").property("ADBE Anchor Point").setValue([90.625,58,0]);
		layer7Outlines.property("ADBE Transform Group").property("ADBE Position").setValue([195.375,220,0]);
		layer7Outlines.selected = false;
	// Apply parents
		compcode.setParentWithJump(compcode2);
		layer3Outlines.setParentWithJump(nullControl);
		layer6Outlines.setParentWithJump(nullControl);

}
writingemails_comp.openInViewer();

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

