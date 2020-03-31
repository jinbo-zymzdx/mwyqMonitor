package com.mwyq.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.mwyq.model.weiBo;
import com.mwyq.service.EntityService;
import com.mwyq.service.NewsService;
import com.mwyq.util.CommonUtils;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("weibo")
public class weiboController {
	@Autowired
	private NewsService newsService;

	@Autowired
	private EntityService entityService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpSession session) {
		ModelAndView view = new ModelAndView("weibo");
		String lang = (String) session.getAttribute("lang");
		lang = lang == null ? "cn" : lang;
		session.setAttribute("lang", lang);
		String emotion = (String) session.getAttribute("emotion");
		emotion = emotion == null ? "0" : emotion;
		List<weiBo> weiBoList = new ArrayList<weiBo>();
		if (emotion.equals("0")) {
			weiBoList = newsService.getWeiBo(lang);
		} else {
			weiBoList = newsService.getWeiBoByEmotion(lang, emotion);
		}
		String color = null;
		for (weiBo weiBo : weiBoList) {
			emotion = weiBo.getEmotion();
			color = CommonUtils.WeiBo_Emotion_Color.get(emotion);
			weiBo.setEmotion("<span style=\"color:" + color + "\">" + emotion + "</span>");
		}
		String username = (String) session.getAttribute("username");
		String passwd = (String) session.getAttribute("passwd");
		String guanzhu = newsService.getGuanzhu(username, passwd).replace("*", " ");
		List<weiBo> tuisongWeibo = newsService.getTuisong(guanzhu);
		if (StringUtils.isNotBlank(guanzhu)) {
			String names[] = guanzhu.split(" ");
			guanzhu = "";
			for (int i = 0; i < names.length; i++) {
				guanzhu = guanzhu + "<a href=\"author/" + names[i] + "\"" + " target=\"_blank\">"
						+ " <span style=\"font-size:15px;color:blue;padding-left:5px;\">" + names[i] + "</span></a>";
			}
		}
		if (emotion.equals("0")) {
			view.addObject("emotion", "全部");
		} else {
			view.addObject("emotion", emotion);
		}
		view.addObject("guanzhu", guanzhu);
		view.addObject("weibo", weiBoList);
		view.addObject("tuisong", tuisongWeibo);
		return view;
	}

	@RequestMapping(value = "/emotion/{emotion}", method = RequestMethod.GET)
	public ModelAndView getWeiboByEmotion(HttpServletRequest request, HttpSession session,
			@PathVariable("emotion") String emotion) {
		ModelAndView view = new ModelAndView("redirect:/weibo/");
		session.setAttribute("emotion", emotion);
		return view;
	}

	@RequestMapping(value = "/weiboSwitchLang", method = RequestMethod.POST)
	public ModelAndView chooseLang(HttpServletRequest request, HttpSession session) {
		String lang = request.getParameter("langtype");
		session.setAttribute("lang", lang);
		ModelAndView view = new ModelAndView("redirect:/weibo/");
		String sessionLang = (String) session.getAttribute("lang");
		if (!StringUtils.isEmpty(sessionLang) && sessionLang.equals("meng")) {
			ModelAndView view1 = new ModelAndView("redirect:/topic/");
			return view1;
		}
		return view;
	}

	@RequestMapping(value = "/getWeiBoTendency", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getWeiBoTendency(HttpServletRequest request, HttpSession session) {
		System.out.println("寰崥鐢熸晥");
		String lang = session.getAttribute("lang").toString();
		String result = entityService.getWeiBoTendency(lang);
		return result;
	}

	@RequestMapping(value = "/getWeiFensi", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getWeiFensi(HttpServletRequest request, HttpSession session) {
		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "meng");
			lang = "cn";
		}
		JSONObject json = newsService.getWeiboFens(lang.toString());
		return json.toString();
	}

	@RequestMapping(value = "/guanzhu", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public void guanzhu(HttpServletRequest request, HttpSession session) {

		String username = (String) session.getAttribute("username");
		String passwd = (String) session.getAttribute("passwd");

		Object follow = request.getParameter("follow");
		Object bozhu = request.getParameter("bozhu");

		if (follow.toString().equals("yes")) {
			newsService.upYesFollow(username, passwd, bozhu.toString());
		} else {
			newsService.upNoFollow(username, passwd, bozhu.toString());
		}

	}

	@RequestMapping(value = "/author/{authorName}", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public ModelAndView getWeiAuthor(HttpServletRequest request, @PathVariable("authorName") String authorName,
			HttpSession session) {
		ModelAndView view = new ModelAndView("redirect:/weibo/weiboAuthor");
		session.setAttribute("authorName", authorName);
		return view;
	}
	
	@RequestMapping(value = "/weiboAuthor", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public ModelAndView weiboAuthor(HttpServletRequest request,HttpSession session) {
		ModelAndView view = new ModelAndView("weiboAuthor");
		String authorName = (String) session.getAttribute("authorName");
		List<weiBo> weiboList = newsService.getAuthorWeibo(authorName);
		view.addObject("name", authorName);
		view.addObject("weibo", weiboList);
		return view;
	}
}
