package build

toolchain: zig: {
    lanes: ["0.16"]
    preferred: "0.16"
}

packages: {
    zigimg: {
        path: "../../zig-pkg/zigimg-0.1.0-8_eo2oyaFwBZwJpmqPkCfVXWBrHcqbYwmrp1I6bTD3lI"
    }
    uucode: {
        path: "../../zig-pkg/uucode-0.2.0-ZZjBPlK5VADj7fdoq7G8LIHzD5o6FSkcBXXrRWr4jnrA"
        lazy: true
    }
}

vaxis: #Module & {
    kind: "module"
    root: "../../src/main.zig"
    pkg_imports: [
        {
            alias: "zigimg"
            package: "zigimg"
            module: "zigimg"
        },
        {
            alias: "uucode"
            package: "uucode"
            module: "uucode"
        },
    ]
}

vaxis_probe: #Module & {
    kind: "exe"
    root: "src/vaxis_probe.zig"
    deps: ["vaxis"]
    link: "import"
}
