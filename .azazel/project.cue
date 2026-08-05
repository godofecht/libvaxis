// Azazel parity model for libvaxis.
//
// The `vaxis` library is a Zig module (b.addModule("vaxis", src/main.zig))
// that imports two package dependencies: zigimg (image decoding) and uucode
// (Unicode property tables). uucode is selective: it only compiles the data
// tables named in its `fields` build option, so the model passes the exact
// four fields vaxis needs (east_asian_width / grapheme_break /
// general_category / is_emoji_presentation) via Azazel's pkg_imports `fields`.
//
// The earlier `queue` slice (a std-only static lib) is kept so the fork still
// carries a self-contained target; `vaxis` is the full library.
package build

toolchain: zig: {
	lanes: ["0.16"]
	preferred: "0.16"
}

// Dependencies resolve against the repo's build.zig.zon. uucode is made eager
// there (Azazel consumes it through b.dependency), so no lazy handling is
// needed; the fields option still selects only the four tables vaxis uses.
packages: {
	zigimg: {}
	uucode: {}
}

queue: #Module & {
	kind: "static"
	root: "src/queue.zig"
}

vaxis: #Module & {
	kind: "static"
	root: "src/main.zig"
	pkg_imports: [
		{alias: "zigimg", package: "zigimg", module: "zigimg"},
		{
			alias:   "uucode"
			package: "uucode"
			module:  "uucode"
			fields: [
				"east_asian_width",
				"grapheme_break",
				"general_category",
				"is_emoji_presentation",
			]
		},
	]
}
