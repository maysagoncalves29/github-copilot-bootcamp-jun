import * as React from 'react';
import * as ReactDom from 'react-dom';

import PeopleDirectory from './components/PeopleDirectory';
import { IPeopleDirectoryProps } from './components/IPeopleDirectoryProps';

// Mock interfaces for demo purposes (in real SPFx these come from @microsoft/sp-* packages)
interface IVersion {
  parse(versionString: string): IVersion;
}

interface IPropertyPaneConfiguration {
  pages: any[];
}

interface IPropertyPaneTextField {
  (targetProperty: string, properties: any): any;
}

// Mock SPFx base class for demonstration
export interface IPeopleDirectoryWebPartProps {
  description: string;
}

export default class PeopleDirectoryWebPart {
  private properties: IPeopleDirectoryWebPartProps = {
    description: 'People Directory Web Part'
  };
  
  private context: any = {
    pageContext: {
      web: {
        title: 'Demo Site',
        serverRelativeUrl: '/demo'
      }
    }
  };
  
  private domElement: Element | null = null;

  constructor(domElement: Element) {
    this.domElement = domElement;
  }

  public render(): void {
    const element: React.ReactElement<IPeopleDirectoryProps> = React.createElement(
      PeopleDirectory,
      {
        description: this.properties.description,
        context: this.context
      }
    );

    if (this.domElement) {
      ReactDom.render(element, this.domElement);
    }
  }

  public dispose(): void {
    if (this.domElement) {
      ReactDom.unmountComponentAtNode(this.domElement);
    }
  }

  protected get dataVersion(): string {
    return '1.0';
  }

  // Mock property pane configuration (in real SPFx this would use actual SPFx property pane)
  protected getPropertyPaneConfiguration(): any {
    return {
      pages: [
        {
          header: {
            description: 'People Directory Configuration'
          },
          groups: [
            {
              groupName: 'Settings',
              groupFields: [
                {
                  type: 'TextField',
                  targetProperty: 'description',
                  properties: {
                    label: 'Description Field'
                  }
                }
              ]
            }
          ]
        }
      ]
    };
  }
}