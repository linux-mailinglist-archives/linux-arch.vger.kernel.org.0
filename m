Return-Path: <linux-arch+bounces-3310-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0969891421
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C191F222D1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D7F40844;
	Fri, 29 Mar 2024 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YLcJkY4U"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552B3FE2B
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697086; cv=none; b=e0V6e0udDiBjMOxTgJVLs36tbNkthF79dw04pPKfHaAkZSQFW1kkBzFm3JRKJtiGNZuleNxLPQTjfbtaqTBKK0Uayu4yl45I+RjcGiPguAqpOBaggKS8ULzoZwlqkaA8Ve6CebIUBlg5/LKCnTMwN5eryYYnq+qth3VEXPUq3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697086; c=relaxed/simple;
	bh=cDdC7qSNGUzpG6UlyjsDWPh/KILcYk93sgCXZ4m0Ofk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOzGAIzyahrkrk74fsJwvekAcTsF+9V0zDaMzYtS/YzV2WaHEtqm6y2DRz+mjtrV4/0jVId07BgbX1Z+wSgocdFNgS+ndnGbYbnW3lZHE1AdgQ8oBaCwA0dp2qf6t2e7Ki5qx6q/yIMUkFfSjeGHvTZ6I05EPh/ihYFX63xRDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YLcJkY4U; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so1486554b3a.2
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697083; x=1712301883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9VxbCTgzZ80UmziOWsKJFOvNNy0Qw1c5wWNUXcCD38=;
        b=YLcJkY4UcCZP2Sv7cyrOxbTbDPiTmg3zQVnqI9tkG4F+uEK1D/dYZcqHhcgX3Hg2Cc
         +YfiLQflU/vKxMN+a33TY9/5/G6wGUbip/bp/1SjWWIS0CfIIuqfRMZF4lhYgwPwKYiH
         6bwEfF2E6Pt3JyUXXAztgl0UkZf2kfE2etbYfMJBjE5Xr/N/7zHjyvJQzEFQ19s6VP+7
         hdLI5JHjBMCr6FluhOwvhfXhlqs6cUSgbyFaceBYrPg7vndZIVpMhi2+q9Bhj7x2H1MB
         La2W+rN/qL9Boc2DQOU6HXWjz9H/pCdRmOzGq3/HV3x8pqqbkO9263ySIy8AOvMn0Nz3
         0SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697083; x=1712301883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9VxbCTgzZ80UmziOWsKJFOvNNy0Qw1c5wWNUXcCD38=;
        b=fblmHdBup+Kd9IvFEnEcZY5MzkbZi8QQqRJP8oZ+fGBFE2uBnPb9QBkB2lVcPFHyEG
         AJgTKTmKwE+iBfzoXUa4FqM7mnSljN8IG9iKUfr9kx0Eii81zrcghSi7jrWOuwC2Uang
         7RMD4PORjiYdB7ATS1o9Ss1OJAA4v3PSocduTuQLSuTxqnlY7+1JjZ5OlGcBp1r4T+oQ
         Fs/LYWXZbdO9OAFN4dIKCMTjGTCh3lkQ+NMuF7wCrXKw2hiU8I8mvqgWanH3V3FlALQT
         ojnaOBx+qeYwqIjd9Ph4ZGwnpUFTMEmXSF0xDJ0mItdgxRJYiqAT16GJHHqmvTl+/N67
         66Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUS8mAy6lp+/aINeKomWq91t6Q9ikU4UAoEpqMRQJG3g/iLqypIXW/EJQX3rrd1CR3oN+ZQPtoPjDCglaYWnLlLl4ahEnqBdQ4f1w==
X-Gm-Message-State: AOJu0YzcVXpf5flN83xrmSQs0px2NxATMWEzY/dsmmYjIneBO9oFAFLB
	PAGlHfxzIo6B9M1Bzfo9MiVlmFZqrwcaeg3Nz6MptpNARSMQmgHXr2UOgI8xouw=
X-Google-Smtp-Source: AGHT+IEb5QR4f0wxokXnCFueIg3e5DUC8zxXcfXICifgdBJpQrnHEBOFNWDHzDiuuKhBOVbgthprFw==
X-Received: by 2002:a05:6a20:ce4d:b0:1a3:c460:1a4f with SMTP id id13-20020a056a20ce4d00b001a3c4601a4fmr1590367pzb.59.1711697083202;
        Fri, 29 Mar 2024 00:24:43 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:24:42 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH v4 00/15] Unified cross-architecture kernel-mode FPU API
Date: Fri, 29 Mar 2024 00:18:15 -0700
Message-ID: <20240329072441.591471-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series unifies the kernel-mode FPU API across several architectures
by wrapping the existing functions (where needed) in consistently-named
functions placed in a consistent header location, with mostly the same
semantics: they can be called from preemptible or non-preemptible task
context, and are not assumed to be reentrant. Architectures are also
expected to provide CFLAGS adjustments for compiling FPU-dependent code.
For the moment, SIMD/vector units are out of scope for this common API.

