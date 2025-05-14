function pageDoRetrieve(url, pageNo){
  console.log("doRetrieveButton click!");

  form.pageNo.value =pageNo;
  form.action = url;

  form.submit();
}