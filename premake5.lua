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
		"./src/**.cpp"
	}

	includedirs {
		"%{IncludeDir.icu}",
		"%{IncludeDir.skia}",
		"%{IncludeDir.harfbuzz}",
		"%{IncludeDir.freetype}",
		"%{IncludeDir.vulkan_headers}"
	}

	excludes { 
		"./src/**/*dawn*",
		"./src/**/*mozilla*",
		"./src/**/*android*",
		"./src/**/*fontconfig*",
		"./src/**/*libjpegturbo*",

		"./src/gpu/vk/vulkanmemoryallocator/VulkanMemoryAllocatorWrapper.cpp"
	}

	defines {
		"SK_VULKAN",
		"SK_USE_VMA",
		"SK_GRAPHITE"
	}

	filter "system:windows"
		disablewarnings { "4244" }
		defines { "SK_BUILD_FOR_WIN", "_CRT_SECURE_NO_WARNINGS" }
	filter "system:macosx"
		defines { "SK_BUILD_FOR_MAC" }