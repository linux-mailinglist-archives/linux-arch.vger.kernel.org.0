Return-Path: <linux-arch+bounces-781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBA8809BF4
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 06:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CDC1F21334
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 05:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F385A6FA6;
	Fri,  8 Dec 2023 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P08wfLhZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6A171D
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 21:55:03 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d04c097e34so14168995ad.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 21:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014903; x=1702619703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIC4glHzB+IOAGM7YCu4gQFdGXeLpWj/I7OZVSGOh7k=;
        b=P08wfLhZLVp03l/oDHQYVEsEgGHxNL73uQkfOF2REHD8CU/xGIjVdn6TTfwt7Z9Acq
         yc5mEZY6+zMF9WUpEkK2U3S1uISA2BG89ANRwcL4lHxC8Rh4VHKLZ3ajdOYMgS5ABoht
         UiFsalaJpQLxpgJROK1FFOjdCKzyxqIqj+Lqmk5HmOytUWQGFIwNv2BPFL+JSuhOvm5D
         Gao/0wdYqjQsQm5cY7zKoOKpv/TZ1raGHI8hieOaLnNUnvI+CHfmj9SRa3ijwjmhw7QD
         lo3SeRnwnr/5YPMJfY75InwAzTKn5kuuqEtzcz+qVTdzwsPw/TvhNGb9TU/DdOxBGXIf
         VYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014903; x=1702619703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIC4glHzB+IOAGM7YCu4gQFdGXeLpWj/I7OZVSGOh7k=;
        b=PVzTxNrDprYOo5bBdDofEoRItswkKxhTJV8VKPZRl8Z8YyPldWYsqgIlx6nVR8/d/9
         BMgfX41cWQU0EVWDv0fTSwjjj9nMhSGNvTB3p2NhI2TuxlATybEd/15hMySH7GppnfMG
         k6pQ3jEnfIyPrpg6I3yP2pos7lXhKnctVOfBW7NAi0QWv6UH6mBgy1OW9mBKFaeT806k
         h3pVXYOgIcbwED6CzxhZJjV4qJ7T/vZNgckL3sVH0oD8o59tvIlKrujhB5imMFhDnz4Q
         huXWQGWKdZnKmEbRnzkeDh7nfZb5k1hRI97MXs/RfifATS5WmoqjylmMmG9a7BDpz4TQ
         PL3A==
X-Gm-Message-State: AOJu0YwGlsa+KhRBs1yRvuZi0Vyw8TS4dIIdRB2W9MHWS0vGgr8DPdZH
	kM/6IJpJSXDlTfX2Byxp8WHvRQ==
X-Google-Smtp-Source: AGHT+IHobgnIbAqUwh0qy5g87XS9Ops6tA3mZ0Tbbi2vny+WXvVENlMrplaMBh4oGzh2rC3HGh0NRQ==
X-Received: by 2002:a17:902:c20c:b0:1d0:6ffd:610c with SMTP id 12-20020a170902c20c00b001d06ffd610cmr481032pll.46.1702014902890;
        Thu, 07 Dec 2023 21:55:02 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:02 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 00/12] Unified cross-architecture kernel-mode FPU API
Date: Thu,  7 Dec 2023 21:54:30 -0800
Message-ID: <20231208055501.2916202-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series supersedes my earier RISC-V specific series[1].

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

[1]: https://lore.kernel.org/linux-riscv/20231122030621.3759313-1-samuel.holland@sifive.com/


Samuel Holland (12):
  arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
  ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
  arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
  LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  riscv: Add support for kernel-mode FPU
  drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
  selftests/fpu: Move FP code to a separate translation unit
  selftests/fpu: Allow building on other architectures

 Makefile                                      |  4 ++
 arch/Kconfig                                  |  9 +++++
 arch/arm/Kconfig                              |  1 +
 arch/arm/Makefile                             |  7 ++++
 arch/arm/include/asm/fpu.h                    | 17 +++++++++
 arch/arm/lib/Makefile                         |  3 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/Makefile                           |  9 ++++-
 arch/arm64/include/asm/fpu.h                  | 17 +++++++++
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/Makefile                       |  5 ++-
 arch/loongarch/include/asm/fpu.h              |  1 +
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/Makefile                         |  5 ++-
 arch/powerpc/include/asm/fpu.h                | 28 ++++++++++++++
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/Makefile                           |  3 ++
 arch/riscv/include/asm/fpu.h                  | 26 +++++++++++++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/kernel_mode_fpu.c           | 28 ++++++++++++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/Makefile                             | 20 ++++++++++
 arch/x86/include/asm/fpu.h                    | 13 +++++++
 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 33 +----------------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 36 +-----------------
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 36 +-----------------
 lib/Kconfig.debug                             |  2 +-
 lib/Makefile                                  | 26 ++-----------
 lib/raid6/Makefile                            | 31 ++++------------
 lib/{test_fpu.c => test_fpu_glue.c}           | 37 +++----------------
 lib/test_fpu_impl.c                           | 35 ++++++++++++++++++
 32 files changed, 255 insertions(+), 185 deletions(-)
 create mode 100644 arch/arm/include/asm/fpu.h
 create mode 100644 arch/arm64/include/asm/fpu.h
 create mode 100644 arch/powerpc/include/asm/fpu.h
 create mode 100644 arch/riscv/include/asm/fpu.h
 create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c
 create mode 100644 arch/x86/include/asm/fpu.h
 rename lib/{test_fpu.c => test_fpu_glue.c} (71%)
 create mode 100644 lib/test_fpu_impl.c

-- 
2.42.0


