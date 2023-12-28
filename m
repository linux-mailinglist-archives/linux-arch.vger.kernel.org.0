Return-Path: <linux-arch+bounces-1182-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D86A81F3BE
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 02:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094DD2826D6
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 01:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D8D23B7;
	Thu, 28 Dec 2023 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hrprsTQ7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481417F7
	for <linux-arch@vger.kernel.org>; Thu, 28 Dec 2023 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so3360871b3a.2
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727745; x=1704332545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuiZ+dA63qa6KuTRM/9EMSF12UiDXQURMhZ59hCd4g8=;
        b=hrprsTQ71tPBhB2Fb/uL9FCkSQ7BtyqZJrmMSgxTQxDECXYvzerZcG5VXtzqhIhvk8
         VHTf336LUSs3GJ8YczHMGB6xTrkQGjCf1NA9gOiq1bEMfMA70gCy13o0fqeg0LAnPBlX
         bqfySVi47x95fL3M5cUDfJmhRMetJXHR3uhzCSeDlm3Bi+7s0ikAa55hhPxK70GiZoUY
         cnfga12XDILrBR0P7wblA5Z6DAj8MW+dJ9Ov3wP2BEGNfpgri9DimtrN0+ZVN+FEsmR3
         lunUaE5XV4gSo7HKgNB32RexxF4VjJkjmEooeo5jF8gVNkVIlDbLSBhRRLNhCT+TpyLp
         2c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727745; x=1704332545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuiZ+dA63qa6KuTRM/9EMSF12UiDXQURMhZ59hCd4g8=;
        b=BhwPXSUQE7g82Omikp4xEqCy4xlxYw59jCAr6chlS7gCkd4R8KzQ9pfhXCI6dqfuh+
         f4eqCZV82UPZT5FVoXzhUhmBaeaFlzqtXZhV0E7ThUzu+VAQuWmf1kXqW/dLzN+jAzYB
         j9t9Hlfo8Bgzu2ofhOS1NifgSGdbJz3YQHnVjGGhzQzxz9INm9KqAo6HgQ2nKZ+8qCaB
         UsR9J7+26sD7san73CXyxPQ/B71KLAYdPi+Xmgmrk1Kb2JOP3szJNaEOZYHOHlnUwHKS
         dNjtPhUwM9vmR0LPk0Ntn7DTUt87FJpeptRWNCX5lsM2n16211SlU2ZUNFdkwlhfP/X8
         knMQ==
X-Gm-Message-State: AOJu0YzSAlKVwYQusDWkrwSVg7JpcRccp3XeMi9eiNzPNDfTvVTFMWvL
	Kr6PL6luMywNJ6VdvB8cXGDK25lCYJ8lKA==
X-Google-Smtp-Source: AGHT+IEILlR72JmnZxJTq7QER4Rq98IUb8qZ6aLblKynPh8gjQmZYjrM9YnZu6dduDjff4jpI/ud3w==
X-Received: by 2002:aa7:9142:0:b0:6d9:cbb1:7818 with SMTP id 2-20020aa79142000000b006d9cbb17818mr4021989pfi.20.1703727745150;
        Wed, 27 Dec 2023 17:42:25 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:24 -0800 (PST)
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
Subject: [PATCH v2 02/14] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Dec 2023 17:41:52 -0800
Message-ID: <20231228014220.3562640-3-samuel.holland@sifive.com>
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

ARM provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Remove file name from header comment

 arch/arm/Kconfig           |  1 +
 arch/arm/Makefile          |  7 +++++++
 arch/arm/include/asm/fpu.h | 15 +++++++++++++++
 3 files changed, 23 insertions(+)
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
index 000000000000..2ae50bdce59b
--- /dev/null
+++ b/arch/arm/include/asm/fpu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
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


