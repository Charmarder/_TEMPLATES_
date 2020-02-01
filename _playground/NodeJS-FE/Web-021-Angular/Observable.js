import { Observable } from 'rxjs';
//var rxjs = require('rxjs');
//const { Observable } = rxjs;

// However, an Observable can be synchronous.
const greetingLady$ = new Observable(observer => {
  observer.next('Hello! I am glad to get to know you.');
  observer.complete();
});
console.log('Before calling subscribe on Observable');
greetingLady$.subscribe({
  next: console.log,
  complete: () => console.log('End of conversation with preety lady')
});
console.log(
  'After calling subscribe on Observable (proof of being able to execute sync)'
);

// On the other hand, an Observable can also be asynchronous.
const tiredGreetingLady$ = new Observable(observer => {
  setTimeout(() => {
    observer.next('Hello! I am glad to get to know you.');
    observer.complete();
  }, 2000);
});
console.log('Before calling subscribe on Observable');
tiredGreetingLady$.subscribe({
  next: console.log,
  complete: () => console.log('End of conversation with tired preety lady')
});
console.log(
  'After calling subscribe on Observable (proof of being able to execute async)'
);

// Observable can emit multiple values
const notifications$ = new Observable(observer => {
  const interval = setInterval(() => {
    observer.next('New notification');
  }, 2000);
  return () => clearInterval(interval);
});
const subscription = notifications$.subscribe(console.log);
setTimeout(() => subscription.unsubscribe(), 8000);
