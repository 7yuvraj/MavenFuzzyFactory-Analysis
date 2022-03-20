-- Finding website_pageview_id for relevant sessions
-- Identifying the landing page of each session
-- counting page views for bounce 
-- summarizing
USE mavenfuzzyfactory;

CREATE TEMPORARY TABLE first_pageviews
SELECT 
		website_session_id,
        MIN(website_pageview_id) AS min_pageview_id
		
FROM website_pageviews
WHERE created_at <'2012-06-14'
GROUP BY 
	website_session_id;
    
CREATE TEMPORARY TABLE sessions_w_home_landing_page
SELECT 
	first_pageviews.website_session_id,
    website_pageviews.pageview_url as landing_page
FROM first_pageviews
	LEFT JOIN website_pageviews
		ON website_pageviews.website_pageview_id= first_pageviews.min_pageview_id 
 WHERE website_pageviews.pageview_url ='/home';
 
 CREATE TEMPORARY TABLE bounced_sessions
 SELECT 
	sessions_w_home_landing_page.website_session_id,
    sessions_w_home_landing_page.landing_page,
    COUNT(DISTINCT website_pageviews.website_pageview_id) as count_of_pages_viewed
     
 FROM sessions_w_home_landing_page
		LEFT JOIN website_pageviews
        ON website_pageviews.website_session_id= sessions_w_home_landing_page.website_session_id

GROUP BY 
	sessions_w_home_landing_page.website_session_id,
	sessions_w_home_landing_page.landing_page
HAVING  count_of_pages_viewed =1;
 
 
 SELECT 
	COUNT(DISTINCT sessions_w_home_landing_page.website_session_id ) AS total_sessions,
    COUNT(DISTINCT bounced_sessions.website_session_id) AS bounced_sessions,
    COUNT(DISTINCT bounced_sessions.website_session_id)/ COUNT(DISTINCT sessions_w_home_landing_page.website_session_id ) AS bounce_rate

FROM sessions_w_home_landing_page
		LEFT JOIN bounced_sessions
			ON sessions_w_home_landing_page.website_session_id= bounced_sessions.website_session_id;
    
    
 

 
 
