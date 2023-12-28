Return-Path: <linux-arch+bounces-1188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB8381F3CD
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 02:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018D6B20BB4
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A06FA5;
	Thu, 28 Dec 2023 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BbKQqXFT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601116FDD
	for <linux-arch@vger.kernel.org>; Thu, 28 Dec 2023 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce2170b716so1758510a12.1
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727753; x=1704332553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FK4PuyaVW5o+fowKBsFSathMMiGJoXogQryv4/PrHo=;
        b=BbKQqXFTK++DKEuGj9P3e2CGoRG8JjIO6etW74ul2DUvIJt4YDmRlhWEyvPjNcP9/N
         19Wl2ocg3VECXfkqfOUITfWn5VPr1O+C8WDHxaRPZD1hZ0/GS0kgMs7jeelDpfv90ctV
         Hy5iGIzSElfzu3eUWkc/06X2WwpCaY+8rCgfwd/Rw+FkAECXs80ccTVSnACEVpRagyNt
         S4Mq0PUAmmpenOaJnqTVeGwz0bfjof7ESD2pWH8wL3VQ+s9x3PLny5f0HHDxLYOXJ3t8
         a3e0P4Z8zbCd2gquDx7XokKpWyGD3kZ6CQYEGqABsFCTCD/OrgFDA/moV+C8Zjj4+pyx
         TKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727753; x=1704332553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FK4PuyaVW5o+fowKBsFSathMMiGJoXogQryv4/PrHo=;
        b=ik1K5ebVqd7niWJzQJWo+ORbFEVZec/0PC3oXWm27H2+g2AJBEvwNqB0g15+qvxpZV
         Pi9aAeoD6ZV6hOwJtP52PAR8a6zOb3ZI61ffJMgjWrDwAc7ee6xrZc04cG2pWfw97tKy
         Eg3fFe/MWnfl7pU1gvtXfiGJB0c7VOVBM+INPN7kuL84mpY/0+N632680MzePE7pb796
         bex86lsloyarR9lHrN79FV1ekK+zLGX8u6YLiq2EtZ4lcw7Nsm/ncfoEac8pXJoJREAw
         AfUC8hX1k7kpFcUTgh9Jlt807KFWO/PXbhOyS+5BEuzRW4EWx4n62ouQcV5/Y1LVN3SS
         h4lA==
X-Gm-Message-State: AOJu0YztNLGcOG791woXt2noel1pP6yQ0xZy1Y0+7o117xchxceb0cBE
	DKgZdmBcjKgbklDE/ZQRUPzOWS20ZE30bw==
X-Google-Smtp-Source: AGHT+IGDcwpDNI+ACJS8JwK6slMdt2P3zgEqkBXVCA8XIoKmVvXUWVJm0n6YvZtcZMejj6VORWJ3pQ==
X-Received: by 2002:a05:6a21:612:b0:194:f17b:f877 with SMTP id ll18-20020a056a21061200b00194f17bf877mr9226487pzb.61.1703727752746;
        Wed, 27 Dec 2023 17:42:32 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:32 -0800 (PST)
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
Subject: [PATCH v2 08/14] powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Dec 2023 17:41:58 -0800
Message-ID: <20231228014220.3562640-9-samuel.holland@sifive.com>
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

PowerPC provides an equivalent to the common kernel-mode FPU API, but in
a different header and using different function names. The PowerPC API
also requires a non-preemptible context. Add a wrapper header, and
export the CFLAGS adjustments.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/Makefile          |  5 ++++-
 arch/powerpc/include/asm/fpu.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/fpu.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6f105ee4f3cf..e96cb5b7c571 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -137,6 +137,7 @@ config PPC
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_HUGEPD			if HUGETLB_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT	if PPC_FPU
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEMREMAP_COMPAT_ALIGN	if PPC_64S_HASH_MMU
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index f19dbaa1d541..91106970a8c1 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -142,6 +142,9 @@ CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option, $(MULTIPLEWORD))
 
 CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
+CC_FLAGS_FPU		:= $(call cc-option,-mhard-float)
+CC_FLAGS_NO_FPU		:= $(call cc-option,-msoft-float)
+
 ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY
 KBUILD_CPPFLAGS	+= -DCC_USING_PATCHABLE_FUNCTION_ENTRY
@@ -163,7 +166,7 @@ asinstr := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
 
 KBUILD_CPPFLAGS	+= -I $(srctree)/arch/$(ARCH) $(asinstr)
 KBUILD_AFLAGS	+= $(AFLAGS-y)
-KBUILD_CFLAGS	+= $(call cc-option,-msoft-float)
+KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU)
 KBUILD_CFLAGS	+= $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
diff --git a/arch/powerpc/include/asm/fpu.h b/arch/powerpc/include/asm/fpu.h
new file mode 100644
index 000000000000..ca584e4bc40f
--- /dev/null
+++ b/arch/powerpc/include/asm/fpu.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef _ASM_POWERPC_FPU_H
+#define _ASM_POWERPC_FPU_H
+
+#include <linux/preempt.h>
+
+#include <asm/cpu_has_feature.h>
+#include <asm/switch_to.h>
+
+#define kernel_fpu_available()	(!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+
+static inline void kernel_fpu_begin(void)
+{
+	preempt_disable();
+	enable_kernel_fp();
+}
+
+static inline void kernel_fpu_end(void)
+{
+	disable_kernel_fp();
+	preempt_enable();
+}
+
+#endif /* ! _ASM_POWERPC_FPU_H */
-- 
2.42.0


