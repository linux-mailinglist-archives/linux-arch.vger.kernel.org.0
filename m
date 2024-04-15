Return-Path: <linux-arch+bounces-3693-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874EC8A563C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE6A2836B2
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8178C75;
	Mon, 15 Apr 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YIpnWYr3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081860EF9;
	Mon, 15 Apr 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194488; cv=none; b=EEg40nsbpQwFR1xkLw7nklkMGxmrBJTk5Vcq7bPR5CCicHbI73o8gn3ZYNtLnyFs6wo03EhW2Vbosz7MINTiykgqpSQQOOWKKElxMERYtB5nko4ToaxzuGmqXamJi53qrz/qTxAkG20JvCK+u+dP5KwwL0ARxgySaM4nBt7iECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194488; c=relaxed/simple;
	bh=osgSadJZvQn1wrb//TYw1z/uIXekqzai4TYartnsTww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCiwJMpkdMrl4kSo0Pq/WTw8k3KwtnRxZNo2lXySPg+jvKyNdz5/Yy9HhpVZwBvavNQur/MjcKWfjzFUsn2DDwEphQdkXI6bUvlU7Xvnq3+EOOqKIb6rFfCx5vBOvmy3w6cVDHO94+31/vTrTtOQ/Y4efPUDGf59Qb/7wxYpgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YIpnWYr3; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1713194478;
	bh=osgSadJZvQn1wrb//TYw1z/uIXekqzai4TYartnsTww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIpnWYr3OBNaVcOtObbIoF+WFBDFoEQ/+FXjlJGb5vZB+HrgGpmxY8qVUM3yt7rbK
	 pqGEs1MaSgpWZeTEHe7l9yu17qAlGcj5gxBTDhZZ4LLh/htXEt0TMDTv+04thWG6KA
	 e/rZHM8+gRKKta041QgyUJBZ6PCTJyuRk0rI3Kscx8JaOGTMnlVyCCYLAEcsjbY+8Z
	 PXJtu1qOkAqYXDYv+HAUIA+d+DjAeGzD+fSsD6slc5Lqnsq+fP0NRGuMC6qvhllBEx
	 kFI0glyI2mjasoAdAkLHJ5EbBqgqvHT3QtrW/rDNII+MhcDO03FlLwq8JNwPDHaFpp
	 K1ISv5JuAFfPg==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VJ9qf0ksTzvSD;
	Mon, 15 Apr 2024 11:21:18 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	"levi . yun" <yeoreum.yun@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sched: Add missing memory barrier in switch_mm_cid
Date: Mon, 15 Apr 2024 11:21:13 -0400
Message-Id: <20240415152114.59122-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415152114.59122-1-mathieu.desnoyers@efficios.com>
References: <20240415152114.59122-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many architectures' switch_mm() (e.g. arm64) do not have an smp_mb()
which the core scheduler code has depended upon since commit:

    commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")

If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear() can
unset the actively used cid when it fails to observe active task after it
sets lazy_put.

There *is* a memory barrier between storing to rq->curr and _return to
userspace_ (as required by membarrier), but the rseq mm_cid has stricter
requirements: the barrier needs to be issued between store to rq->curr
and switch_mm_cid(), which happens earlier than:

- spin_unlock(),
- switch_to().

So it's fine when the architecture switch_mm() happens to have that
barrier already, but less so when the architecture only provides the
full barrier in switch_to() or spin_unlock().

It is a bug in the rseq switch_mm_cid() implementation. All architectures
that don't have memory barriers in switch_mm(), but rather have the full
barrier either in finish_lock_switch() or switch_to() have them too late
for the needs of switch_mm_cid().

Introduce a new smp_mb__after_switch_mm(), defined as smp_mb() in the
generic barrier.h header, and use it in switch_mm_cid() for scheduler
transitions where switch_mm() is expected to provide a memory barrier.

Architectures can override smp_mb__after_switch_mm() if their
switch_mm() implementation provides an implicit memory barrier.
Override it with a no-op on x86 which implicitly provide this memory
barrier by writing to CR3.

Link: https://lore.kernel.org/lkml/20240305145335.2696125-1-yeoreum.yun@arm.com/
Reported-by: levi.yun <yeoreum.yun@arm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com> # for arm64
Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86
Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Cc: <stable@vger.kernel.org> # 6.4.x
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: levi.yun <yeoreum.yun@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: x86@kernel.org
---
 arch/x86/include/asm/barrier.h |  3 +++
 include/asm-generic/barrier.h  |  8 ++++++++
 kernel/sched/sched.h           | 20 ++++++++++++++------
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index fe1e7e3cc844..63bdc6b85219 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -79,6 +79,9 @@ do {									\
 #define __smp_mb__before_atomic()	do { } while (0)
 #define __smp_mb__after_atomic()	do { } while (0)
 
+/* Writing to CR3 provides a full memory barrier in switch_mm(). */
+#define smp_mb__after_switch_mm()	do { } while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_X86_BARRIER_H */
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 0c0695763bea..dc32b96140c1 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -294,5 +294,13 @@ do {									\
 #define io_stop_wc() do { } while (0)
 #endif
 
+/*
+ * Architectures that guarantee an implicit smp_mb() in switch_mm()
+ * can override smp_mb__after_switch_mm.
+ */
+#ifndef smp_mb__after_switch_mm
+#define smp_mb__after_switch_mm()	smp_mb()
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..d2895d264196 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -79,6 +79,8 @@
 # include <asm/paravirt_api_clock.h>
 #endif
 
+#include <asm/barrier.h>
+
 #include "cpupri.h"
 #include "cpudeadline.h"
 
@@ -3445,13 +3447,19 @@ static inline void switch_mm_cid(struct rq *rq,
 		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
 		 * Provide it here.
 		 */
-		if (!prev->mm)                          // from kernel
+		if (!prev->mm) {                        // from kernel
 			smp_mb();
-		/*
-		 * user -> user transition guarantees a memory barrier through
-		 * switch_mm() when current->mm changes. If current->mm is
-		 * unchanged, no barrier is needed.
-		 */
+		} else {				// from user
+			/*
+			 * user -> user transition relies on an implicit
+			 * memory barrier in switch_mm() when
+			 * current->mm changes. If the architecture
+			 * switch_mm() does not have an implicit memory
+			 * barrier, it is emitted here.  If current->mm
+			 * is unchanged, no barrier is needed.
+			 */
+			smp_mb__after_switch_mm();
+		}
 	}
 	if (prev->mm_cid_active) {
 		mm_cid_snapshot_time(rq, prev->mm);
-- 
2.39.2


