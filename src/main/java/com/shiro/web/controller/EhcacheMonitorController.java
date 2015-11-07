package com.shiro.web.controller;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.shiro.util.PrettyMemoryUtils;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * @ClassName EhcacheMonitorController.java
 * @Description 缓存监控
 *
 * @author 1904
 * @version V1.0 
 * @Date 2015年7月21日 下午4:58:20
 */
@SuppressWarnings("all")
@Controller
@RequestMapping("/ehcaches")
public class EhcacheMonitorController {

    @Autowired
    private CacheManager cacheManager;

    
    /**
     * 查看缓存列表
     * @param model
     * @return
     */
    @RequiresPermissions("monitor:ehcache:view")
    @RequestMapping()
    public String index(Model model) {
        model.addAttribute("cacheManager", cacheManager);
        return "ehcache/index";
    }

    
    /**
     * 缓存详细
     * @param cacheName
     * @param model
     * @return
     */
    @RequiresPermissions("monitor:ehcache:detail")
    @RequestMapping("{cacheName}/details")
    public String details(@PathVariable("cacheName") String cacheName, Model model) {
        model.addAttribute("cacheName", cacheName);
        List allKeys = cacheManager.getCache(cacheName).getKeys();
        
        model.addAttribute("keys", allKeys);
		return "ehcache/details";
    }

    
    /**
     * 查看单个缓存的详细信息
     * @param cacheName
     * @param key
     * @param model
     * @return
     */
    @RequiresPermissions("monitor:ehcache:detail")
    @RequestMapping(value = "{cacheName}/{key}/details", method = RequestMethod.GET, produces = "text/json;charset=UTF-8")
    @ResponseBody
    public String keyDetail(@PathVariable("cacheName") String cacheName, @PathVariable("key") String key, Model model) {

        Element element = cacheManager.getCache(cacheName).get(key);

        String dataPattern = "yyyy-MM-dd HH:mm:ss";
        Map<String, Object> data = Maps.newHashMap();
        data.put("objectValue", element.getObjectValue().toString());
        data.put("size", PrettyMemoryUtils.prettyByteSize(element.getSerializedSize()));
        data.put("hitCount", element.getHitCount());

        Date latestOfCreationAndUpdateTime = new Date(element.getLatestOfCreationAndUpdateTime());
        data.put("latestOfCreationAndUpdateTime", DateFormatUtils.format(latestOfCreationAndUpdateTime, dataPattern));
        Date lastAccessTime = new Date(element.getLastAccessTime());
        data.put("lastAccessTime", DateFormatUtils.format(lastAccessTime, dataPattern));
        if(element.getExpirationTime() == Long.MAX_VALUE) {
            data.put("expirationTime", "不过期");
        } else {
            Date expirationTime = new Date(element.getExpirationTime());
            data.put("expirationTime", DateFormatUtils.format(expirationTime, dataPattern));
        }

        data.put("timeToIdle", element.getTimeToIdle());
        data.put("timeToLive", element.getTimeToLive());
        data.put("version", element.getVersion());

        return new Gson().toJson(data);
    }


    /**
     * 删除单个缓存信息
     * @param cacheName
     * @param key
     * @return
     */
    @RequiresPermissions("monitor:ehcache:delete")
    @RequestMapping(value = "{cacheName}/{key}/delete")
    @ResponseBody
    public String delete(
            @PathVariable("cacheName") String cacheName,
            @PathVariable("key") String key
    ) {

        Cache cache = cacheManager.getCache(cacheName);

        cache.remove(key);

        return "操作成功！";

    }

    
    /**
     * 清空单个缓存
     * @param cacheName
     * @return
     */
    @RequiresPermissions("monitor:ehcache:clean")
    @RequestMapping(value = "{cacheName}/clear")
    @ResponseBody
    public String clear(
            @PathVariable("cacheName") String cacheName
    ) {

        Cache cache = cacheManager.getCache(cacheName);
        cache.clearStatistics();
        cache.removeAll();

        return "操作成功！";

    }

}