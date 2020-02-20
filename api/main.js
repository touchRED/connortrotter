import express from 'express'
const app = express()

app.get('/', (req, res) => {
    res.write("Hey!")
    res.end()
})

// app.post('/', (req, res) => {
//     // Validate, sanitize and send
//     res.write("Hey!")
//     res.end()
// })

export default {
  path: '/api/contact',
  handler: app
}