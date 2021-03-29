import { Controller } from "stimulus"
import { Grid, Page, Selection, Sort } from '@syncfusion/ej2-grids';
import { DataManager, WebApiAdaptor } from '@syncfusion/ej2-data';

export default class extends Controller {
  static targets = ["output"]

  connect() {
    this.create_table()
  }

  create_table() {
    Grid.Inject(Page, Selection, Sort);
     // RemoteData sample
    let hostUrl = 'http://localhost:3000/admins_backoffice/';
    let data = new DataManager({
      url: document.getElementById('Grid').dataset.url,
      adaptor: new WebApiAdaptor,
      crossDomain: true
    });
    let grid = new Grid({
      dataSource: data,
      allowPaging: true,
      allowSorting: true,

      columns: [
        {field: 'id', headerText: 'id', width: 130, textAlign: 'Left'},
        {field: 'email', headerText: 'Email', width: 170, textAlign: 'Left', allowSearching: true},
      ],
      pageSettings: {pageCount: 3}
    });
    grid.appendTo('#Grid');
  }

}
