var express = require('express');
var path = require('path');
var logger = require('morgan');
var bodyParser = require('body-parser');

var routes = require('./routes/index');
var upload = require('./routes/upload');
var authentication = require('./routes/authentication');
var padesSignature = require('./routes/pades-signature');
var cadesSignature = require('./routes/cades-signature');
var fullXmlSignature = require('./routes/xml-full-signature');
var xmlElementSignature = require('./routes/xml-element-signature');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/upload', upload);
app.use('/authentication', authentication);
app.use('/pades-signature', padesSignature);
app.use('/cades-signature', cadesSignature);
app.use('/xml-full-signature', fullXmlSignature);
app.use('/xml-element-signature', xmlElementSignature);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;
