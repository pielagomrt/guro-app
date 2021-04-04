import generateShortId from '../helpers/generateShortId'
import mountStudentRow from '../helpers/mountStudentRow'

const addStudentBtn = document.querySelector('#add-student-btn')

addStudentBtn.addEventListener('click', () => {
  const studentRows = [...document.querySelectorAll('.student-row')]
  const lastRow = studentRows[studentRows.length - 1]
  mountStudentRow(generateShortId(), lastRow)
})