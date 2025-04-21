// 다음주소 함수
function zipCodeBtn(){
    // 다음주소 api 호출
    // alert("다음주소 api 호출");
    new daum.Postcode({
        oncomplete: function(data) {
            document.querySelector("#postZip").value = data.zonecode;
            document.querySelector("#addr1").value = data.address;
            document.querySelector("#addr2").focus();
        }
    }).open();
}

//------------------------------------------------------------------------------

// 비밀번호 확인 함수
// input 인 경우 .value 형태로 값을 넣고 그외 모든 것은 .innerText로 값은 넣는다.
// class/ id -> ./ # // document.querySelector("#pw")
function pwConfirm(){
    //alert("비밀번호확인");
    let pw = document.querySelector("#pw").value;
    let pw2 = document.querySelector("#pw2").value;


    if(pw == pw2){
        document.querySelector("#pwCheck").style.color= "blue";
        document.querySelector("#pwCheck").innerText="비밀번호가 일치합니다.";
    }    
    else{
        document.querySelector("#pwCheck").style.color= "red";
        document.querySelector("#pwCheck").innerText="비밀번호가 일치하지않습니다.";
    }    

    if(pw2==""){
        document.querySelector("#pwCheck").style.color= "#555";
        document.querySelector("#pwCheck").innerText="비밀번호를 다시 한번 입력해주세요.";
    }
}


function emailChange(){
    //alert("이메일을 변경했습니다.");
    let email_sel = document.querySelector("#email-sel").value;
    console.log(email_sel);

    document.querySelector("#email2").value = email_sel;
}