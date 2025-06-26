// Mock data generation and API simulation
class PeopleAPI {
    constructor() {
        this.people = [];
        this.lastUpdate = null;
        this.updateInterval = null;
        this.init();
    }

    // Generate random names
    generateRandomName() {
        const firstNames = [
            'Ana', 'Carlos', 'Maria', 'João', 'Lucia', 'Pedro', 'Fernanda', 'Roberto',
            'Camila', 'Rafael', 'Juliana', 'André', 'Beatriz', 'Diego', 'Carla', 'Marcos',
            'Isabela', 'Felipe', 'Amanda', 'Rodrigo', 'Vanessa', 'Bruno', 'Priscila', 'Thiago',
            'Renata', 'Lucas', 'Mônica', 'Gabriel', 'Patrícia', 'Leonardo'
        ];
        
        const lastNames = [
            'Silva', 'Santos', 'Oliveira', 'Souza', 'Rodrigues', 'Ferreira', 'Alves', 'Pereira',
            'Lima', 'Gomes', 'Costa', 'Ribeiro', 'Martins', 'Carvalho', 'Almeida', 'Lopes',
            'Soares', 'Fernandes', 'Vieira', 'Barbosa', 'Rocha', 'Dias', 'Monteiro', 'Cardoso',
            'Reis', 'Araújo', 'Nascimento', 'Freitas', 'Correia', 'Machado'
        ];

        const firstName = firstNames[Math.floor(Math.random() * firstNames.length)];
        const lastName = lastNames[Math.floor(Math.random() * lastNames.length)];
        return `${firstName} ${lastName}`;
    }

    // Generate random email based on name
    generateEmail(name) {
        const domains = ['gmail.com', 'hotmail.com', 'yahoo.com.br', 'outlook.com', 'empresa.com.br'];
        const cleanName = name.toLowerCase()
            .replace(/\s+/g, '.')
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, ''); // Remove accents
        
        const domain = domains[Math.floor(Math.random() * domains.length)];
        const randomNum = Math.floor(Math.random() * 999);
        
        return `${cleanName}${randomNum > 100 ? randomNum : ''}@${domain}`;
    }

    // Generate random phone number
    generatePhone() {
        const areaCodes = ['11', '21', '31', '41', '51', '61', '71', '81', '85', '87'];
        const areaCode = areaCodes[Math.floor(Math.random() * areaCodes.length)];
        const firstPart = Math.floor(Math.random() * 90000) + 10000; // 5 digits
        const secondPart = Math.floor(Math.random() * 9000) + 1000; // 4 digits
        
        return `(${areaCode}) ${firstPart}-${secondPart}`;
    }

    // Generate a single person
    generatePerson() {
        const name = this.generateRandomName();
        return {
            id: Date.now() + Math.random(),
            name: name,
            email: this.generateEmail(name),
            phone: this.generatePhone()
        };
    }

    // Generate initial dataset
    generateInitialData() {
        const count = Math.floor(Math.random() * 15) + 8; // 8-22 people
        this.people = [];
        
        for (let i = 0; i < count; i++) {
            this.people.push(this.generatePerson());
        }
        
        this.lastUpdate = new Date();
    }

    // Simulate data updates (some people change, some new ones added/removed)
    updateData() {
        const actions = ['modify', 'add', 'remove'];
        const numChanges = Math.floor(Math.random() * 4) + 1; // 1-4 changes
        
        for (let i = 0; i < numChanges; i++) {
            const action = actions[Math.floor(Math.random() * actions.length)];
            
            switch (action) {
                case 'modify':
                    if (this.people.length > 0) {
                        const index = Math.floor(Math.random() * this.people.length);
                        const person = this.people[index];
                        
                        // Randomly update one field
                        const field = ['name', 'email', 'phone'][Math.floor(Math.random() * 3)];
                        if (field === 'name') {
                            const newName = this.generateRandomName();
                            person.name = newName;
                            person.email = this.generateEmail(newName);
                        } else if (field === 'email') {
                            person.email = this.generateEmail(person.name);
                        } else {
                            person.phone = this.generatePhone();
                        }
                    }
                    break;
                    
                case 'add':
                    if (this.people.length < 25) {
                        this.people.push(this.generatePerson());
                    }
                    break;
                    
                case 'remove':
                    if (this.people.length > 5) {
                        const index = Math.floor(Math.random() * this.people.length);
                        this.people.splice(index, 1);
                    }
                    break;
            }
        }
        
        this.lastUpdate = new Date();
    }

    // Get current data
    getData() {
        return {
            people: [...this.people],
            lastUpdate: this.lastUpdate,
            count: this.people.length
        };
    }

    // Initialize the API
    init() {
        this.generateInitialData();
        this.startAutoUpdate();
    }

    // Start auto-update every 10 seconds
    startAutoUpdate() {
        this.updateInterval = setInterval(() => {
            this.showLoadingIndicator();
            
            // Simulate network delay
            setTimeout(() => {
                this.updateData();
                this.renderData();
                this.hideLoadingIndicator();
            }, 800);
        }, 10000);
    }

    // Show loading indicator
    showLoadingIndicator() {
        const indicator = document.getElementById('loadingIndicator');
        if (indicator) {
            indicator.classList.add('show');
        }
    }

    // Hide loading indicator
    hideLoadingIndicator() {
        const indicator = document.getElementById('loadingIndicator');
        if (indicator) {
            indicator.classList.remove('show');
        }
    }

    // Render data to the table
    renderData() {
        const data = this.getData();
        const tbody = document.getElementById('resultsBody');
        const countElement = document.getElementById('resultsCount');
        const lastUpdateElement = document.getElementById('lastUpdate');

        if (!tbody || !countElement || !lastUpdateElement) return;

        // Update count
        countElement.textContent = data.count;

        // Update last update time
        lastUpdateElement.textContent = data.lastUpdate.toLocaleString('pt-BR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });

        // Clear and populate table
        tbody.innerHTML = '';
        
        data.people.forEach(person => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${person.name}</td>
                <td>${person.email}</td>
                <td>${person.phone}</td>
            `;
            tbody.appendChild(row);
        });
    }

    // Clean up
    destroy() {
        if (this.updateInterval) {
            clearInterval(this.updateInterval);
        }
    }
}

// Initialize the application when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Create API instance
    const api = new PeopleAPI();
    
    // Initial render
    api.renderData();
    
    // Handle page visibility change to pause/resume updates
    document.addEventListener('visibilitychange', function() {
        if (document.hidden) {
            // Page is hidden, could pause updates to save resources
        } else {
            // Page is visible, ensure updates are running
            if (!api.updateInterval) {
                api.startAutoUpdate();
            }
        }
    });
    
    // Clean up when page is unloaded
    window.addEventListener('beforeunload', function() {
        api.destroy();
    });
    
    // Add manual refresh functionality (optional)
    const header = document.querySelector('.header h1');
    if (header) {
        header.style.cursor = 'pointer';
        header.title = 'Clique para atualizar manualmente';
        header.addEventListener('click', function() {
            api.showLoadingIndicator();
            setTimeout(() => {
                api.updateData();
                api.renderData();
                api.hideLoadingIndicator();
            }, 500);
        });
    }
    
    console.log('🚀 People Directory API initialized!');
    console.log('📊 Data updates every 10 seconds automatically');
    console.log('👆 Click on the title to manually refresh data');
});