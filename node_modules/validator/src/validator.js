/*
{
"mandate":{
    "flags": "required",
    "type":"string",
    "match": "/^[0-9a-f]{16}$/"
 }
}
*/
var validator = function (targets, rules){
  //асинхрон не нужен
  
  //настройка чистильщиков
  //TODO свести в один объект? да, для удобства подключения плугинов
  var checkers = Object.create(null);
  var handlers = Object.create(null);
  
  handlers['required'] = function (target) {
      return true;
  };
  handlers['notRequired'] = function (target) {
      return true;
  };


  checkers["match"] = function (rule, target) {
      if(null === target.match(rule)){
          throw new Error("match: did not");
      }
  };
  checkers["type"] = function (rule, target) {
      switch(rule){
          case "integer":
              var re = /^[0-9]+$/g;
              if(("string" !== typeof target) || !re.test(target)){
		  throw new Error("illegal type");
	      }
	      break;
	  default:
              if(rule !== typeof target){
                  throw new Error("illegal type");
          }
      }
  };
  checkers["whiteList"] = function (rule, target){
  
      var helper = function (str, index, owner){
          return str.trim() === target;
      };
      
      if(!rule.split(',').some(helper)){
          throw new Error("whiteList: not in");
      }
  };

var cache = Object.create(null);

        for(var key in rules){
    
            if(key in targets){
                for(var rule in rules[key]){
                    if(rule === "flags"){
                        var chunks = rules[key][rule].split(',');
                        var flags = {};
                        chunks.forEach(cv => flags[cv] = "");
                        for(var flag in flags){
                            if(flag in handlers){
                                handlers[flag](targets[key]);
                            }
                            else{
                                throw new Error("unknown flag " + flag);
                            }
                        }
                        continue;
                    }else if(rule in checkers){
                        checkers[rule](rules[key][rule], targets[key]);
                    }
                    else{
                        throw new Error("there are no handler for rule");
                    }
                }
            
            }
            else{
                //throw если явно не указан notRequired
                var chunks = rules[key]['flags'].split(',');
                var flags = {};
                chunks.forEach(cv => flags[cv] = "");
                var required = true;
                for (var flag in flags) {
                    if (flags[flag] === 'notRequired') {
                        required = false;
                        break;
                    }
                }
                if (required) {
                    throw new Error("there are no target for rule " + key);
                }
            }
            if(targets[key]){
                cache[key] = targets[key];
                delete targets[key];
	    }
        }   

        //если в targets что то осталось - то значит нет такого правила
        //если есть unknown - проверить им
        for(target in targets){
            //TODO has own property
            //else
            throw new Error("there are no rule for target: " + JSON.stringify(targets));
        }
    //console.log("cbr: ");
    //console.log(cache);
    return cache;
}

module.exports = validator;
