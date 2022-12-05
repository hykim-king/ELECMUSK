/*
 * method: GET/POST
 * url:/ehr+"/user/doRetrive.do"
 * async: true
 * params: 전달데이터
 * callback function
 */
  let PClass = {
      callAjax:function( _method="GET",_url,_async=true,_params,_callback){
        
        if(null !=_url)_url = "/ehr"+_url;
        console.log("┌=============================┐");
        console.log("_method:"+_method);
        console.log("_url:"+_url);
        console.log("_async:"+_async);
        console.log("_params");
        let paramArray = Object.keys(_params)
        if(null !=paramArray && paramArray.length>0){
          for(let i=0;i<paramArray.length;i++){
            console.log("\t"+paramArray[i]+","+_params[ paramArray[i] ]);
          }
        }
        console.log("└=============================┘");  
        $.ajax({ 
           type: _method,
           url: _url,
           asyn: _async,
           dataType: "html",
           data:_params,
           success:function(data){ //통신 성공
             _callback(data);
           },
           error:function(data){//실패
           },
           complete:function(data){//성공, 실패 관계 없이 출력
           }
        });
        //$.ajax----------------------------------------------------------------
      }    
  };