import ReactOnRails from 'react-on-rails';
import HelloWorldApp from './HelloWorldAppClient';
import ChatApp from './ChatAppClient';
import InstallationApp from './InstallationClient';
import TemplateApp from './TemplateClient';

// This is how react_on_rails can see the HelloWorldApp in the browser.
ReactOnRails.register({ HelloWorldApp });
ReactOnRails.register({ InstallationApp });
ReactOnRails.register({ ChatApp });
ReactOnRails.register({ TemplateApp });
