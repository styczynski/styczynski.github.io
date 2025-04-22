import * as React from 'react';
import styled from 'styled-components';

import Page from 'components/Page';
import HomePanel from 'components/HomePanel';

export interface HomePageProps {
}

export default class HomePage extends React.Component<HomePageProps, undefined> {
    render() {
        // FIXME: Force redirect 22 Apr 2025
        window.location.replace("https://styczynski.in");
        return (
            <Page>
                <HomePanel />
            </Page>
        );
    }
};
