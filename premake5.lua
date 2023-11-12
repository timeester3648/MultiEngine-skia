include "../../premake/common_premake_defines.lua"

project "Skia"
	kind "StaticLib"
	language "C++"
	cppdialect "C++latest"
	cdialect "C17"
	targetname "%{prj.name}"
	inlining "Auto"

	files {
		"./include/**.h",
		
		"./src/**.h",
		"./src/**.cpp",

		"./modules/skcms/**.h",
		"./modules/skcms/**.cc",
	}

	includedirs {
		"%{IncludeDir.mle}",
		"%{IncludeDir.fmt}",
		"%{IncludeDir.boost}",
		"%{IncludeDir.spdlog}",
		"%{IncludeDir.intrinsics}",
		"%{IncludeDir.magic_enum}",
		"%{IncludeDir.general_includes}",

		"%{IncludeDir.icu}",
		"%{IncludeDir.vma}",
		"%{IncludeDir.skia}",
		"%{IncludeDir.zlib}",
		"%{IncludeDir.brotli}",
		"%{IncludeDir.libwebp}",
		"%{IncludeDir.harfbuzz}",
		"%{IncludeDir.freetype}",
		"%{IncludeDir.spirv_tools}",
		"%{IncludeDir.spirv_cross}",
		"%{IncludeDir.spirv_headers}",
		"%{IncludeDir.vulkan_headers}",

		"./src/gpu/vk/vulkanmemoryallocator/"
	}

	excludes { 
		"./src/**/ganesh/gl/**",
		"./src/**/ganesh/d3d/**",

		"./src/**/*mozilla*",
		"./src/**/*mozalloc*",

		"./src/codec/*Png*",
		"./src/codec/*Raw*",
		"./src/codec/*Jpeg*",
		"./src/codec/*Avif*",
		"./src/codec/*Wuffs*",
		
		"./src/encode/*SkPngEncoderImpl*",
		"./src/encode/*SkJpegEncoderImpl*",
		"./src/encode/*SkJPEGWriteUtility*",
		"./src/encode/*SkWebpEncoder_none*",
		"./src/encode/*SkJpegGainmapEncoder*",

		"./src/pdf/*SkDocument_PDF_None*",

		"./src/ports/*NDK*",
		"./src/ports/*SkFontMgr_win*",
		"./src/ports/*SkFontMgr_custom_empty_factory*",
		"./src/ports/*SkFontMgr_custom_embedded_factory*",
		"./src/ports/*SkFontMgr_custom_directory_factory*",

		"./src/**/*dawn*",
		"./src/**/*vello*",
		"./src/**/*fuchsia*",
		"./src/**/*android*",
		"./src/**/*fontations*",
		"./src/**/*fontconfig*",
		"./src/**/*libjpegturbo*",

		"./src/xml/**",

		"./src/gpu/vk/vulkanmemoryallocator/VulkanMemoryAllocatorWrapper.cpp"
	}

	defines {
		"SK_USE_VMA",

		"SK_TYPEFACE_FACTORY_FREETYPE",
		"SK_FREETYPE_MININUM_RUNTIME_VERSION_IS_BUILD_VERSION",

		"SKIA_IMPLEMENTATION=1"
	}

	filter "system:windows"
		disablewarnings { "4244", "4267", "4291" }
		defines { "SK_BUILD_FOR_WIN", "_CRT_SECURE_NO_WARNINGS" }
		excludes {
			"./src/**/*posix*",
			"./src/**/*ImageGeneratorCG*"
		}
	filter "system:macosx"
		defines { "SK_BUILD_FOR_MAC" }
		excludes {
			"./src/**/*ImageGeneratorWIC*"
		}