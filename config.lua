local config = require("lapis.config")

config("development", {
  server = "cqueues",
  postgres = {
    host = "127.0.0.1",
    user = "postgres",
    password = "1234"
    database = "api_lapis_db"
  }
})
