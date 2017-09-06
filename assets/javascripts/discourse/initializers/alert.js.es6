export default {
    name: 'initlog',
    initialize(container) {
        const store = container.lookup('store:main');

        console.log('ignore-list plugin link is active');
    }
};
