package com.pcwk.ehr.station.api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "elecmusk", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
public class StationApiController {

	final Logger LOG = LogManager.getLogger(getClass());

	@GetMapping(value = "/stationapi.do")
	public String StationDataCall() {

		StringBuffer result = new StringBuffer();
		try {
			StringBuilder sb = new StringBuilder("https://api.odcloud.kr/api/EvInfoServiceV2/v1/getEvSearchList");
			sb.append("?" + URLEncoder.encode("page", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
			sb.append("&" + URLEncoder.encode("perPage", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8"));
			sb.append("&" + URLEncoder.encode("serviceKey", "UTF-8")
					+ "=m8mhLoQ0Q98g4kewmJc%2B3l2PboIiGXBoq8WLOkx1QNqRJzBDzbH2rCRhsBNwTFjbI77pAcduxM3M9%2FwrB%2BKS6Q%3D%3D");
			sb.append("&application/json;charset=UTF-8");
			URL url = new URL(sb.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			String line;
			while ((line = rd.readLine()) != null) {
				result.append(line + "\n");
			}
			//LOG.debug("result:" + result);



		} catch (Exception e) {
			e.printStackTrace();
		}

		return result + "";

	}

}