Return-Path: <linux-arch+bounces-3243-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24C88EFC8
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD4EB2701C
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C641552F4;
	Wed, 27 Mar 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="noziLqwF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFF154C02
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569740; cv=none; b=QEynzq03R2vZ+H9VAScnFE9oJtmCZbhmBSCoaQJ0g5mAFhcZ9O+2PEBoQfMeJvYd4lnIiHJ8BnHFwVe7rYBUvTh+Q7uyeNlXhYCYMXjKHxNkte/h+DkWD8SDIgxtKu1cGdMfvkYBX/1G3uP5UqVNp5V7Je43toOsq5BcKKRRuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569740; c=relaxed/simple;
	bh=E7MLSmCZtdYqT/97iSjjy5MvTX1XvFIxMI0c3iuGdCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krRGqBzx+j98DcNeT8oszmLyAvKl3sa4K+NOlX+OiD8B8+59v3JeSKD9utvivwZuvgU1mKlN2F+tj7LGtHNC7B/SgmKRELELFkgdYPUfiWUFWhMnCRueLiQ8hXxq4FzIsDPy2SOaD4hejc7alF9AmOqfaskzAlgddvlmBGAbWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=noziLqwF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1def59b537cso1592305ad.2
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569738; x=1712174538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KPYCb9S3Soscoa7gVsLkBiv/vc0d18dY2Lykf0pkTk=;
        b=noziLqwFZQWZjHYxnaQ7Ba1PpL6FqL/WWlAx8A69tosxUn7uAeWY2fUa8cTYFNY6o5
         E7ahw2Hh2itkW8PLwG53FIRFWIKFriGNHXis1RGuCH3o68E1DYnzq3XSUHs8PB0AJXx5
         FmGeEc7wMrN5bhJSwoonwaFyVDQ+aGsIcT9AQ5fFolpPWUdk+4SYeYnl95dF86XOBJbK
         ZcKfoZpQzni84VSM08/4GJF86upNXlb1nSk+x/hSAtfrMvc6zPIaBLCpn+VuG1b6emkN
         MjZAUr4QOUTZIdE9a64iRpyoNyZLEZWTohxGSe4OE6ZwzYmZTqg4pn8TwxMBAZAPxbMz
         88CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569738; x=1712174538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KPYCb9S3Soscoa7gVsLkBiv/vc0d18dY2Lykf0pkTk=;
        b=kMP9WcCk2wGuA6qYT3elpXzehqq1Zgx8Xt8JFDFHgvn1+esOW5OP3Ckl6TaPYTGBfh
         BtXzXRLCAbvbnoAnK2kRAG4bXTdyg4X3SUVLWqrLCUaOd2bngyCtxdofe1d0rvH5xb+q
         6j/Fa568oYxX52PoX04RCwSNi/4TcCuTkoez58+Ls3ohwaYLj61aCqb1ZVDcZagqqde/
         24JOT2Zd8yyiJhDWjxANdmQbC3tajkPq/vR0mrCRbBBk8M1SmSGraN7IcT01edYk3ksf
         sT3otK5DbFjDQaPjYdqs9ISMqps62Gp3nS2NbKmuvPgTObVRXDltOr6qFWEZFBv51jop
         ymeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXarUeBQrLzLxOb9hA3TpDLzZ1Gzkd4JiDkhl+LpoeK2fwfzJ1pE+R28HmGAksEUdSTt2QBaezAGCBymiAfQKyffMmN7ruCKvPMMA==
X-Gm-Message-State: AOJu0YwyCCm3gfvE96PWenQGPWGvL0Elf/j+MKRGkJGxwSWK1FpzqR/i
	ZT8WgI2hiHHvufA/mfNflf/s0mX9ZS4w7viZpMT2UzL8Qp8loEUsiZnPA4IkghA=
X-Google-Smtp-Source: AGHT+IHiVrJt14UyveizhwLAq9XPpEU6ZyZvDdQzDZe0rjNysh7dZh6CYDZhY9eiiH2RA2j+uTxBcQ==
X-Received: by 2002:a17:902:ec8b:b0:1e0:1f1d:bd38 with SMTP id x11-20020a170902ec8b00b001e01f1dbd38mr622795plg.7.1711569737898;
        Wed, 27 Mar 2024 13:02:17 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:17 -0700 (PDT)
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
Subject: [PATCH v3 14/14] selftests/fpu: Allow building on other architectures
Date: Wed, 27 Mar 2024 13:00:45 -0700
Message-ID: <20240327200157.1097089-15-samuel.holland@sifive.com>
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
2.43.1


