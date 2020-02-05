import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

interface Note {
  _id?: string;
  text: string;
}

@Component({
  selector: 'app-notes',
  templateUrl: './notes.component.html',
  styleUrls: ['./notes.component.css']
})
export class NotesComponent implements OnInit {
  private notesUrl = 'notes'; // URL to web api
  notes: Note[] = [];

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.readNotes();
  }
  readNotes() {
    this.getNotes().then(notes => {
      this.notes = notes;
      console.log(notes);
    });
  }

  add(text: string) {
    text = text.trim();
    if (!text) {
      return;
    }
    const note = { text };
    this.addNote(note).then(() => this.readNotes());
  }

  remove(id: string) {
    this.removeNote(id).then(response => {
      if (response.ok) {
        console.log(`note with id ${id} removed, response`, response);
        this.readNotes();
      } else {
        console.error(`server-side error when removing
          note with id ${id}`);
      }
    });
  }

  //   delete(idx) {
  //   this.deleteNote(idx);
  //   this.notes.splice(idx, 1);
  // }

  //////// API methods //////////
  getNotes(): Promise<Note[]> {
    return this.http
      .get<Note[]>(this.notesUrl)
      .toPromise()
      .catch(err => this.handleError(err));
  }

  addNote(note: Note): Promise<void> {
    return this.http
      .post(this.notesUrl, note)
      .toPromise()
      .then(() => console.log('note sent to add'))
      .catch(err => this.handleError(err));
  }

  removeNote(id: string): Promise<{ ok: boolean }> {
    return this.http
      .delete<{ ok: boolean }>(this.notesUrl, { params: { id } })
      .toPromise()
      .catch(err => this.handleError(err));
  }

  // deleteNote(idx: number): Promise<void> {
  //     return this.http
  //       .delete(`${this.notesUrl}/${idx}`)
  //       .toPromise()
  //       .then(response => console.log('note sent to delete', response));
  //   }

  private handleError(err) {
    console.error(err);
    return err;
  }
}
