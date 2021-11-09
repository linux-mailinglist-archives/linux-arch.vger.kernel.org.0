Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8055944A5A7
	for <lists+linux-arch@lfdr.de>; Tue,  9 Nov 2021 05:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbhKIEOV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Nov 2021 23:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbhKIEOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Nov 2021 23:14:20 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129FC061767;
        Mon,  8 Nov 2021 20:11:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so18579759plf.3;
        Mon, 08 Nov 2021 20:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Laa6GrX8SMmNI5AeZnDYqtRTHmWrIAQmq1BDfZLEoc=;
        b=XT2o5XUetjN29wsbWpeLvnjSX3wVVX03K6SkuptYESMG6ouma6KxHw4dt5/1Wfgn5b
         4YuLdXmik/9gU4f/ABXBRmU3BZlaPomSWcsls8MXCkTYGuw/nfkMXxgVI7/ryKy85R6a
         AIXuXWFrdGW62905o3x2OwuIKqscYGJQbcf118GOriHP7gLHin2d6zwg5xB+x7x/N5vt
         8mTXrUkC1UEL0DlO/LPxvs32I3048cXxSrBC77azwn9PU4s1FyveFV97Zn5EA7j1J5qX
         6mgL3spiOULc3cpKlVa+bsIulFMEPFgnF3hdoSIw3CYIThCGkIDHEu3a5PYCAEDw/VaW
         eAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Laa6GrX8SMmNI5AeZnDYqtRTHmWrIAQmq1BDfZLEoc=;
        b=psPZTttjqll8HBOyr1wOK2Nen9zImgef0rNJf1VX2X4r7zp8WthAFXVeDt8HEbUZL6
         s3zGm/zGElN4IzcR2uGzSyZ/Uy7i1BcYK7i8Ozt2jb/Ko8dFCnG9KyuZU/qTRzAJrnnX
         72a+Bgek7po2FiD12I7rIORyGU/zoiNOjYMG1t4GzMNwvjelNcHQfbVZPzhqTbQeFYQ/
         4HcTGozA3cb+hyEqTGSu5j1zW9z1sDth2zXqLq8Wcdxl0vrjxjUZM5iWVJLgejHSxjyx
         nr4fLZcJ4yCtNYtF5gCJROF+HljUxh9cTVBlF+Z/jQD8gXJxKyCrHFTTxb3VHrA+D2rZ
         G5IA==
X-Gm-Message-State: AOAM531JhEC7T8386MOLbiRLgwRERL1ACFS4M0lyJbaepmibjl7+Cfsa
        euNlvx/VtYS6q/4Kd1K9YYg=
X-Google-Smtp-Source: ABdhPJwxS9sUKSGEc2iC4g4n5cPiizDFLEP0mJ24/zIiv4oJbth9XqC6bOgazToLXlxIBm1mCmkW0w==
X-Received: by 2002:a17:902:ba85:b0:13e:c846:c92e with SMTP id k5-20020a170902ba8500b0013ec846c92emr4294154pls.57.1636431094629;
        Mon, 08 Nov 2021 20:11:34 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id o19sm18278063pfu.56.2021.11.08.20.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 20:11:34 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 2/4] lazy tlb: allow lazy tlb mm refcounting to be configurable
Date:   Tue,  9 Nov 2021 14:11:17 +1000
Message-Id: <20211109041119.1972927-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211109041119.1972927-1-npiggin@gmail.com>
References: <20211109041119.1972927-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 Documentation/vm/active_mm.rst |  6 ++++++
 arch/Kconfig                   | 17 +++++++++++++++++
 include/linux/sched/mm.h       | 13 +++++++++++--
 kernel/sched/core.c            | 22 ++++++++++++++++++----
 kernel/sched/sched.h           |  4 +++-
 5 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/Documentation/vm/active_mm.rst b/Documentation/vm/active_mm.rst
index 6f8269c284ed..2b0d08332400 100644
--- a/Documentation/vm/active_mm.rst
+++ b/Documentation/vm/active_mm.rst
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
index 8df1c7102643..73d98edc5cdc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -428,6 +428,23 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
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
index f7a0b347fecb..939dee9f5bc8 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -52,12 +52,21 @@ static inline void mmdrop(struct mm_struct *mm)
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
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 480205b6a188..8fdc004b4f1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4772,7 +4772,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
-	struct mm_struct *mm = rq->prev_mm;
+	struct mm_struct *mm = NULL;
 	long prev_state;
 
 	/*
@@ -4791,7 +4791,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
-	rq->prev_mm = NULL;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+	mm = rq->prev_lazy_mm;
+	rq->prev_lazy_mm = NULL;
+#endif
 
 	/*
 	 * A task struct has one reference for the use as "current".
@@ -4927,9 +4930,20 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
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
index 3d3e5793e117..43e7fbe06557 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -977,7 +977,9 @@ struct rq {
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
2.23.0

