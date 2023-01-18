Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CD067167B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 09:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjARIsH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 03:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjARIpd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 03:45:33 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A3E8F7E9
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b17so28598171pld.7
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j17jMfq2pjg82rh+LLiiAYltqlq3/q9a3KAqNyLA6fY=;
        b=qt6g0zZxclXPX/KufLzDrxetxOa+Y0KuO2kDBGjEirYTyEuDL2FU0kh1CW+bvKzQ8e
         1PgIn8vJJDHYwOXsY+eXFKzMReN8kzIkL3cqJbHC/KcVaDPk5+4ASp5rwAzbthNV2jCy
         sFId0D+KFl7RHqDm5hu7vWp9CHS1bb0XbHOhZNmj1FkqrWt4HCW+AaZLa2qrD0ImjpmG
         OLknz9aRVzEP5mWTfavQXBkdiCAYcQpJIhtMx/MGg9B5RRIVRIGc2Rw6L2BEqeC36yiX
         RdYtdnH476ugfbY0kv33lImerLZIfQVPZX7TrvFbeii8oXEK4Tdej1T6R4YBH6qhLF7Z
         2J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j17jMfq2pjg82rh+LLiiAYltqlq3/q9a3KAqNyLA6fY=;
        b=U5pYaxIkVpa4/kWKLxLbTH9rFJTPz/skKWawD/4G/f6st4rbeh1UeV0LtAhyLDPGer
         JbfxZ4Dm0WspmncKRYlozthri1o8MRvYT6VY/3donJkjaDqWopJv0lhaL5mZwaQ34dVp
         JArwBFmnT/KeTqIcyr/n6rLFEIVqOH2rc+Z+NaTVqtiT0Qeqc6zXcJ0Ta3awFXrs0rql
         PDydv3uc0y0k2WX5jFOe+Wg1NBcY/+/hVhlDjoDrY2iPn/pKMkzxTrFMjIvfrEJ2A8hn
         gVevkAY33HG2khIetqJNuVltPZMVxCUR3JputNAVL4YlfJeQrd8Q1gkBBosP0VfGHXM6
         U6lQ==
X-Gm-Message-State: AFqh2kp50T3IqkoOQo9MMSsVedUF9PkiJ4AnFtVF7iFgtoEl7zAyQ2Fy
        S/ccA06ZZUQA9XXnvFdPVa8=
X-Google-Smtp-Source: AMrXdXtbjb5k3yKNxPZ6Ry87Y+0HPuS/QyUv3IYX7qbgXoBriB0NOKeG0RZHtZHLAEw3QY6HwQqHbg==
X-Received: by 2002:a17:90b:1d04:b0:229:2b7d:ee41 with SMTP id on4-20020a17090b1d0400b002292b7dee41mr5967999pjb.45.1674028830421;
        Wed, 18 Jan 2023 00:00:30 -0800 (PST)
Received: from bobo.ibm.com (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a16c200b002272616d3e1sm738462pje.40.2023.01.18.00.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:00:29 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 2/5] lazy tlb: allow lazy tlb mm refcounting to be configurable
Date:   Wed, 18 Jan 2023 18:00:08 +1000
Message-Id: <20230118080011.2258375-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230118080011.2258375-1-npiggin@gmail.com>
References: <20230118080011.2258375-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb mm
when it is context switched. This can be disabled by architectures that
don't require this refcounting if they clean up lazy tlb mms when the
last refcount is dropped. Currently this is always enabled, which is
what existing code does, so the patch is effectively a no-op.

Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/mm/active_mm.rst |  6 ++++++
 arch/Kconfig                   | 17 +++++++++++++++++
 include/linux/sched/mm.h       | 18 +++++++++++++++---
 kernel/sched/core.c            | 22 ++++++++++++++++++----
 kernel/sched/sched.h           |  4 +++-
 5 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/mm/active_mm.rst b/Documentation/mm/active_mm.rst
