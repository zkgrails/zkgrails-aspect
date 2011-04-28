package org.zkoss.zkgrails;

import groovy.lang.Closure;

import org.zkoss.zul.Grid;
import org.zkoss.zul.Row;
import org.zkoss.zul.RowRenderer;

public privileged aspect SugarAspect {

    public static class InternalRowRenderer implements RowRenderer {
        private final Closure c;
        public InternalRowRenderer(Closure c) {
            this.c = c;
        }
        public void render(Row row, Object data) throws Exception {
           c.call(new Object[]{row, data});
        }
    }

    public void Grid.setRowRenderer(final Closure c) {
        this.setRowRenderer(new SugarAspect.InternalRowRenderer(c));
    }

}

