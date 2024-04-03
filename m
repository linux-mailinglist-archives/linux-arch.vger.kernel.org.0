Return-Path: <linux-arch+bounces-3377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A9896F67
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 14:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEF71F2974F
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D10A1474AD;
	Wed,  3 Apr 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKSsvjLp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208371419BA;
	Wed,  3 Apr 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148672; cv=none; b=VUGTJbZ6SLNi8h7Bz14sKR/EsDyysWItPx4ZtqSs2n28Ef07x7CJUY3iHy3/3gSpPdSxoqoyeg2+LNcUo/XCWeVW8taral8k34g/NRQKDy2aZ824F2RrDL9u8VtHOESxPn5Yq8+eFmQPZwcXmK0Gk+SwJ8r7AGQ4vSLMBvsIsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148672; c=relaxed/simple;
	bh=zwy5/UeNKw0rdFTNUIENurIiqNiqQ2OzHWaKd+hx69E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCiEOOoSVq06tOmvJQibRuYZv+0GOgQhX2d/F8ktP57j1LvOC2dudHA8xH4n8I2LPnQF1rJiTFFpCE5kQWLxyY6FOe1PDARjrLAP3f0VbNc8FBpELmLg+FwC4uUKATUWzmhw2WmKPeeMfatzTc6IKNlxr8YP4QoTTzH/EuQms1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKSsvjLp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-416262d747dso717435e9.0;
        Wed, 03 Apr 2024 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712148669; x=1712753469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29BgQt41fxpDRMixAlECbaCmewv1mm5rdtRovSAulMA=;
        b=IKSsvjLp0pJJD2zzd42kk8JKagUJBhyhBAbjFRxMcnVC69OY+OmP3vSc+uBBbzoKwo
         qyjcDHAEPDimmutVqfD2UK8TPYcdUSLswOHb6t7OuvpMdTAEhSkvBtv+Vyc0VRzEXg77
         xRyY63/Jaubow1Fko4loce8URvZgTriZHa3LILOSwAOUuZ22rH863YQcL1tgGlI0iLQE
         8dcOwyalOwzZBS6P3DyPgamV/ouMX93NZfcoZBePxuVnmYBOn31xyfT1x9gxE2BHoGjY
         gX/SVQ51YDIIgd3TGiFmKfo8Cf5I7fw1Bh8qbRH5EdkNcWH1cU+cTRr2A5wbFIfuzXeE
         8LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712148669; x=1712753469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29BgQt41fxpDRMixAlECbaCmewv1mm5rdtRovSAulMA=;
        b=ANO5y9mj4fTiF+3he8HNrJEYRh3AYs+oSBNQUrsd/pMFxU/rSrFGR1ZYoUW5kWEPOb
         d42xhxAONMH3lioFvlQxcdiV8aieRUeFSqFqG0PRo1CGoqKQT6V6D2V6Ryw0SDnmy12L
         jKS0Le/4z6lreRN1zYLiRdw6qNdgOMeIggo8ntTqIuqj6CkHTyGR8L387CnyUyAbtvP1
         cYNsvAIgGUaEN85IyXr+3bd2dMQd/9JpE8ZuC7K20Vnoc+0FAPbj06HbpSVOS1pkKWGk
         BKf17qz8p0f+zhg7i+6x7o0y1X+ffPwImN9rJHfVMViEsaENlwGL0W/IJG0ZKVESLivc
         iJpA==
X-Forwarded-Encrypted: i=1; AJvYcCVeBqG7IYbGwrNarsNgrJEs/lDNRU/C9LTqpwlVfuQyI1Emk9/+7f201Ke2jBa/Xs47Gr6pAl9e8tBM2u81hRxJ/KmFBflU3blif0a+SmmNIQCanbp3LFKUXTYj185lhXnSxI3JI9GSg2eLd8gvTgB2L91R2cwif/KZ7TP6YWWya3Shjg==
X-Gm-Message-State: AOJu0YxI5yfO2XiPv3Mb5x7XPgYG7BGQr9rQP6vz5zZBgLax60jYYhXm
	OpMMXCSd4s/DJkUXIhK510vEH1TEjpn/J+YXMSnF1MlV/Ukki9cr
X-Google-Smtp-Source: AGHT+IGiMxFFkzEMKwErZDGMsEh8QQujgECEb7hAYrnmXSB8PanQ6hfDeg6f6lJ/1vv3KfoIi9fU0w==
X-Received: by 2002:a05:600c:5710:b0:414:9103:e38c with SMTP id jv16-20020a05600c571000b004149103e38cmr10494666wmb.22.1712148669149;
        Wed, 03 Apr 2024 05:51:09 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id dj11-20020a0560000b0b00b003437799a373sm3724238wrb.83.2024.04.03.05.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 05:51:08 -0700 (PDT)
Message-ID: <0c95aa84-63e6-41be-8c70-3a6dadefd682@gmail.com>
Date: Wed, 3 Apr 2024 14:51:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] Unified cross-architecture kernel-mode FPU API
To: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Russell King <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, "Wentland, Harry" <Harry.Wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I only skimmed over the platform patches and spend only a few minutes on 
the amdgpu stuff.

 From what I've seen this series seems to make perfect sense to me, I 
just can't fully judge everything.

So feel free to add Acked-by: Christian König <christian.koenig@amd.com> 
but I strongly suggest that Harry and Rodrigo take a look as well.

Regards,
Christian.

