import { withPluginApi } from 'discourse/lib/plugin-api';

function hideContent(api, siteSettings) {

  api.decorateCooked(decorate, { onlyStream: true } );
    function decorate($elem,helper){
      const post = helper.getModel();
      const currentUser = api.getCurrentUser();

      if (currentUser && currentUser.custom_fields !== null && currentUser.custom_fields['ignored_users'] !== null) {

        const ignoredUsers = currentUser.custom_fields['ignored_users'].split(',');
        if (ignoredUsers.includes(post.username)) {
          console.log('ignored cooked');
          $elem.addClass('ignoredCooked');
          $elem.wrapInner('<div class="hidden"></div>');
          $elem.append('<div class="designorerWrapper">Vous avez choisi d\'ignorer cet utilisateur <button class="designorer btn" value="voir quand même">voir quand même</button></div>');
          $elem.find('.designorer').on("click",function(e){
            console.log('clicked');
            $(e.target).closest('.ignoredCooked').find('.hidden').removeClass('hidden');
            $(e.target).closest('.designorerWrapper').addClass('hidden');
            e.preventDefault();
            return false;
          });
        }
      }
    }
}

export default {
  name: 'ignore-list',
  initialize(container) {
    const siteSettings = container.lookup('site-settings:main');
    if (siteSettings.ignored_users_enabled) {
      withPluginApi('0.1', api => hideContent(api, siteSettings));
    }
  }
};
