Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA99B48849D
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiAHQog (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiAHQoc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1111C06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99261B80B4A
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3914AC36AED;
        Sat,  8 Jan 2022 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660269;
        bh=6qfndroNSvS0PIjgZS5xp09UQvoV+Yf5NN9ZzmIhrIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMeO/k5pF7lBmYkpUKME1r7Y5oNUYFq/iwsij2I8eVxJi2tdPS2zI9IGMIU0GE0oU
         Kp7yLce8Y8unoowsw8vYLycwt5QPkQbUsU/pJC2zVt7G0e7/0ej+MjGXXyAA+As8T2
         /eQIgeEcTkClLIINypGIvv3g8UyKQOGSbIVtosrPGbq66FUsx1pfb6vmQD03IdCc+H
         e8eGvUz+8Eah4ApSmNIO4TYL3M08jd8NBw0r7xP3/knCaFOnTVadFP93khGD+GhXaD
         8qDMF4ZFAz2/FK7pl7iB1h6sJ9g8HqrJztV0RgSKf/WcwAhbRfzDcKyCslUESX9xvl
         wDEj07Lyuq/OQ==
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
        Andy Lutomirski <luto@kernel.org>,
        Woody Lin <woodylin@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH 11/23] sched/scs: Initialize shadow stack on idle thread bringup, not shutdown
Date:   Sat,  8 Jan 2022 08:43:56 -0800
Message-Id: <233d81a0a1e7b8eca1907998152ee848159b8774.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Starting with commit 63acd42c0d49 ("sched/scs: Reset the shadow stack when
idle_task_exit"), the idle thread's shadow stack was reset from the idle
task's context during CPU hot-unplug.  This was fragile: between resetting
the shadow stack and actually stopping the idle task, the shadow stack
did not match the actual call stack.

Clean this up by resetting the idle task's SCS in bringup_cpu().

init_idle() still does scs_task_reset() -- see the comments there.  I
leave this to an SCS maintainer to untangle further.

Cc: Woody Lin <woodylin@google.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/cpu.c        | 3 +++
 kernel/sched/core.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 192e43a87407..be16816bb87c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
+#include <linux/scs.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -587,6 +588,8 @@ static int bringup_cpu(unsigned int cpu)
 	struct task_struct *idle = idle_thread_get(cpu);
 	int ret;
 
+	scs_task_reset(idle);
+
 	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 917068b0a145..acd52a7d1349 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8621,7 +8621,15 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
+	/*
+	 * NB: This is called from sched_init() on the *current* idle thread.
+	 * This seems fragile if not actively incorrect.
+	 *
+	 * Initializing SCS for about-to-be-brought-up CPU idle threads
+	 * is in bringup_cpu(), but that does not cover the boot CPU.
+	 */
 	scs_task_reset(idle);
+
 	kasan_unpoison_task_stack(idle);
 
 #ifdef CONFIG_SMP
@@ -8779,7 +8787,6 @@ void idle_task_exit(void)
 		finish_arch_post_lock_switch();
 	}
 
-	scs_task_reset(current);
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
-- 
2.33.1

