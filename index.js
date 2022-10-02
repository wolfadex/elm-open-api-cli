const fs = require('fs')
const path = require('path')

const { Elm } = require('./build/main')

process.stdin.resume()

const app = Elm.Main.init()

app.ports.writeMsg.subscribe(function (msg) {
  console.log(msg)

  if (msg === 'Success!!!!') {
    process.exit(0)
  }
})

app.ports.writeFile.subscribe(function ([filePath, data]) {
  fs.writeFile(
    path.join(__dirname, 'generated', filePath),
    data,
    { encoding: 'utf-8' },
    function (err) {
      if (err) {
        console.log('File write error:', err)
        process.exit(1)
      }
    },
  )
})

const [, , inputPath] = process.argv

fs.readFile(path.join(__dirname, inputPath), { encoding: 'utf-8' }, function (
  err,
  data,
) {
  if (err) {
    console.log(err)
    rl.close()
    process.exit(1)
  } else {
    try {
      app.ports.gotSpec.send(JSON.parse(data))
    } catch (error) {
      console.log(error)
      rl.close()
      process.exit(1)
    }
  }
})
