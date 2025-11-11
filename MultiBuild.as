void main(MultiBuild::Workspace& workspace) {	
	auto project = workspace.create_project(".");
	auto properties = project.properties();

	project.name("Skia");
	properties.binary_object_kind(MultiBuild::BinaryObjectKind::eStaticLib);
	project.license("./LICENSE");
	properties.tags({ "use_header_only_mle", "utf8" });

	project.include_own_required_includes(true);
	project.add_required_project_include({
		"."
	});

	properties.dependencies({
		"libwebp",
		"VulkanMemoryAllocator"
	});

	properties.files({
		"./include/**.h",
		
		"./src/**.h",
		"./src/**.cpp",

		"./modules/skcms/**.h",
		"./modules/skcms/**.cc"
	});

	properties.defines({
		"SK_USE_VMA",
		"SK_VULKAN",
		"SK_GANESH",
		"SK_GRAPHITE",

		"SK_TYPEFACE_FACTORY_FREETYPE",
		"SK_FREETYPE_MINIMUM_RUNTIME_VERSION_IS_BUILD_VERSION",

		"SK_PDF_USE_HARFBUZZ_SUBSET",

		"SKIA_IMPLEMENTATION=1"
	});

	properties.include_directories({
		".",
		"./src/gpu/vk/vulkanmemoryallocator/"
	});

	properties.excluded_files({
		"./src/**/ganesh/gl/**",
		"./src/**/ganesh/d3d/**",

		"./src/**/*mozilla*",
		"./src/**/*mozalloc*",

		"./src/codec/*Png*",
		"./src/codec/*Raw*",
		"./src/codec/*Jpeg*",
		"./src/codec/*Avif*",
		"./src/codec/*Wuffs*",

		"./src/sksl/codegen/SkSLSPIRVtoHLSL.*",
		"./src/sksl/codegen/SkSLSPIRVValidator.*",

		"./src/sksl/codegen/*WGSL*",
		"./src/sksl/SkSLModuleDataFile.cpp",

		"./src/gpu/graphite/compute/*Vello*",
		
		"./src/encode/*SkPngEncoder*",
		"./src/encode/*SkPngRustEncoder*",
		"./src/encode/*SkJpegEncoderImpl*",
		"./src/encode/*SkJPEGWriteUtility*",
		"./src/encode/*SkWebpEncoder_none*",
		"./src/encode/*SkJpegGainmapEncoder*",

		"./src/pdf/*SkDocument_PDF_None*",

		"./src/ports/*NDK*",
		"./src/ports/*SkFontMgr_win*",
		"./src/ports/*empty*",
		"./src/ports/*embedded*",
		"./src/ports/*direct*",

		"./src/**/*dawn*/**",
		"./src/**/*vello*/**",
		"./src/**/*fuchsia*/**",
		"./src/**/*android*/**",
		"./src/**/*fontations*/**",
		"./src/**/*fontconfig*/**",
		"./src/**/*libjpegturbo*/**",

		"./src/**/*dawn*",
		"./src/**/*vello*",
		"./src/**/*fuchsia*",
		"./src/**/*android*",
		"./src/**/*fontations*",
		"./src/**/*fontconfig*",
		"./src/**/*libjpegturbo*",

		"./src/xml/**",

		"./src/gpu/vk/vulkanmemoryallocator/VulkanMemoryAllocatorWrapper.cpp"
	});
	
	{
		MultiBuild::ScopedFilter _(project, "project.compiler:VisualCpp");
		properties.disable_warnings({ "4244", "4267", "4291", "4806", "5030" });
	}

	{
		MultiBuild::ScopedFilter _(project, "config.platform:Windows");
		properties.defines({ "SK_BUILD_FOR_WIN", "_CRT_SECURE_NO_WARNINGS", "WIN32_LEAN_AND_MEAN" });
		properties.excluded_files({ 
			"./src/**/*posix*",
			"./src/**/*ImageGeneratorCG*",

			"./src/utils/*mac*",
			"./src/utils/*linux*"
		});
	}

	{
		MultiBuild::ScopedFilter _(project, "config.platform:MacOS");
		properties.defines("SK_BUILD_FOR_MAC");
		properties.excluded_files("./src/**/*ImageGeneratorWIC*");
	}
}