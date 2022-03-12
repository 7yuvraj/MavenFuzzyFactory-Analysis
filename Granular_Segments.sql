SELECT 
		MIN(DATE(created_at)) AS week_Start_date,
		COUNT(DISTINCT CASE WHEN device_type='desktop' then website_session_id ELSE NULL END) AS desktop_sessions,
        COUNT(DISTINCT CASE WHEN device_type='mobile' then website_session_id ELSE NULL END ) AS mobile_sessions
        
FROM website_sessions
WHERE website_sessions.created_at<'2012-06-09' AND
	 website_sessions.created_at>'2012-04-15' AND
     utm_source='gsearch'AND
     utm_campaign='nonbrand'
GROUP BY 
		WEEK(created_at)
     
		