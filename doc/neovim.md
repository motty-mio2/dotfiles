# nvim cfg
## Telescope
- filer
### ripgrep
- common : `cargo install ripgrep`
- windows : `scoop install ripgrep`
- POSIX : `brew install ripgrep`
## LSP

### bash : bashls
 - common : `npm install --location=global bash-language-server`

### C/C++ : clangd
 - windows : `scoop install llvm`
 - POSIX : `brew install llvm`

### Python : Pyright
 - common : `npm install --location=global pyright`

### SystemVerilog : svls
- common : `cargo install svlint svls`
- windows : `scoop bucket add hdl https://github.com/motty-mio2/scoop_hdl.git && scoop install svlint svls`

## Reference
- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.txt
