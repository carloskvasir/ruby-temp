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
      url: hostUrl + 'admins.json',
      updateUrl: "/Home/Update",
      insertUrl: "/Home/Insert",
      adaptor: new WebApiAdaptor,
      crossDomain: true
    });
    let grid = new Grid({
      dataSource: data,
      allowPaging: true,
      allowSorting: true,
      toolbar: ['Add', 'Edit', 'Delete', 'Update', 'Cancel'],
      editSettings: { allowEditing: true, allowAdding: true, allowDeleting: true, mode: 'Normal' },
      columns: [
        {field: 'id', headerText: 'id', width: 130, textAlign: 'Left', isPrimaryKey: true,},
        {field: 'email', headerText: 'Email', width: 170, textAlign: 'Left'},
        // { field: 'EmployeeID', headerText: 'Employee ID', width: 135, textAlign: 'Right' },
        // { field: 'Freight', headerText: 'Freight', width: 160, textAlign: 'Right', format: 'C2' },
        // { field: 'ShipCountry', headerText: 'Ship Country', width: 150, textAlign: 'Center' },
      ],
      pageSettings: {pageCount: 3}
    });
    grid.appendTo('#Grid');
  }

}
