Return-Path: <linux-arch+bounces-4809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C273902A2D
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 22:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC7D1F2360A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 20:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208011422A8;
	Mon, 10 Jun 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oNUVm+WZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A8132117;
	Mon, 10 Jun 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052530; cv=none; b=nxBhLC37elo6eICj5KF9dpMQq10IwBwJigx+HHPvuZdqirDX94WdLK8uYJTzT0iZL3phR+4Ho5H/dS2VJexYRwqXsn+ROah6giK0u1qbdvk8/2kb5csxpnUwgxMZHcU0fQn0L/DqkYirtnOkuh6EOiaJI4TmtvkCt0Za42vGut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052530; c=relaxed/simple;
	bh=MfMv4iuvVtYp4fD/Tz2vUcjF5O+YDb2bOLk4u2a4UXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSEYMow6p0P3hW5SY60u5eogdurcoXqg4GSv2ef+329AERUcM9cLjlNQGRP2X5Tf5zX4aoq7QLHy+f/fY4A2qspOT8m7ad+3EiGpxnWchMhfRv53DPx3lE6HDr0617mwr+fywslgP7t8rANmAnG2ooJotzmycr2e5rwz0EcLwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oNUVm+WZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12469C2BBFC;
	Mon, 10 Jun 2024 20:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718052529;
	bh=MfMv4iuvVtYp4fD/Tz2vUcjF5O+YDb2bOLk4u2a4UXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNUVm+WZChQbUcGuxj0iePgzWN/STCk1UDe6eSft6fNqLQzRWj+cEg6N7Iub4DgQT
	 gFmRbO2VfLFjfkDGuPpTzofcmjldor6JMmMVNRboHNJ+QDhCRD1vXvPcqriY2jlZwk
	 nb0xo8U5Gn6m4lnOBGwcfoDV9Lp536H4cH2d1m6E=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/7] add default dummy 'runtime constant' infrastructure
Date: Mon, 10 Jun 2024 13:48:16 -0700
Message-ID: <20240610204821.230388-3-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
In-Reply-To: <20240610204821.230388-1-torvalds@linux-foundation.org>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the initial dummy support for 'runtime constants' for when
an architecture doesn't actually support an implementation of fixing up
said runtime constants.

This ends up being the fallback to just using the variables as regular
__ro_after_init variables, and changes the dcache d_hash() function to
use this model.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/dcache.c                         | 11 ++++++++++-
 include/asm-generic/Kbuild          |  1 +
 include/asm-generic/runtime-const.h | 15 +++++++++++++++
 include/asm-generic/vmlinux.lds.h   |  8 ++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/runtime-const.h

diff --git a/fs/dcache.c b/fs/dcache.c
index 8b4382f5c99d..5d3a5b315692 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -35,6 +35,8 @@
 #include "internal.h"
 #include "mount.h"
 
+#include <asm/runtime-const.h>
+
 /*
  * Usage:
  * dcache->d_inode->i_lock protects:
@@ -102,7 +104,8 @@ static struct hlist_bl_head *dentry_hashtable __ro_after_init;
 
 static inline struct hlist_bl_head *d_hash(unsigned long hashlen)
 {
-	return dentry_hashtable + ((u32)hashlen >> d_hash_shift);
+	return runtime_const_ptr(dentry_hashtable) +
+		runtime_const_shift_right_32(hashlen, d_hash_shift);
 }
 
 #define IN_LOOKUP_SHIFT 10
@@ -3129,6 +3132,9 @@ static void __init dcache_init_early(void)
 					0,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
+
+	runtime_const_init(shift, d_hash_shift);
+	runtime_const_init(ptr, dentry_hashtable);
 }
 
 static void __init dcache_init(void)
@@ -3157,6 +3163,9 @@ static void __init dcache_init(void)
 					0,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
+
+	runtime_const_init(shift, d_hash_shift);
+	runtime_const_init(ptr, dentry_hashtable);
 }
 
 /* SLAB cache for __getname() consumers */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b20fa25a7e8d..052e5c98c105 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -46,6 +46,7 @@ mandatory-y += pci.h
 mandatory-y += percpu.h
 mandatory-y += pgalloc.h
 mandatory-y += preempt.h
+mandatory-y += runtime-const.h
 mandatory-y += rwonce.h
 mandatory-y += sections.h
 mandatory-y += serial.h
diff --git a/include/asm-generic/runtime-const.h b/include/asm-generic/runtime-const.h
new file mode 100644
index 000000000000..670499459514
--- /dev/null
+++ b/include/asm-generic/runtime-const.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+/*
+ * This is the fallback for when the architecture doesn't
+ * support the runtime const operations.
+ *
+ * We just use the actual symbols as-is.
+ */
+#define runtime_const_ptr(sym) (sym)
+#define runtime_const_shift_right_32(val, sym) ((u32)(val)>>(sym))
+#define runtime_const_init(type,sym) do { } while (0)
+
+#endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5703526d6ebf..389a78415b9b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -944,6 +944,14 @@
 #define CON_INITCALL							\
 	BOUNDED_SECTION_POST_LABEL(.con_initcall.init, __con_initcall, _start, _end)
 
+#define RUNTIME_NAME(t,x) runtime_##t##_##x
+
+#define RUNTIME_CONST(t,x)						\
+	. = ALIGN(8);							\
+	RUNTIME_NAME(t,x) : AT(ADDR(RUNTIME_NAME(t,x)) - LOAD_OFFSET) {	\
+		*(RUNTIME_NAME(t,x));					\
+	}
+
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
 		. = ALIGN(8);						\
-- 
2.45.1.209.gc6f12300df


