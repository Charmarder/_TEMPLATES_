const express = require("express");
const router = new express.Router();

router.get("/", function (req, res) {
//    res.json({message: "This is About page"});
    res.render("pages/about");
});

module.exports = router;