import * as React from 'react';
import { RouteComponentProps } from 'react-router';
import 'isomorphic-fetch';

interface WebsiteDetails {
    WebsiteId: number;
    Url: string;
    TotalVisits: number;
    VisitDate: string;
}

interface WebsitesExampleState {
    websites: WebsiteDetails[];
    loading: boolean;
    topNumber: number;
    searchDate: string;
    listSearchColumns: Array<string>;
    searchColumns: string;
    currentOption: string;
    responseJsonColumns: Array<string>;
    errorMessage: string;
}

export class Websites extends React.Component<RouteComponentProps<{}>, WebsitesExampleState> {

    constructor() {
        super();
        let listColumns = ["Url,TotalVisits,VisitDate", "Url,TotalVisits"];
        this.state = {
            websites: []
            , loading: true
            , topNumber: 5
            , searchDate: "2018-11-01"
            , listSearchColumns: listColumns
            , searchColumns: listColumns[0]
            , currentOption: listColumns[0]
            , responseJsonColumns: []
            , errorMessage: ""
        };
    };

    async componentDidMount() { this.getDataFromDBUsingServer(); }

    private setComponentState = (stateOptions: any) => this.setState({...this.state,...stateOptions });

    private getDataFromDBUsingServer = () => {
        let apiOptions = "?";
        apiOptions += (this.state.searchDate.trim() !== "" ? "&searchDate=" + this.state.searchDate.trim() : "");
        apiOptions += (this.state.topNumber !== null ? "&topNumber=" + this.state.topNumber.toString() : "");
        apiOptions += (this.state.currentOption.trim() !== "" ? "&columns=WebsiteId," + this.state.currentOption.trim() : "");
        fetch('api/Websites/Index' + apiOptions)
            .then(response => {
                let data = response.json();
                if(response.status === 200) {
                    this.setComponentState({
                        loading: false
                        , errorMessage: 'reading'
                    });
                }
                return data
            })
            .then(data => {
                if(this.state.errorMessage === 'reading') {
                    this.setComponentState({
                        websites: data.length === 0 ? [] : data as WebsiteDetails[]
                        , loading: false
                        , searchColumns: this.state.currentOption.trim()
                        , responseJsonColumns: data.length === 0 ? [] : Object.keys(data[0]) 
                        , errorMessage: ""
                    });
                }
                else{
                    this.setComponentState({
                        loading: false
                        , errorMessage: data.Message
                    });    
                }
            })
            .catch((error) => {
                console.log('API call failed:',error)
            });
    }

    public render() {
        return <div>
            <h1>Website Tracking Details</h1>
            <p>This component demonstrates top websites by visits data from the server.</p>
            <p>Get top&nbsp;&nbsp;
                {Websites.renderTopNumber(this.state, (stateOptions: any) => this.setComponentState(stateOptions))}
                &nbsp;&nbsp;websites for&nbsp;&nbsp;
                {Websites.renderSearchDate(this.state, (stateOptions: any) => this.setComponentState(stateOptions))}
                &nbsp;&nbsp;with columns as &nbsp;&nbsp;
                {Websites.renderColumnsList(this.state, (stateOptions: any) => this.setComponentState(stateOptions))}
                &nbsp;&nbsp;
                {Websites.renderSubmitButton(() => this.getDataFromDBUsingServer())}
            </p>
            {
                this.state.loading
                    ? <p><em>Loading...</em></p>
                    : (
                        this.state.errorMessage === ""
                            ? Websites.renderWebsitesTable(this.state)
                            : (this.state.errorMessage === "reading" 
                                ? <p><em>Loading...data fetched...reading...</em></p>
                                : <p><em>Error occured : {this.state.errorMessage}</em></p>
                            )
                    )            
            }
        </div>;
    }

    private static renderWebsitesTable(state: Readonly<WebsitesExampleState>) {
        const websites = state.websites as WebsiteDetails[]
        return <table className='table'>
            <thead>
                <tr>
                    {state.responseJsonColumns.map(s => (s.toUpperCase().trim() !== 'WEBSITEID' ? <th key={s}>{s}</th> : null)) }
                </tr>
            </thead>
            <tbody>
            {   websites.map(website =>
                    <tr key={website.WebsiteId}>
                        {!websites.every(s => s.Url === undefined)          && <td> {website.Url}   </td>}
                        {!websites.every(s => s.TotalVisits === undefined)  && <td> {website.TotalVisits}   </td>}
                        {!websites.every(s => s.VisitDate === undefined)    && <td> {website.VisitDate !== undefined ? (new Date(website.VisitDate).toLocaleDateString()) : null}   </td>}
                    </tr>
                )
            }
            </tbody>
        </table>;
    }

    private static renderTopNumber(state: Readonly<WebsitesExampleState>, setComponentState:(stateOptions: any) => void) {
        const topNumberChange = (event: { currentTarget: { value: string; }; }) => setComponentState({ topNumber: parseInt(event.currentTarget.value) });
        
        return  <select id="topNumberSelect"
            value={state.topNumber.toString()}
            onChange={e => topNumberChange(e)}
            style={{ width:"45px"}}
        >
            {
                [1,2,3,4,5,6,7,8,9,10].map((val) => {
                    var setVal = val;
                    return <option key={setVal} value={setVal} >{setVal}</option>
                })
            }
        </select>
    }

    private static renderSearchDate(state: Readonly<WebsitesExampleState>, setComponentState:(stateOptions: any) => void) {
        const dateChange = (event: { currentTarget: { value: string; }; }) => setComponentState({ searchDate: event.currentTarget.value });
    
        return  <input type="date" id="searchDateSelect" min="2018-11-01" max="2018-11-10"
            value={state.searchDate}
            onChange={e => dateChange(e)}
        />
    }

    private static renderColumnsList(state: Readonly<WebsitesExampleState>, setComponentState:(stateOptions: any) => void) {
        const columnsChange = (event: { currentTarget: { value: string; }; }) => setComponentState({ currentOption : event.currentTarget.value });
    
        return <select id="columnsSelect"
            value={state.currentOption}
            onChange={e => columnsChange(e)}
            style={{ width: "200px" }}
            ref="columnsSelect"
        >
            {
                state.listSearchColumns.map((val) => {
                    var setVal = val;
                    return <option key={setVal} value={setVal} >{setVal}</option>
                })
            }
        </select>
    }

    private static renderSubmitButton(getData: () => void) {
        return <button id="btnSubmit" onClick={e => getData()} >View</button>;
    }
}