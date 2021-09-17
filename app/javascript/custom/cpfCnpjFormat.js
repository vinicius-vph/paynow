function formatCpfCnpj(inputField,callback) {
  input = inputField;
  functionCallback = callback;
  setTimeout(inputFieldMask(), 4);
}

function inputFieldMask() {
  input.value = functionCallback(input.value);
}

function cpfCnpj(inputChange) {
  inputChange = inputChange.replace(/\D/g,"");
  
  if (inputChange.length <= 11) { //CPF
      
      inputChange=inputChange.replace(/(\d{3})(\d)/,"$1.$2");
      
      inputChange=inputChange.replace(/(\d{3})(\d)/,"$1.$2");
      
      inputChange=inputChange.replace(/(\d{3})(\d{1,2})$/,"$1-$2");
      
  } else { //CNPJ
      
      inputChange=inputChange.replace(/^(\d{2})(\d)/,"$1.$2");
      
      inputChange=inputChange.replace(/^(\d{2})\.(\d{3})(\d)/,"$1.$2.$3");
      
      inputChange=inputChange.replace(/\.(\d{3})(\d)/,".$1/$2");
      
      inputChange=inputChange.replace(/(\d{4})(\d)/,"$1-$2");
  }
  
  return inputChange;
}

window.onclick = () => {
  const inputs = document.querySelectorAll(
    "input.cpfcnpj"
  );
  inputs.forEach((inputField) => {
    inputField.addEventListener("keypress", () => {
      formatCpfCnpj(inputField, cpfCnpj)
    });
  });
}