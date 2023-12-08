Return-Path: <linux-arch+bounces-789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25474809BFD
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 06:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06461F212D6
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 05:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D80A7460;
	Fri,  8 Dec 2023 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T4LqkHlr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086B1733
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 21:55:13 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d04d286bc0so13129575ad.3
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 21:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014912; x=1702619712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOdH6gQ2/kSr11qF6anDkZP04y2oGGJwChsMHemqfok=;
        b=T4LqkHlraVGMzq4C9tWiv8BniomaaUN0FsEXm/RKku0Y5B7y0fPRi1ZQycLzyVP+0T
         IHZ0KKRXegLktdCL8wQpOigg1hzXyG0Fz4BXDxfWLPffxhqCHZEDogY/hO8fn9bAbLb7
         x8VUn4CTv6a21gYTRxMoTNw2CY7FvLNyba3L4EdLCEgxUZSRQGsnS1jKsSHvZh9OQYTG
         YRmz1T4U+c+XzwmhOgwFh4Io9cyrrIiEUf7TjeDEPiRsKpJ5PyQ5p8GJ1DwZwOWN8Okk
         PsdM4+U3fxLvx7l35UejxLDN9Xm98edMr5ZgoYi70LOXuLMtEUpdG6zNBUri8pNK+SQM
         iDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014912; x=1702619712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOdH6gQ2/kSr11qF6anDkZP04y2oGGJwChsMHemqfok=;
        b=jY4twnYd4GtVVFXspwgjBcW1pbFWf349A2KMGqOAdNLKTzJBCL+40ItCROSLW3aakQ
         VHiW08wrwmgJy/ImA5nLHnYOe+5lQ/Azjz1zSzopMb8RcxJDaxMrBeIgmUMrnY8h25U4
         ThDh7BeA/FxkInB9h59B41qp8HLqibpSg/d73vNeY1wlV6L/bBTiCaO3ewJrDCi7Oy7s
         FcnUx2zuecwILOIiP6QvDtBCLq4GXg1MmDzp9iAeky46bjK9VNCfNXf49wgfXxfs5MUE
         pALnDbyvcH7NtH1pElOXRAls111gwMhCJR/G1ZzaJPzdGd7NQFKtNPq7tWKI89uUCPQD
         xZnA==
X-Gm-Message-State: AOJu0YztAEUbIygoj8J6IYgirpDIWTvCH+KuPSDxmwWf1riNtxVbOm8U
	lWh79hbaBZwViXcWsGNKYmq0jg==
X-Google-Smtp-Source: AGHT+IF6KW8xi8WlWkg/kkkF64YaWdAU9w8XTSDFOxfj/W9T6fcHp2B4VJ43fwnOYGHYYluHTLhnIQ==
X-Received: by 2002:a17:902:64d0:b0:1d2:eea4:a7d7 with SMTP id y16-20020a17090264d000b001d2eea4a7d7mr180399pli.5.1702014912711;
        Thu, 07 Dec 2023 21:55:12 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:12 -0800 (PST)
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
Subject: [RFC PATCH 08/12] x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Thu,  7 Dec 2023 21:54:38 -0800
Message-ID: <20231208055501.2916202-9-samuel.holland@sifive.com>
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

x86 already provides kernel_fpu_begin() and kernel_fpu_end(), but in a
different header. Add a wrapper header, and export the CFLAGS
adjustments as found in lib/Makefile.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/x86/Kconfig           |  1 +
 arch/x86/Makefile          | 20 ++++++++++++++++++++
 arch/x86/include/asm/fpu.h | 13 +++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/x86/include/asm/fpu.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..1fe7f2d8d017 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -81,6 +81,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de12a56..71576c8dbe79 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -70,6 +70,26 @@ export BITS
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
 
+#
+# CFLAGS for compiling floating point code inside the kernel.
+#
+CC_FLAGS_FPU := -msse -msse2
+ifdef CONFIG_CC_IS_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
+# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
+#
+# The "-msse" in the first argument is there so that the
+# -mpreferred-stack-boundary=3 build error:
+#
+#  -mpreferred-stack-boundary=3 is not between 4 and 12
+#
+# can be triggered. Otherwise gcc doesn't complain.
+CC_FLAGS_FPU += -mhard-float
+CC_FLAGS_FPU += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
+endif
+
 ifeq ($(CONFIG_X86_KERNEL_IBT),y)
 #
 # Kernel IBT has S_CET.NOTRACK_EN=0, as such the compilers must not generate
diff --git a/arch/x86/include/asm/fpu.h b/arch/x86/include/asm/fpu.h
new file mode 100644
index 000000000000..b2743fe19339
--- /dev/null
+++ b/arch/x86/include/asm/fpu.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef _ASM_X86_FPU_H
+#define _ASM_X86_FPU_H
+
+#include <asm/fpu/api.h>
+
+#define kernel_fpu_available()	true
+
+#endif /* ! _ASM_X86_FPU_H */
-- 
2.42.0


