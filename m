Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFD3ADDB9
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jun 2021 10:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhFTIQr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Jun 2021 04:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFTIQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Jun 2021 04:16:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09DC061767
        for <linux-arch@vger.kernel.org>; Sun, 20 Jun 2021 01:14:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g192so3573967pfb.6
        for <linux-arch@vger.kernel.org>; Sun, 20 Jun 2021 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bn/kZP/WveYwO1tnw3RZiDXTThXPveweAr7cC4FhaI4=;
        b=cotnDjFMip2ycKvwfTIf7RBFTbk5SLG7CGsCZBVk2HAOxjXwlMUXrgXc9d8GBWYxuO
         5I03ZcWdxacoE6DAWED5SeHP1Z7Aoxx4PdLRUi1XbNBR0JuZQVv8XFwO1x2h8EGQiKo1
         e4gYZ1XupVlUqKqG52+HreSUZuLYcnURyAMwCgeOqbk5fHgBCT+ahvzau99ETrRRl4ki
         0IOckINcsNsAVrO+mH1k++pVmYxCkwCMaD0Jp2bKY171nI6ajqbfyWy2r5H2e5jcuAWa
         TSnnsf7WcbSx9tlsEP3MbnA4p+dT6+RXyKj2GFFZPx15Gu3/oRmIFZuEBwIbJBM+OMQx
         cFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bn/kZP/WveYwO1tnw3RZiDXTThXPveweAr7cC4FhaI4=;
        b=a2WruXVB5RMeK3qrSmPHoUh4j9MdkklWrCugESsdIUVrlgSocqdW8dGIAIrjeKxAtu
         CuX7jbX/fOuBrmVCnW7gKKBAiMAa7DsshPPgnw2iPxiKc0InA3R8oJMn6xINF7FJQowW
         +DdtPLfwP5KK58BESqVCgj2IXLDMQoLnlVpvQN7oRzKHOkrWzDXRvuvNVoKJwCbr1bGZ
         T0eG6+Mm7CDxtMgdwyl2expoWOiW95IwJAI+o0fYh7xCKyjc2NQCZUSTjMPqaWq+qXwg
         G7QIUqy9SaOfvKLyNDxrMXMekpDLoi9hAuNmpQRCSJpwiDcfwAO+qPwXnpLaJW8+Rjug
         HRhg==
X-Gm-Message-State: AOAM532EbpPpwe8IQhJI+3vHp8l2ZVhFuR2S0DEPBHG3bKu6wG5vcL3E
        AG3JBxadRMbudnLiIGqlFW4=
X-Google-Smtp-Source: ABdhPJyOzB7if14965aYi6seB+tStu4AslKd4CqmwnCAkzHDLjsevAyQLi9EWr6mn3j/bw40Ww0hvA==
X-Received: by 2002:a63:1b17:: with SMTP id b23mr18194455pgb.242.1624176872919;
        Sun, 20 Jun 2021 01:14:32 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id q3sm12169496pfj.89.2021.06.20.01.14.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 01:14:32 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id A5B5A360326; Sun, 20 Jun 2021 20:14:28 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Cc:     ebiederm@xmission.com, torvalds@linux-foundation.org,
        schwab@linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v3 2/3] m68k: correctly handle IO worker stack frame set-up
Date:   Sun, 20 Jun 2021 20:14:24 +1200
Message-Id: <1624176865-15570-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624176865-15570-1-git-send-email-schmitzmic@gmail.com>
References: <1624176865-15570-1-git-send-email-schmitzmic@gmail.com>
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

Patch suggested by Linus (authored, actually - replace my signoff
if that's not appropriate, please).

Tested on both ARAnyM and Falcon hardware.

CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/kernel/entry.S   | 11 +++++++++++
 arch/m68k/kernel/process.c | 13 +++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

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
index 7dd0eea..f9598e0 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -192,12 +192,17 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 
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

