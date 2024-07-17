Return-Path: <linux-arch+bounces-5444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B655933708
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 08:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922A01F2339A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD4134A8;
	Wed, 17 Jul 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="I6u/wuUj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63B125DE
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197693; cv=none; b=GKBNw3ni3+/YQSAW+MPV98ytk5eBlKJVUs3yE2C6rrwuCmq5Gn8swPSfVutSG36OGF7sSp3T0liajjxQJQUB4q257PEZWRiq3GFxX6xhi5USvZxscJrzBP0Q58bCjJA4L32tBgKKS/4Qh8+hi2qCXTqIVOMcFyeFeZLTWFNRHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197693; c=relaxed/simple;
	bh=o4ZK/GG6lXAN1cfDXgIpVYZWTFwSck3jVd1HEtW4i7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhb0cWBQgBdVEyPMKmgWh3S9Ldj1iTHXpQ0uepIoGSXi2teYd2IhmT6cyxkRYbfB+sg2rJaNhrXxM+H1j2RjSvN99sU3fsibhOGPXMryhdKbcvPSgCDp4KOmYjA5jWBWJX/bGJEdC0LOzXwLO2lD5flV4y8Ot5G6EUKuCplSlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=I6u/wuUj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36796aee597so3855649f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721197690; x=1721802490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpMFH6VmSNUk91jIQ+0kjGx11FiPCz2ltKgHshZWUPg=;
        b=I6u/wuUj5CnDUwLH4wrq9HfUioSQ7oasAohffOGS68gfC9zsa5layZnUFJOwA/w0rM
         Tt5VSRxm+G5nL4CjwLnKaB53jOkz/niuppF0xoU77TOuVfXxwkbMIuWiQZQP/G/dE7hd
         uLBaJOoOEb1faae/bPdA/QDGjITikMzGsJC5Fqz9hB5hH6T5ZCoq/DM14ohxn2YYDS2H
         /6FVwKbNu59UGmT56iK12KaxIO8p8QvtDeMTaDyOak/OJrRlxnCAp4g/6BBqJzGNZvkp
         jpi3DobF56AD3OXStSvtr7RDbRMMHEwk8v0WYoQlJI3+dk399zAiq2KO3dJC81AePHUW
         KT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197690; x=1721802490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpMFH6VmSNUk91jIQ+0kjGx11FiPCz2ltKgHshZWUPg=;
        b=ZVqlK35430Zf7M6lCoxdMB0Hw3L59ko3sYEVV1rROPgTCDPmw7w/euULX5EWZWULm0
         emSZWiqVrQxuSsUZw/cPhuki6ZJ21YLtPdwCTEw2agVRQS2LzfUuLDDXAxKultFxORsY
         4Ye8oImeO3ZxCP9OH93UAUQhxc7m52bd/16AfpBzusY2GKT0E7uV9UHiUYxKHHYbgcY4
         C6OCsVHB9urZ9eOD/dnFRLwmxSeY5Icjrdeh/saPESmJxwd62NNwXjWmF7yoLn9UC3Xh
         UCkuWh+sk0iaO6ordtVjviI1UBi1M9fXTQnPHXD54lGDjb+A5+UfIrpIG3vyDr7RP2/M
         l+5A==
X-Forwarded-Encrypted: i=1; AJvYcCWAtIgOC8THYSfHdNw79Dmt1R6GqYw5aJeGQO/XSbRBIZRPMwgv1S7xIu+EbuNAehTrF6HkJvGW4YhKhxMvdLZRWKhu3Ak7CW9RrA==
X-Gm-Message-State: AOJu0YxuoR43LqHjF0O/4Yma/afVtCPDb0Zza9JVGi/ovAq7XazTUXRu
	0g1U6MhZsF14uAGIoDkAhTLBGS8es5LYZ71Dqj5siLwohwCCpRPiNemWmMnuH/8=
X-Google-Smtp-Source: AGHT+IFM/AGZ5F1dS74/5pYkBU8cAcbJDWrIIu9c3nYaG0zPFdfcFYCGZfuTjOfFxaw1xsX/SOzMGA==
X-Received: by 2002:adf:e508:0:b0:366:f041:935d with SMTP id ffacd0b85a97d-3683179ebc7mr379203f8f.60.1721197690168;
        Tue, 16 Jul 2024 23:28:10 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccacdsm10824862f8f.62.2024.07.16.23.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:28:09 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v3 08/11] asm-generic: ticket-lock: Add separate ticket-lock.h
Date: Wed, 17 Jul 2024 08:19:54 +0200
Message-Id: <20240717061957.140712-9-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717061957.140712-1-alexghiti@rivosinc.com>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

Add a separate ticket-lock.h to include multiple spinlock versions and
select one at compile time or runtime.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/CAK8P3a2rnz9mQqhN6-e0CGUUv9rntRELFdxt_weiD7FxH7fkfQ@mail.gmail.com/
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 include/asm-generic/spinlock.h        |  87 +---------------------
 include/asm-generic/ticket_spinlock.h | 103 ++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 86 deletions(-)
 create mode 100644 include/asm-generic/ticket_spinlock.h

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index 4773334ee638..970590baf61b 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -1,94 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-/*
- * 'Generic' ticket-lock implementation.
- *
- * It relies on atomic_fetch_add() having well defined forward progress
- * guarantees under contention. If your architecture cannot provide this, stick
- * to a test-and-set lock.
- *
- * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
- * sub-word of the value. This is generally true for anything LL/SC although
- * you'd be hard pressed to find anything useful in architecture specifications
- * about this. If your architecture cannot do this you might be better off with
- * a test-and-set.
- *
- * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
- * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
- * a full fence after the spin to upgrade the otherwise-RCpc
- * atomic_cond_read_acquire().
- *
- * The implementation uses smp_cond_load_acquire() to spin, so if the
- * architecture has WFE like instructions to sleep instead of poll for word
- * modifications be sure to implement that (see ARM64 for example).
- *
- */
-
 #ifndef __ASM_GENERIC_SPINLOCK_H
 #define __ASM_GENERIC_SPINLOCK_H
 
