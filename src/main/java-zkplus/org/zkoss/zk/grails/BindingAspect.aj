package org.zkoss.zk.grails;

import java.lang.reflect.Method;

import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.metainfo.ComponentInfo;
import org.zkoss.zk.ui.util.Composer;

import org.zkoss.zkplus.databind.TypeConverter;

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