// Mock WebPartContext for demonstration (in real SPFx, this comes from SharePoint)
export interface IWebPartContext {
  pageContext: {
    web: {
      title: string;
      serverRelativeUrl: string;
    };
  };
}

export interface IPeopleDirectoryProps {
  description: string;
  context?: IWebPartContext; // Optional for demo purposes
}