index 6f8269c284ed..2b0d08332400 100644
--- a/Documentation/mm/active_mm.rst
+++ b/Documentation/mm/active_mm.rst
@@ -4,6 +4,12 @@
 Active MM
 =========
 
+Note, the mm_count refcount may no longer include the "lazy" users
+(running tasks with ->active_mm == mm && ->mm == NULL) on kernels
+with CONFIG_MMU_LAZY_TLB_REFCOUNT=n. Taking and releasing these lazy
+references must be done with mmgrab_lazy_tlb() and mmdrop_lazy_tlb()
+helpers which abstracts this config option.
+
 ::
 
  List:       linux-kernel
diff --git a/arch/Kconfig b/arch/Kconfig
index 12e3ddabac9d..b07d36f08fea 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -465,6 +465,23 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	  irqs disabled over activate_mm. Architectures that do IPI based TLB
 	  shootdowns should enable this.
 
+# Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
+# MMU_LAZY_TLB_REFCOUNT=n can improve the scalability of context switching
+# to/from kernel threads when the same mm is running on a lot of CPUs (a large
+# multi-threaded application), by reducing contention on the mm refcount.
+#
+# This can be disabled if the architecture ensures no CPUs are using an mm as a
+# "lazy tlb" beyond its final refcount (i.e., by the time __mmdrop frees the mm
+# or its kernel page tables). This could be arranged by arch_exit_mmap(), or
+# final exit(2) TLB flush, for example.
+#
+# To implement this, an arch *must*:
+# Ensure the _lazy_tlb variants of mmgrab/mmdrop are used when dropping the
+# lazy reference of a kthread's ->active_mm (non-arch code has been converted
+# already).
+config MMU_LAZY_TLB_REFCOUNT
+	def_bool y
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 5376caf6fcf3..68bbe8d90c2e 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -82,17 +82,29 @@ static inline void mmdrop_sched(struct mm_struct *mm)
 /* Helpers for lazy TLB mm refcounting */
 static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
 {
-	mmgrab(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
+		mmgrab(mm);
 }
 
 static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 {
-	mmdrop(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT)) {
+		mmdrop(mm);
+	} else {
+		/*
+		 * mmdrop_lazy_tlb must provide a full memory barrier, see the
+		 * membarrier comment finish_task_switch which relies on this.
+		 */
+		smp_mb();
+	}
 }
 
 static inline void mmdrop_lazy_tlb_sched(struct mm_struct *mm)
 {
-	mmdrop_sched(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
+		mmdrop_sched(mm);
+	else
+		smp_mb(); // see above
 }
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 26aaa974ee6d..1ea14d849a0d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5081,7 +5081,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
-	struct mm_struct *mm = rq->prev_mm;
+	struct mm_struct *mm = NULL;
 	unsigned int prev_state;
 
 	/*
@@ -5100,7 +5100,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
-	rq->prev_mm = NULL;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+	mm = rq->prev_lazy_mm;
+	rq->prev_lazy_mm = NULL;
+#endif
 
 	/*
 	 * A task struct has one reference for the use as "current".
@@ -5231,9 +5234,20 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		lru_gen_use_mm(next->mm);
 
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
-			rq->prev_mm = prev->active_mm;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+			/* Will mmdrop_lazy_tlb() in finish_task_switch(). */
+			rq->prev_lazy_mm = prev->active_mm;
 			prev->active_mm = NULL;
+#else
+			/*
+			 * Without MMU_LAZY_TLB_REFCOUNT there is no lazy
+			 * tracking (because no rq->prev_lazy_mm) in
+			 * finish_task_switch, so no mmdrop_lazy_tlb(), so no
+			 * memory barrier for membarrier (see the membarrier
+			 * comment in finish_task_switch()).  Do it here.
+			 */
+			smp_mb();
+#endif
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..33da8fa8b5a5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1009,7 +1009,9 @@ struct rq {
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
-	struct mm_struct	*prev_mm;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+	struct mm_struct	*prev_lazy_mm;
+#endif
 
 	unsigned int		clock_update_flags;
 	u64			clock;
-- 
2.37.2

