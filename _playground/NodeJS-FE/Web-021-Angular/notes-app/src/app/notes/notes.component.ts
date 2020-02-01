import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

interface Note {
  text: string;
}

@Component({
  selector: 'app-notes',
  templateUrl: './notes.component.html',
  styleUrls: ['./notes.component.css']
})
export class NotesComponent implements OnInit {
  private notesUrl = 'http://localhost:8080/notes'; // URL to web api
  notes: Note[] = [{ text: 'Note one' }, { text: 'Note two' }];

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.getNotes();
  }

  text: string;

  add() {
    const note = { text: this.text };
    this.notes.push(note);
    this.text = '';
  }
  remove(idx) {
    this.notes.splice(idx, 1);
  }

  getNotes() {
    let promise = new Promise((resolve, reject) => {
      this.http
        .get(this.notesUrl)
        .toPromise()
        .then(notes => {
          //this.notes = notes;
          console.log(notes);
        });
    });
    return promise;
  }
}
