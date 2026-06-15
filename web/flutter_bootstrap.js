{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    
    // Fade out and remove the skeleton loader
    const loader = document.getElementById('skeleton-loader');
    if (loader) {
      loader.classList.add('fade-out');
      setTimeout(() => {
        loader.remove();
      }, 500); // Wait for the CSS transition to complete
    }
    
    await appRunner.runApp();
  }
});
