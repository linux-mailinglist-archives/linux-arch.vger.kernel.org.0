Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633B81AAED2
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410518AbgDOQxL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 12:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410513AbgDOQxJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:53:09 -0400
Received: from localhost.localdomain (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1BEE208FE;
        Wed, 15 Apr 2020 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969588;
        bh=G13fe0U2+2ZpJqPiS3FSgXyfcn//elPJNIal9BP4qMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlYb5qc3CFH6Mm46PdxdSYP3xKBFBOWKLRm+NykuYeR/qFerIcRR+ouJCa5shYwwo
         DpBy8MeRUruJ3Czq1T3fABH3dj4b+OIR5Mym1J83T7WtDvMinejKPYE91JXkkJTHV8
         dYMWLANO4Xp47ZMnz7IHzcsoxLrfQG7iuJlss9Hw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 07/12] READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
Date:   Wed, 15 Apr 2020 17:52:13 +0100
Message-Id: <20200415165218.20251-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415165218.20251-1-will@kernel.org>
References: <20200415165218.20251-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

{READ,WRITE}_ONCE() cannot guarantee atomicity for arbitrary data sizes.
This can be surprising to callers that might incorrectly be expecting
atomicity for accesses to aggregate structures, although there are other
callers where tearing is actually permissable (e.g. if they are using
something akin to sequence locking to protect the access).

Linus sayeth:

  | We could also look at being stricter for the normal READ/WRITE_ONCE(),
  | and require that they are
  |
  | (a) regular integer types
  |
  | (b) fit in an atomic word
  |
  | We actually did (b) for a while, until we noticed that we do it on
  | loff_t's etc and relaxed the rules. But maybe we could have a
  | "non-atomic" version of READ/WRITE_ONCE() that is used for the
  | questionable cases?

The slight snag is that we also have to support 64-bit accesses on 32-bit
architectures, as these appear to be widespread and tend to work out ok
if either the architecture supports atomic 64-bit accesses (x86, armv7)
or if the variable being accesses represents a virtual address and
therefore only requires 32-bit atomicity in practice.

Take a step in that direction by introducing a variant of
'compiletime_assert_atomic_type()' and use it to check the pointer
argument to {READ,WRITE}_ONCE(). Expose __{READ,WRITE_ONCE}() variants
which are allowed to tear and convert the one broken caller over to the
new macros.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/xen/time.c       |  2 +-
 include/linux/compiler.h | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 0968859c29d0..108edbcbc040 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -64,7 +64,7 @@ static void xen_get_runstate_snapshot_cpu_delta(
 	do {
 		state_time = get64(&state->state_entry_time);
 		rmb();	/* Hypervisor might update data. */
-		*res = READ_ONCE(*state);
+		*res = __READ_ONCE(*state);
 		rmb();	/* Hypervisor might update data. */
 	} while (get64(&state->state_entry_time) != state_time ||
 		 (state_time & XEN_RUNSTATE_UPDATE));
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 0bf6c04b3f8f..3e0b14de3504 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -198,24 +198,43 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #include <asm/barrier.h>
 #include <linux/kasan-checks.h>
 
+/*
+ * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
+ * atomicity or dependency ordering guarantees. Note that this may result
+ * in tears!
+ */
+#define __READ_ONCE(x)	(*(const volatile typeof(x) *)&(x))
+
+#define __READ_ONCE_SCALAR(x)						\
+({									\
+	typeof(x) __x = __READ_ONCE(x);					\
+	smp_read_barrier_depends();					\
+	__x;								\
+})
+
 /*
  * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
  * to hide memory access from KASAN.
  */
 #define READ_ONCE_NOCHECK(x)						\
 ({									\
-	typeof(x) __x = *(volatile typeof(x) *)&(x);			\
-	smp_read_barrier_depends();					\
-	__x;								\
+	compiletime_assert_rwonce_type(x);				\
+	__READ_ONCE_SCALAR(x);						\
 })
 
 #define READ_ONCE(x)	READ_ONCE_NOCHECK(x)
 
-#define WRITE_ONCE(x, val)				\
+#define __WRITE_ONCE(x, val)				\
 do {							\
 	*(volatile typeof(x) *)&(x) = (val);		\
 } while (0)
 
+#define WRITE_ONCE(x, val)				\
+do {							\
+	compiletime_assert_rwonce_type(x);		\
+	__WRITE_ONCE(x, val);				\
+} while (0)
+
 #ifdef CONFIG_KASAN
 /*
  * We can't declare function 'inline' because __no_sanitize_address conflicts
@@ -299,6 +318,16 @@ static inline void *offset_to_ptr(const int *off)
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
+/*
+ * Yes, this permits 64-bit accesses on 32-bit architectures. These will
+ * actually be atomic in many cases (namely x86), but for others we rely on
+ * the access being split into 2x32-bit accesses for a 32-bit quantity (e.g.
+ * a virtual address) and a strong prevailing wind.
+ */
+#define compiletime_assert_rwonce_type(t)					\
+	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
+		"Unsupported access size for {READ,WRITE}_ONCE().")
+
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
-- 
2.26.0.110.g2183baf09c-goog

