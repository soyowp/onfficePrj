package org.office.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.mysql.cj.x.protobuf.MysqlxDatatypes.Array;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class CrawlingServiceImpl implements CrawlingService {

	@Override
	public HashMap<String, Object> crawling() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Document doc = null;
		Document doc2 = null;
		try {
			doc = Jsoup.connect("https://weather.naver.com/today")
					.userAgent("Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.82 Safari/537.36")
					.timeout(1000)
                    .get();
			
			doc2 = Jsoup.connect("https://news.naver.com/")
					.userAgent("Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.82 Safari/537.36")
					.timeout(1000)
                    .get();
			
		}catch(IOException e) {
		e.printStackTrace();
		}
		String temp = doc.select(".current").text();
		String weather = doc.select(".weather").text();
		String dust = doc.select(".today_chart_list").text();
		
		List<String> hL = doc2.select(".hdline_article_tit").eachText();
		List<Object> headLine = new ArrayList<Object>();
		log.info(hL);
		log.info(hL.size());
		
		map.put("temp", temp.toString());
		map.put("weather", weather.toString());
		map.put("dust", dust.toString());
		map.put("headLine", hL);
		
		return map;
	
	}

}