-#include <linux/atomic.h>
-#include <asm-generic/spinlock_types.h>
-
-static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	u32 val = atomic_fetch_add(1<<16, &lock->val);
-	u16 ticket = val >> 16;
-
-	if (ticket == (u16)val)
-		return;
-
-	/*
-	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
-	 * custom cond_read_rcsc() here we just emit a full fence.  We only
-	 * need the prior reads before subsequent writes ordering from
-	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
-	 * have no outstanding writes due to the atomic_fetch_add() the extra
-	 * orderings are free.
-	 */
-	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
-	smp_mb();
-}
-
-static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
-{
-	u32 old = atomic_read(&lock->val);
-
-	if ((old >> 16) != (old & 0xffff))
-		return false;
-
-	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
-}
-
-static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
-	u32 val = atomic_read(&lock->val);
-
-	smp_store_release(ptr, (u16)val + 1);
-}
-
-static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	u32 val = lock.val.counter;
-
-	return ((val >> 16) == (val & 0xffff));
-}
-
-static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
-{
-	arch_spinlock_t val = READ_ONCE(*lock);
-
-	return !arch_spin_value_unlocked(val);
-}
-
-static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
-{
-	u32 val = atomic_read(&lock->val);
-
-	return (s16)((val >> 16) - (val & 0xffff)) > 1;
-}
-
+#include <asm-generic/ticket_spinlock.h>
 #include <asm/qrwlock.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
new file mode 100644
index 000000000000..cfcff22b37b3
--- /dev/null
+++ b/include/asm-generic/ticket_spinlock.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * 'Generic' ticket-lock implementation.
+ *
+ * It relies on atomic_fetch_add() having well defined forward progress
+ * guarantees under contention. If your architecture cannot provide this, stick
+ * to a test-and-set lock.
+ *
+ * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
+ * sub-word of the value. This is generally true for anything LL/SC although
+ * you'd be hard pressed to find anything useful in architecture specifications
+ * about this. If your architecture cannot do this you might be better off with
+ * a test-and-set.
+ *
+ * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
+ * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
+ * a full fence after the spin to upgrade the otherwise-RCpc
+ * atomic_cond_read_acquire().
+ *
+ * The implementation uses smp_cond_load_acquire() to spin, so if the
+ * architecture has WFE like instructions to sleep instead of poll for word
+ * modifications be sure to implement that (see ARM64 for example).
+ *
+ */
+
+#ifndef __ASM_GENERIC_TICKET_SPINLOCK_H
+#define __ASM_GENERIC_TICKET_SPINLOCK_H
+
+#include <linux/atomic.h>
+#include <asm-generic/spinlock_types.h>
+
+static __always_inline void ticket_spin_lock(arch_spinlock_t *lock)
+{
+	u32 val = atomic_fetch_add(1<<16, &lock->val);
+	u16 ticket = val >> 16;
+
+	if (ticket == (u16)val)
+		return;
+
+	/*
+	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
+	 * custom cond_read_rcsc() here we just emit a full fence.  We only
+	 * need the prior reads before subsequent writes ordering from
+	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
+	 * have no outstanding writes due to the atomic_fetch_add() the extra
+	 * orderings are free.
+	 */
+	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
+	smp_mb();
+}
+
+static __always_inline bool ticket_spin_trylock(arch_spinlock_t *lock)
+{
+	u32 old = atomic_read(&lock->val);
+
+	if ((old >> 16) != (old & 0xffff))
+		return false;
+
+	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
+}
+
+static __always_inline void ticket_spin_unlock(arch_spinlock_t *lock)
+{
+	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	u32 val = atomic_read(&lock->val);
+
+	smp_store_release(ptr, (u16)val + 1);
+}
+
+static __always_inline int ticket_spin_value_unlocked(arch_spinlock_t lock)
+{
+	u32 val = lock.val.counter;
+
+	return ((val >> 16) == (val & 0xffff));
+}
+
+static __always_inline int ticket_spin_is_locked(arch_spinlock_t *lock)
+{
+	arch_spinlock_t val = READ_ONCE(*lock);
+
+	return !ticket_spin_value_unlocked(val);
+}
+
+static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(&lock->val);
+
+	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+}
+
+/*
+ * Remapping spinlock architecture specific functions to the corresponding
+ * ticket spinlock functions.
+ */
+#define arch_spin_is_locked(l)		ticket_spin_is_locked(l)
+#define arch_spin_is_contended(l)	ticket_spin_is_contended(l)
+#define arch_spin_value_unlocked(l)	ticket_spin_value_unlocked(l)
+#define arch_spin_lock(l)		ticket_spin_lock(l)
+#define arch_spin_trylock(l)		ticket_spin_trylock(l)
+#define arch_spin_unlock(l)		ticket_spin_unlock(l)
+
+#endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
-- 
2.39.2


