Return-Path: <linux-arch+bounces-3241-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A474088EFC2
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A93297B9C
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99B7154BF3;
	Wed, 27 Mar 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gPcp9vYv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C28154442
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569737; cv=none; b=dNMtEqBZaFD7TFpL0yV/fx6yIuVb2hfZXzkw8k4LLOm1cEiU0tIdH5IDaF5O+tF+HN1bBU+gPel5M0wJG+8ORtQRB41lyfiR0wq9e2+YQ4aDEHgNU2dwSOugSsuSv8ImaxCqIYIy0VTwPrLIJZxoQhyuFernh8/yK0oOsvEB+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569737; c=relaxed/simple;
	bh=g4mhkWbOPq5UTkZ8eyYBkXzUJ8zECj1QnaC6Culjcfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZ2xW6h5qqYM13REKqlkpElItf+/evcB+R9yGfRsL0tjLLD2I4Paxh7qPnzTDKHbCBXP+KY7/8hOnKxGUMOJK3RmsOVdxmbyF7F2lxbZQto3ROMzMERY1SEIWi1mtB9yBoXjAnPbsZN6xsWahB8pFDHzoq9WIzqcosB6uToImU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gPcp9vYv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1def3340682so2199265ad.1
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569735; x=1712174535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM3Hi+5Alr7tzqsz3KXbQamZzAJvK/Ux1AY7aws8WNM=;
        b=gPcp9vYv/QWPJ8uDrQ0o6MUAt6FwdJouyp6V3Z3ucB4Pj4HbDUXqi+x2WEVAZU29gH
         j3Ce7n/wzBvX346MjJp5QE1HgrmXb6ASRpOVSPzWDRky8d7DcqmUUs3nDJwJ3CQ4/uiy
         oj29p7SFDVeNLnsSYcZTwTQEEpUz6ZBs8E4sv+w1TfMdX4upoWAvU6W66zOo88r39g3m
         y15Wmnp4KtXkou6Kg+gJpxsQLP2nDlZdo0l2iV3yma4Ad3SOthAKbiNvtYCZb7o5K/HU
         8zZ6lmg6XxFSQ5ceFE4/BMLxxwtmgFwMQcIuXWM3CgYOqGJmJ9FQM5xZ+djmQGRqF1VT
         SWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569735; x=1712174535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM3Hi+5Alr7tzqsz3KXbQamZzAJvK/Ux1AY7aws8WNM=;
        b=wkGAoLhs8YboROJbDBB6uUyjqU/scgqBUl4Pgr8u6DzWOhsohblADOFIAs9/xULQ1C
         aUxTk9Cb8i7P42nADNEcGHywu9Jsxqyxh1I8WrBv5jFdmdTPhkhsRuAc0SX4jcIz9adw
         I5jhnb5JBsiBFOBIy7rQR+T9wDMqLPjjvQQVvqq8VhNq820UYzGcjtPPKv2R2gCXZRth
         VZyNGSIRPjl6vHbMNEWHwp/FVKkJ6lq8CaiE7lxrlZ10+nP/lVaE8Z5VyLag6GMlwhD3
         9pt1sEV7Ht+/9wvYVMWaYKImq/GrniaYwOtCWaSEIZsBmoCYL6Sc/1Do4Tht4VP3VkAN
         1Uhw==
X-Forwarded-Encrypted: i=1; AJvYcCVU4yUZSPHmKOQrY/OE3qq3KYm2UheqnqRspSHLIJQ4OSfQvrlaGGEGxNzsdA0dwJidlnLuVMCmTW7d0Up6nAp9AKYi3E3QOerwZA==
X-Gm-Message-State: AOJu0YxZVyYa+8LsQEouOhYkBVn+//eXXRmEacmHHBwcg0B6CtDpHtVE
	aMwtWyEnL5b5gwCv/mKHLDtQgJlysoAE5OAFjT0zxMSMMdLWrHfxWQA9S6U2j38=
X-Google-Smtp-Source: AGHT+IFj0bwxlMv24MtX2R4pKVUBPTEZabeDrpj2jWHiUrD8cnm8OWyltVVZB2eEjF0aA2RcWrF1Pw==
X-Received: by 2002:a17:902:e5c1:b0:1e0:c91d:4487 with SMTP id u1-20020a170902e5c100b001e0c91d4487mr958029plf.43.1711569735358;
        Wed, 27 Mar 2024 13:02:15 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:14 -0700 (PDT)
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
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 12/14] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Mar 2024 13:00:43 -0700
Message-ID: <20240327200157.1097089-13-samuel.holland@sifive.com>
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

