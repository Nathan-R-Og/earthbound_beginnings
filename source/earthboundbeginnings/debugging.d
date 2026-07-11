module earthboundbeginnings.debugging;

//mostly taken from earthbounD. lol

import earthboundbeginnings.ram;
import replatform64;
import replatform64.nes;

MemoryEditor defaultEditorSettings(string dumpFile) {
	MemoryEditor editor;
	editor.Cols = 8;
	editor.Dumpable = true;
	editor.DumpFile = dumpFile;
	editor.OptShowOptions = false;
	editor.OptShowDataPreview = false;
	editor.OptShowAscii = false;
	return editor;
}

void prepareDebugUI(const UIState uiState) {
	if (ImGui.BeginMainMenuBar()) {
		ImGui.EndMainMenuBar();
	}
}

void renderDebugWindow(const UIState state) {
	if (ImGui.TreeNode("Game State")) {
        ImGui.Text("ME_Pulse1Index: %d", ME_Pulse1Index);
        ImGui.Text("ME_Pulse2Index: %d", ME_Pulse2Index);
        ImGui.Text("ME_TriangleIndex: %d", ME_TriangleIndex);
        ImGui.Text("ME_NoiseIndex: %d", ME_NoiseIndex);
        ImGui.TreePop();
	}
}

void handleDialog(T)(ref bool isActive, string title) {
	import std.meta : Filter;
	static T data;
	if (!isActive) {
		return;
	}
	ImGui.OpenPopup(title);
	ImGui.SetNextWindowPos(ImGui.GetMainViewport().GetCenter(), ImGuiCond.Appearing, ImVec2(0.5f, 0.5f));
	if (ImGui.BeginPopupModal(title, null, ImGuiWindowFlags.AlwaysAutoResize)) {
		static foreach (field; T.tupleof) {{
			alias labels = Filter!(typeMatches!Label, __traits(getAttributes, __traits(getMember, data, __traits(identifier, field))));
			static if (labels.length == 1) {
				enum label = labels[0].text;
			} else {
				enum label = "NO LABEL";
			}
			InputEditable(label, __traits(getMember, data, __traits(identifier, field)));
		}}
		if (ImGui.Button("OK")) {
			snes.registerHook("main", &data.execute);
			isActive = false;
		}
		ImGui.SameLine();
		if (ImGui.Button("Cancel")) {
			isActive = false;
		}
		ImGui.EndPopup();
	}
}

void disabledCheckbox(string label, bool value) {
	ImGui.BeginDisabled();
	ImGui.Checkbox(label, &value);
	ImGui.EndDisabled();
}

struct IMGUIValueChanged(T...) {
	T values;
	private bool changed;
	alias values this;
	bool opCast(T: bool)() const @safe pure {
		return changed;
	}
}

struct Label {
	string text;
}

void menuItemCallback(string label, void function() func) {
	if (ImGui.MenuItem(label, null, null)) {
		func();
	}
}
