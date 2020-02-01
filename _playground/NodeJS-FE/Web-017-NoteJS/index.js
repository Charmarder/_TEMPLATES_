const express = require('express');
const rootRouter = require("./routes/rootRoute.js");
const aboutRouter = require("./routes/aboutRoute.js");
const fs = require("fs");
const path = require("path");

const port = 3000;
const app = express();

app.set("view engine", "pug");
app.set("views", path.join(__dirname, "templates"));
app.use(express.static("static"));

app.use(function (req, res, next) {
    console.log(req.url);
    next();
});

app.use("/home", rootRouter);
app.use("/about", aboutRouter);

app.get('/', (req, res) => {
    //res.json({message: 'Hello World!'});
    fs.readFile("package.json", (err, data) => {
        let json = data.toString();
        let packageMeta = JSON.parse(json);
        let result = {
            name: packageMeta.name,
            version: packageMeta.version,
            author: packageMeta.author,
            scripts: packageMeta.scripts
        }
//        res.json(result);
        res.render("index", result);
    })
})

app.get("/files", (req, res) => {
    fs.readdir("./", (err, files) => {
        console.log(files);
        res.json({files: files});
    })
})

app.get("*", function (req, res) {
    console.log("No such route");
    res.status(404).send("No such route");
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`))