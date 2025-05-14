
document.addEventListener('DOMContentLoaded',function(){
  const form = document.querySelector('#form');

});

function pageDoRetrieve(url, pageNo){
  form.pageNo.value = pageNo;
  form.action = url;
  form.submit();
}

