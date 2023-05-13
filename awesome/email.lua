local wibox = require("wibox")
local awful = require("awful")
local watch = require("awful.widget.watch")

local email_widget = wibox.widget.textbox()
email_widget:set_font("Noto Sans Regular 15")

watch(
    [[bash -c "ls -l ~/.mail/outlook/Inbox/new | grep '^-' | wc -l"]],
    30,
    function(_, stdout)
        local unread_emails_num = tonumber(stdout) or 0
        if (unread_emails_num > 0) then
            email_widget.markup = "<b><span color='red'>Email: " .. stdout .. "</span></b>"
        elseif (unread_emails_num == 0) then
            email_widget:set_text("")
        end
    end
)

local function open_mutt()
    awful.spawn("lxterminal -e mutt")
end

email_widget:connect_signal("button::press", function() open_mutt() end)

return email_widget
