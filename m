Return-Path: <linux-arch+bounces-1242-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0116822F6B
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 15:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBD286B1D
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C11A59C;
	Wed,  3 Jan 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe4kYOdz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B01A594;
	Wed,  3 Jan 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2046c724383so1923701fac.1;
        Wed, 03 Jan 2024 06:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704292078; x=1704896878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a349tfFo0Tz6+yladu1vGz3cOOaSViS9QyeDAzXiKtI=;
        b=Pe4kYOdzNeudFCkX8EA3GZYLfLIBH/DxnRNGN9VRkKB2osQEUuTPCFVKtG6dH3wzfO
         v6ieCWQibeCoMAtWb5me/rE1eVapEY8Xu0jgk/AQ3T10yg/xauSPo9PkN++BKOQpGg0R
         Ad/J3ejqiMHpyZldi6JRuAxtbukPpJTE5biENr1xMDs6u1aR7ym4iDDDbXGIuGxj+LpO
         hg55fi3X13H5hWsaZWBf7PwM/e1/+cpybqYusLJd410p2ga7v7n4a7wlAvmejSBTExAR
         vzisuQ5N/Am24sdb05KppAyvoVs8zwRdplQJVN7qTEya5yuHhot3t2YXAgveIwB9wimD
         z9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704292078; x=1704896878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a349tfFo0Tz6+yladu1vGz3cOOaSViS9QyeDAzXiKtI=;
        b=vhz+CMT0RS+3L7l28AyjfaiAKjqPSl4cUmF1ESVSjBlDruPe0W/BS44flr6cJVAJo3
         31XpZrslcyU1G28g53NqpmJVo7ehW0vQngALEwMisaIdUBgsY7zsQL1J5sX6IRM3OSnC
         uhBkfbaHCf4LGGuBjtAZMrGlZmK8TWAavoHOzYJO4lAtiODIBPnZbr3QPQd/OwQ+8aHF
         uuMRHz+FJjG1OrQLyWHkE3TfMFNNZ1Il7X3ZxIjevOw7fK0EzW9x/2eyX36K3FXsUc7w
         bWl0NDaxhe/2M0fxK20vxkTehCC3WOEO8GPrc8lAWPvqepKCldilzPPRaG4wek5Z79uP
         6FPw==
X-Gm-Message-State: AOJu0Yxq1yPb6qCg3quqTbsVcn71w3RE3UfJt9/r0Ihu9MOwaeXReOwy
	CO8CC3GI5D4oxxscUTGrsPMkne8cqzFSd3P8/Wc=
X-Google-Smtp-Source: AGHT+IHjuxm+WsGold4msvLzUcwvASXsLbNWaImZQEtNmF+UM28LD4T6ctfH3u7LonFz90aecPkvdKH3c/Z8VWiEa/Q=
X-Received: by 2002:a05:6871:2b02:b0:204:32f7:6668 with SMTP id
 dr2-20020a0568712b0200b0020432f76668mr8870200oac.34.1704292078704; Wed, 03
 Jan 2024 06:27:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
In-Reply-To: <20231228014220.3562640-1-samuel.holland@sifive.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:27:47 -0500
Message-ID: <CADnq5_Pub0UULb6UqO2g+Eo6RCy=gqtWLN9txjEyp2Gmw9idww@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Unified cross-architecture kernel-mode FPU API
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	x86@kernel.org, linux-riscv@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 5:11=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Previous versions:
> v1: https://lore.kernel.org/linux-kernel/20231208055501.2916202-1-samuel.=
holland@sifive.com/
> v0: https://lore.kernel.org/linux-kernel/20231122030621.3759313-1-samuel.=
holland@sifive.com/
>
> Changes in v2:
>  - Add documentation explaining the built-time and runtime APIs
>  - Add a linux/fpu.h header for generic isolation enforcement
>  - Remove file name from header comment
>  - Clean up arch/arm64/lib/Makefile, like for arch/arm
>  - Remove RISC-V architecture-specific preprocessor check
>  - Split altivec removal to a separate patch
>  - Use linux/fpu.h instead of asm/fpu.h in consumers
>  - Declare test_fpu() in a header
>
> Michael Ellerman (1):
>   drm/amd/display: Only use hard-float, not altivec on powerpc
>
> Samuel Holland (13):
>   arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
>   ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>   ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
>   arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>   arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
>   lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
>   LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>   powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>   x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>   riscv: Add support for kernel-mode FPU
>   drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
>   selftests/fpu: Move FP code to a separate translation unit
>   selftests/fpu: Allow building on other architectures
>
>  Documentation/core-api/floating-point.rst     | 78 +++++++++++++++++++
>  Documentation/core-api/index.rst              |  1 +
>  Makefile                                      |  5 ++
>  arch/Kconfig                                  |  6 ++
>  arch/arm/Kconfig                              |  1 +
>  arch/arm/Makefile                             |  7 ++
>  arch/arm/include/asm/fpu.h                    | 15 ++++
>  arch/arm/lib/Makefile                         |  3 +-
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/Makefile                           |  9 ++-
>  arch/arm64/include/asm/fpu.h                  | 15 ++++
>  arch/arm64/lib/Makefile                       |  6 +-
>  arch/loongarch/Kconfig                        |  1 +
>  arch/loongarch/Makefile                       |  5 +-
>  arch/loongarch/include/asm/fpu.h              |  1 +
>  arch/powerpc/Kconfig                          |  1 +
>  arch/powerpc/Makefile                         |  5 +-
>  arch/powerpc/include/asm/fpu.h                | 28 +++++++
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/Makefile                           |  3 +
>  arch/riscv/include/asm/fpu.h                  | 16 ++++
>  arch/riscv/kernel/Makefile                    |  1 +
>  arch/riscv/kernel/kernel_mode_fpu.c           | 28 +++++++
>  arch/x86/Kconfig                              |  1 +
>  arch/x86/Makefile                             | 20 +++++
>  arch/x86/include/asm/fpu.h                    | 13 ++++
>  drivers/gpu/drm/amd/display/Kconfig           |  2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 35 +--------
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 36 +--------
>  drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 36 +--------
>  include/linux/fpu.h                           | 12 +++
>  lib/Kconfig.debug                             |  2 +-
>  lib/Makefile                                  | 26 +------
>  lib/raid6/Makefile                            | 31 ++------
>  lib/test_fpu.h                                |  8 ++
>  lib/{test_fpu.c =3D> test_fpu_glue.c}           | 37 ++-------
>  lib/test_fpu_impl.c                           | 37 +++++++++
>  37 files changed, 343 insertions(+), 190 deletions(-)
>  create mode 100644 Documentation/core-api/floating-point.rst
>  create mode 100644 arch/arm/include/asm/fpu.h
>  create mode 100644 arch/arm64/include/asm/fpu.h
>  create mode 100644 arch/powerpc/include/asm/fpu.h
>  create mode 100644 arch/riscv/include/asm/fpu.h
>  create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c
>  create mode 100644 arch/x86/include/asm/fpu.h
>  create mode 100644 include/linux/fpu.h
>  create mode 100644 lib/test_fpu.h
>  rename lib/{test_fpu.c =3D> test_fpu_glue.c} (71%)
>  create mode 100644 lib/test_fpu_impl.c
>
> --
> 2.42.0
>

