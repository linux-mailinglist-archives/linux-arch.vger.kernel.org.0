Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28C521ACCA
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 03:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGJB55 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 21:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgGJB5W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 21:57:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE35C08C5CE;
        Thu,  9 Jul 2020 18:57:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md7so1922418pjb.1;
        Thu, 09 Jul 2020 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TndaA+7n10SOeC82kaRc/SAF/MahQj0lom1PGKrEXvU=;
        b=gCXjs8bI2mKELHWhu45fBwg1UfGpXWYrZpw6lFS/SvzlUgi0yqDt8mR0Swy0XW/Eoh
         OxqpNXxxb+SbP/lNioVntQfSfi4+giY2ZWkfv6+c2VV1Qi1h2qu8pfPyehvx7JDtU+cj
         fvFVZxq2JpBW77ynSZam+fy+gVUFRdFqePTsZSQz9vkfcGVU7meycx1z83dKI6D6L/tX
         IeuWG+VZDdlxt2r8ZWdEGs3JCuZlfe+MRZJkfZUwxv0/SwopWrbT5G8its/MryhEKJ/d
         ClkJ1u2tLeLTb181Zjyjn82cQDXUyvsMLzzmGPsgTdpCvZWDM2JzPr7Eb1HexxQB+tSM
         +CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TndaA+7n10SOeC82kaRc/SAF/MahQj0lom1PGKrEXvU=;
        b=OjuZz7WnMJLmJ2vRRV49CyeoGD6FcW0YS8f6WxZvVehsN5hgBN4URSRPIq3fF3EhAn
         uFMlfESMn5acz0eMSAcT1udDHYWsZ+/XFp/E4phYKhQcqOAeDWEnKHEkaNmJDqvglazZ
         8RdkvlwtpmsYR28ChctWTSD23jmZH8mZQgCNrzPleboZug2zdZf5lhRkbsTeER3g/n8I
         TZuvfjOhen0t0v6akJ6xPO+do2gopR6cI+5BAdx9dWg7NRzj9wVfBBDs49f/GJOEfq23
         1YyWGrFFV5iOeAN3w6FeBuEYRwEBUVD4uRqzC37eEOOTTYYOe2qtaI05HO+ETVSMKEzs
         3JLQ==
X-Gm-Message-State: AOAM531HaF6XW7rkGTlsOZo+LSLB0jgiivqgv6r0xAAMywqxsjnBUmB3
        vupKSfq77L/ZWiQtPLtNrPKWK45d
X-Google-Smtp-Source: ABdhPJzaWKUBO6GLgF6DS/ZblFwcTQFZaXYAVtzx8AT9SnnyhUC2nMRdbyYbGy72wTEeylcuoM1gzw==
X-Received: by 2002:a17:90a:4bc7:: with SMTP id u7mr3117178pjl.217.1594346241669;
        Thu, 09 Jul 2020 18:57:21 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (220-245-19-62.static.tpgi.com.au. [220.245.19.62])
        by smtp.gmail.com with ESMTPSA id 7sm3912834pgw.85.2020.07.09.18.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 18:57:21 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [RFC PATCH 3/7] mm: introduce exit_lazy_tlb
Date:   Fri, 10 Jul 2020 11:56:42 +1000
Message-Id: <20200710015646.2020871-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 fs/exec.c                         |  5 +++--
 include/asm-generic/mmu_context.h | 20 ++++++++++++++++++++
 kernel/kthread.c                  |  1 +
 kernel/sched/core.c               |  2 ++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..e2ab71e88293 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1117,9 +1117,10 @@ static int exec_mmap(struct mm_struct *mm)
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
 		mm_update_next_owner(old_mm);
 		mmput(old_mm);
-		return 0;
+	} else {
+		exit_lazy_tlb(active_mm, tsk);
+		mmdrop(active_mm);
 	}
-	mmdrop(active_mm);
 	return 0;
 }
 
diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
index 86cea80a50df..3fc4c3879b79 100644
--- a/include/asm-generic/mmu_context.h
+++ b/include/asm-generic/mmu_context.h
@@ -24,6 +24,26 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 }
 #endif
 
+/*
+ * exit_lazy_tlb - Called after switching away from a lazy TLB mode mm.
+ *
+ * mm:  the lazy mm context that was switched away from
+ * tsk: the task that was switched to non-lazy mm
+ *
+ * tsk->mm will not be NULL.
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
index 132f84a5fde3..e813d92f2eab 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1253,6 +1253,7 @@ void kthread_use_mm(struct mm_struct *mm)
 
 	if (active_mm != mm)
 		mmdrop(active_mm);
+	exit_lazy_tlb(active_mm, tsk);
 
 	to_kthread(tsk)->oldfs = get_fs();
 	set_fs(USER_DS);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca5db40392d4..debc917bc69b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3439,6 +3439,8 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
 		if (!prev->mm) {                        // from kernel
+			exit_lazy_tlb(prev->active_mm, next);
+
 			/* will mmdrop() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;
-- 
2.23.0

