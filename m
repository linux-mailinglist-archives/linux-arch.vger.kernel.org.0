Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F53B110A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 02:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFWAYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhFWAYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 20:24:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD15C061766
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 17:21:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m17so169066plx.7
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 17:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SgnGwu38bw0UJStBIOH7tya3nH76/iWM9MgdrSCFQ48=;
        b=vAvWSPfAz2uGO4/fqjwE/Yw3BzJ7kFXGR7IuyRvCMB0KXDAjy29udzSpbwlZQsouvO
         7j1+IZjOKKDAcsF2viBVIHPP7sy/tK1QRZ8sZxKv7BExx2ubzA+edcWdGA9r44SYMHH4
         tQIDOxlD2iO6xYp9ivxXEG80xgHd1Ts5tA1bI5wmeaWG4aNE25t2bYUza9XhqLP/iNN4
         L3yTX9bj0p6/I0irIEt05jPZhCnWUgs3LJ9+N1PAcz49RXWZ59j0mKCGK3RPw9S7q6oM
         Quh1c/Bs1hopdqcEjm0q1UIZb/dRgiXbH8XiT9Spnwe+jPwlIGai4Yr9KEbHJehUC5Gv
         FnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SgnGwu38bw0UJStBIOH7tya3nH76/iWM9MgdrSCFQ48=;
        b=nrjQoCfncRKPnOWaNfzvgliROTtaFVlfnKA5nklqgMGUA/zKNgmXExeRlbnshi+GG5
         tJqXBJnnN9kVQjZ95q0RpMf3oVQQM3OoXXOi+t0Lnz128/L8tPvL3Lb+GaA1QD+30fFQ
         LZeZIqAOQYu1udlkgEnOP37gTxqGI0hPHqlGgb01Xb32LVtlxyW73VDs6DBQMYV97Ocl
         jpw8b7egaRQ5sZk3TERvUgb6d0QYliFScnsJlewdhk8L+WEwvUwpd5UTuKUr3Tp1lx8H
         B1nIyDDV4iqTJNvlRmpdSDLoLhn+7NMDqMLcjRJCFU0QzRMombmSaTEHAHSN+0D8jgXL
         ulnA==
X-Gm-Message-State: AOAM5332vDcUuuMO7QmkUvWm0MZwyqp/+jxtV5CxSJNpFMbLFLDdNrXz
        5DUuuj65wzDuk33qKeed09s=
X-Google-Smtp-Source: ABdhPJxivMOFNonYC7xkUefPVBHYlYCiXMGVsCxLLdHIQTPKtFqrYCf2ZtaGAde4HlpBhRE7yCgiqg==
X-Received: by 2002:a17:90a:7c4a:: with SMTP id e10mr6556364pjl.56.1624407703931;
        Tue, 22 Jun 2021 17:21:43 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id p4sm409696pff.148.2021.06.22.17.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 17:21:43 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 0A6113603E0; Wed, 23 Jun 2021 12:21:39 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Cc:     ebiederm@xmission.com, torvalds@linux-foundation.org,
        schwab@linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v4 2/3] m68k: correctly handle IO worker stack frame set-up
Date:   Wed, 23 Jun 2021 12:21:35 +1200
Message-Id: <1624407696-20180-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Create full stack frame plus switch stack frame in copy_thread()
when creating a kernel worker thread. The switch stack frame will
then be consumed in resume(), leaving a full stack frame of zero
content for ptrace to play with.

Change ret_from_exception switch stack handling to restore the
switch stack (and pop the return address restored by that)after
return from kernel worker threads.

Patch as suggested by Linus (comments added by me).

Tested on both ARAnyM and Falcon hardware.

CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/kernel/entry.S   | 11 +++++++++++
 arch/m68k/kernel/process.c | 17 +++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 275452a..0c25038 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -147,6 +147,15 @@ ENTRY(ret_from_fork)
 	addql	#4,%sp
 	jra	ret_from_exception
 
+	| A kernel thread will jump here directly from resume,
+	| with the stack containing the full register state
+	| (pt_regs and switch_stack).
+	|
+	| The argument will be in d7, and the kernel function
+	| to call will be in a3.
+	|
+	| If the kernel function returns, we want to return
+	| to user space - it has done a kernel_execve().
 ENTRY(ret_from_kernel_thread)
 	| a3 contains the kernel thread payload, d7 - its argument
 	movel	%d1,%sp@-
@@ -154,6 +163,8 @@ ENTRY(ret_from_kernel_thread)
 	movel	%d7,(%sp)
 	jsr	%a3@
 	addql	#4,%sp
+	RESTORE_SWITCH_STACK
+	addql	#4,%sp
 	jra	ret_from_exception
 
 #if defined(CONFIG_COLDFIRE) || !defined(CONFIG_MMU)
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 6f2f2ab..d371edf 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -190,14 +190,23 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	 */
 	p->thread.fs = get_fs().seg;
 
+	/* kernel threads require an additional switch stack,
+	 * which is then consumed by resume() once we switch to
+	 * the new thread!
+	 */
 	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
 		/* kernel thread */
-		memset(frame, 0, sizeof(struct fork_frame));
+		struct switch_stack *kstp = &frame->sw - 1;
+
+		/* kernel thread - a kernel-side switch-stack and the full user fork_frame */
+		memset(kstp, 0, sizeof(struct switch_stack) + sizeof(struct fork_frame));
+
 		frame->regs.sr = PS_S;
-		frame->sw.a3 = usp; /* function */
-		frame->sw.d7 = arg;
-		frame->sw.retpc = (unsigned long)ret_from_kernel_thread;
+		kstp->a3 = usp; /* function */
+		kstp->d7 = arg;
+		kstp->retpc = (unsigned long)ret_from_kernel_thread;
 		p->thread.usp = 0;
+		p->thread.ksp = (unsigned long)kstp;
 		return 0;
 	}
 	memcpy(frame, container_of(current_pt_regs(), struct fork_frame, regs),
-- 
2.7.4

