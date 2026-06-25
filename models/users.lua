local Model = require("lapis.db.model").Model

local Users = Model:extend("users", {
    get_active_users = function(self)
        return self:select("where active = true")
    end
})

return Users