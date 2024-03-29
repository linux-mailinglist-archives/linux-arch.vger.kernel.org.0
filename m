Return-Path: <linux-arch+bounces-3318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E79A891435
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4031F222F5
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DE540BF2;
	Fri, 29 Mar 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W9Nr8Et4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942EB4086F
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697101; cv=none; b=F+QOIsI7t84ICS277QTrdP0x4O24rYYjihgnOZ1dT4IBPMbXxc/9nBHuSq3QOTheos4IS/5qnYR3E/NMxxewSmAEMVp2LWblUNwg/jqjZ4iSHPkxSYJk5Hrz15ICYwp2YoNC/WLlS4pGIdmIL9zvlnXykg9W1BRPHQemOUwp1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697101; c=relaxed/simple;
	bh=b0p3yNyhI4gS1UO6/7FtNHSLtx6SD/wV4pT5We/leTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/hTodbJbhvcby+/r2zQ4Zz2lfoRU72jAAZgmj95bIjAB02+n2wK4kTHdh6B9J78ncm+q9G37Wlwq8tXuQPg57blBsYS5KdX5FGsEbpXOgMz+VB7jmfyjoMPxcc+N2JZ+Ue8ylKrTJxx3qSS7UImGN/ozI2s2LqhbbtnHJB8cPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=W9Nr8Et4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eac64f2205so1527684b3a.2
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697099; x=1712301899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miBOSRWGIbztCOf3acmBaICqQz/+WnlSIiHBb+4Rl8M=;
        b=W9Nr8Et4E7CYYgCXsjROXWY+7psvqjEG+P6oATRtBEuCOvOUDiUXpO1oYQKwPh725t
         FFMzcQYn9hF3EdD2PIEh+Lpv6WzWeoZH7rejTzk9Hm97+xwK5DmfeOJ026lYqV3gwxAV
         CVkjLMj1RqPjZWsURZfw6K8yNPYMuQqvoTggVfh7YU8wyDkR809xfF/fzZzOW8uWXyrL
         XEuHlW9dy1xV99rvlZIjjhvAjE+AoxrB3TYYh8INRk8G9CsPU1CnqwGSpayz+d27YYzP
         u/T5+0tsjqz8Yt0hEsFtpqOdR0epwwhKAshtmgbFVXo2rhO5I1Ldknnj4pVQnP/H/rAe
         blkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697099; x=1712301899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miBOSRWGIbztCOf3acmBaICqQz/+WnlSIiHBb+4Rl8M=;
        b=KyiVJnFgvzvyTetuen3nX6x86Rm81kTlw/T22nXTy2gee7P4C8siANzOE9XgUbqPhU
         eETLSBOXEQJQQH7+61Dl/ESSPpa8qvcs4Yvpw8kBQfbKwKaX9k5TpoLn/JmqJodxY2Pa
         MPpQq9dgv70HDgzWhJdtChRlKU7RLDqsQRM+sPDXTltJ/M0cDN8+BgdTshTw/I2MVSTB
         /Bu5IiOc7JJ37+9/ILq7Iq37SUFZywY4cu5Pl+CqMKGmd1cWlSTeG2e3/mRYRBnB+Q3G
         ye+i3DHCHncDfrM2ZDJqz0JGWvi/6/0wKe1qbQsw1XXPydSDEpTe9xmaMsBVnqQp5NAz
         stMw==
X-Forwarded-Encrypted: i=1; AJvYcCWUZwV094HxzTdzukDYdxS6FgEBj77/H351SbrEGItohXe7M7OehvE3fbLW83gtTZ9d7bMcKgaOiL2+Vl+GNG2aSXyIPHlR17LNTA==
X-Gm-Message-State: AOJu0YxdWtGEAcIcz6VIKkSBD9K3LdAxBQmrk89Qv2N6nBMXExNNQWoo
	IDsA3gpJG1Ewiwy/6+3KJC62n4yosSr4sVZnfdkqU/9IKDT30UbVpfFKgjBAxyQ=
X-Google-Smtp-Source: AGHT+IHGvAdAnX/0WDZVeXS0a7ZQ/motGWeac64eqKBau0xYaG382zqiN+0tE34St5zugVtRmJL1tg==
X-Received: by 2002:a05:6a20:549c:b0:1a3:baad:d566 with SMTP id i28-20020a056a20549c00b001a3baadd566mr1487303pzk.40.1711697098883;
        Fri, 29 Mar 2024 00:24:58 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:24:53 -0700 (PDT)
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
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4 08/15] powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Fri, 29 Mar 2024 00:18:23 -0700
Message-ID: <20240329072441.591471-9-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
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

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
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
index 1c4be3373686..c42a57b6839d 100644
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
index 65261cbe5bfd..93d89f055b70 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -153,6 +153,9 @@ CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option, $(MULTIPLEWORD))
 
 CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
+CC_FLAGS_FPU		:= $(call cc-option,-mhard-float)
+CC_FLAGS_NO_FPU		:= $(call cc-option,-msoft-float)
+
 ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY
 KBUILD_CPPFLAGS	+= -DCC_USING_PATCHABLE_FUNCTION_ENTRY
@@ -174,7 +177,7 @@ asinstr := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
 
 KBUILD_CPPFLAGS	+= -I $(srctree)/arch/powerpc $(asinstr)
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
2.44.0


