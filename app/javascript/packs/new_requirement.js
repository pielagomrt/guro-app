const number_inputs = document.querySelectorAll("input[type='number']")

number_inputs.forEach(input => input.addEventListener('keypress', function (event) {

  const { key } = event;
  const numInput = parseInt(key)
  const isNotANumber = Number.isNaN(numInput)
  if (isNotANumber) return event.returnValue = false

}))