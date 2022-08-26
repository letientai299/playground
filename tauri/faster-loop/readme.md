# Faster loop

Experimental setup to have faster edit-build-test loop while developing tauri
app.

## Problems

The recommended workflows for a Tauri + Vite project is to run `yarn tauri dev`,
which runs the tauri CLI to build the frontend, watch and rebuild the Rust part.
The frontend, via Vite, could be reloaded quickly and reliably. However, the
Rust backend reloading is very brittle and slow.
