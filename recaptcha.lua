local validate = function (privatekey, request)

	local response = http.request({
		url='https://www.google.com/recaptcha/api/siteverify',
		method='post',
		data={
			secret = privatekey,
			remoteip = request.remote_addr,
			response = request.form["g-recaptcha-response"]
		}})

	return response.statuscode == 200 and
		json.parse(response.content).success

end

return { validate = validate } 
