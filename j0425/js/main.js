// 제이쿼리 선언
$(function(){   

    $("#dataOpen2").click(function(){
        $.ajax({
            url:"js/students.json",
            type:"get",
            dataType:"json",
            success: function(data){
                console.log(data[5].sname);
                alert("데이터를 가져옵니다.");
                
                let hdata =``;

                for(let i=0;i<data.length;i++){
                    hdata +=`<tr id="${data[i].sno}">`;
                    hdata +=`<td>${data[i].sno}</td>`;
                    hdata +=`<td>${data[i].sname}</td>`;
                    hdata +=`<td>${data[i].kor}</td>`;
                    hdata +=`<td>${data[i].eng}</td>`;
                    hdata +=`<td>${data[i].math}</td>`;
                    hdata += `<td>${data[i].kor+data[i].eng+data[i].math}</td>`;
                    hdata +=`<td>${((data[i].kor+data[i].eng+data[i].math)/3).toFixed(2)}</td>`;
                    hdata +=`<td>${data[i].sdate}</td>`;
                    hdata +=`<td>`;
                    hdata +=`<button type="button" class="updateBtn">수정</button>`;
                    hdata +=`<button type="button" class="deleteBtn">삭제</button>`;
                    hdata +=`</td>`;
                    hdata +=`</tr>`; 
                }
                
                $("#tbody").html(hdata);

            },//suceess

            error: function(){
                alert("실패");
            }//error

        });//ajax
    });// dataOpen2

    // 버튼 클릭
    $("#dataOpen").click(function(){
        // html 서버통신 X, 웹프로그래밍, ajax 방법
        // html 일부데이터만 화면전환없이 변경 가능
        $.ajax({
            url: "js/board.json",                      // 서버 전송하는 서버
            type:"get",                      // get= url 노출, post= url 숨겨서 전송
            data :{"bno":1,"bhit":50},   // 서버로 전송하는 데이터
            dateType:"json",             // html, xml, json, text
            success: function(data){    // 서버와 통신성공하면 data변수로 데이터를 전송
                alert("데이터를 가져옵니다.");
                console.log(data);
                console.log("1번째: ",data[0]);
                console.log("1번째: ",data[0].bno);
                console.log("총 개수: ",data.length);
                let hdata = ``;     // 초기화 선언

                for(let i=0;i<data.length;i++){
                    hdata += `<tr id="${data[i].bno}">`;
                    hdata += `<td>${data[i].bno}</td>`;
                    hdata += `<td>${data[i].title}</td>`;
                    hdata += `<td>${data[i].id}</td>`;
                    hdata += `<td>${data[i].bdate}</td>`;
                    hdata += `<td>${data[i].bhit}</td>`;
                    hdata += `<td>`;
                    hdata += `<button type="button" class="updateBtn">수정</button>`;
                    hdata += `<button type="button" class="deleteBtn">삭제</button>`;
                    hdata += `</td>`;
                    hdata += `</tr>`;
                }
                $("#tbody").html(hdata);

            },  //success
            error: function(){
                alert("실패");
            }   //error
        }); //ajax
    }); //dataOpen

    

}); //jquery