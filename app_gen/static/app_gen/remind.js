console.log('connected');
if (localStorage.chkbx && localStorage.chkbx != '') {
    chkbx.checked = true;
    email.value = (localStorage.email);
    password.value = (localStorage.password);
} else {
    chkbx.checked = false;
    email.value = '';
    password.value = '';
}

chkbx.addEventListener('click',remindInput)

function remindInput() {
    console.log('click')
    if (chkbx.checked === true) {
        localStorage.email = email.value;
        localStorage.password = password.value;
        localStorage.chkbx = chkbx.value;
    } else {
        localStorage.email = '';
        localStorage.password = '';
        localStorage.chkbx = '';
    }
}