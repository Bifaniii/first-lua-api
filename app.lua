local lapis = require("lapis")
local respond_to = require("lapis.application").respond_to
local Users = require("model.users")

local app = lapis.Application()

app:match("/api/users", respond_to({
  GET = function(self)
    local users = Users:select()

    local output = {}
    for _, user in ipairs(users) do 
      table.insert(output, { id = user.id, name = user.name, email = user.email })
    end

    return { json = output }
  end,

  POST = function(self)
    local params = self.params

    if not params.name or not params.email then
      return { json = { error = "Campos obrigatórios ausentes" }, status = 400 }
    end

    local new_user = Users:create({
      name = params.name,
      email = params.email
    })

    return { json = { message = "Usuário criado!", id = new_user.id }, status = 201 }
  end
}))

app:match("/api/users/:id", respond_to({
  GET = function(self)
    local user = Users:find(self.params.id)

    if not user then
      return { json = { error = "Usuário não encontrado"}, status = 404 }
    end

    return { json = { id = user.id, name = user.name, email = user.email } }
  end
}))

return app
