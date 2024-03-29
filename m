Return-Path: <linux-arch+bounces-3320-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F9289143A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E445B218A5
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0453E0A;
	Fri, 29 Mar 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kRKoUdUb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E852F82
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697103; cv=none; b=ifYL4rMBCsveAAc5SPlhtjIg48R6w/rpAaTGow3utcAsm+5xyb4h2cx1tdqQfeCqgWJN4rMLLwpsvlym0hpuKEQUdmIWKgvsYs2tpB1o0mo74ASQSxgA6APqJDUZp8Jn9VCjVctKoDlZyyTqqFE2a0iteIDT67210dZs79wTJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697103; c=relaxed/simple;
	bh=3Jxdlw0MxGrCtqcQU2OdpgNfa0UAfuPKsYPLtYGhH+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2AbGy3HdPb/TQdg/NqyZcqt/7RIVMKWKJYB7FOEotx1YNDDGgO1Yh884fn/kFc8GDQ4mxH2nx97HJ1S5n4FbaysjYe1MV3h2f1kSAhQ3nX7yXeRUB2YlDNN2hPz3vgGy7mcS+PLW1Xz8HZ2HjY+caYLOeoaTh5LFITekZPKvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kRKoUdUb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a07b092c4fso1396499a91.0
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697101; x=1712301901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZUya0v8Oh5iLzX7Kw5hO2ocqVWj9tNi/iu8yR8eYow=;
        b=kRKoUdUb5DKxUUPJAvbU2/4hQ+E/oXSY0LBXlgydG8sxeauznurMwd1pglgfOv2qLt
         5yf/dkmCvaDbG7KD8WCrOlK36TSxx1gxWAwPo/+Dg5GYKvagT03vY0zYsbf+Qe2/fUQR
         a7YtQ/wjEizRohXrTGipik8PM2A845dP//p4whryxZtt/QjlMZbBuX36uSwDIRRVQvzz
         +e4e4kVFuQVbdBFMnWE8zKwIWFvepXDxwsB0fq8Y+YYlXpquH2LevRpeOVLL1nEhPG/W
         sI8AToK7DW+eUIkRQXLxgCDLBwEj/2lQkEqHtU/oV8qxFhtO5e1NXyEE06o8kcx7Ws8V
         JzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697101; x=1712301901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZUya0v8Oh5iLzX7Kw5hO2ocqVWj9tNi/iu8yR8eYow=;
        b=EJc6KtHTUjl7QDrqGL1VQLPm9NzMU5kaYvmeaI/NFtOmq4PmSUjtFrR6xWbsrNnsuT
         H5agd0LzAM4JLK1XN5bjQBN8vUOzmUC+gQPVbf42ae5sDVzpNBYJ88JY7bkSq4Tu2M31
         9iDUt3Eky9fVfuW7+OOEbKkZO0cdd/uMm9fWrLMGTsEEj2nlk2YSX4zS2Hx273dwnqQ3
         MfGLZTXTkWO1mbTXrUlqltbrG0WGbOGVAk5+/LVOm2epTZAakMY4RrrIaY08+CwGghkq
         8yj4ca68bMxKwE9DpB73TYjP7kPvycLN24L3D8e4eK3Ne8mQ8fCiQ7m7nv0aA934Ota7
         4a6w==
X-Forwarded-Encrypted: i=1; AJvYcCXJJLor3N8gkI08wbXtxzdCLIHC+OSsQzq6XDRIkrTEOxz0nXU7PeF4w2ib9u/l2mgMG+IQcbNY8qYBMKR73kbia4exwqh+DZVXSw==
X-Gm-Message-State: AOJu0YwRFiuRhko0WEMFbsevqCnFZqKkxZvshyM01rkJyQjl92yZE/nC
	C9chdD8ENqR7yO+gg0Uqf0Q0bF+bUNXIx2UJFM8ceLQc2p46AMZ3rN3xBdAsDzg=
X-Google-Smtp-Source: AGHT+IERKMtTUUrMNrNdpmOZyYX6MKtFB7fSH53v9LodH/8MB2comF4l1LxXs3fRZJNBleQgeI68Nw==
X-Received: by 2002:a17:90a:b008:b0:2a0:5339:7751 with SMTP id x8-20020a17090ab00800b002a053397751mr1529473pjq.37.1711697101571;
        Fri, 29 Mar 2024 00:25:01 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:25:01 -0700 (PDT)
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
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 10/15] x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Fri, 29 Mar 2024 00:18:25 -0700
Message-ID: <20240329072441.591471-11-samuel.holland@sifive.com>
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

x86 already provides kernel_fpu_begin() and kernel_fpu_end(), but in a
different header. Add a wrapper header, and export the CFLAGS
adjustments as found in lib/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/x86/Kconfig           |  1 +
 arch/x86/Makefile          | 20 ++++++++++++++++++++
 arch/x86/include/asm/fpu.h | 13 +++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/x86/include/asm/fpu.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886bab943a..7c9d032ee675 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -83,6 +83,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 662d9d4033e6..5a5f5999c505 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -74,6 +74,26 @@ KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
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
2.44.0


