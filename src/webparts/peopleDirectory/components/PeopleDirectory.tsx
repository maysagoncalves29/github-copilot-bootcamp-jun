import * as React from 'react';
import { IPeopleDirectoryProps } from './IPeopleDirectoryProps';
import { PeopleService, IPeopleData, IPerson } from '../services/PeopleService';
import './PeopleDirectory.css'; // Using regular CSS instead of SCSS module for simplicity

interface IPeopleDirectoryState {
  data: IPeopleData;
  isLoading: boolean;
}

export default class PeopleDirectory extends React.Component<IPeopleDirectoryProps, IPeopleDirectoryState> {
  private peopleService: PeopleService;

  constructor(props: IPeopleDirectoryProps) {
    super(props);
    
    this.peopleService = new PeopleService();
    
    this.state = {
      data: this.peopleService.getData(),
      isLoading: false
    };
  }

  public componentDidMount(): void {
    // Start auto-update
    this.peopleService.startAutoUpdate(() => {
      this.setState({
        data: this.peopleService.getData()
      });
    });
  }

  public componentWillUnmount(): void {
    // Stop auto-update
    this.peopleService.stopAutoUpdate();
  }

  private handleManualRefresh = (): void => {
    this.setState({ isLoading: true });
    
    // Simulate loading delay like the original
    setTimeout(() => {
      this.peopleService.refreshData();
      this.setState({
        data: this.peopleService.getData(),
        isLoading: false
      });
    }, 500);
  }

  private formatDate(date: Date): string {
    return date.toLocaleString('pt-BR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    });
  }

  private renderTableRows(): JSX.Element[] {
    return this.state.data.people.map((person: IPerson, index: number) => (
      <tr key={index}>
        <td>{person.name}</td>
        <td>{person.email}</td>
        <td>{person.phone}</td>
      </tr>
    ));
  }

  public render(): React.ReactElement<IPeopleDirectoryProps> {
    const { data, isLoading } = this.state;

    return (
      <div className="people-directory">
        <header className="header">
          <h1 onClick={this.handleManualRefresh} title="Clique para atualizar manualmente">
            🔍 People Directory
          </h1>
          <p className="subtitle">API Search Results - SPFx React Version</p>
        </header>
        
        <div className="status-bar">
          <div className="status-info">
            <span className="status-dot"></span>
            <span>Live Data</span>
          </div>
          <div className="last-update">
            Last updated: {this.formatDate(data.lastUpdate)}
          </div>
        </div>

        <div className="search-results">
          <div className="results-header">
            <h2>Search Results</h2>
            <div className="results-count">
              {data.count} people found
            </div>
          </div>
          
          <div className="table-container">
            <table className="results-table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                </tr>
              </thead>
              <tbody>
                {this.renderTableRows()}
              </tbody>
            </table>
          </div>
        </div>

        {isLoading && (
          <div className="loading-indicator show">
            <div className="spinner"></div>
            <p>Updating data...</p>
          </div>
        )}
      </div>
    );
  }
}