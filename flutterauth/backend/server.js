const express = require('express')
const mongoose = require('mongoose')
const bodyparser = require('body-parser')
const fileUpload = require('express-fileupload')
const user = require("./auth/signin");
const User = require("./model/user");
const cors = require('cors');


const app = express()
app.use(express.json())
app.use(cors());


mongoose.connect("mongodb+srv://Gauravd:gauravd@cluster0.hbhwc24.mongodb.net/", {
  useNewurlParser: true,
  useUnifiedtopology: true
}).then(() => {
  console.log("Connected With MongoDB");
}).catch((err) => {
  console.log(`error is ${err}`);
})


const profileSchema = new mongoose.Schema({
    username: String,
    email: String,
  
  });
  const Profile = mongoose.model('studentlogins', profileSchema);
  
  

app.use("/user", user);


app.listen(3000, () => {
  console.log(`server on port 3000`)
})