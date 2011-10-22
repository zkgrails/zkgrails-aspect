package org.zkoss.zk.grails;

import org.zkoss.zk.ui.Component;

import org.zkoss.zkplus.databind.TypeConverter;
import org.zkoss.zkplus.databind.Binding;

public privileged aspect BindingAspect {

    pointcut callCoerceTo(Object val, Component comp, Binding binding):
    (
     call(public Object TypeConverter.coerceToUI(Object, Component)) ||
     call(public Object TypeConverter.coerceToBean(Object, Component))
    )
    && args(val, comp) && this(binding);

    Object around(Object val, Component comp, Binding binding): callCoerceTo(val, comp, binding) {
        comp.setAttribute("zkgrails.current.binding.attr", binding._attr);
        Object result = proceed(val, comp);
        comp.removeAttribute("zkgrails.current.binding.attr");
        return result;
    }
}