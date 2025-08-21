document.addEventListener('DOMContentLoaded', () => {
    const container = document.getElementById('navbar');
    if (!container) return;
    fetch('nav.html')
        .then(res => res.text())
        .then(html => {
            container.innerHTML = html;
            const page = window.location.pathname.split('/').pop().replace('.html', '');
            const active = container.querySelector(`a[data-page="${page}"]`);
            if (active) {
                active.classList.remove('font-medium', 'text-gray-600', 'hover:text-blue-700', 'hover:bg-blue-50');
                active.classList.add('font-semibold', 'text-blue-800', 'bg-blue-100', 'shadow-sm');
            }
        })
        .catch(err => console.error('Failed to load navigation', err));
});