Am 29.03.24 um 08:18 schrieb Samuel Holland:
> This series unifies the kernel-mode FPU API across several architectures
> by wrapping the existing functions (where needed) in consistently-named
> functions placed in a consistent header location, with mostly the same
> semantics: they can be called from preemptible or non-preemptible task
> context, and are not assumed to be reentrant. Architectures are also
> expected to provide CFLAGS adjustments for compiling FPU-dependent code.
> For the moment, SIMD/vector units are out of scope for this common API.
>
> This allows us to remove the ifdeffery and duplicated Makefile logic at
> each FPU user. It then implements the common API on RISC-V, and converts
> a couple of users to the new API: the AMDGPU DRM driver, and the FPU
> self test.
>
> The underlying goal of this series is to allow using newer AMD GPUs
> (e.g. Navi) on RISC-V boards such as SiFive's HiFive Unmatched. Those
> GPUs need CONFIG_DRM_AMD_DC_FP to initialize, which requires kernel-mode
> FPU support.
>
> Previous versions:
> v3: https://lore.kernel.org/linux-kernel/20240327200157.1097089-1-samuel.holland@sifive.com/
> v2: https://lore.kernel.org/linux-kernel/20231228014220.3562640-1-samuel.holland@sifive.com/
> v1: https://lore.kernel.org/linux-kernel/20231208055501.2916202-1-samuel.holland@sifive.com/
> v0: https://lore.kernel.org/linux-kernel/20231122030621.3759313-1-samuel.holland@sifive.com/
>
> Changes in v4:
>   - Add missed CFLAGS changes for recov_neon_inner.c
>     (fixes arm build failures)
>   - Fix x86 include guard issue (fixes x86 build failures)
>
> Changes in v3:
>   - Rebase on v6.9-rc1
>   - Limit riscv ARCH_HAS_KERNEL_FPU_SUPPORT to 64BIT
>
> Changes in v2:
>   - Add documentation explaining the built-time and runtime APIs
>   - Add a linux/fpu.h header for generic isolation enforcement
>   - Remove file name from header comment
>   - Clean up arch/arm64/lib/Makefile, like for arch/arm
>   - Remove RISC-V architecture-specific preprocessor check
>   - Split altivec removal to a separate patch
>   - Use linux/fpu.h instead of asm/fpu.h in consumers
>   - Declare test_fpu() in a header
>
> Michael Ellerman (1):
>    drm/amd/display: Only use hard-float, not altivec on powerpc
>
> Samuel Holland (14):
>    arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
>    ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>    ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
>    arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>    arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
>    lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
>    LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>    powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>    x86/fpu: Fix asm/fpu/types.h include guard
>    x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>    riscv: Add support for kernel-mode FPU
>    drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
>    selftests/fpu: Move FP code to a separate translation unit
>    selftests/fpu: Allow building on other architectures
>
>   Documentation/core-api/floating-point.rst     | 78 +++++++++++++++++++
>   Documentation/core-api/index.rst              |  1 +
>   Makefile                                      |  5 ++
>   arch/Kconfig                                  |  6 ++
>   arch/arm/Kconfig                              |  1 +
>   arch/arm/Makefile                             |  7 ++
>   arch/arm/include/asm/fpu.h                    | 15 ++++
>   arch/arm/lib/Makefile                         |  3 +-
>   arch/arm64/Kconfig                            |  1 +
>   arch/arm64/Makefile                           |  9 ++-
>   arch/arm64/include/asm/fpu.h                  | 15 ++++
>   arch/arm64/lib/Makefile                       |  6 +-
>   arch/loongarch/Kconfig                        |  1 +
>   arch/loongarch/Makefile                       |  5 +-
>   arch/loongarch/include/asm/fpu.h              |  1 +
>   arch/powerpc/Kconfig                          |  1 +
>   arch/powerpc/Makefile                         |  5 +-
>   arch/powerpc/include/asm/fpu.h                | 28 +++++++
>   arch/riscv/Kconfig                            |  1 +
>   arch/riscv/Makefile                           |  3 +
>   arch/riscv/include/asm/fpu.h                  | 16 ++++
>   arch/riscv/kernel/Makefile                    |  1 +
>   arch/riscv/kernel/kernel_mode_fpu.c           | 28 +++++++
>   arch/x86/Kconfig                              |  1 +
>   arch/x86/Makefile                             | 20 +++++
>   arch/x86/include/asm/fpu.h                    | 13 ++++
>   arch/x86/include/asm/fpu/types.h              |  6 +-
>   drivers/gpu/drm/amd/display/Kconfig           |  2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 35 +--------
>   drivers/gpu/drm/amd/display/dc/dml/Makefile   | 36 +--------
>   drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 36 +--------
>   include/linux/fpu.h                           | 12 +++
>   lib/Kconfig.debug                             |  2 +-
>   lib/Makefile                                  | 26 +------
>   lib/raid6/Makefile                            | 33 +++-----
>   lib/test_fpu.h                                |  8 ++
>   lib/{test_fpu.c => test_fpu_glue.c}           | 37 ++-------
>   lib/test_fpu_impl.c                           | 37 +++++++++
>   38 files changed, 348 insertions(+), 193 deletions(-)
>   create mode 100644 Documentation/core-api/floating-point.rst
>   create mode 100644 arch/arm/include/asm/fpu.h
>   create mode 100644 arch/arm64/include/asm/fpu.h
>   create mode 100644 arch/powerpc/include/asm/fpu.h
>   create mode 100644 arch/riscv/include/asm/fpu.h
>   create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c
>   create mode 100644 arch/x86/include/asm/fpu.h
>   create mode 100644 include/linux/fpu.h
>   create mode 100644 lib/test_fpu.h
>   rename lib/{test_fpu.c => test_fpu_glue.c} (71%)
>   create mode 100644 lib/test_fpu_impl.c
>


