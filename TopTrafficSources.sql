-- Top Traffic Sources-- 
-- Which add campaigns leading to customers visiting the website--
USE mavenfuzzyfactory;
SELECT 
	website_sessions.utm_source ,
    website_sessions.utm_campaign,
    website_sessions.http_referer,
    COUNT( DISTINCT( website_sessions.website_session_id)) AS sessions
FROM website_sessions
WHERE website_sessions.created_at<'2012-04-12'
GROUP BY utm_source,
		utm_campaign,
        http_referer
ORDER BY sessions DESC