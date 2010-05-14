package org.zkoss.zkgrails;

import java.lang.reflect.Constructor;

import org.zkoss.zk.ui.metainfo.PageDefinitions;
import org.zkoss.util.resource.ResourceCache;
import org.zkoss.zk.ui.WebApp;
import org.zkoss.util.resource.Loader;

public privileged aspect ResourceLoaderAspect {

	private static Class<?> RESOURCE_LOADER_CLASS = null;
	public static void PageDefinitions.setResourceLoaderClass(Class<?> c) {
		RESOURCE_LOADER_CLASS = c;
	}
		
	pointcut executeGetCache(WebApp wapp): 
		execution(private static final ResourceCache PageDefinitions.getCache(WebApp))
		&& args(wapp);
		
	ResourceCache around(WebApp wapp): executeGetCache(wapp) {
		ResourceCache cache = (ResourceCache)wapp.getAttribute(PageDefinitions.ATTR_PAGE_CACHE);
		if (cache == null) {
			synchronized (PageDefinitions.class) {
				cache = (ResourceCache)wapp.getAttribute(PageDefinitions.ATTR_PAGE_CACHE);
				if (cache == null) {
					Class<?> rlClass = RESOURCE_LOADER_CLASS;
					Loader rLoader = new PageDefinitions.MyLoader(wapp);
					if(rlClass != null) {
						try {
							Constructor<?> ctor;
							ctor = rlClass.getDeclaredConstructor(new Class[]{WebApp.class});
							rLoader = (Loader)ctor.newInstance(new Object[]{wapp});
						} catch (Throwable e) { /* do nothing */ }							
					}					
					cache = new ResourceCache(rLoader, 167);
					cache.setMaxSize(1024);
					cache.setLifetime(60*60000); //1hr
					wapp.setAttribute(PageDefinitions.ATTR_PAGE_CACHE, cache);
				}
			}
		}
		return cache;
	}
}
