const express = require('express');
const path = require('path');
// const session = require('express-session');
const bodyParser = require('body-parser');
const MongoClient = require('mongodb').MongoClient;
const assert = require('assert');

const port = 8080;
const app = express();

app.use(express.static(path.join(__dirname, '../dist/notes-app')));

app.use(require('cors')()); // allow Cross-domain requests

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// app.use(
//   session({
//     secret: 'angular_tutorial',
//     resave: true,
//     saveUninitialized: true
//   })
// );

// app.get('/notes', function(req, res) {
//   console.log('reading notes', req.session.notes);

//   // res.header('Access-Control-Allow-Origin', '*');
//   // res.header('Access-Control-Allow-Headers', 'Content-Type, X-Requested-With');

//   if (!req.session.notes) {
//     req.session.notes = [
//       { text: 'First note' },
//       { text: 'Second note' },
//       { text: 'Third note' }
//     ];
//   }
//   res.send(req.session.notes);
// });

// app.post('/notes', function(req, res) {
//   var note = req.body;
//   req.session.notes.push(note);
//   console.log('adding note...', req.session.notes);
//   res.end();
// });

// app.delete('/notes/:id', function(req, res) {
//   let id = req.params.id;
//   req.session.notes.splice(id, 1);
//   console.log('deleting note', id, 'after delete', req.session.notes);
//   res.end();
// });

// open MongoDB@2.2.x connection
// const Db = require('mongodb').Db;
// const Server = require('mongodb').Server;
// open MongoDB connection
// var db = new Db(
//   'tutor',
//   new Server('localhost', 27017, { safe: true }, { auto_reconnect: true }, {})
// );

// db.open(function(err) {
//   if (err) console.log(err);
//   else console.log('mongo db is opened!');
//   db.collection('notes', function(error, notes) {
//     db.notes = notes;
//   });
// });

// open MongoDB@3.5.x connection
const dbName = 'tutor';
const url = 'mongodb://localhost:27017/';
let db;
MongoClient.connect(url, (err, client) => {
  assert.equal(null, err);
  console.log('Connected successfully to server');
  db = client.db(dbName);
  db.notes = db.collection('notes');
  db.todos = db.collection('todos');
  // client.close();
});

/*** Notes API ***/
app.get('/notes', (req, res) => {
  // res.header('Access-Control-Allow-Origin', '*');
  // res.header('Access-Control-Allow-Headers', 'Content-Type, X-Requested-With');

  db.notes.find(req.query).toArray(function(err, items) {
    if (err) res.sendStatus(500);
    else res.send(items);
  });
});

app.post('/notes', function(req, res) {
  db.notes.insert(req.body).then(function() {
    res.end();
  });
});

const ObjectID = require('mongodb').ObjectID;
app.delete('/notes', function(req, res) {
  var id = new ObjectID(req.query.id);
  db.notes.remove({ _id: id }, function(err) {
    if (err) {
      console.error(err);
      res.send({ ok: false });
    } else {
      res.send({ ok: true });
    }
  });
});

/*** Todos API ***/
app.get('/todos', (req, res) => {
  db.todos.find(req.query).toArray(function(err, items) {
    if (err) res.sendStatus(500);
    else
      res.send(
        items.map(i => {
          i.id = i._id;
          delete i._id;
          return i;
        })
      );
  });
});

app.post('/todos', function(req, res) {
  db.todos.insertOne(req.body, function(err, r) {
    if (err) throw err;
    let o = r.ops[0];
    o.id = o._id;
    delete o._id;
    console.log('Object inserted', o);
    res.send(o);
  });
});

app.delete('/todos/:id', function(req, res) {
  var id = new ObjectID(req.params.id);
  db.todos.remove({ _id: id }, function(err) {
    if (err) {
      console.error(err);
      res.send({ ok: false });
    } else {
      res.send({ ok: true });
    }
  });
});

const listener = app.listen(port, () => {
  console.log(
    'Your app is listening on http://localhost:' + listener.address().port
  );
});