Now that all previously-supported architectures select
ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
of the existing list of architectures. It can also take advantage of the
common kernel-mode FPU API and method of adjusting CFLAGS.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Split altivec removal to a separate patch
 - Use linux/fpu.h instead of asm/fpu.h in consumers

 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 27 ++------------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 36 ++-----------------
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 36 ++-----------------
 4 files changed, 7 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 901d1961b739..5fcd4f778dc3 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -8,7 +8,7 @@ config DRM_AMD_DC
 	depends on BROKEN || !CC_IS_CLANG || ARM64 || RISCV || SPARC64 || X86_64
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
-	select DRM_AMD_DC_FP if (X86 || LOONGARCH || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
+	select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && (!ARM64 || !CC_IS_CLANG)
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 0de16796466b..e46f8ce41d87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -26,16 +26,7 @@
 
 #include "dc_trace.h"
 
-#if defined(CONFIG_X86)
-#include <asm/fpu/api.h>
-#elif defined(CONFIG_PPC64)
-#include <asm/switch_to.h>
-#include <asm/cputable.h>
-#elif defined(CONFIG_ARM64)
-#include <asm/neon.h>
-#elif defined(CONFIG_LOONGARCH)
-#include <asm/fpu.h>
-#endif
+#include <linux/fpu.h>
 
 /**
  * DOC: DC FPU manipulation overview
@@ -87,16 +78,9 @@ void dc_fpu_begin(const char *function_name, const int line)
 	WARN_ON_ONCE(!in_task());
 	preempt_disable();
 	depth = __this_cpu_inc_return(fpu_recursion_depth);
-
 	if (depth == 1) {
-#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
+		BUG_ON(!kernel_fpu_available());
 		kernel_fpu_begin();
-#elif defined(CONFIG_PPC64)
-		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
-			enable_kernel_fp();
-#elif defined(CONFIG_ARM64)
-		kernel_neon_begin();
-#endif
 	}
 
 	TRACE_DCN_FPU(true, function_name, line, depth);
@@ -118,14 +102,7 @@ void dc_fpu_end(const char *function_name, const int line)
 
 	depth = __this_cpu_dec_return(fpu_recursion_depth);
 	if (depth == 0) {
-#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_end();
-#elif defined(CONFIG_PPC64)
-		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
-			disable_kernel_fp();
-#elif defined(CONFIG_ARM64)
-		kernel_neon_end();
-#endif
 	} else {
 		WARN_ON_ONCE(depth < 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 59d3972341d2..a94b6d546cd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -25,40 +25,8 @@
 # It provides the general basic services required by other DAL
 # subcomponents.
 
-ifdef CONFIG_X86
-dml_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
-dml_ccflags := $(dml_ccflags-y) -msse
-endif
-
-ifdef CONFIG_PPC64
-dml_ccflags := -mhard-float
-endif
-
-ifdef CONFIG_ARM64
-dml_rcflags := -mgeneral-regs-only
-endif
-
-ifdef CONFIG_LOONGARCH
-dml_ccflags := -mfpu=64
-dml_rcflags := -msoft-float
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifneq ($(call gcc-min-version, 70100),y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-dml_ccflags += -mpreferred-stack-boundary=4
-else
-dml_ccflags += -msse2
-endif
-endif
+dml_ccflags := $(CC_FLAGS_FPU)
+dml_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
 ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index 7b51364084b5..4f6c804a26ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -24,40 +24,8 @@
 #
 # Makefile for dml2.
 
-ifdef CONFIG_X86
-dml2_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
-dml2_ccflags := $(dml2_ccflags-y) -msse
-endif
-
-ifdef CONFIG_PPC64
-dml2_ccflags := -mhard-float
-endif
-
-ifdef CONFIG_ARM64
-dml2_rcflags := -mgeneral-regs-only
-endif
-
-ifdef CONFIG_LOONGARCH
-dml2_ccflags := -mfpu=64
-dml2_rcflags := -msoft-float
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-dml2_ccflags += -mpreferred-stack-boundary=4
-else
-dml2_ccflags += -msse2
-endif
-endif
+dml2_ccflags := $(CC_FLAGS_FPU)
+dml2_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
 ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
-- 
2.43.1


