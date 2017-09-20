import { withPluginApi } from 'discourse/lib/plugin-api';
import RawHtml from 'discourse/widgets/raw-html';

function hideContent(api, siteSettings) {
  // api.includePostAttributes('custom_fields');
  // api.includeUserAttributes('ignored_users_key');

  api.decorateWidget('post-contents:after-cooked', dec => {

    const attrs = dec.attrs;
    console.log('attrs');
    console.log(attrs);
    const currentUser = api.getCurrentUser();
    console.log(currentUser);
    if (currentUser) {
      const ignoredUsers = currentUser.custom_fields[currentUser.ignored_users_key].split(',');
      if (enabled) {
        return [dec.h('hr'), dec.h('div', new RawHtml({html: `<div class='user-signature'>LOL</div>`}))];

      }
    }
  });
}

export default {
  name: 'ignore-list',
  initialize(container) {
    const siteSettings = container.lookup('site-settings:main');
    // if (siteSettings.signatures_enabled) {
      withPluginApi('0.1', api => hideContent(api, siteSettings));
    // }
  }
};
