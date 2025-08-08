if SERVER then
    local function CreateDataBase()
        sql.Query('CREATE TABLE IF NOT EXISTS kuyash_money (steam_id INTEGER UNIQUE, money INTEGER)')
    end
    CreateDataBase()
    print('Database status: ' .. tostring(sql.TableExists('kuyash_money')))
end