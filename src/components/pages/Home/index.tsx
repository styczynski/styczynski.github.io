import * as React from 'react';
import styled from 'styled-components';

import Page from 'components/Page';
import HomePanel from 'components/HomePanel';

export interface HomePageProps {
}

export default class HomePage extends React.Component<HomePageProps, undefined> {
    render() {
        return (
            <Page>
                <HomePanel />
            </Page>
        );
    }
};