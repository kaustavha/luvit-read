local readers = require('./main.lua')
local path = require('path')
local fs = require('fs')
local Transform = require('stream').Transform

local Reader = Transform:extend()
function Reader:initialize()
  Transform.initialize(self, {objectMode = true})
end  
function Reader:_transform(line, cb)
  self:push(line)
  cb()
end
local txt = [[Line1
#commentline

Line2]]
local tmp_file = './test_read.txt'

require('tap')(function(test)
  test('Test for readStreamClean', function(expect)
    local readStreamClean = readers.readStreamClean
    fs.writeFileSync(tmp_file, txt)
    local readData = {}
    local function onEnd()
      local expected = 'Line1Line2'
      local readString = table.concat(readData)
      assert(expected == readString)
      fs.unlinkSync(tmp_file)
    end

    local readStream = readStreamClean(tmp_file)
    local reader = Reader:new()
    reader:once('end', onEnd)
    reader:on('data', function(data)
      table.insert(readData, data)
    end)
    readStream:pipe(reader)
  end)

  test('Test for readStream', function(expect) 
    local rs = readers.readStream
    fs.writeFileSync(tmp_file, txt)
    local readData = {}
    local function onEnd()
      local expected = 'Line1#commentlineLine2'
      local readString = table.concat(readData)
      assert(expected == readString)
      fs.unlinkSync(tmp_file)
    end

    local readStream = rs(tmp_file)
    local reader = Reader:new()
    reader:once('end', onEnd)
    reader:on('data', function(data)
      table.insert(readData, data)
    end)
    readStream:pipe(reader)
  end)

  test('Test for readStream with extra ending newline', function(expect) 
    local rs = readers.readStream
    fs.writeFileSync(tmp_file, txt..'\n')
    local readData = {}
    local function onEnd()
      local expected = 'Line1#commentlineLine2'
      local readString = table.concat(readData)
      assert(expected == readString)
      fs.unlinkSync(tmp_file)
    end

    local readStream = rs(tmp_file)
    local reader = Reader:new()
    reader:once('end', onEnd)
    reader:on('data', function(data)
      table.insert(readData, data)
    end)
    readStream:pipe(reader)
  end)

  test('Test for read', function(expect)
    local read = readers.read
    fs.writeFileSync(tmp_file, txt)
    local function onEnd(err, data)
      local expected = 'Line1#commentlineLine2'
      local readString = table.concat(data)
      assert(expected == readString)
      fs.unlinkSync(tmp_file)
    end
    read(tmp_file, onEnd)
  end)

  test('Test for readClean', function(expect)
    local read = readers.readClean
    fs.writeFileSync(tmp_file, txt)
    local function onEnd(err, data)
      local expected = 'Line1Line2'
      local readString = table.concat(data)
      assert(expected == readString)
      fs.unlinkSync(tmp_file)
    end
    read(tmp_file, onEnd)
  end)
end)
