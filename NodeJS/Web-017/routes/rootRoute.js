const express = require("express");
const rootRouter = new express.Router();

rootRouter.get("/", function (req, res) {
    res.json({message: "Root route"});
});

rootRouter.get("/users", function (req, res) {
    res.json({users: ["Alise", "Tom", "Bob"]});
});

module.exports = rootRouter;