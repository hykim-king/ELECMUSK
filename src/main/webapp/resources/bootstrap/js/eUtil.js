let eUtil = {};
  //str이 비어있으면 true,
  //그렇지 않으면 false
  eUtil.ISEmpty = function(str){
    if(null != str && undefined != str){
      str = str.toString();
      
      if(str.replace(/ /gi,"").length == 0){
        return true;
      }
    }
    
    return false;
  }