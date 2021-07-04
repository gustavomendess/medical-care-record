document.addEventListener('keydown', function(event) {
    if(event.keyCode != 46 && event.keyCode != 8){
      var i = document.getElementById("patient_cpf").value.length;
      if (i === 3 || i === 7)
        document.getElementById("patient_cpf").value = document.getElementById("patient_cpf").value + ".";
      else if (i === 11)
        document.getElementById("patient_cpf").value = document.getElementById("patient_cpf").value + "-";
    }
});