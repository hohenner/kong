local helpers = require "spec.02-integration.03-dao.helpers"
local Factory = require "kong.dao.factory"
local DB = require "kong.db"

helpers.for_each_dao(function(kong_config)
  describe("Plugins DAOs with DB: #" .. kong_config.database, function()
    it("load plugins DAOs", function()
      local db = DB.new(kong_config)
      assert(db:init_connector())
      local factory = assert(Factory.new(kong_config, db))
      assert.truthy(factory.apis)
    end)

    describe("plugins migrations", function()
      local factory
      lazy_setup(function()
        local db = DB.new(kong_config)
        assert(db:init_connector())
        factory = assert(Factory.new(kong_config, db))
      end)
      it("migrations_modules()", function()
        local migrations = factory:migrations_modules()
        assert.is_table(migrations["key-auth"])
        assert.is_table(migrations["basic-auth"])
        assert.is_table(migrations["acl"])
        assert.is_table(migrations["hmac-auth"])
        assert.is_table(migrations["jwt"])
        assert.is_table(migrations["oauth2"])
        assert.is_table(migrations["rate-limiting"])
        assert.is_table(migrations["response-ratelimiting"])
      end)
    end)
  end)
end)
