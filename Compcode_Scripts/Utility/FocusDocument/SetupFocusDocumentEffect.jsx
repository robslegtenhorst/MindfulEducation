// SetupFocusDocumentEffect();    function SetupFocusDocumentEffect() {		//-------------------------------------------//------ Edit presetEffects.xml  -----------//-------------------------------------------var xmlContent = '<!-- BEGIN MINDFUL PSEUDO EFFECTS v02-->\n';	xmlContent += '	<Effect matchname="Pseudo/8B30e8667aY5F" name="$$$/AE/Preset/FocusDocument=FocusDocument">\n';    xmlContent += '		<Checkbox name="$$$/AE/Preset/ScriptEnabled=Script Enabled" default="true"/>\n';    xmlContent += '		<Slider name="$$$/AE/Preset/FocusControl=Focus Control" default="0" valid_min="0" valid_max="100"\n';    xmlContent += '		slider_min="0" slider_max="100" precision="1" DISPLAY_PERCENT="true"/>\n';    xmlContent += '		<Group name="$$$/AE/Preset/Movement=Movement">\n';    xmlContent += '			<Checkbox name="$$$/AE/Preset/MoveToCenter=Move To Center" default="true"/>\n';    xmlContent += '			<Layer name="$$$/AE/Preset/CenterRefLayer=Center Ref Layer" default_self="false"/>\n';    xmlContent += '			<Slider name="$$$/AE/Preset/XOffset=X Offset" default="0" valid_min="-2000" valid_max="2000" slider_min="-200" slider_max="200" precision="0"/>\n';    xmlContent += '			<Slider name="$$$/AE/Preset/YOffset=Y Offset" default="0" valid_min="-2000" valid_max="2000" slider_min="-200" slider_max="100" precision="0"/>\n';    xmlContent += '		</Group>\n';    xmlContent += '		<Group name="$$$/AE/Preset/Scale=Scale">\n';    xmlContent += '			<Checkbox name="$$$/AE/Preset/AutoScaleEnabled=Auto Scale Enabled" default="true"/>\n';    xmlContent += '			<Slider name="$$$/AE/Preset/ScaleFactor=Scale Factor" default="1" valid_min="-20" valid_max="100" slider_min="0" slider_max="10" precision="2"/>\n';    xmlContent += '		</Group>\n';    xmlContent += '		<Group name="$$$/AE/Preset/Drop_shadow=Drop shadow">\n';    xmlContent += '			<Checkbox name="$$$/AE/Preset/DSEnabled=DS Enabled" default="true"/>\n';    xmlContent += '			<Checkbox name="$$$/AE/Preset/UseGlobal=Use Global" default="true"/>\n';    xmlContent += '			<Color name="$$$/AE/Preset/DSColor=DS Color" default_red="0" default_green="0" default_blue="0"/>\n';    xmlContent += '			<Slider name="$$$/AE/Preset/DSMaxOpacity=DS Max Opacity" default="0" valid_min="0" valid_max="100" slider_min="0" slider_max="100" precision="0" DISPLAY_PERCENT="true"/>\n';    xmlContent += '			<Slider name="$$$/AE/Preset/DSMaxDistance=DS Max Distance" default="0" valid_min="0" valid_max="10000" slider_min="0" slider_max="120" precision="1"/>\n';    xmlContent += '			<Slider name="$$$/AE/Preset/DSMaxSoftness=DS Max Softness" default="0" valid_min="0" valid_max="1000" slider_min="0" slider_max="250" precision="1"/>\n';    xmlContent += '		</Group>\n';    xmlContent += '	</Effect>\n';    xmlContent += '<!-- END MINDFUL PSEUDO EFFECTS -->';	var appPath = Folder.appPackage.fsName;	var presetEffectsFile = new File(appPath + "\\PresetEffects.xml");	if ($.os.toLowerCase().indexOf("mac") >= 0) presetEffectsFile = new File(appPath + "/Contents/Resources/PresetEffects.xml");	if (presetEffectsFile.exists)	{		presetEffectsFile.open("r","TEXT");		var presetEffectsString = presetEffectsFile.read();				presetEffectsFile.close();		//update		var startIndex = presetEffectsString.indexOf("<!-- BEGIN MINDFUL PSEUDO EFFECTS v");		var endIndex = presetEffectsString.indexOf("<!-- END MINDFUL PSEUDO EFFECTS -->") + 35;		if (startIndex >= 0)		{			//USE THIS SECTION TO UPDATE EXISTING CODE			var stringToRemove = presetEffectsString.substring(startIndex,endIndex);			presetEffectsString = presetEffectsString.replace(stringToRemove,xmlContent);						if ($.os.toLowerCase().indexOf("mac") >= 0)			{				var cmd = "chmod u+rw  " + "\"" + appPath + "/Contents/Resources/PresetEffects.xml\"";				alert (system.callSystem(cmd), 'error');				system.callSystem(cmd);			}			else			{				var cmd = "cmd /c attrib -r /S /D \"" + appPath + "\"";				system.callSystem(cmd);				cmd = "cmd /c attrib -r /S /D \"" + appPath + "\\PresetEffects.xml\"";				system.callSystem(cmd);			}			//backup file			presetEffectsFile.copy(presetEffectsFile.fullName + ".bak");			//write the new file			var isReadOnly = presetEffectsFile.readonly;			presetEffectsFile.readonly = false;			presetEffectsFile.open("w","TEXT");			presetEffectsFile.write(presetEffectsString);			presetEffectsFile.close();			presetEffectsFile.readonly = isReadOnly;						alert('Script updated');		}		else		{			presetEffectsString = presetEffectsString.replace("</Effects>",xmlContent + "\r\n</Effects>");			//gets write access			if ($.os.toLowerCase().indexOf("mac") >= 0)			{				var cmd = "chmod u+rw  " + "\"" + appPath + "/Contents/Resources/PresetEffects.xml\"";				alert (system.callSystem(cmd), 'error');				system.callSystem(cmd);			}			else			{				var cmd = "cmd /c attrib -r /S /D \"" + appPath + "\"";				system.callSystem(cmd);				cmd = "cmd /c attrib -r /S /D \"" + appPath + "\\PresetEffects.xml\"";				system.callSystem(cmd);			}			//backup file			presetEffectsFile.copy(presetEffectsFile.fullName + ".bak");			//write the new file			var isReadOnly = presetEffectsFile.readonly;			presetEffectsFile.readonly = false;			presetEffectsFile.open("w","TEXT");			presetEffectsFile.write(presetEffectsString);			presetEffectsFile.close();			presetEffectsFile.readonly = isReadOnly;						alert('Please restart After Effects to complete installation');		}				}				} 