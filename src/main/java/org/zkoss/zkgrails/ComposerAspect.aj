package org.zkoss.zkgrails;

import java.lang.reflect.Method;

import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.metainfo.ComponentInfo;
import org.zkoss.zk.ui.util.Composer;

public privileged aspect ComposerAspect {

    private static Class composerResolver = null;
    public static void ComponentInfo.setComposerResolver(Class c) {
        composerResolver = c;
    }

    pointcut executeToComposer(Page page, Object o):
        execution(private static Composer toComposer(Page, Object))
        && args(page, o);

    Composer around(Page page, Object o): executeToComposer(page, o) {
        if(composerResolver != null) {
            try {
                Method m = composerResolver.getMethod("resolveComposer", new Class[]{Page.class, String.class});
                if(o instanceof String) {
                    Composer result = (Composer)m.invoke(null, new Object[]{page, o});
                    if(result != null) return result;
                }
            }catch(Throwable e) { /* do nothing */}
        }

        return proceed(page, o);
    }
}

