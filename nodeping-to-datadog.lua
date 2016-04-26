local handle = function (dd_api_key, request)

	--- massage nodeping info into a DD event ---	
	if request.query.m == nil then
		request.query.m = "OK"
	end

	local event_text = string.format("Status change on %s: %s. Status=%s, latency=%s",
		request.query.label,
		request.query.m,
		request.query.sc,
		request.query.rt
		)
		
	if request.query.su == "true" then
		alert_type = "success"
	else 
		alert_type = "error"
	end

	-- create DD formatted event --
	local event = json.stringify({
		aggregation_key = crypto.md5(request.query.tg).hexdigest(),
		alert_type = alert_type,
		tags = {
			"nodeping",
			"check:"..request.query.label,
		},
		text = event_text,
		title = string.format("%s is %s",
			request.query.label, request.query.event),
	})

	-- send event to datadog --
	local status = http.request({
		url = "https://app.datadoghq.com/api/v1/events?api_key=" .. api_key,
		data = event,
		method = 'post',
		headers = { ["Content-type"] = "application/json" }
	}).statuscode

	if status == 202 then
		return "Event accepted"
	else
		return status, "Event was *not* created"
	end

end

return { handle = handle }

