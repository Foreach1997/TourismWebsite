package com.cn.utils;

public enum TypeEnum {
	  
	  HOT("����"), TEAMBUY("�Ź�");
      
      private final String value;

      TypeEnum(String value) {
          this.value = value;
      }
      
      public String getValue() {
          return value;
      }
    
}
