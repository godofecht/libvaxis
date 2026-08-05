// Azazel parity model for libvaxis. First target slice: queue, a self-contained
// pure-Zig module. src/queue.zig imports only std (no zigimg, no uucode), so
// Azazel builds it directly as a static library. Verified: the source compiles
// as a static lib on 0.16.0. The full vaxis library additionally needs the
// zigimg and uucode package deps (azazel pkg_imports).
package build

toolchain: zig: {
	lanes: ["0.16"]
	preferred: "0.16"
}

queue: #Module & {
	kind: "static"
	root: "src/queue.zig"
}
