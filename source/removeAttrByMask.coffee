# Usage: 
#   * $el.removeAttr(matching: 'example-*')
#   * $el.removeAttr(matching: /something/)
do ->
  removeAttr  = $.fn.removeAttr
  maskCache   = {}
  maskConvert = (mask) ->
    return mask if mask instanceof RegExp
    maskCache[mask] ?= new RegExp(mask.replace(/\*/g, '\\S+'))
    
  $.fn.removeAttr = (arg) ->
    if arguments.length > 0
      if arg isnt null and typeof arg is 'object' and arg.matching?
        removeAttrByMask(this, arg.matching)
      else
        removeAttr.call(this, arg)
    else
      removeAttr.call(this)
        
  removeAttrByMask =
    (elements, mask) ->
      re = maskConvert(mask)
      for el in elements
        attrs = el.attributes
        l     = el.attributes.length
        i     = -1
        while ++i < l
          attr = attrs[i]
          if re.test(attr.name)
            --l
            --i
            el.removeAttribute(attr.name)
      elements
