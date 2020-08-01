Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFE234F19
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 03:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgHABPD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 21:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgHABPC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:15:02 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F195021744;
        Sat,  1 Aug 2020 01:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244501;
        bh=G2VNe93BWzqh5NFXOKKw/WKZ4VfWD4d5tZ6KgNKEhes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vy1xgTXYDXfaMlH4HYJnKX3ZiUZHkUGx3dxyWhEJC+0jhTBiSjW430z17fwjB6gje
         cxMlHQppU7ZYOUreoLinA0EdVP7/Cyuz/sHfVtLo+seAaS+8sSZe2ShBOedzPz9enT
         Wdtlra3mBD5xVXwayX9QbWW1SunEDrXKBm6V6k94=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH 13/13] csky: Add context tracking support
Date:   Sat,  1 Aug 2020 01:14:13 +0000
Message-Id: <1596244453-98575-14-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch support context tracking with no hz full.

Here is the test result with dynticks-testing (see tick_stop):

 cat /sys/kernel/debug/tracing/per_cpu/cpu0/trace
 tracer: nop

 entries-in-buffer/entries-written: 356/356   #P:1

                              _-----=> irqs-off
                             / _----=> need-resched
                            | / _---=> hardirq/softirq
                            || / _--=> preempt-depth
                            ||| /     delay
           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
              | |       |   ||||       |         |
...
          sleep-192   [000] d.h.   167.088270: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=166436355700
          sleep-192   [000] d.h.   167.092279: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=166440365700
         <idle>-0     [000] d.h2   167.096492: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=166444578400
         <idle>-0     [000] d..1   167.097876: tick_stop: success=1 dependency=NONE
                                               ^^^^^^^^^
         <idle>-0     [000] d.h1   168.818206: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=168166280900
   kworker/u2:0-7     [000] ....   168.821760: workqueue_execute_start: work struct (ptrval): function wb_workfn
   kworker/u2:0-7     [000] d.h1   168.824464: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=168172547100
    kworker/0:1-18    [000] ....   168.825053: workqueue_execute_start: work struct (ptrval): function vmstat_update
    kworker/0:1-18    [000] ....   168.825238: workqueue_execute_start: work struct (ptrval): function vmstat_shepherd
    kworker/0:1-18    [000] ....   168.825516: workqueue_execute_start: work struct (ptrval): function neigh_periodic_work
         <idle>-0     [000] d..1   168.826121: tick_stop: success=1 dependency=NONE
   kworker/u2:0-7     [000] ....   169.377327: workqueue_execute_start: work struct (ptrval): function flush_to_ldisc
         <idle>-0     [000] d..1   169.379832: tick_stop: success=1 dependency=NONE
   kworker/u2:0-7     [000] ....   169.607935: workqueue_execute_start: work struct (ptrval): function flush_to_ldisc
   kworker/u2:0-7     [000] d.h1   169.608148: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=168956235500
         <idle>-0     [000] d..1   169.608654: tick_stop: success=1 dependency=NONE

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Greentime Hu <greentime.hu@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig        |  2 ++
 arch/csky/kernel/entry.S | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index ad98b93..af23873 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -42,6 +42,8 @@ config CSKY
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_COPY_THREAD_TLS
+	select HAVE_CONTEXT_TRACKING
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index efd2e69..5936391 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -23,6 +23,22 @@
 #endif
 .endm
 
+.macro	context_tracking
+	mfcr	a0, epsr
+	btsti	a0, 31
+	bt	1f
+	jbsr	context_tracking_user_exit
+	ldw	a0, (sp, LSAVE_A0)
+	ldw	a1, (sp, LSAVE_A1)
+	ldw	a2, (sp, LSAVE_A2)
+	ldw	a3, (sp, LSAVE_A3)
+#if defined(__CSKYABIV1__)
+	ldw	r6, (sp, LSAVE_A4)
+	ldw	r7, (sp, LSAVE_A5)
+#endif
+1:
+.endm
+
 .macro tlbop_begin name, val0, val1, val2
 ENTRY(csky_\name)
 	mtcr    a3, ss2
@@ -103,6 +119,7 @@ ENTRY(csky_\name)
 .endm
 .macro tlbop_end is_write
 	zero_fp
+	context_tracking
 	RD_MEH	a2
 	psrset  ee, ie
 	mov     a0, sp
@@ -128,6 +145,7 @@ tlbop_end 1
 ENTRY(csky_systemcall)
 	SAVE_ALL TRAP0_SIZE
 	zero_fp
+	context_tracking
 	psrset  ee, ie
 
 	lrw     r9, __NR_syscalls
@@ -237,6 +255,9 @@ ret_from_exception:
 	and	r10, r9
 	cmpnei	r10, 0
 	bt	exit_work
+#ifdef CONFIG_CONTEXT_TRACKING
+	jbsr	context_tracking_user_enter
+#endif
 1:
 #ifdef CONFIG_PREEMPTION
 	mov	r9, sp
@@ -277,6 +298,7 @@ work_resched:
 ENTRY(csky_trap)
 	SAVE_ALL 0
 	zero_fp
+	context_tracking
 	psrset	ee
 	mov	a0, sp                 /* Push Stack pointer arg */
 	jbsr	trap_c                 /* Call C-level trap handler */
@@ -311,6 +333,7 @@ ENTRY(csky_get_tls)
 ENTRY(csky_irq)
 	SAVE_ALL 0
 	zero_fp
+	context_tracking
 	psrset	ee
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.7.4

