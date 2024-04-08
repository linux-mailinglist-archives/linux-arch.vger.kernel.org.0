Return-Path: <linux-arch+bounces-3499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72F89CB0D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2231C23AF3
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86A144D12;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjWDSlzB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79D1448DD;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=IwiQDn5QX7UoNIDsPwnbFMYwoBEqu0FCAPhANixn7f9RhRPd2CpvZ8+L3tMDe8t5Bu/95NQTIZdGQwBSWcYMxmdxy5I+Kdm91Buk/+HtvpvUYEnOe8Fl3a3IFEtlDrkYFW6YwOtICIkFueScE01ZT81Pw/4uK/i46vfMIn0c41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=Zs6ak+wPmG4tPQkLrLcc6JxAJjrKyJZjKo6tat/+S/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzVnjEWYPEr0UbBlmGO2SXtLrJu+AlYUimBmjzGQB4ml+TKMq3jI3vT4jaXkxuQuzXuIqx/dg1+dZ/fqzFez0EzlWMh2Y6/bnfpk1/w4XIZSvtlmKdNpxtWu2zfOK8ciivPYjY1c49Su8I/rHz9lfwtvys6AA4BMx+sNw4wLjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjWDSlzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093D1C43142;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598587;
	bh=Zs6ak+wPmG4tPQkLrLcc6JxAJjrKyJZjKo6tat/+S/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjWDSlzBhwQ4qB8O00FJjJXhK/J+MUo0IKYNwnd+lZQtcfrJnSVLG9asJrOsDpsIK
	 jqzrNovshWX4pfBmetx5No7YjJfMLbfqBHQzlSZQwFmdct/OymQMft3/yxi2K9vE9/
	 TWW8nE+ihDQkz8soa8GyuYsKtOn+t4XvlIoZkrf8v7ti7LUCy9SsIN7dsCl5TpBSLx
	 09xN+tJ47BuuKPQ93m0/3EFQ2z7hdyzqZW1HmXVBZnupMpJY20n8yWymPPTjnCGvwF
	 SIOu8K7/MaOWtD8XxMmVCeMkUMD9NZY7yCV5FErh42J5zvrLqjI6Hobzl8QVXbi/Bh
	 +0iQhp9+D6YaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 51F0DCE2CCF; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	torvalds@linux-foundation.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH cmpxchg 09/14] lib: Add one-byte emulation function
Date: Mon,  8 Apr 2024 10:49:39 -0700
Message-Id: <20240408174944.907695-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Architectures are required to provide four-byte cmpxchg() and 64-bit
architectures are additionally required to provide eight-byte cmpxchg().
However, there are cases where one-byte cmpxchg() would be extremely
useful.  Therefore, provide cmpxchg_emu_u8() that emulates one-byte
cmpxchg() in terms of four-byte cmpxchg().

Note that this emulations is fully ordered, and can (for example) cause
one-byte cmpxchg_relaxed() to incur the overhead of full ordering.
If this causes problems for a given architecture, that architecture is
free to provide its own lighter-weight primitives.

[ paulmck: Apply Marco Elver feedback. ]
[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]

Link: https://lore.kernel.org/all/0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
---
 arch/Kconfig                |  3 +++
 include/linux/cmpxchg-emu.h | 15 +++++++++++++
 lib/Makefile                |  1 +
 lib/cmpxchg-emu.c           | 45 +++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+)
 create mode 100644 include/linux/cmpxchg-emu.h
 create mode 100644 lib/cmpxchg-emu.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f066785bb71d..284663392eef8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1609,4 +1609,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
 	# strict alignment always, even with -falign-functions.
 	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
 
+config ARCH_NEED_CMPXCHG_1_EMU
+	bool
+
 endmenu
diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
new file mode 100644
index 0000000000000..998deec67740a
--- /dev/null
+++ b/include/linux/cmpxchg-emu.h
@@ -0,0 +1,15 @@
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
+
+#endif /* __LINUX_CMPXCHG_EMU_H */
diff --git a/lib/Makefile b/lib/Makefile
index ffc6b2341b45a..cc3d52fdb477d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -236,6 +236,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
+obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_EMU) += cmpxchg-emu.o
 
 obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 #ensure exported functions have prototypes
diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
new file mode 100644
index 0000000000000..27f6f97cb60dd
--- /dev/null
+++ b/lib/cmpxchg-emu.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Emulated 1-byte cmpxchg operation for architectures lacking direct
+ * support for this size.  This is implemented in terms of 4-byte cmpxchg
+ * operations.
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
+		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
+	} while (ret != old32.w);
+	return old;
+}
+EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
-- 
2.40.1


