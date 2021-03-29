import { Controller } from "stimulus"
import { Grid, Page, Selection } from '@syncfusion/ej2-grids';
import { DataManager, WebApiAdaptor } from '@syncfusion/ej2-data';

export default class extends Controller {
  static targets = ["output"]

  connect() {
    this.create_table()
  }

  create_table() {
    Grid.Inject(Page, Selection);
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

      editSettings: { allowEditing: true, allowAdding: true, allowDeleting: true, mode: 'Normal' },
      columns: [
        {field: 'id', headerText: 'id', width: 130, textAlign: 'Left', isPrimaryKey: true,},
        {field: 'email', headerText: 'Email', width: 170, textAlign: 'Left', allowSearching: true},
      ],
      pageSettings: {pageCount: 3}
    });
    grid.appendTo('#Grid');
  }

}
