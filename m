Return-Path: <linux-arch+bounces-3239-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF988EFBD
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4282A29F583
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A76154424;
	Wed, 27 Mar 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cFsvDM3u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F52153BD9
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569734; cv=none; b=kkqSDJcMOMqh7I9RBYzNJjCnrnsb/ZtNr5IlTzSNmr4fikj0rZv1ps7u21mCqKrHrF6An9kCeeKviP400O46tdPEyz5Pe2KwQAEshmqM4DPBiqntr44wkfIVz0Cxedw6a+egDMtwyhnsQYglijvQrjilW3HP5+dHFMCOcBuN5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569734; c=relaxed/simple;
	bh=D6H+zfohyEBjWK7u8MlCfJa00G/AECIZNSXMg7mgjSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG/R9QYCE192d1Yd1CVA/gXY4YOdyG9UIvr0n+syZAmIxhmhXhxtZ8PQAqMilEqUfEhmdtCrGde7HshR5g6HJ/MgPtboeSaUgh/ZcNp7ukVMzqNAlQr78W6o6w6S20y4UIYRfg2MWLwQypWdYo8oxd2D95rmc19u0rkqRfhk3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cFsvDM3u; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0d8403257so2162415ad.1
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569732; x=1712174532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGWc9ebaY2QC87evSRTtIDPTTKODWYBNdAFlf6sP+x8=;
        b=cFsvDM3ur9SJxx0hQBb8eyFb7Ufq4lsaUSiRrERC7eJuRqPGqI6BQso4U865sz5uOv
         P725SmFzzkx4lDG7RGZhBvRpgD9y6wiirhwyoAXl2X/5fYTAKeyx/N3GqaWMC/DiZkvw
         W/NRgsfZiMxUMl0g/ViLX9LMS33VeuCXYiDoxNb80zoAF60hucvl8b5frEFZQg6hOpKJ
         50amoL31Lxe/jSjuS9PUjYGuwtPT8ecqVRvDj9dH9L5OOeevOEkN8jMFf7m7uM63nlMH
         RCbZQUWV6m7WVR/vRdNUPGm1eFy+P/Zo3zkuLToaIstuoDftyFYSaeasOyg0MEdPuaUW
         RyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569732; x=1712174532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGWc9ebaY2QC87evSRTtIDPTTKODWYBNdAFlf6sP+x8=;
        b=vqgBmYwR5z68NGDt507TJ94iOTkTjHqAmdMUkCNsmhYHcYshAbvGN1ZW8rOmTvI3kj
         MAUFpP0XAOMjhReVER2knupvC72TZZlBIUr2A3wKvdTgjL3AOAlXko2XkTQtFWtFVu2z
         BB9EuI8aaFZ1CSvphvHkPMdKBrySmV2JfZxV4GETJH5eEjG8phlUnf7t5bzjCh0OJQmI
         pttC6arSIh8TwhqVHaXccBKVqr4rb3W1ehmU7XClV+EDJGpvaIrw61w83WknzrM2ln7s
         rmtFFnIfoWFNTro1J3iYNiQb6UXyUjUHvVLaxh/zOJmz6kKrw9YeINvz3T9czP4425CN
         kPyg==
X-Forwarded-Encrypted: i=1; AJvYcCXHoyPfr3zYAKLTMYfEButTdStlqNTytxcawZcn/knDCuJPnAkfg5v88dkroB+2y1BYDvi8QhHncY2eQFUn/h1Asph+/1huetzO/Q==
X-Gm-Message-State: AOJu0YxobnHAVZeaWr1Fk47iLRwLOl20PLf9fJtD9ZFEqbkTtLKAuWA/
	8V8J2Pwww1wRlP16WpAc+vJ/1/bRHCS5LNokSlcZ5fsFzI5EnctK8VRiFJ1Mxrs=
X-Google-Smtp-Source: AGHT+IF/XXLIIHj+pdeHOeaQpfwKr83x+9g91i//d+1nB1dHcUYu9bI9urgKfRLt2peRxnrkYrSQjA==
X-Received: by 2002:a17:902:ec92:b0:1e0:73d:9175 with SMTP id x18-20020a170902ec9200b001e0073d9175mr916865plg.45.1711569732549;
        Wed, 27 Mar 2024 13:02:12 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:12 -0700 (PDT)
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
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 10/14] riscv: Add support for kernel-mode FPU
Date: Wed, 27 Mar 2024 13:00:41 -0700
Message-ID: <20240327200157.1097089-11-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
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

Support is limited to riscv64 because riscv32 requires runtime (libgcc)
assistance to convert between doubles and 64-bit integers.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Rebase on v6.9-rc1
 - Limit ARCH_HAS_KERNEL_FPU_SUPPORT to 64BIT

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
index be09c8836d56..3bcd0d250810 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -27,6 +27,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if 64BIT && FPU
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MMIOWB
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 252d63942f34..76ff4033c854 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -84,6 +84,9 @@ KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64i
 
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
index 81d94a8ee10f..5b243d46f4b1 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
 obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
 
 obj-$(CONFIG_FPU)		+= fpu.o
+obj-$(CONFIG_FPU)		+= kernel_mode_fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
 obj-$(CONFIG_SMP)		+= smpboot.o
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
2.43.1


