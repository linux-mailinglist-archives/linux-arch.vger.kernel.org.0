Return-Path: <linux-arch+bounces-3601-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4771B8A1E0E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CD51C225B7
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89822131E54;
	Thu, 11 Apr 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cw926R2Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79F4131E2E;
	Thu, 11 Apr 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857574; cv=none; b=jVZQte/qTSceA65LmGk45nCSdc+zq6Wxtr12WJyLtl1bV8UpEPhdyxg+he0ctRrELgGfPML2MIZLjpZOImpt4HA8t1jMK+Cm1llU0dOYJzfA2+fHlBwW1odeqIg2HEjc+/UGpd40mo2FBFNlCEEMo95usRa5azvnHyx9+Reuf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857574; c=relaxed/simple;
	bh=OKxXIh/WXhatcgx1Ou+NvsrOJcDB3Ihf5QKnsGO8RQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OzHZVf0WNYrbVsGcW+xSi5IZ9fkgshsZtjlY5CjG5EPWpWtd3RXJddfq1tK3RhUV24fTyaSju+TPcO14X+zbEygo+6jm3uLABSCaSzLnGK++/YKr0wcKuabYCw7cDKCOmpqDxd8NEGlnFjizpDQIq9hvs/tfd6pNrV6WX7bs1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cw926R2Z; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1712857563;
	bh=OKxXIh/WXhatcgx1Ou+NvsrOJcDB3Ihf5QKnsGO8RQI=;
	h=From:To:Cc:Subject:Date:From;
	b=cw926R2ZfZ1029Vbp53hck1uPrzSwQh8tRDZhRSYvJRpmGGx6eXEKOMBajPcXeAiM
	 62lGtEXeEuE7Bh79gMY/YrQ7Ix11qWduAI5cuBM2MJ4HF8Bdm/pJJQQgI5zzAWOGl8
	 g7v/GJekpVD2eEh4gTp5Hw5IkehtGrQZg4LsgB96VecOZWTPRevSsyrrudfmx+Rf7h
	 EqugCQIzkPP17GYgRErQJh3FIntGNYOPODSjK5ZZ1SXX40e41jWtIxAk4zbNOA+bNj
	 jbRhNSO0j8FJ1E8xg/thTSJbuVcEGgtjj9+BsqRGKJSpKpkOZvs4xCRDsS5JpF4viv
	 dbGRGq6E0YUmA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VFnDV4cYWzsHQ;
	Thu, 11 Apr 2024 13:46:02 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"levi . yun" <yeoreum.yun@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH] sched: Add missing memory barrier in switch_mm_cid
Date: Thu, 11 Apr 2024 13:43:02 -0400
Message-Id: <20240411174302.353889-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
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
index 0216f63a366b..d0795b5fab46 100644
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
index 961f4d88f9ef..5a6c94d7a598 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -296,5 +296,13 @@ do {									\
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
index 001fe047bd5d..35717359d3ca 100644
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
2.25.1


