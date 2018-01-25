package com.hwq.msonline.entity;

import java.util.List;

/**
 * 权限菜单树
 * @author Administrator
 *
 */
public class MenuTree {
     private String id;
     private String text;
     private Integer pid;
     private List<MenuTree> nodes;
     private State state;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public List<MenuTree> getNodes() {
		return nodes;
	}
	public void setNodes(List<MenuTree> nodes) {
		this.nodes = nodes;
	}
	
    public State getState() {
		return state;
	}
	public void setState(State state) {
		this.state = state;
	}

	public static class State{
    	 private boolean checked =false;
    	 private boolean disabled=false;
    	 private boolean expanded=false;
    	 private boolean selected=false;
		public boolean isChecked() {
			return checked;
		}
		public void setChecked(boolean checked) {
			this.checked = checked;
		}
		public boolean isDisabled() {
			return disabled;
		}
		public void setDisabled(boolean disabled) {
			this.disabled = disabled;
		}
		public boolean isExpanded() {
			return expanded;
		}
		public void setExpanded(boolean expanded) {
			this.expanded = expanded;
		}
		public boolean isSelected() {
			return selected;
		}
		public void setSelected(boolean selected) {
			this.selected = selected;
		}
    	 
     }
}
