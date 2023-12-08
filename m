Return-Path: <linux-arch+bounces-790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB25809BFF
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 06:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C63B20E54
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 05:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC716FA5;
	Fri,  8 Dec 2023 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AHmyGEfx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DE21737
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 21:55:14 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d05212a7c5so13052285ad.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 21:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014914; x=1702619714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYvZSY93/xrjeeL5ETwAXbtukKNXxCCQ4+T0woOWU40=;
        b=AHmyGEfxc3LH7QLB/XcbwdIp1OfktJXk8rSFWe5BEOz3ExHQDJ3iiIGlnZiHfPwkuv
         VVLQ+cbpSbgDfHoXvxvJoiuwiQA20H/57xjh4HgRx/qp+qAe52IUcntWbwRP3LFmsyG+
         6VMY0aGz1+5pZsupP0QCYDdUkYydQBKkOGaIDJm4E+zlClexqG53Bbo5TAeQqn+yF78t
         4rHfIEmiop/8EvTaPKQi51s/nD1JcrpE0xSwAj8OMEWEWuFc4CQBeCfMJF2UILJPLwUE
         +0zcCHx0gTh1v+9OH0f4a1HpCyjFNJ0VSPiJL46MpuCp/iHSshq/kkFf2oPJuJC/+brZ
         TSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014914; x=1702619714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYvZSY93/xrjeeL5ETwAXbtukKNXxCCQ4+T0woOWU40=;
        b=IaWQ7o6/HEEarxpZTaUWgs7hT1jMWt7DjFC3C1iX2DA+IrXz6753d4Q4bFXh1z6hC+
         G92POIrM7Q7cpaYg5DVkfzhfkOztIy0+3qQr6S/XL36C1x0b5tgRkbWEw9GynzODywEd
         ntA/3L1MFLG14qmJsxRwBImtr4/PTe8APZ8nKuxjnML5z65j+bX3pegimmsiMKY7IdZu
         NB29KDVAQ40frMOY6XdtulNtbBVfvXGW6+v6riZ8g7yiTtjMFF07txcL/mN+T2jBXjqN
         0BYk2fAqS1x1Z0N96SAi85i6K1IsAIBkFzKuKK9zwn9fJJiOgT40qAAwRbTfz10oQ/t2
         HsjQ==
X-Gm-Message-State: AOJu0Yw/gRXZpKrcKv183olHxnqjZOpGos/m30PhblOp7QP+5u99JwzV
	Gxi4ZXbQRDiPnJlQ3O2WvM/enA==
X-Google-Smtp-Source: AGHT+IEX6fsur3fhby/cWKLu/7STh1pjdXEZxMWOcghK1shSxSRPNcFQAcmIt0ejFquarrBp9mMVPA==
X-Received: by 2002:a17:902:e541:b0:1d0:a084:affd with SMTP id n1-20020a170902e54100b001d0a084affdmr3001010plf.73.1702014913936;
        Thu, 07 Dec 2023 21:55:13 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:13 -0800 (PST)
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
Subject: [RFC PATCH 09/12] riscv: Add support for kernel-mode FPU
Date: Thu,  7 Dec 2023 21:54:39 -0800
Message-ID: <20231208055501.2916202-10-samuel.holland@sifive.com>
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

This is motivated by the amdgpu DRM driver, which needs floating-point
code to support recent hardware. That code is not performance-critical,
so only provide a minimal non-preemptible implementation for now.

Use a similar trick as ARM to force placing floating-point code in a
separate translation unit, so it is not possible for compiler-generated
floating-point code to appear outside kernel_fpu_{begin,end}().

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Makefile                 |  3 +++
 arch/riscv/include/asm/fpu.h        | 26 ++++++++++++++++++++++++++
 arch/riscv/kernel/Makefile          |  1 +
 arch/riscv/kernel/kernel_mode_fpu.c | 28 ++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+)
 create mode 100644 arch/riscv/include/asm/fpu.h
 create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..cf0967928e6d 100644
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
index 000000000000..8cd027acc015
--- /dev/null
+++ b/arch/riscv/include/asm/fpu.h
@@ -0,0 +1,26 @@
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
+#ifdef __riscv_f
+
+#define kernel_fpu_begin() \
+	static_assert(false, "floating-point code must use a separate translation unit")
+#define kernel_fpu_end() kernel_fpu_begin()
+
+#else
+
+void kernel_fpu_begin(void);
+void kernel_fpu_end(void);
+
+#endif
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
index 000000000000..9b2024cc056b
--- /dev/null
+++ b/arch/riscv/kernel/kernel_mode_fpu.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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


