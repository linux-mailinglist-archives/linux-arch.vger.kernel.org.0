Return-Path: <linux-arch+bounces-1190-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C681F3D2
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 02:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F1D1C217A4
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 01:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B06109;
	Thu, 28 Dec 2023 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R36n+Nhx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B76AA2
	for <linux-arch@vger.kernel.org>; Thu, 28 Dec 2023 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bb9b28acb4so2874560b6e.2
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727755; x=1704332555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lB3PwOsXsU0eA+wVy54fia689m8tbEsIcyHsrS82lA=;
        b=R36n+Nhxv2ci/t7udVXZLBbXXNdq+2qk4+dSW/KR48C9REzX+GNf1WuMlFuHzE7AJI
         Bt0QG4ouo5TvpSX+PpCTXpBeYh8XO2hG0TXxZJG4H2zHNHZkQGoz5mUBDiu769b5X+Xm
         G9Za+MuMqsJrE8IE4gJ9M1oGSTc5W7TeQin1Hml5GpqosqXr/dhyqeQ4CfK4GC3gxP4o
         kNtOA8oHTB6nkFG9pqDpnkAG5F+TUMxovUVHoa0yUZMUWrBD8l8mxmJIKeVMWxR1Lv09
         8eaD7oFgk3Wicha4tbOy4PjIxdbVjFLLjlZ39QsF07AaEnfX8sO29FMOYW+AoftaRl+W
         7T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727755; x=1704332555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lB3PwOsXsU0eA+wVy54fia689m8tbEsIcyHsrS82lA=;
        b=AlNF+dJyi8n1XIxDtsjtr2+GiidOEeIMzO5ONlYU69UnOKeNAWvGD0ak8okyaajIkc
         ndJYUFGOA9VHkAgZUOUS5qFWB9OKl5108ulhLP9mHhqiEHp0MUncyTQNT+SwUpt9e1TW
         mi3xRH4MIJ0qvf5YUsIDn2WflIpDybtVa4Lk1bydLm9gxuPuKFtHFf/nLUFms24gd/eD
         UruYqNMJz9iDWVE33eph9NLK2ptP2hN8g81+ndizQsGp1GdHV8tny4F9lk0bjOY7EAkf
         tyqvaPsgkfzXNR1Dfm7r6cRjD12oAYOBmARMC7Y/DbLQDm/tqRZ7DdATIttvJQl2dqHZ
         VCgg==
X-Gm-Message-State: AOJu0YyPeoCeZ5UAjIO56GHvwWKXLWsNt+FabmP5Rl+eashhq5p+J8of
	MFIZ1ghdgRayUEfIXbgMxVuErFQbZpZihg==
X-Google-Smtp-Source: AGHT+IGOumGBELysHMV6R76DMfrPeDaWnM5H7Bg8VEJaO8mkFNmjt6T/b5crzc3IAojRuB/OVWCSfQ==
X-Received: by 2002:a05:6358:9213:b0:174:cf3a:749 with SMTP id d19-20020a056358921300b00174cf3a0749mr9824262rwb.36.1703727755495;
        Wed, 27 Dec 2023 17:42:35 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:35 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 10/14] riscv: Add support for kernel-mode FPU
Date: Wed, 27 Dec 2023 17:42:00 -0800
Message-ID: <20231228014220.3562640-11-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231228014220.3562640-1-samuel.holland@sifive.com>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is motivated by the amdgpu DRM driver, which needs floating-point
code to support recent hardware. That code is not performance-critical,
so only provide a minimal non-preemptible implementation for now.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Remove RISC-V architecture-specific preprocessor check

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Makefile                 |  3 +++
 arch/riscv/include/asm/fpu.h        | 16 ++++++++++++++++
 arch/riscv/kernel/Makefile          |  1 +
 arch/riscv/kernel/kernel_mode_fpu.c | 28 ++++++++++++++++++++++++++++
 5 files changed, 49 insertions(+)
 create mode 100644 arch/riscv/include/asm/fpu.h
 create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 24c1799e2ec4..4d4d1d64ce34 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -27,6 +27,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if FPU
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index a74be78678eb..2e719c369210 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -81,6 +81,9 @@ KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64i
 
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
+# For C code built with floating-point support, exclude V but keep F and D.
+CC_FLAGS_FPU  := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)([^v_]*)v?/\1\2/')
+
 KBUILD_CFLAGS += -mno-save-restore
 KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
 
diff --git a/arch/riscv/include/asm/fpu.h b/arch/riscv/include/asm/fpu.h
new file mode 100644
index 000000000000..91c04c244e12
--- /dev/null
+++ b/arch/riscv/include/asm/fpu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef _ASM_RISCV_FPU_H
+#define _ASM_RISCV_FPU_H
+
+#include <asm/switch_to.h>
+
+#define kernel_fpu_available()	has_fpu()
+
+void kernel_fpu_begin(void);
+void kernel_fpu_end(void);
+
+#endif /* ! _ASM_RISCV_FPU_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fee22a3d1b53..662c483e338d 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
+obj-$(CONFIG_FPU)		+= kernel_mode_fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/riscv/kernel/kernel_mode_fpu.c b/arch/riscv/kernel/kernel_mode_fpu.c
new file mode 100644
index 000000000000..0ac8348876c4
--- /dev/null
+++ b/arch/riscv/kernel/kernel_mode_fpu.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#include <linux/export.h>
+#include <linux/preempt.h>
+
+#include <asm/csr.h>
+#include <asm/fpu.h>
+#include <asm/processor.h>
+#include <asm/switch_to.h>
+
+void kernel_fpu_begin(void)
+{
+	preempt_disable();
+	fstate_save(current, task_pt_regs(current));
+	csr_set(CSR_SSTATUS, SR_FS);
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+
+void kernel_fpu_end(void)
+{
+	csr_clear(CSR_SSTATUS, SR_FS);
+	fstate_restore(current, task_pt_regs(current));
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_end);
-- 
2.42.0


