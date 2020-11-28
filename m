Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F612C729F
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389920AbgK1VuM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbgK1S17 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:27:59 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC9EC0258EF;
        Sat, 28 Nov 2020 08:01:55 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f17so6725178pge.6;
        Sat, 28 Nov 2020 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gttnBtFOibE2tP2Qz24NLSDRYoTGub5YJjfSoizC0iA=;
        b=fddofWue+O7PL7JyLzbrmfEZ1AmPAs4YpBi425i4fGaiDzUtTP1Cjb/kUW5gGhUTUG
         zroDx2CGFhUo8MVoFIUF+MP8b1p2psaIqXLAsQr05kPX/p4d/S7xxuUvrdD122e3zNTk
         +yWVb5RpbczP24WMcIBwgAESCFaKaOazX1xmiySUU7Q4UENN4oLJouX6ftvashMBqtNo
         k9k7ojLvXh7wWrdH5HhDZtS64VIpEQm0fl12lwLV2acHXX+2Z4z3IDRijQ1jKh4kn6f8
         te2+ctqgL6SkhFEZCO0U/smJPgELN01XFV1O3fSOhYhR0PJS+cMx8avXrp2TZTREkvoq
         hJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gttnBtFOibE2tP2Qz24NLSDRYoTGub5YJjfSoizC0iA=;
        b=ln1tzmpdK2fhSacy6twFk/mo5N3qA3E9suKQwwc+gk7h8dNDIIefIvVdnKE2VIHpAE
         ON8Deu67BPw3MyLBDqaBKfF+B1fzh92jy8LieJxLg1bypk8xp4nrmQn6duQnJk+JGXn5
         B2urMcRsn0T8aSOUzARM0o5D4SKL+MNdD6IU/aDC6uzN/tne60s7ZQaVbR0CWEh3D76/
         GLjdX1YBL2AUCI/pSocUN/Tta9N/1mNoSofC597qm7KG9eaDKufH4+Xbt5yWmGl4rjHa
         5MMKEGImSJWKzd9kJG1rAmQMz6tQfGl2cVUpWUax43doMAdu9dP2Mgjni5EDsZ2cSPGW
         tkNg==
X-Gm-Message-State: AOAM531OQAkT797WD1TT0XFM9u1S0lIznjdrrI5HwOGNRXawwMACIRms
        pDaDDvDm0ePy4MWERBYonqdcpl0WvJk=
X-Google-Smtp-Source: ABdhPJzSlEN2fFhGsSm+AZ067hVpNTL/kp5XtHU/fInnX4+IsK4D3+Ht2oCRMtspesP14x3iR4yVHg==
X-Received: by 2002:a17:90b:30cb:: with SMTP id hi11mr16522183pjb.94.1606579315315;
        Sat, 28 Nov 2020 08:01:55 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:01:54 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 1/8] lazy tlb: introduce exit_lazy_tlb
Date:   Sun, 29 Nov 2020 02:01:34 +1000
Message-Id: <20201128160141.1003903-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128160141.1003903-1-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is called at points where a lazy mm is switched away or made not
lazy (by its owner switching back).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/mach-rpc/ecard.c            |  1 +
 arch/powerpc/mm/book3s64/radix_tlb.c |  1 +
 fs/exec.c                            |  6 ++++--
 include/asm-generic/mmu_context.h    | 21 +++++++++++++++++++++
 kernel/kthread.c                     |  1 +
 kernel/sched/core.c                  |  2 ++
 6 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 827b50f1c73e..43eb1bfba466 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -253,6 +253,7 @@ static int ecard_init_mm(void)
 	current->mm = mm;
 	current->active_mm = mm;
 	activate_mm(active_mm, mm);
+	exit_lazy_tlb(active_mm, current);
 	mmdrop(active_mm);
 	ecard_init_pgtables(mm);
 	return 0;
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index b487b489d4b6..ac3fec03926a 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -661,6 +661,7 @@ static void do_exit_flush_lazy_tlb(void *arg)
 		mmgrab(&init_mm);
 		current->active_mm = &init_mm;
 		switch_mm_irqs_off(mm, &init_mm, current);
+		exit_lazy_tlb(mm, current);
 		mmdrop(mm);
 	}
 
diff --git a/fs/exec.c b/fs/exec.c
index 547a2390baf5..4b4dea1bb7ba 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1017,6 +1017,8 @@ static int exec_mmap(struct mm_struct *mm)
 	if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
 	activate_mm(active_mm, mm);
+	if (!old_mm)
+		exit_lazy_tlb(active_mm, tsk);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
 	tsk->mm->vmacache_seqnum = 0;
@@ -1028,9 +1030,9 @@ static int exec_mmap(struct mm_struct *mm)
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
 		mm_update_next_owner(old_mm);
 		mmput(old_mm);
-		return 0;
+	} else {
+		mmdrop(active_mm);
 	}
-	mmdrop(active_mm);
 	return 0;
 }
 
diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
index 91727065bacb..4626d0020e65 100644
--- a/include/asm-generic/mmu_context.h
+++ b/include/asm-generic/mmu_context.h
@@ -24,6 +24,27 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 }
 #endif
 
+/*
+ * exit_lazy_tlb - Called after switching away from a lazy TLB mode mm.
+ *
+ * mm:  the lazy mm context that was switched
+ * tsk: the task that was switched to (with a non-lazy mm)
+ *
+ * mm may equal tsk->mm.
+ * mm and tsk->mm will not be NULL.
+ *
+ * Note this is not symmetrical to enter_lazy_tlb, this is not
+ * called when tasks switch into the lazy mm, it's called after the
+ * lazy mm becomes non-lazy (either switched to a different mm or the
+ * owner of the mm returns).
+ */
+#ifndef exit_lazy_tlb
+static inline void exit_lazy_tlb(struct mm_struct *mm,
+			struct task_struct *tsk)
+{
+}
+#endif
+
 /**
  * init_new_context - Initialize context of a new mm_struct.
  * @tsk: task struct for the mm
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 933a625621b8..e380302aac13 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1250,6 +1250,7 @@ void kthread_use_mm(struct mm_struct *mm)
 	}
 	tsk->mm = mm;
 	switch_mm_irqs_off(active_mm, mm, tsk);
+	exit_lazy_tlb(active_mm, tsk);
 	local_irq_enable();
 	task_unlock(tsk);
 #ifdef finish_arch_post_lock_switch
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7e453492cff..dcc46039ade5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3765,6 +3765,8 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
 		if (!prev->mm) {                        // from kernel
+			exit_lazy_tlb(prev->active_mm, next);
+
 			/* will mmdrop() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;
-- 
2.23.0

