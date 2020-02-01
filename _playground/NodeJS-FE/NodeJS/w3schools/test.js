const extend = (...args) => {
    return args.reduce((memo, obj) => {
      return Object.assign(memo, obj)
    }, {})
  }
  
  console.log(extend({a:1}, {a:2, b:2}, {c: 3, b: 1}))