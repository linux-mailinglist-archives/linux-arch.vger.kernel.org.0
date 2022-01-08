Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52348849E
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiAHQoh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiAHQoe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB52C061746
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 616D660DEA
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74EBC36AE0;
        Sat,  8 Jan 2022 16:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660272;
        bh=8B16LCC4JGxAUtyfSb6J025YSsjZ/ID9qTkdK302ZaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2ZWfShUvoLzpVsRhPVgmFaKeZMadx6Ptwbsmg5lcw5VSiQkSWPasXkyTsMqD/XfF
         49hkcmon7N6XWdaYppI3NPLf4mFrCNY8ND+aea/AyOjj1fLUIlnyKFAzu80HZjYHEb
         Sv8FBu159LhVRoRRFS2ESiNTjpaoinj12P0sGeGVU08jllcUyMUhFHD5Umsy8ddwGg
         wbzXjftFLjNH5Ubpv9vB1GoP3zhgyd86usbSN9o//WonrCNiMbLkwbkd2IMwNzzvAW
         LzCjIdawbMRc8i0dJ+sHJw1Yr8K3eZzyOvYWstCT++xy4a6bE5s5mRfNEldhAOBKYP
         g5pEdTcr8nhBQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 14/23] sched, exec: Factor current mm changes out from exec
Date:   Sat,  8 Jan 2022 08:43:59 -0800
Message-Id: <60eb8a98061100f95e53e7868841fbb9a68237c8.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, exec_mmap() open-codes an mm change.  Create new core
__change_current_mm() and __change_current_mm_to_kernel() helpers
and use the former from exec_mmap().  This moves the nasty scheduler
details out of exec.c and prepares for reusing this code elsewhere.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 fs/exec.c                |  32 +----------
 include/linux/sched/mm.h |  20 +++++++
 kernel/sched/core.c      | 119 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 30 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 2afa7b0c75f2..9e1c2ee7c986 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -971,15 +971,13 @@ EXPORT_SYMBOL(read_code);
 static int exec_mmap(struct mm_struct *mm)
 {
 	struct task_struct *tsk;
-	struct mm_struct *old_mm, *active_mm;
+	struct mm_struct *old_mm;
 	int ret;
 
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
 	exec_mm_release(tsk, old_mm);
-	if (old_mm)
-		sync_mm_rss(old_mm);
 
 	ret = down_write_killable(&tsk->signal->exec_update_lock);
 	if (ret)
@@ -1000,41 +998,15 @@ static int exec_mmap(struct mm_struct *mm)
 		}
 	}
 
-	task_lock(tsk);
-	/*
-	 * membarrier() requires a full barrier before switching mm.
-	 */
-	smp_mb__after_spinlock();
+	__change_current_mm(mm, true);
 
-	local_irq_disable();
-	active_mm = tsk->active_mm;
-	tsk->active_mm = mm;
-	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
-	membarrier_update_current_mm(mm);
-	/*
-	 * This prevents preemption while active_mm is being loaded and
-	 * it and mm are being updated, which could cause problems for
-	 * lazy tlb mm refcounting when these are updated by context
-	 * switches. Not all architectures can handle irqs off over
-	 * activate_mm yet.
-	 */
-	if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
-		local_irq_enable();
-	activate_mm(active_mm, mm);
-	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
-		local_irq_enable();
-	membarrier_finish_switch_mm(mm);
-	vmacache_flush(tsk);
-	task_unlock(tsk);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
-		BUG_ON(active_mm != old_mm);
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
 		mm_update_next_owner(old_mm);
 		mmput(old_mm);
 		return 0;
 	}
-	mmdrop(active_mm);
 	return 0;
 }
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f1d2beac464c..7509b2b2e99d 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -83,6 +83,26 @@ extern void mmput(struct mm_struct *);
 void mmput_async(struct mm_struct *);
 #endif
 
+/*
+ * Switch the mm for current.  This does not mmget() mm, nor does it mmput()
+ * the previous mm, if any.  The caller is responsible for reference counting,
+ * although __change_current_mm() handles all details related to lazy mm
+ * refcounting.
+ *
+ * If the caller is a user task, the caller must call mm_update_next_owner().
+ */
+void __change_current_mm(struct mm_struct *mm, bool mm_is_brand_new);
+
+/*
+ * Switch the mm for current to the kernel mm.  This does not mmdrop()
+ * -- the caller is responsible for reference counting, although
+ * __change_current_mm_to_kernel() handles all details related to lazy
+ * mm refcounting.
+ *
+ * If the caller is a user task, the caller must call mm_update_next_owner().
+ */
+void __change_current_mm_to_kernel(void);
+
 /* Grab a reference to a task's mm, if it is not already going away */
 extern struct mm_struct *get_task_mm(struct task_struct *task);
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 32275b4ff141..95eb0e78f74c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -14,6 +14,7 @@
 
 #include <linux/nospec.h>
 
