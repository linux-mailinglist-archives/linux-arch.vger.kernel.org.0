Return-Path: <linux-arch+bounces-793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A66B809C01
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 06:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AB71F21148
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 05:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503DE6FD0;
	Fri,  8 Dec 2023 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lZnJZmFp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E09F1733
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 21:55:18 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d05199f34dso13366775ad.3
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 21:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014917; x=1702619717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcpcBg9iqyFf2P75H/RgUfyoTRLcpINzc/uQQUbU4hE=;
        b=lZnJZmFpO73Gds/A3Nw/akhAFVxsBby192xlde+DD9+nmu1fLqTHMSDc97iflP25Ov
         297O84DoCDaYJKNSAc/TMg52Mr9m3RpMVru3dW0mLnJFc/H7z1EKiwuAF6q7yVr9uwwO
         wrj40NjPuPQ2TlUIDm74y1AfBfGx7fHLcfGUJsscuYWeRrHfop9u2Y55/Pja5n9P9siR
         CBzNrAG0Rnwrw5y9wcoTlvEX0Il7K+OzPRrYs1m6p5ThGmcgA3coZilHeExs5emP9SZq
         E6QUvT6ieOhhwTHTwyWeeeh/dWlliDHZvrn0uDTUxC0gvX+Ct5cYaS5jJCfkMlfKH2UC
         Sekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014917; x=1702619717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcpcBg9iqyFf2P75H/RgUfyoTRLcpINzc/uQQUbU4hE=;
        b=qZ4dgnq0YRXgF1fSjwHVmpVR0r37aESZWbIlJwOTd700Fs2xOzC6R6ykympWXDHrCw
         o6kBTtwbPGvspCpgjLksfqsdeuYyInG1zsN86APVhc1SGmbIXuf1aumD2FAG/aEu/SN6
         X7Z8uSqv7TQjVDC2aQ5vvpp/iQ+K5uVo7H1miLmi2SY1QkWOy8XTj/hU3d3sWsKAwOUk
         enDs2CVCUe4pu2HKIVd2VZObghJlJkhafXiTvGv3/Jh973vJl4J+arh0lmJYjGtuO51v
         g/NWTSpQfDP/5cqpAY2T/6ErqrmQ/exU0lm+4XSUTGj8/gxjMMkkgQikc/q7aBjoIk84
         ZcxA==
X-Gm-Message-State: AOJu0Yxl4zgBCPynrtwuNGKnwQ/4QyX7tlDvowOWU+BNq2iGYRtLUvXd
	+zv8eAC04MGRnK8nqHFobT/Nfg==
X-Google-Smtp-Source: AGHT+IEd1Q8NqQMc7dge0J/g+8VD/1S9VTAlw4GMwW5YWZLRIvv4qPwcnwD5N+VJxlW0x3wmr8JadA==
X-Received: by 2002:a17:902:ab0f:b0:1d2:eee7:2a7e with SMTP id ik15-20020a170902ab0f00b001d2eee72a7emr114365plb.61.1702014917640;
        Thu, 07 Dec 2023 21:55:17 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:17 -0800 (PST)
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
Subject: [RFC PATCH 12/12] selftests/fpu: Allow building on other architectures
Date: Thu,  7 Dec 2023 21:54:42 -0800
Message-ID: <20231208055501.2916202-13-samuel.holland@sifive.com>
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

Now that ARCH_HAS_KERNEL_FPU_SUPPORT provides a common way to compile
and run floating-point code, this test is no longer x86-specific.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 lib/Kconfig.debug   |  2 +-
 lib/Makefile        | 25 ++-----------------------
 lib/test_fpu_glue.c |  5 ++++-
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc7d53d9dc01..bbab0b054e09 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2933,7 +2933,7 @@ config TEST_FREE_PAGES
 
 config TEST_FPU
 	tristate "Test floating point operations in kernel space"
-	depends on X86 && !KCOV_INSTRUMENT_ALL
+	depends on ARCH_HAS_KERNEL_FPU_SUPPORT && !KCOV_INSTRUMENT_ALL
 	help
 	  Enable this option to add /sys/kernel/debug/selftest_helpers/test_fpu
 	  which will trigger a sequence of floating point operations. This is used
diff --git a/lib/Makefile b/lib/Makefile
index e7cbd54944a2..b9f28558c9bd 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -109,31 +109,10 @@ CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
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
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
diff --git a/lib/test_fpu_glue.c b/lib/test_fpu_glue.c
index 2761b51117b0..2e0b4027a5e3 100644
--- a/lib/test_fpu_glue.c
+++ b/lib/test_fpu_glue.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
-#include <asm/fpu/api.h>
+#include <asm/fpu.h>
 
 int test_fpu(void);
 
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
2.42.0


