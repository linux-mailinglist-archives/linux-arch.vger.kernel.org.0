Return-Path: <linux-arch+bounces-1189-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B981F3CF
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 02:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2EC1F22086
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 01:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E56FD6;
	Thu, 28 Dec 2023 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z/n/iW+3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8079D7
	for <linux-arch@vger.kernel.org>; Thu, 28 Dec 2023 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbd1155377so117584b6e.2
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727754; x=1704332554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eH3LxR+7tKPhQkN8usVAFkK9L6kG8awbjmN4hDMh6eY=;
        b=Z/n/iW+3C1ToV/2uNhbi4ZSe8q6Z/gPbzkXXu8cnrzriAHPGZt4UvjtjIBcf/3MaMt
         9Xz20BL8KnGoureDgTLMQfXltIDR+BoI1Y+cpAjqPKWo2A7n6ovc/Yku3tWFeUo08xmB
         AK2stlbE92d1/vNYYO5msb5npjeM8FdrIK69vaj2e/lSTdoKPY0SwTXnA/sq1B1F7Ja5
         v6scMGV9xloBsfur252Hci74HVmZdlqOoq+OMUuuq0vSpGUZpy+XVxhBcPNiDezw+EJR
         07UvNiP4o+DQQtGanCI/0bezPg2MhUpGXs2OC0bBhM0LxI5wCn3/qc54CFOvXISYz3g6
         ENcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727754; x=1704332554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eH3LxR+7tKPhQkN8usVAFkK9L6kG8awbjmN4hDMh6eY=;
        b=gQdaTxx0whfBRDSsLvzeI27GQmIeTN7z8b1L5WEgkJcuFP8rhRhlvZVeCuWVLODOdV
         AsR5hVQvipxNAxNIJp67PPUStyq4t690DTagt99JHrfsTFxDEJhF9QwO8RB9KtKV3a27
         uMk6jet0TRg2if0rcNeKTKMo3t8DmuVpKtx8h7sxYzVa5QGqZ1NqEXoZpzJddk+P1x8D
         JfCIWFvYAACKrSmTK5vfslQJBOzlmDVwWYHICMy86icxo/66f3FCxAP6ZSObZfmyXca1
         I/JZf66ULev+lryWmMlO3I/5dgyuf7IQlQyRl36kvENGVIfTsJnQ8FQ5W0iFrcEN98W5
         TwNQ==
X-Gm-Message-State: AOJu0Yw65RcF5u1KJ0ejnqCgPdSjDJu2jH3l/7eQiBRKl3SI+e/p58J1
	i1Zu9j5Q3wBMZZ7SbBRVTGKWOzWjzfl7UA==
X-Google-Smtp-Source: AGHT+IFEpLCvQycB9Oz1224kGaB5IW+nw3w8GCtWHxMOhFrbIq/NPFVjqUIq8RXAsL/B2ql/Y5FiAg==
X-Received: by 2002:a05:6808:2204:b0:3bb:6f23:8244 with SMTP id bd4-20020a056808220400b003bb6f238244mr12160740oib.70.1703727754042;
        Wed, 27 Dec 2023 17:42:34 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:33 -0800 (PST)
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
Subject: [PATCH v2 09/14] x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Dec 2023 17:41:59 -0800
Message-ID: <20231228014220.3562640-10-samuel.holland@sifive.com>
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


