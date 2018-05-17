# -------------------------------------------------------------------
# RpInit.py - RenderPal V2 Python initialization
# -------------------------------------------------------------------

import sys
import RenderPal

# -- This will redirect all output to RenderPal's output window

class RPRedirect:
	def write(self, s):
		RenderPal.ConWriter(s)

sys.stdout = RPRedirect()
sys.stderr = RPRedirect()

# -- Add RenderPal's Python directories to the search path

sys.path.append(r"$(RenderPal.ScriptPath)")
sys.path.append(r"$(RenderPal.ScriptPathUser)")
sys.path.append(r"$(RenderPal.ScriptPathLib)")
sys.path.append(r"$(RenderPal.ScriptPathDll)")

# - Copyright (c) Shoran Software -----------------------------------
