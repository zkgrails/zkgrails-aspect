package org.zkoss.zk.grails;

import org.zkoss.zk.ui.Component;

import org.zkoss.zkplus.databind.TypeConverter;
import org.zkoss.zkplus.databind.Binding;

public privileged aspect BindingAspect {

    pointcut callCoerceTo(Object val, Component comp):
    (
     call(public Object TypeConverter.coerceToUi(Object, Component)) ||
     call(public Object TypeConverter.coerceToBean(Object, Component))
    )
    && args(val, comp);

    before(Object val, Component comp, Binding binding): callCoerceTo(val, comp) && this(binding) {
        comp.setAttribute("zkgrails.current.binding.expr", binding.getExpression());
    }

    after(Object val, Component comp, Binding binding): callCoerceTo(val, comp) && this(binding) {
        comp.removeAttribute("zkgrails.current.binding.expr");
    }

}