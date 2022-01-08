Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49B488491
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiAHQoV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAHQoT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B6C06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F30D760BAA
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7CDC36AF2;
        Sat,  8 Jan 2022 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660258;
        bh=UNKWT50c2f68zkUzaFiQUCdKH55gB0N7A0rbX5LXlDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZczwHgJCsbxYQ+miDqJBqZB+PJZL285KFnyINpOxf6YtIR3q7IX8VHVvHlx4SJmza
         C2Q5btFR7YvhIRGjiHskhEF48wywxtqHFz0bs4PHvhD8cq2ECMxLPnqL0ityfYR6DL
         R3LzaGkC36Ezj/uRUM8j4zKQEDxSZlQA6315KPBQ8ndjiBO/M/DSR5yQaAh5hEHOWS
         CgKrhoM/iC3dtTzRrsZp6iMc4CT+q4je+3HY4bZZKOE3JsWcz6ObJ/NwT789Fn5bO3
         rKeDuJLuVQtkLsg50jMuXUqIEG0pWzTsl5i8ZTUDG3SwKJKP3OisChDiA2bDWcRhkn
         BukE1CH6jJjVg==
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
Subject: [PATCH 01/23] membarrier: Document why membarrier() works
Date:   Sat,  8 Jan 2022 08:43:46 -0800
Message-Id: <d64b6651fe8799481c6204e43b17f81010018345.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We had a nice comment at the top of membarrier.c explaining why membarrier
worked in a handful of scenarios, but that consisted more of a list of
things not to forget than an actual description of the algorithm and why it
should be expected to work.

Add a comment explaining my understanding of the algorithm.  This exposes a
couple of implementation issues that I will hopefully fix up in subsequent
patches.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/sched/membarrier.c | 60 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index b5add64d9698..30e964b9689d 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -7,8 +7,64 @@
 #include "sched.h"
 
 /*
- * For documentation purposes, here are some membarrier ordering
- * scenarios to keep in mind:
+ * The basic principle behind the regular memory barrier mode of
+ * membarrier() is as follows.  membarrier() is called in one thread.  Tt
+ * iterates over all CPUs, and, for each CPU, it either sends an IPI to
+ * that CPU or it does not. If it sends an IPI, then we have the
+ * following sequence of events:
+ *
+ * 1. membarrier() does smp_mb().
+ * 2. membarrier() does a store (the IPI request payload) that is observed by
+ *    the target CPU.
+ * 3. The target CPU does smp_mb().
+ * 4. The target CPU does a store (the completion indication) that is observed
+ *    by membarrier()'s wait-for-IPIs-to-finish request.
+ * 5. membarrier() does smp_mb().
+ *
+ * So all pre-membarrier() local accesses are visible after the IPI on the
+ * target CPU and all pre-IPI remote accesses are visible after
+ * membarrier(). IOW membarrier() has synchronized both ways with the target
+ * CPU.
+ *
+ * (This has the caveat that membarrier() does not interrupt the CPU that it's
+ * running on at the time it sends the IPIs. However, if that is the CPU on
+ * which membarrier() starts and/or finishes, membarrier() does smp_mb() and,
+ * if not, then the scheduler's migration of membarrier() is a full barrier.)
+ *
+ * membarrier() skips sending an IPI only if membarrier() sees
+ * cpu_rq(cpu)->curr->mm != target mm.  The sequence of events is:
+ *
+ *           membarrier()            |          target CPU
+ * ---------------------------------------------------------------------
+ *                                   | 1. smp_mb()
+ *                                   | 2. set rq->curr->mm = other_mm
+ *                                   |    (by writing to ->curr or to ->mm)
+ * 3. smp_mb()                       |
+ * 4. read rq->curr->mm == other_mm  |
+ * 5. smp_mb()                       |
+ *                                   | 6. rq->curr->mm = target_mm
+ *                                   |    (by writing to ->curr or to ->mm)
+ *                                   | 7. smp_mb()
+ *                                   |
+ *
+ * All memory accesses on the target CPU prior to scheduling are visible
+ * to membarrier()'s caller after membarrier() returns due to steps 1, 2, 4
+ * and 5.
+ *
+ * All memory accesses by membarrier()'s caller prior to membarrier() are
+ * visible to the target CPU after scheduling due to steps 3, 4, 6, and 7.
+ *
+ * Note that, tasks can change their ->mm, e.g. via kthread_use_mm().  So
+ * tasks that switch their ->mm must follow the same rules as the scheduler
+ * changing rq->curr, and the membarrier() code needs to do both dereferences
+ * carefully.
+ *
+ * GLOBAL_EXPEDITED support works the same way except that all references
+ * to rq->curr->mm are replaced with references to rq->membarrier_state.
+ *
+ *
+ * Specific examples of how this produces the documented properties of
+ * membarrier():
  *
  * A) Userspace thread execution after IPI vs membarrier's memory
  *    barrier before sending the IPI
-- 
2.33.1

