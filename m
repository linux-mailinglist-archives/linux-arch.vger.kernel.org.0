Return-Path: <linux-arch+bounces-3325-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9325D891445
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67FC1C218FE
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3B6A013;
	Fri, 29 Mar 2024 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Cu5VI3LT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E965E20
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697109; cv=none; b=d5yy9J7j+wjgXkclJ9TIAqTOCsxLuBbOsbEaQRqr6bd9Sccgqe2hbiL4rd+LezWa27VQU12eZ9l78n7Cg8tdI8r0F+zcPA/fXET3g4IZeIvlEbqqG8TGzEltvSJuCETT0cUnDT4GLLrrPctSxIjDKeap8mKiz+XltYe3Ej8Odrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697109; c=relaxed/simple;
	bh=/RMV6EvjfbMDeh8AAAKCcDfR7SkW64DSoezNtrIFGmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHoxuzBmNr0LYW3OqKvFLz9quR1Jd8hYWxIRBim7RkzzPgNfJOx2mohDA5GTvavWjG4i4/do9iGDXwb7cUgAwTdpd+hdAT0AslJI4mNiXtSaLAPHd4fbGbRiX0xP7Hu15+llldHwx3hMXUwZW7/UAD0Z3/nHiL8Lnla6e7dXWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Cu5VI3LT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29dee60302fso2013247a91.1
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697108; x=1712301908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd7UwvCa9oMHOiIEhQpk6/wRs60SiO2oLPgpnvXy/o4=;
        b=Cu5VI3LTXLsWnzJZr16aULBeoGYvllWpLE7OISDoerEZotowO2K8zzVzVCSz1X4Wpq
         T+F8nl3Xjy93hK4yLiFZUXiozBkIWuQpaT/DebCnc9lXB32QgB6kyeO2+3vV6rt0oFu1
         qnHmz/Nc/8rzkkzZSwW1UXWFSUFZ5Jpmd9LmuB0i4iFi6ZJ5vZy54dvqHC9NyASHetnH
         bu6aZ+RPcR8o6xao06C6eBqnDUJKC3apQBeKP/stGLhAnUUG97Jo7V9wME194m2HUlP/
         iSSByguZa8P5D1EhFqxPTY6oeEqtiEXZzcsAqYbopcto3ow3olxr33hkDznm/8ratXFp
         KHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697108; x=1712301908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd7UwvCa9oMHOiIEhQpk6/wRs60SiO2oLPgpnvXy/o4=;
        b=P4qnAac5W6Ju+p5sKkgXH9Ze0vHE0RDSMT73JHilr/N/kFWUYAwQpuDHS5mU0OvbXZ
         HI005Qfeu+/af3K/nK3zSA0q1ZQ3o9vp7SeLeWbc5cgA4rpbJ/Gj7GbVtoTYwSfvMjWM
         yLCDEDiO3+p+4A0WBV3O8WApJ9Q6XNcz5sqJpSF0Zv6KpGmI+ru1oC2knF7qdTx7+/Iy
         10EiDAdDhDUcc7eEkxSXfBZUwOjsP/fXGfcFma3QJ0LvigXehz8WOdqAMnVJ08tocqbd
         H0ynjPImMOyPNY85wMxuz6gIO1yRpp4mnkh2AoXBp6xVHoNTd3v5THto9lUSlrP5VuM7
         NcxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTRQK0s4fr6bUPIrCoIKbFDSmRA3KPIBfAtCbFRoTRW/Z3/34/qB6Vzl13aOiRbecw4tXFgHK8TIFgFaCOAAI7+a2L8PF8tEPalg==
X-Gm-Message-State: AOJu0YzwqCnTATHOemTZC2RgEy2cYQDrUmMdhmys6umpUAvHTbrY/pKc
	mJB6cbfQbB48Aod+W3KzRKxOWNjO7dk02UfK0f/wD7LKVUs5K4Rgc5u5TzSvF44=
X-Google-Smtp-Source: AGHT+IHxypVhChIzRiQ/e47hMPrNYQnLhNujXyM1QCssN6f6ZMhSHIBGzyaKpY86BExy9FwELnwgHw==
X-Received: by 2002:a17:90b:1c06:b0:29d:f52c:5d40 with SMTP id oc6-20020a17090b1c0600b0029df52c5d40mr2496570pjb.15.1711697107768;
        Fri, 29 Mar 2024 00:25:07 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:25:07 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 15/15] selftests/fpu: Allow building on other architectures
Date: Fri, 29 Mar 2024 00:18:30 -0700
Message-ID: <20240329072441.591471-16-samuel.holland@sifive.com>
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

Now that ARCH_HAS_KERNEL_FPU_SUPPORT provides a common way to compile
and run floating-point code, this test is no longer x86-specific.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 lib/Kconfig.debug   |  2 +-
 lib/Makefile        | 25 ++-----------------------
 lib/test_fpu_glue.c |  5 ++++-
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c63a5fbf1f1c..f93e778e0405 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2890,7 +2890,7 @@ config TEST_FREE_PAGES
 
 config TEST_FPU
 	tristate "Test floating point operations in kernel space"
-	depends on X86 && !KCOV_INSTRUMENT_ALL
+	depends on ARCH_HAS_KERNEL_FPU_SUPPORT && !KCOV_INSTRUMENT_ALL
 	help
 	  Enable this option to add /sys/kernel/debug/selftest_helpers/test_fpu
 	  which will trigger a sequence of floating point operations. This is used
diff --git a/lib/Makefile b/lib/Makefile
index fcb35bf50979..e44ad11f77b5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -110,31 +110,10 @@ CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
 
-#
-# CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
-# off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
-# get appended last to CFLAGS and thus override those previous compiler options.
-#
-FPU_CFLAGS := -msse -msse2
-ifdef CONFIG_CC_IS_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
-#
-# The "-msse" in the first argument is there so that the
-# -mpreferred-stack-boundary=3 build error:
-#
-#  -mpreferred-stack-boundary=3 is not between 4 and 12
-#
-# can be triggered. Otherwise gcc doesn't complain.
-FPU_CFLAGS += -mhard-float
-FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
-endif
-
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
 test_fpu-y := test_fpu_glue.o test_fpu_impl.o
-CFLAGS_test_fpu_impl.o += $(FPU_CFLAGS)
+CFLAGS_test_fpu_impl.o += $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_test_fpu_impl.o += $(CC_FLAGS_NO_FPU)
 
 # Some KUnit files (hooks.o) need to be built-in even when KUnit is a module,
 # so we can't just use obj-$(CONFIG_KUNIT).
diff --git a/lib/test_fpu_glue.c b/lib/test_fpu_glue.c
index 85963d7be826..eef282a2715f 100644
--- a/lib/test_fpu_glue.c
+++ b/lib/test_fpu_glue.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
-#include <asm/fpu/api.h>
+#include <linux/fpu.h>
 
 #include "test_fpu.h"
 
@@ -38,6 +38,9 @@ static struct dentry *selftest_dir;
 
 static int __init test_fpu_init(void)
 {
+	if (!kernel_fpu_available())
+		return -EINVAL;
+
 	selftest_dir = debugfs_create_dir("selftest_helpers", NULL);
 	if (!selftest_dir)
 		return -ENOMEM;
-- 
2.44.0


