Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6689713743B
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 17:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgAJQ44 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 11:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728695AbgAJQ4z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 11:56:55 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8449E20721;
        Fri, 10 Jan 2020 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578675414;
        bh=8YNKigtXUusnuZh4FiNJm9hdVLUewI/+Ux2Mz0HrA1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3N6hTq5o+2muYfzD36ZEJTFZxE4ToDEzsQSCBiRFtJ+PF76Yrp4MBLdpaFEz9nle
         O5H/RpoKv+r60lQD4qS3YySMNYZse+RUCpw1BCl3+xzL4IZuuZXAXYzK4S63L7fRle
         uuZS4OHHRVBTdC0VdF2FO+2ClKZq5D3m1i2kxGP0=
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
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH 5/8] READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
Date:   Fri, 10 Jan 2020 16:56:33 +0000
Message-Id: <20200110165636.28035-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
References: <20200110165636.28035-1-will@kernel.org>
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
which are allowed to tear and convert the two broken callers over to the
new macros.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/xen/time.c       |  2 +-
 include/linux/compiler.h | 37 +++++++++++++++++++++++++++++++++----
 net/xdp/xsk_queue.h      |  2 +-
 3 files changed, 35 insertions(+), 6 deletions(-)

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
index 44974d658f30..863180641336 100644
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
+#define __READ_ONCE(x)	(*(volatile typeof(x) *)&(x))
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
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index eddae4688862..2b55c1c7b2b6 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -304,7 +304,7 @@ static inline struct xdp_desc *xskq_validate_desc(struct xsk_queue *q,
 		struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
 		unsigned int idx = q->cons_tail & q->ring_mask;
 
-		*desc = READ_ONCE(ring->desc[idx]);
+		*desc = __READ_ONCE(ring->desc[idx]);
 		if (xskq_is_valid_desc(q, desc, umem))
 			return desc;
 
-- 
2.25.0.rc1.283.g88dfdc4193-goog