+#include <linux/vmacache.h>
 #include <linux/kcov.h>
 #include <linux/scs.h>
 
@@ -4934,6 +4935,124 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	return finish_task_switch(prev);
 }
 
+void __change_current_mm(struct mm_struct *mm, bool mm_is_brand_new)
+{
+	struct task_struct *tsk = current;
+	struct mm_struct *old_active_mm, *mm_to_drop = NULL;
+
+	BUG_ON(!mm);	/* likely to cause corruption if we continue */
+
+	/*
+	 * We do not want to schedule, nor should procfs peek at current->mm
+	 * while we're modifying it.  task_lock() disables preemption and
+	 * locks against procfs.
+	 */
+	task_lock(tsk);
+	/*
+	 * membarrier() requires a full barrier before switching mm.
+	 */
+	smp_mb__after_spinlock();
+
+	local_irq_disable();
+
+	if (tsk->mm) {
+		/* We're detaching from an old mm.  Sync stats. */
+		sync_mm_rss(tsk->mm);
+	} else {
+		/*
+		 * Switching from kernel mm to user.  Drop the old lazy
+		 * mm reference.
+		 */
+		mm_to_drop = tsk->active_mm;
+	}
+
+	old_active_mm = tsk->active_mm;
+	tsk->active_mm = mm;
+	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
+	membarrier_update_current_mm(mm);
+
+	if (mm_is_brand_new) {
+		/*
+		 * For historical reasons, some architectures want IRQs on
+		 * when activate_mm() is called.  If we're going to call
+		 * activate_mm(), turn on IRQs but leave preemption
+		 * disabled.
+		 */
+		if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
+			local_irq_enable();
+		activate_mm(old_active_mm, mm);
+		if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
+			local_irq_enable();
+	} else {
+		switch_mm_irqs_off(old_active_mm, mm, tsk);
+		local_irq_enable();
+	}
+
+	/* IRQs are on now.  Preemption is still disabled by task_lock(). */
+
+	membarrier_finish_switch_mm(mm);
+	vmacache_flush(tsk);
+	task_unlock(tsk);
+
+#ifdef finish_arch_post_lock_switch
+	if (!mm_is_brand_new) {
+		/*
+		 * Some architectures want a callback after
+		 * switch_mm_irqs_off() once locks are dropped.  Callers of
+		 * activate_mm() historically did not do this, so skip it if
+		 * we did activate_mm().  On arm, this is because
+		 * activate_mm() switches mm with IRQs on, which uses a
+		 * different code path.
+		 *
+		 * Yes, this is extremely fragile and be cleaned up.
+		 */
+		finish_arch_post_lock_switch();
+	}
+#endif
+
+	if (mm_to_drop)
+		mmdrop(mm_to_drop);
+}
+
+void __change_current_mm_to_kernel(void)
+{
+	struct task_struct *tsk = current;
+	struct mm_struct *old_mm = tsk->mm;
+
+	if (!old_mm)
+		return;	/* nothing to do */
+
+	/*
+	 * We do not want to schedule, nor should procfs peek at current->mm
+	 * while we're modifying it.  task_lock() disables preemption and
+	 * locks against procfs.
+	 */
+	task_lock(tsk);
+	/*
+	 * membarrier() requires a full barrier before switching mm.
+	 */
+	smp_mb__after_spinlock();
+
+	/* current has a real mm, so it must be active */
+	WARN_ON_ONCE(tsk->active_mm != tsk->mm);
+
+	local_irq_disable();
+
+	sync_mm_rss(old_mm);
+
+	WRITE_ONCE(tsk->mm, NULL);  /* membarrier reads this without locks */
+	membarrier_update_current_mm(NULL);
+	vmacache_flush(tsk);
+
+	/* active_mm is still 'old_mm' */
+	mmgrab(old_mm);
+	enter_lazy_tlb(old_mm, tsk);
+
+	local_irq_enable();
+
+	task_unlock(tsk);
+}
+
 /*
  * nr_running and nr_context_switches:
  *
-- 
2.33.1

