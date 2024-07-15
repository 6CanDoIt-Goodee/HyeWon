function showFormSection() {
    const formSections = document.querySelectorAll('.form-section');
    formSections.forEach(section => {
        section.style.display = 'none';
    });

    const selectedOption = document.getElementById('eventType').value;
    if (selectedOption) {
        document.getElementById('form-section' + selectedOption.slice(-1)).style.display = 'block';
    }
}

function toggleEndDate(section) {
    const startDate = document.getElementById('startDate' + section).value;
    const endDate = document.getElementById('endDate' + section);
    if (startDate) {
        endDate.disabled = false;
    } else {
        endDate.disabled = true;
    }
}
 
document.addEventListener('DOMContentLoaded', () => {
    showFormSection();
    toggleEndDate(1); 
    toggleEndDate(2); 
    setMinDateTime();

    document.getElementById('startDate2').addEventListener('change', setMinValue);
    document.getElementById('endDate2').addEventListener('change', setMinValue);
});

function previewImage(event, section) {
    const input = event.target;
    const reader = new FileReader();
    reader.onload = function() {
        const imgElement = document.getElementById('imagePreview' + section);
        imgElement.src = reader.result;
        imgElement.style.display = 'block';
        document.getElementById('imageBox' + section).classList.remove('default');
        document.getElementById('deleteButton' + section).style.display = 'block';
    };
    if (input.files && input.files[0]) {
        reader.readAsDataURL(input.files[0]);
    }
}

function setMinDateTime() {
    const now = new Date();
    const offset = new Date().getTimezoneOffset() * 60000;
    const localISOTime = new Date(now.getTime() - offset).toISOString().slice(0, -8); // 초를 제외하고 분까지만

    const startDate2 = document.getElementById('startDate2');
    const endDate2 = document.getElementById('endDate2');

    startDate2.value = localISOTime;
    startDate2.setAttribute('min', localISOTime);
    endDate2.setAttribute('min', localISOTime);
}

function setMinValue() {
    const startDate2 = document.getElementById('startDate2');
    const endDate2 = document.getElementById('endDate2');

    const now = new Date();
    const offset = new Date().getTimezoneOffset() * 60000;
    const localISOTime = new Date(now.getTime() - offset).toISOString().slice(0, -5);

    // 현재 시간 이전의 날짜는 설정할 수 없도록 하는 로직
    if (startDate2.value < localISOTime) {
        alert('현재 시간보다 이전의 날짜는 설정할 수 없습니다.');
        startDate2.value = localISOTime;
    }

    // startDate2에 값이 입력되면 endDate2 활성화
    if (startDate2.value) {
        endDate2.disabled = false;
    } else {
        endDate2.disabled = true;
    }

    // endDate2가 startDate2보다 빠른 경우 경고 메시지
    if (endDate2.value && endDate2.value < startDate2.value) {
        alert('시작일보다 이전의 날짜는 설정할 수 없습니다.');
        endDate2.value = startDate2.value;
    }
}

function eventInsertBtn() { 
    const form = document.create_evnt_form;
    form.submit();
}

function deleteImage(section) {
    const imgElement = document.getElementById('imagePreview' + section);
    imgElement.src = '';
    imgElement.style.display = 'none';
    document.getElementById('imageBox' + section).classList.add('default');
    document.getElementById('deleteButton' + section).style.display = 'none';
    document.getElementById('eventimage' + section).value = '';
}