This allows us to remove the ifdeffery and duplicated Makefile logic at
each FPU user. It then implements the common API on RISC-V, and converts
a couple of users to the new API: the AMDGPU DRM driver, and the FPU
self test.

The underlying goal of this series is to allow using newer AMD GPUs
(e.g. Navi) on RISC-V boards such as SiFive's HiFive Unmatched. Those
GPUs need CONFIG_DRM_AMD_DC_FP to initialize, which requires kernel-mode
FPU support.

Previous versions:
v3: https://lore.kernel.org/linux-kernel/20240327200157.1097089-1-samuel.holland@sifive.com/
v2: https://lore.kernel.org/linux-kernel/20231228014220.3562640-1-samuel.holland@sifive.com/
v1: https://lore.kernel.org/linux-kernel/20231208055501.2916202-1-samuel.holland@sifive.com/
v0: https://lore.kernel.org/linux-kernel/20231122030621.3759313-1-samuel.holland@sifive.com/

Changes in v4:
 - Add missed CFLAGS changes for recov_neon_inner.c
   (fixes arm build failures)
 - Fix x86 include guard issue (fixes x86 build failures)

Changes in v3:
 - Rebase on v6.9-rc1
 - Limit riscv ARCH_HAS_KERNEL_FPU_SUPPORT to 64BIT

Changes in v2:
 - Add documentation explaining the built-time and runtime APIs
 - Add a linux/fpu.h header for generic isolation enforcement
 - Remove file name from header comment
 - Clean up arch/arm64/lib/Makefile, like for arch/arm
 - Remove RISC-V architecture-specific preprocessor check
 - Split altivec removal to a separate patch
 - Use linux/fpu.h instead of asm/fpu.h in consumers
 - Declare test_fpu() in a header

Michael Ellerman (1):
  drm/amd/display: Only use hard-float, not altivec on powerpc

Samuel Holland (14):
  arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
  ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
  arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
  lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
  LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  x86/fpu: Fix asm/fpu/types.h include guard
  x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  riscv: Add support for kernel-mode FPU
  drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
  selftests/fpu: Move FP code to a separate translation unit
  selftests/fpu: Allow building on other architectures

 Documentation/core-api/floating-point.rst     | 78 +++++++++++++++++++
 Documentation/core-api/index.rst              |  1 +
 Makefile                                      |  5 ++
 arch/Kconfig                                  |  6 ++
 arch/arm/Kconfig                              |  1 +
 arch/arm/Makefile                             |  7 ++
 arch/arm/include/asm/fpu.h                    | 15 ++++
 arch/arm/lib/Makefile                         |  3 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/Makefile                           |  9 ++-
 arch/arm64/include/asm/fpu.h                  | 15 ++++
 arch/arm64/lib/Makefile                       |  6 +-
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/Makefile                       |  5 +-
 arch/loongarch/include/asm/fpu.h              |  1 +
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/Makefile                         |  5 +-
 arch/powerpc/include/asm/fpu.h                | 28 +++++++
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/Makefile                           |  3 +
 arch/riscv/include/asm/fpu.h                  | 16 ++++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/kernel_mode_fpu.c           | 28 +++++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/Makefile                             | 20 +++++
 arch/x86/include/asm/fpu.h                    | 13 ++++
 arch/x86/include/asm/fpu/types.h              |  6 +-
 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 35 +--------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 36 +--------
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 36 +--------
 include/linux/fpu.h                           | 12 +++
 lib/Kconfig.debug                             |  2 +-
 lib/Makefile                                  | 26 +------
 lib/raid6/Makefile                            | 33 +++-----
 lib/test_fpu.h                                |  8 ++
 lib/{test_fpu.c => test_fpu_glue.c}           | 37 ++-------
 lib/test_fpu_impl.c                           | 37 +++++++++
 38 files changed, 348 insertions(+), 193 deletions(-)
 create mode 100644 Documentation/core-api/floating-point.rst
 create mode 100644 arch/arm/include/asm/fpu.h
 create mode 100644 arch/arm64/include/asm/fpu.h
 create mode 100644 arch/powerpc/include/asm/fpu.h
 create mode 100644 arch/riscv/include/asm/fpu.h
 create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c
 create mode 100644 arch/x86/include/asm/fpu.h
 create mode 100644 include/linux/fpu.h
 create mode 100644 lib/test_fpu.h
 rename lib/{test_fpu.c => test_fpu_glue.c} (71%)
 create mode 100644 lib/test_fpu_impl.c

-- 
2.44.0


