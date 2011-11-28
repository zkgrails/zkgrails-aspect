package org.zkoss.web.util.resource;

import java.io.File;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.BufferedInputStream;
import java.io.InputStreamReader;
import java.net.URL;

import javax.servlet.ServletContext;

import org.zkoss.lang.D;
import org.zkoss.lang.Exceptions;
import org.zkoss.lang.SystemException;
import org.zkoss.util.resource.ResourceCache;
import org.zkoss.util.logging.Log;
import org.zkoss.io.Files;

import org.zkoss.web.servlet.Servlets;

public privileged aspect ResourceCachesAspect {

    pointcut executeGet(ResourceCache cache, ServletContext ctx, String path, Object extra):
        execution(public static Object get(ResourceCache,ServletContext,String,Object))
        && args(cache,ctx,path,extra);

    Object around(ResourceCache cache, ServletContext ctx, String path, Object extra):
            executeGet(cache, ctx, path, extra) {
        URL url = null;
        if (path == null || path.length() == 0) path = "/";
        else if (path.charAt(0) != '/') {
            if (path.indexOf("://") > 0) {
                try {
                    url = new URL(path);
                } catch (java.net.MalformedURLException ex) {
                    throw new SystemException(ex);
                }
            } else path = '/' + path;
        }

        if (url == null) {
            if (path.startsWith("/~")) {
                final ServletContext ctx0 = ctx;
                final String path0 = path;
                final int j = path.indexOf('/', 2);
                final String ctxpath;
                if (j >= 0) {
                    ctxpath = "/" + path.substring(2, j);
                    path = path.substring(j);
                } else {
                    ctxpath = "/" + path.substring(2);
                    path = "/";
                }

                final ExtendletContext extctx =
                    Servlets.getExtendletContext(ctx, ctxpath.substring(1));
                if (extctx != null) {
                    url = extctx.getResource(path);
                    if (url == null)
                        return null;
                    return cache.get(new ResourceInfo(path, url, extra));
                }

                ctx = ctx.getContext(ctxpath);
                if (ctx == null) { //failed
                    ctx = ctx0; path = path0;//restore
                }
            }

            final String flnm = ctx.getRealPath(path);
            if (flnm != null) {
                final File file = new File(flnm);
                // if (file.exists())
                return cache.get(new ResourceInfo(path, file, extra));
            }
        }

        // try url because some server uses JAR format
        try {
            if (url == null)
                url = ctx.getResource(path);
            if (url != null)
                return cache.get(new ResourceInfo(path, url, extra));
        } catch (Throwable ex) {
            // log.warning("Unable to load "+path+"\n"+Exceptions.getMessage(ex));
        }
        return null;
    }

}