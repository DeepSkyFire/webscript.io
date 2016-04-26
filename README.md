# jswank/webscript.io

Scripts and libraries for https://www.webscript.io.

## reCAPTCHA

Validate a recaptcha.  See the [reCaptcha Developer Docs](https://developers.google.com/recaptcha/)
for setup instructions.

In HTML:
```html
<script src='https://www.google.com/recaptcha/api.js'></script>

<form action="https://site.webscript.io/script">
  <div class="g-recaptcha" data-sitekey="your-site-key"></div>
  <input type="submit" value="Submit">
</form>
```

In webscript.io:

```lua
local RECAPTCHA_KEY = 'your-secret-key'

local recaptcha = require('jswank/webscript.io/recaptcha.lua') 

if recaptcha.validate(RECAPTCHA_KEY,request) then
  return 200, 'Validated!'
else
  return 400, 'Not validated!
end
```

## nodeping-to-datadog

Use as a webhook notification for Nodeping, and forward to Datadog.

```lua
local api_key="datadog_api_key"

local bridge = require('jswank/webscript.io/nodeping-to-datadog.lua') 

bridge.handle(api_key,request)
```
