// Auto populate date picker with current date
function getDate() {
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    return year + "-" + month.toString().padStart(2, '0');
}

document.getElementById("modal_add_budget").addEventListener('show.bs.modal', function () {
    document.getElementById('budget_date_add').value = getDate();
    document.getElementById('budget_date_add').min = getDate();
});

const modals_edit = document.querySelectorAll('[id^="modal_edit"]');
for (const modal of modals_edit) {
    let budget_id = modal.id.split("_")[modals_edit.length - 1];
    document.getElementById(modal.id).addEventListener('show.bs.modal', function () {
        document.getElementById("budget_date_edit_" + budget_id).min = getDate();
    });
}

// Reset form content in Bootstrap modals when closing modal
document.getElementById("modal_add_budget").addEventListener('hidden.bs.modal', function () {
    document.querySelectorAll("#modal_add_budget form")[0].reset();
});

for (const modal of modals_edit) {
    document.getElementById(modal.id).addEventListener('hidden.bs.modal', function () {
        document.querySelectorAll(`#${CSS.escape(modal.id)} form`)[0].reset();
    });
}