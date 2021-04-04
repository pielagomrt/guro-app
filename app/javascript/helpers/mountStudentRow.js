export default function mountStudentRow(id, lastRow) {

  // create HTML element
  const container = document.createElement('DIV')
  container.className = "form-group row student-row animated--fade-in"
  container.id = id

  container.innerHTML = `
    <div class="col-sm-3">
      <input class="form-control" required="required" autocomplete="off" placeholder="First Name" type="text" name="section_students[${id}[first_name]]" id="section_students[${id}[first_name]]">
    </div>
    <div class="col-sm-3">
      <input class="form-control" required="required" autocomplete="off" placeholder="Last Name" type="text" name="section_students[${id}[last_name]]" id="section_students[${id}[last_name]]">
    </div>
    <div class="col-sm-5">
      <input class="form-control" required="required" autocomplete="off" placeholder="Email" type="email" name="section_students[${id}[email]]" id="section_students[${id}[email]]">
    </div>
    <div class="col-sm-1 d-flex align-items-center">
      <button name="button" type="button" class="btn btn-danger btn-circle btn-sm" data-id="${id}">
        <i class="fas fa-minus"></i>
      </button>    
    </div>
  `


  // mount to DOM
  const studentHeader = document.querySelector('.student-row-header')

  if (lastRow) lastRow.after(container)
  if (!lastRow) studentHeader.after(container)



  // mount event listener for removing a row
  const remove_button = document.querySelector(`button[data-id='${id}']`)
  const studentRow = document.getElementById(`${id}`)

  remove_button.addEventListener('click', () => studentRow.remove())
}
