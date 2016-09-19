import ReactOnRails from 'react-on-rails';
import HelloWorldApp from './HelloWorldAppClient';
import ChatApp from './ChatAppClient';
import InstallationApp from './InstallationClient';
import TemplateApp from './TemplateClient';
import CheckResultApp from './CheckResultClient';
import DefectApp from './DefectClient';
import LinkListApp from './LinkListClient';

// This is how react_on_rails can see the HelloWorldApp in the browser.
ReactOnRails.register({ HelloWorldApp });
ReactOnRails.register({ InstallationApp });
ReactOnRails.register({ ChatApp });
ReactOnRails.register({ TemplateApp });
ReactOnRails.register({ CheckResultApp });
ReactOnRails.register({ DefectApp });
ReactOnRails.register({ LinkListApp });
