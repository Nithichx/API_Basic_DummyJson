*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Library     String

*** Variables ***

${URL}        https://dummyjson.com/



*** Test Cases ***

TA01_Get_Smartphone
    Create Session        Get_Smartphone      ${URL}              verify=True
    ${response}           GET On Session    Get_Smartphone        /products/category/smartPhone
    Log    ${response.status_code}
    Log    ${response.headers}
    Log    ${response.content}

    ${return_code}    Convert To String    ${response.status_code} 
    Should Be Equal As Integers        ${response.status_code}        200

TA02_POST_Product
    [Documentation]    
    [Tags]
    Create Session        Post_Product         ${URL}             verify=True
    ${header}     Create Dictionary      Content-type=application/json; charset=UTF-8
    ${images_list}    Create List 
    ...        https://i.dummyjson.com/data/products/1/1.jpg
    ...        https://i.dummyjson.com/data/products/1/2.jpg
    ...        https://i.dummyjson.com/data/products/1/3.jpg
    ...        https://i.dummyjson.com/data/products/1/4.jpg
    ...        https://i.dummyjson.com/data/products/1/5.jpg

    ${body}       Create Dictionary      
    ...        title=Iphone 15
    ...        description=An apple mobile which is nothing like apple   
    ...        price=549
    ...        discountPercentage=12.96
    ...        rating=4.69  
    ...        stock=94   
    ...        brand=apple       
    ...        category=Smartphone   
    ...        thumbnail=https://i.dummyjson.com/data/products/1/thumbnail.jpg
    ...        images=${images_list}
               

        
    ${response}   POST On Session        Post_Product        /products/add       headers=${header}    json=${body} 

    Log    ${response.status_code}
    Log    ${response.headers}
    Log    ${response.content}

    Should Be Equal As Integers        ${response.status_code}        200


TA03_PUT_Product
    Create Session        Put_Product         ${URL}             verify=True
    ${header}     Create Dictionary      Content-type=application/json; charset=UTF-8
    ${images_list_2}    Create List 
    ...        https://i.dummyjson.com/data/products/1/1.jpg
    ...        https://i.dummyjson.com/data/products/1/2.jpg
    ${body}       Create Dictionary      
    ...    title=Iphone 14
    ...        description=An apple mobile which is nothing like apple   
    ...        price=549   
    ...        discountPercentage=12.96    
    ...        rating=8   
    ...        stock=94       
    ...        brand=apple       
    ...        category=Smartphone    
    ...        thumbnail=https://i.dummyjson.com/data/products/1/thumbnail.jpg
    ...        images=${images_list_2}
    ${response}   PUT On Session        Put_Product        /products/3       headers=${header}    json=${body} 

    Log    ${response.status_code}
    Log    ${response.headers}
    Log    ${response.content}

    Should Be Equal As Integers        ${response.status_code}        200


TA04_PATCH_Product
    Create Session        Patch_Product         ${URL}             verify=True
    ${header}     Create Dictionary      Content-type=application/json; charset=UTF-8
    ${body}       Create Dictionary      title=Sammsung S23U           
    ${response}   PATCH On Session        Patch_Product        /products/10      headers=${header}    json=${body} 

    Log    ${response.status_code}
    Log    ${response.headers}
    Log    ${response.content}

    Should Be Equal As Integers        ${response.status_code}        200

TA05_DELETE_Product
    Create Session        Delete_Product         ${URL}             verify=true 
    ${response}           DELETE On Session    Delete_Product        /posts/10
    Log    ${response.status_code}
    Log    ${response.headers}
    Log    ${response.content}

    Should Be Equal As Integers        ${response.status_code}        200