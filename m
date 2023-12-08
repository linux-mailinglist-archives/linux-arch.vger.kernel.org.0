Return-Path: <linux-arch+bounces-782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6FB809BF5
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 06:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083071C20CCF
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 05:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9266FC7;
	Fri,  8 Dec 2023 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JmSewdVo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C64172A
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 21:55:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d048c171d6so15672155ad.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 21:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014905; x=1702619705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S9qeMKPrbOjny9ys0DNZnwzZdal5DwwFbQdO5IaRKs=;
        b=JmSewdVoGFeZo1lHvmaUjEUWED6zUvdSOdnZKKiVDvRmaKzwFw1wS3fNMK7qQfsq89
         PhA5q2a0ux/z0wXFMvjO7gjdZ35qeHz4Duaf5bVDnGnvmGR3CZIwtD5FeqXMT58pZ0F/
         mot7nAJQFljqLP7pBFPOkpOAD9nFJC4Vl9bY6oxK9dVTmPoIhkCvSNy3/nouXQdk/5U3
         tuDppz4hALl7NJZe/7VyXTTbQX3cHLy98yaDSABf2TBxUhESkrWJXpQ4WV3W66ZI+X7G
         7Ky8Q6GeOOrqjWcQ+2lCrA1bNmAIO66T79pWGg2HdA6+u92QngLmnHfwppUr0QM8hj+t
         K7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014905; x=1702619705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9S9qeMKPrbOjny9ys0DNZnwzZdal5DwwFbQdO5IaRKs=;
        b=iGw4cdmZkOgXckq5v4mLfXbiseBP3T/2V8AJLPREtTartjpa5n0Io5HKOqf7xuDGLq
         toNidNE+EgztMuvANWLZq6yF3oKaHu0C69JBdYovgLoGXktOiAxOAy+LSWtYKPeBFbog
         EqL+T8s0YVYWpkuiT7T69CzeuM4q7MwYCgQWqIQlMaTvm6z52V0VA3K0So2J2Y2glLAX
         uv+28UZnDlu4TLx49H4yGnKF+rFUjmmn87YB/Q1JpDLX+O6MlLM/6aCN44QPhwZ66hiS
         zWyvyw0mG/ZcMaTMuymTDNicxPesMXqCZUc+GLGL7MiaLy3aXejgDBViAxPr40l7hAR/
         852w==
X-Gm-Message-State: AOJu0Yzo9oCUSjETNWbaP23QHhtQ/kPFJvrTq2OwDXvzzWDn+B0E/Emg
	1DWLxu15F9/qPs7lce1Ruwa6cgp0grg0bu6DTwU=
X-Google-Smtp-Source: AGHT+IHfVmDuQcwcTNkJBCCNyd1od5dj0sgf6cJP7ZkJkjT+CFkpOEIDhByDVUVjY+z9LFISOIDfEQ==
X-Received: by 2002:a17:902:6844:b0:1cf:b190:ea07 with SMTP id f4-20020a170902684400b001cfb190ea07mr2955137pln.21.1702014905389;
        Thu, 07 Dec 2023 21:55:05 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:05 -0800 (PST)
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
Subject: [RFC PATCH 02/12] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Thu,  7 Dec 2023 21:54:32 -0800
Message-ID: <20231208055501.2916202-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208055501.2916202-1-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/arm/Kconfig           |  1 +
 arch/arm/Makefile          |  7 +++++++
 arch/arm/include/asm/fpu.h | 17 +++++++++++++++++
 3 files changed, 25 insertions(+)
 create mode 100644 arch/arm/include/asm/fpu.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f8567e95f98b..92e21a4a2903 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -14,6 +14,7 @@ config ARM
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5ba42f69f8ce..1dd860dba5f5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -130,6 +130,13 @@ endif
 # Accept old syntax despite ".syntax unified"
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
 
+# The GCC option -ffreestanding is required in order to compile code containing
+# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
+CC_FLAGS_FPU	:= -ffreestanding
+# Enable <arm_neon.h>
+CC_FLAGS_FPU	+= -isystem $(shell $(CC) -print-file-name=include)
+CC_FLAGS_FPU	+= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
+
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 CFLAGS_ISA	:=-Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
diff --git a/arch/arm/include/asm/fpu.h b/arch/arm/include/asm/fpu.h
new file mode 100644
index 000000000000..d01ca06e700a
--- /dev/null
+++ b/arch/arm/include/asm/fpu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * linux/arch/arm/include/asm/fpu.h
+ *
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef __ASM_FPU_H
+#define __ASM_FPU_H
+
+#include <asm/neon.h>
+
+#define kernel_fpu_available()	cpu_has_neon()
+#define kernel_fpu_begin()	kernel_neon_begin()
+#define kernel_fpu_end()	kernel_neon_end()
+
+#endif /* ! __ASM_FPU_H */
-- 
2.42.0


