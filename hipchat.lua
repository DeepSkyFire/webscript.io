local send function(room,token,message,color)

  local response = http.request({
      method='POST',
      url='https://api.hipchat.com/v2/room/'..room..'/notification?auth_token='..token..'',
      headers={
          ['Content-Type']='application/json'
      },
      data=json.stringify {
        color=color
        message=message,
        message_format='text'           
      }
    })

    return response.statuscode == 200 and
      json.parse(response.content).success

end

return { send = send } 
