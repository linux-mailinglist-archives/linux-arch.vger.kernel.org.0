Return-Path: <linux-arch+bounces-3352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDA89469F
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 23:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91376B22E2E
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 21:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9854BE9;
	Mon,  1 Apr 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPx7qALc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F954BDB;
	Mon,  1 Apr 2024 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007592; cv=none; b=VslnTrjctxZp0YWXgO84JHSU0fLe8LMbH1Kre6TqxvmEiKjmIgKGaxq7ZAwLWixGeCnWNljmoVODuD3zDHXcPy5OOfS6VaiTBkofza4Hg33HnT54CKrGfQ29g3OMC1U5kHdSicsl1KoHdgl8TDkairoGFmGCBTqLz9jZB3QnJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007592; c=relaxed/simple;
	bh=c9GjA7u0Ah+LPIGy6CuP6SHZiXz0K6ltKvEILVHzc/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6mlEtggAk1+16GdaEOb5xBqfciAUURVGz0htUBM27BLw12t6sB6gQ6zV4dzIKhiXosPutfHNZFH1GBIsh2lebNHkK4hmBOUKogsDt8reMDJZYEKiKMzq74615kdStaSZfsRdbDexxucEpMKQa1WO8Zd4qnb92P8GL11MDKPE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPx7qALc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884C3C433C7;
	Mon,  1 Apr 2024 21:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712007591;
	bh=c9GjA7u0Ah+LPIGy6CuP6SHZiXz0K6ltKvEILVHzc/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPx7qALcCOxvTnvEAcA3+dk6h1GB5Tnoxoecgz0uRzekeKZe766+kQZ2Z8Ca5IW1x
	 kmJOvZP/anIHmtsEQ7xEPET9CdARoFdDFRxI4MfannlBA1Mt3PJCJbKb8cslrK8vTa
	 DeGdwO6TTWr9EQ6MnutEVztHHC1GI8ZK6V5V5M/ms+1lTDmr2ucS7XXrP+OqS5zv+J
	 NHr55wA3dE2xFD7IiWXjroW6WIXLX7KgpMlJJrU9SOrKHwxFQrA7oAjXhEnJsuKii9
	 j7/N+SNoeVo8X9T4rvkPXezLa7VsDu31wG5ddhr1D8qF7uzzbhVUC7FE4BjnMfYuK0
	 bO4ILXDXEnRFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3EF4FCE0738; Mon,  1 Apr 2024 14:39:51 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH RFC cmpxchg 1/8] lib: Add one-byte and two-byte cmpxchg() emulation functions
Date: Mon,  1 Apr 2024 14:39:43 -0700
Message-Id: <20240401213950.3910531-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Architectures are required to provide four-byte cmpxchg() and 64-bit
architectures are additionally required to provide eight-byte cmpxchg().
However, there are cases where one-byte and two-byte cmpxchg()
would be extremely useful.  Therefore, provide cmpxchg_emu_u8() and
cmpxchg_emu_u16() that emulate one-byte and two-byte cmpxchg() in terms
of four-byte cmpxchg().

Note that these emulations are fully ordered, and can (for example)
cause one-byte cmpxchg_relaxed() to incur the overhead of full ordering.
If this causes problems for a given architecture, that architecture is
free to provide its own lighter-weight primitives.

[ paulmck: Apply Marco Elver feedback. ]
[ paulmck: Apply kernel test robot feedback. ]

Link: https://lore.kernel.org/all/0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <linux-arch@vger.kernel.org>
---
 arch/Kconfig                |  3 ++
 include/linux/cmpxchg-emu.h | 16 ++++++++
 lib/Makefile                |  1 +
 lib/cmpxchg-emu.c           | 74 +++++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)
 create mode 100644 include/linux/cmpxchg-emu.h
 create mode 100644 lib/cmpxchg-emu.c

diff --git a/arch/Kconfig b/arch/Kconfig
index ae4a4f37bbf08..01093c60952a5 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1609,4 +1609,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
 	# strict alignment always, even with -falign-functions.
 	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
 
+config ARCH_NEED_CMPXCHG_1_2_EMU
+	bool
+
 endmenu
diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
new file mode 100644
index 0000000000000..fee8171fa05eb
--- /dev/null
+++ b/include/linux/cmpxchg-emu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Emulated 1-byte and 2-byte cmpxchg operations for architectures
+ * lacking direct support for these sizes.  These are implemented in terms
+ * of 4-byte cmpxchg operations.
+ *
+ * Copyright (C) 2024 Paul E. McKenney.
+ */
+
+#ifndef __LINUX_CMPXCHG_EMU_H
+#define __LINUX_CMPXCHG_EMU_H
+
+uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
+uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
+
+#endif /* __LINUX_CMPXCHG_EMU_H */
diff --git a/lib/Makefile b/lib/Makefile
index ffc6b2341b45a..1d93b61a7ecbe 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -236,6 +236,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
+obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_2_EMU) += cmpxchg-emu.o
 
 obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 #ensure exported functions have prototypes
diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
new file mode 100644
index 0000000000000..a88c4f3c88430
--- /dev/null
+++ b/lib/cmpxchg-emu.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Emulated 1-byte and 2-byte cmpxchg operations for architectures
+ * lacking direct support for these sizes.  These are implemented in terms
+ * of 4-byte cmpxchg operations.
+ *
+ * Copyright (C) 2024 Paul E. McKenney.
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/instrumented.h>
+#include <linux/atomic.h>
+#include <linux/panic.h>
+#include <linux/bug.h>
+#include <asm-generic/rwonce.h>
+#include <linux/cmpxchg-emu.h>
+
+union u8_32 {
+	u8 b[4];
+	u32 w;
+};
+
+/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
+uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
+{
+	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
+	int i = ((uintptr_t)p) & 0x3;
+	union u8_32 old32;
+	union u8_32 new32;
+	u32 ret;
+
+	ret = READ_ONCE(*p32);
+	do {
+		old32.w = ret;
+		if (old32.b[i] != old)
+			return old32.b[i];
+		new32.w = old32.w;
+		new32.b[i] = new;
+		instrument_atomic_read_write(p, 1);
+		ret = data_race(cmpxchg(p32, old32.w, new32.w));
+	} while (ret != old32.w);
+	return old;
+}
+EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
+
+union u16_32 {
+	u16 h[2];
+	u32 w;
+};
+
+/* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
+uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
+{
+	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
+	int i = (((uintptr_t)p) & 0x2) / 2;
+	union u16_32 old32;
+	union u16_32 new32;
+	u32 ret;
+
+	WARN_ON_ONCE(((uintptr_t)p) & 0x1);
+	ret = READ_ONCE(*p32);
+	do {
+		old32.w = ret;
+		if (old32.h[i] != old)
+			return old32.h[i];
+		new32.w = old32.w;
+		new32.h[i] = new;
+		instrument_atomic_read_write(p, 2);
+		ret = data_race(cmpxchg(p32, old32.w, new32.w));
+	} while (ret != old32.w);
+	return old;
+}
+EXPORT_SYMBOL_GPL(cmpxchg_emu_u16);
-- 
2.40.1


