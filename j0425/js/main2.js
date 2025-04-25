// jquery 선언
$(function(){
    $("#dataOpen3").click(function(){
        alert("확인");
        
        $.ajax({
            url:"https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList1?serviceKey=bFRK9ZqnlUcL84dUtWGKOmdZnXef3GjD0E%2Fj%2BBUl6YM4BHktIhTmnpHvI6RjRvy9Ew25Nb0SDVMGQOldDDgQiA%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&_type=json",
            type:"get",
            dataType:"json",
            success: function(data){
                alert("성공");
                console.log(data.response.body.items.item);
                console.log(data.response.body.items.item[0].galWebImageUrl);
                data = data.response.body.items.item;

                let imgData = data.response.body.items.item[0].galWebImageUrl;
                let hdata = `<img id="img" src="${imgData}">`;
                $("#txt").html(hdata);
                

                /* 
                let hdata = ``;
                let data = data.response.body.items.item;
                for(let i=0;i<data.length;i++){
                    hdata += `<tr id="${data[i]}">`;
                    hdata += `<td>${data[i].galContentTypeId}</td>`;
                    hdata += `<td>${data[i].galCreatedtime}</td>`;
                    hdata += `<td>${data[i].galPhotographer}</td>`;
                    hdata += `<td>${data[i].galPhotographyLocation}</td>`;
                    hdata += `<td>${data[i].galSearchKeyword}</td>`;
                    hdata += `<td>${data[i].galTitle}</td>`;
                    hdata += `<td>${data[i].galWebImageUrl}</td>`;
                    hdata += `<td>`;
                    hdata += `<button type="button" class="updateBtn">수정</button>`;
                    hdata += `<button type="button" class="deleteBtn">삭제</button>`;
                    hdata += `</td>`;
                    hdata += `</tr>`;

                }   
                $("#tbody").html(hdata);
*/
            }, 
            error: function(){
                alert("실패");
            }
        }); 
    });
});