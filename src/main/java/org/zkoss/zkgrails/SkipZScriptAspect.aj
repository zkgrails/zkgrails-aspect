package org.zkoss.zkgrails;

import java.lang.reflect.Method;

import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.metainfo.ComponentInfo;
import org.zkoss.zk.ui.util.Composer;
import org.zkoss.zk.ui.util.GenericAutowireComposer;

public privileged aspect SkipZScriptAspect {

    public void GenericAutowireComposer.skipZscriptWiring() {
        this._ignoreZScript = false;
        this._ignoreXel = false;
    }

}