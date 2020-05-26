Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B21B2AE5
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgDUPQH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 11:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgDUPQG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 11:16:06 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B421206F4;
        Tue, 21 Apr 2020 15:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587482166;
        bh=EcepAhAbbjDVQZZ71eMW9AWIepEXOvuDQICxGrphrw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8V4v8I2oo8z+oHqFUMH0pBmgACYJvBIzXIWD/XXvs+syzLnjuN9oEi5viuM0Yj9y
         xOZdIbh4QvHML95PdfPYM5vo5YTcUvqUUONNHtyXH0mv1GnISOqlviXttDNBcVZNcg
         rF25tJapuTTvAyILtlNqBW9kjj5KbCgCuXUY1DC4=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v4 07/11] READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
Date:   Tue, 21 Apr 2020 16:15:33 +0100
Message-Id: <20200421151537.19241-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
References: <20200421151537.19241-1-will@kernel.org>
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
argument to {READ,WRITE}_ONCE(). Expose __{READ,WRITE}_ONCE() variants
which are allowed to tear and convert the one broken caller over to the
new macros.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/xen/time.c       |  2 +-
 include/linux/compiler.h | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 4 deletions(-)

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
index 338111a448d0..50bb2461648f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -198,20 +198,37 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #include <asm/barrier.h>
 #include <linux/kasan-checks.h>
 
-#define __READ_ONCE(x)	(*(volatile typeof(x) *)&(x))
+/*
+ * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
+ * atomicity or dependency ordering guarantees. Note that this may result
+ * in tears!
+ */
+#define __READ_ONCE(x)	(*(const volatile typeof(x) *)&(x))
 
-#define READ_ONCE(x)							\
+#define __READ_ONCE_SCALAR(x)						\
 ({									\
 	typeof(x) __x = __READ_ONCE(x);					\
 	smp_read_barrier_depends();					\
 	__x;								\
 })
 
-#define WRITE_ONCE(x, val)				\
+#define READ_ONCE(x)							\
+({									\
+	compiletime_assert_rwonce_type(x);				\
+	__READ_ONCE_SCALAR(x);						\
+})
+
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
@@ -313,6 +330,16 @@ static inline void *offset_to_ptr(const int *off)
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
2.26.1.301.g55bc3eb7cb9-goog

