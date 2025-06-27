export interface IPerson {
  name: string;
  email: string;
  phone: string;
}

export interface IPeopleData {
  people: IPerson[];
  lastUpdate: Date;
  count: number;
}

export class PeopleService {
  private people: IPerson[] = [];
  private lastUpdate: Date | null = null;
  private updateInterval: number | null = null; // Using number instead of NodeJS.Timeout

  constructor() {
    this.generateInitialData();
  }

  // Generate random names (converted from original script.js)
  private generateRandomName(): string {
    const firstNames = [
      'Ana', 'Bruno', 'Carlos', 'Daniela', 'Eduardo', 'Fernanda', 'Gabriel', 'Helena',
      'Igor', 'Juliana', 'Kaique', 'Larissa', 'Mateus', 'Natália', 'Otávio', 'Paula',
      'Rafael', 'Sabrina', 'Thiago', 'Valentina', 'Wagner', 'Yasmin', 'Zeca'
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

  // Generate email from name
  private generateEmail(name: string): string {
    const emailDomains = ['email.com', 'empresa.com.br', 'work.net', 'company.org'];
    const cleanName = name.toLowerCase()
      .replace(/\s+/g, '.')
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '');
    const domain = emailDomains[Math.floor(Math.random() * emailDomains.length)];
    return `${cleanName}@${domain}`;
  }

  // Generate phone number
  private generatePhone(): string {
    const areaCodes = ['11', '21', '31', '41', '51', '61', '71', '81', '85', '47'];
    const areaCode = areaCodes[Math.floor(Math.random() * areaCodes.length)];
    const number = Math.floor(Math.random() * 900000000) + 100000000;
    return `(${areaCode}) ${Math.floor(number / 10000)}-${number % 10000}`;
  }

  // Generate a person
  private generatePerson(): IPerson {
    const name = this.generateRandomName();
    return {
      name,
      email: this.generateEmail(name),
      phone: this.generatePhone()
    };
  }

  // Generate initial dataset
  private generateInitialData(): void {
    const count = Math.floor(Math.random() * 15) + 8; // 8-22 people
    this.people = [];
    
    for (let i = 0; i < count; i++) {
      this.people.push(this.generatePerson());
    }
    
    this.lastUpdate = new Date();
  }

  // Simulate data updates
  private updateData(): void {
    const actions = ['modify', 'add', 'remove'];
    const numberOfChanges = Math.floor(Math.random() * 3) + 1; // 1-3 changes
    
    for (let i = 0; i < numberOfChanges; i++) {
      const action = actions[Math.floor(Math.random() * actions.length)];
      
      switch (action) {
        case 'modify':
          if (this.people.length > 0) {
            const index = Math.floor(Math.random() * this.people.length);
            const person = this.people[index];
            
            if (Math.random() < 0.5) {
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
  public getData(): IPeopleData {
    return {
      people: [...this.people],
      lastUpdate: this.lastUpdate || new Date(),
      count: this.people.length
    };
  }

  // Start auto-update
  public startAutoUpdate(callback: () => void): void {
    this.updateInterval = window.setInterval(() => {
      this.updateData();
      callback();
    }, 10000); // Update every 10 seconds
  }

  // Stop auto-update
  public stopAutoUpdate(): void {
    if (this.updateInterval) {
      window.clearInterval(this.updateInterval);
      this.updateInterval = null;
    }
  }

  // Manual refresh
  public refreshData(): void {
    this.updateData();
  }
}