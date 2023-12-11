Return-Path: <linux-arch+bounces-880-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A139580C9A9
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 13:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D535D1C209B5
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D13B29B;
	Mon, 11 Dec 2023 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nIVA8V0y"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233322119;
	Mon, 11 Dec 2023 04:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1702297420;
	bh=ODAUXRjain77XOmoPnKy1MNIInbnbbNcYLIa9FPn8ks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nIVA8V0yVj+ZMN8x89h2gJxxT4+cCTauZuj8Ht7cflzgnHnN4ITpBMOV1xWo7AIlq
	 Qb+tJKhKhRta6FIYqIPB6IjCP4IRbYllJ3J3dFQkrZ5gBhylzYOFVQ0olRQRq0XFRq
	 mToIUeHe7mjunplXY3/T3inRVriUXVwwqHAyMT8ZrNdDNjb78fGIZ7jZefsf1Xa8DY
	 kagFMIi8wqGn8H2LFlRDsc9/abaI9Ajeo1k+5RyvhTShHF9xXBTFIlBig9ReYi7rDb
	 14jHwg99Lq6Mb4L4gts5PmojrjCNJA0P9GJfiVGM/34KY923DExlNs08GewB4rxZRl
	 xDIjF0NgfU/GA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Spgrp6jZHz4xGM;
	Mon, 11 Dec 2023 23:23:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Samuel Holland <samuel.holland@sifive.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 Timothy Pearson <tpearson@raptorengineering.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-arch@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [RFC PATCH 10/12] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <20231208055501.2916202-11-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-11-samuel.holland@sifive.com>
Date: Mon, 11 Dec 2023 23:23:35 +1100
Message-ID: <87h6kpdj20.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Samuel,

Thanks for trying to clean all this up.

One problem below.

Samuel Holland <samuel.holland@sifive.com> writes:
> Now that all previously-supported architectures select
> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
> of the existing list of architectures. It can also take advantage of the
> common kernel-mode FPU API and method of adjusting CFLAGS.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
...
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> index 4ae4720535a5..b64f917174ca 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> @@ -87,20 +78,9 @@ void dc_fpu_begin(const char *function_name, const int line)
>  	WARN_ON_ONCE(!in_task());
>  	preempt_disable();
>  	depth = __this_cpu_inc_return(fpu_recursion_depth);
> -
>  	if (depth == 1) {
> -#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
> +		BUG_ON(!kernel_fpu_available());
>  		kernel_fpu_begin();
> -#elif defined(CONFIG_PPC64)
> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
> -			enable_kernel_vsx();
> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
> -			enable_kernel_altivec();
 
Note altivec.

> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
> -			enable_kernel_fp();
> -#elif defined(CONFIG_ARM64)
> -		kernel_neon_begin();
> -#endif
>  	}
>  
>  	TRACE_DCN_FPU(true, function_name, line, depth);
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index ea7d60f9a9b4..5aad0f572ba3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -25,40 +25,8 @@
>  # It provides the general basic services required by other DAL
>  # subcomponents.
>  
> -ifdef CONFIG_X86
> -dml_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
> -dml_ccflags := $(dml_ccflags-y) -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -dml_ccflags := -mhard-float -maltivec
> -endif

And altivec is enabled in the flags there.

That doesn't match your implementation for powerpc in patch 7, which
only deals with float.

I suspect the AMD driver actually doesn't need altivec enabled, but I
don't know that for sure. It compiles without it, but I don't have a GPU
to actually test. I've added Timothy on Cc who added the support for
powerpc to the driver originally, hopefully he has a test system.

Anyway if that's true that it doesn't need altivec we should probably do
a lead-up patch that drops altivec from the AMD driver explicitly, eg.
as below.

cheers


diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 4ae4720535a5..0de16796466b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -92,11 +92,7 @@ void dc_fpu_begin(const char *function_name, const int line)
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP))
-			enable_kernel_vsx();
-		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
-			enable_kernel_altivec();
-		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			enable_kernel_fp();
 #elif defined(CONFIG_ARM64)
 		kernel_neon_begin();
@@ -125,11 +121,7 @@ void dc_fpu_end(const char *function_name, const int line)
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_end();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP))
-			disable_kernel_vsx();
-		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
-			disable_kernel_altivec();
-		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			disable_kernel_fp();
 #elif defined(CONFIG_ARM64)
 		kernel_neon_end();
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 6042a5a6a44f..554c39024a40 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -31,7 +31,7 @@ dml_ccflags := $(dml_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
-dml_ccflags := -mhard-float -maltivec
+dml_ccflags := -mhard-float
 endif
 
 ifdef CONFIG_ARM64
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index acff3449b8d7..7b51364084b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -30,7 +30,7 @@ dml2_ccflags := $(dml2_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
-dml2_ccflags := -mhard-float -maltivec
+dml2_ccflags := -mhard-float
 endif
 
 ifdef CONFIG_ARM64

