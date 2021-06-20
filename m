Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B023ADDBA
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jun 2021 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhFTIQz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Jun 2021 04:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhFTIQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Jun 2021 04:16:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E720C061787
        for <linux-arch@vger.kernel.org>; Sun, 20 Jun 2021 01:14:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y4so4268512pfi.9
        for <linux-arch@vger.kernel.org>; Sun, 20 Jun 2021 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ixZmUnYAsnmNrcoi3362CfURu2mlbL5TSqES1nWSzWU=;
        b=fn5rx49+T14qr9AE5Z5UHJP2TV3anXSSCzTg0npGA9Yrt4NQVSnYL29d7YH90xqp/o
         cAESc5pqUXHvjoqh70x0YOz3p1D/VFuX+qW82DX0CWyTmrtwrnYxfv7Sk5UEYSepfHMJ
         Krm6uKBmwYSHzzhCjEJ+7349LF2Z3CPsk6gPPyCgyAtfRKV9Kh6S9QtjHOVxm6qeyId5
         F09SJyxodhsNPIAsd973nFlYEA7OV7aHTo2Osbbgf2yWjw+lJkh0L4nh+z9a+tTohuE/
         y7Z1D93MVz1PFIYLwNetuwoGda28uspNbYCjBL8yWgw8s0ZwvKWM5mlqKJrqfYywQxGo
         PD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ixZmUnYAsnmNrcoi3362CfURu2mlbL5TSqES1nWSzWU=;
        b=SQ7RS5plPnJtfPRONGqpbVJcR5G5M/2k+/aRmRGnpqDjrvrnoBNdA+pG6CH+xdUza7
         mLgMRX3wxBDHri8F7zmbhKI3GjLlQLOoLB4rRhbP95JcMGt0m2qpqr4bRpTXFchpjY86
         7bY8LtM9TWJ39o1Q0wTrq4uW4apjyXLz740RinjvNzt1U/0P0sKO8VPmwfeUP4GAkfQD
         ae+zJ6Lfueu2Z4Vqt9DxHy/r/vlDGBidUHPA6/mO2oA0xlpGwTbok8hT3iJyXgLLTndn
         fWF02PKtvPuWAGjO/By8e+XeLleMuQKjYdu9zJu/f7v3VAJ7rEts3xmxoF8zxcsR8VDO
         b2zw==
X-Gm-Message-State: AOAM530Glb8cwDLrGnqH9CU2M+VaTGK9dcLAnamRxYOBSMccMBye/HBl
        cldFc8wAXuQ4sxON7BTql0Q=
X-Google-Smtp-Source: ABdhPJyQQ3u5MFZ80EmLP/dQmS0nJFtV9bO/DCtKHyrQ2hATT1TrR+QGtcSXj0rBM17BNXykVuFPfQ==
X-Received: by 2002:a63:2503:: with SMTP id l3mr1207518pgl.237.1624176873181;
        Sun, 20 Jun 2021 01:14:33 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id z18sm11718437pfe.214.2021.06.20.01.14.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 01:14:32 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 0F2D0360335; Sun, 20 Jun 2021 20:14:29 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Cc:     ebiederm@xmission.com, torvalds@linux-foundation.org,
        schwab@linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v3 3/3] m68k: track syscalls being traced with shallow user context stack
Date:   Sun, 20 Jun 2021 20:14:25 +1200
Message-Id: <1624176865-15570-4-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624176865-15570-1-git-send-email-schmitzmic@gmail.com>
References: <1624176865-15570-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add 'status' field to thread_info struct to hold syscall trace
status info.

Set flag bit in thread_info->status at syscall trace entry, clear
flag bit on trace exit.

Set another flag bit on entering syscall where the full stack
frame has been saved. These flags can be checked whenever a
syscall calls ptrace_stop().

Tested on ARAnyM only - boots and survives running strace on a
binary, nothing fancy.

CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/include/asm/entry.h       | 5 +++++
 arch/m68k/include/asm/thread_info.h | 1 +
 arch/m68k/kernel/asm-offsets.c      | 1 +
 arch/m68k/kernel/entry.S            | 8 ++++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/m68k/include/asm/entry.h b/arch/m68k/include/asm/entry.h
index 9b52b06..e6a5318 100644
--- a/arch/m68k/include/asm/entry.h
+++ b/arch/m68k/include/asm/entry.h
@@ -41,6 +41,11 @@
 #define ALLOWINT	(~0x700)
 #endif /* machine compilation types */
 
+#define TIS_TRACE_ON	(0x1)
+#define TIS_TRACE_OFF	(0xfe)
+#define TIS_SWITCH_STACK	(0x2)
+#define TIS_NO_SWITCH_STACK	(0xfd)
+
 #ifdef __ASSEMBLY__
 /*
  * This defines the normal kernel pt-regs layout.
diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
index 15a7570..a88b48b 100644
--- a/arch/m68k/include/asm/thread_info.h
+++ b/arch/m68k/include/asm/thread_info.h
@@ -29,6 +29,7 @@ struct thread_info {
 	unsigned long		flags;
 	mm_segment_t		addr_limit;	/* thread address space */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
+	unsigned int		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* should always be 0 on m68k */
 	unsigned long		tp_value;	/* thread pointer */
 };
diff --git a/arch/m68k/kernel/asm-offsets.c b/arch/m68k/kernel/asm-offsets.c
index ccea355..ac1ec8f 100644
--- a/arch/m68k/kernel/asm-offsets.c
+++ b/arch/m68k/kernel/asm-offsets.c
@@ -41,6 +41,7 @@ int main(void)
 	/* offsets into the thread_info struct */
 	DEFINE(TINFO_PREEMPT, offsetof(struct thread_info, preempt_count));
 	DEFINE(TINFO_FLAGS, offsetof(struct thread_info, flags));
+	DEFINE(TINFO_STATUS, offsetof(struct thread_info, status));
 
 	/* offsets into the pt_regs */
 	DEFINE(PT_OFF_D0, offsetof(struct pt_regs, d0));
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 0c25038..7fe0cdf 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -77,10 +77,14 @@ ENTRY(__sys_clone3)
 	rts
 
 ENTRY(__sys_exit)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
 	jbsr	m68k_exit
 	lea	%sp@(28),%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(__sys_exit_group)
@@ -200,6 +204,7 @@ ENTRY(ret_from_user_rt_signal)
 #else
 
 do_trace_entry:
+	orb	#TIS_TRACE_ON, %a1@(TINFO_STATUS+3)
 	movel	#-ENOSYS,%sp@(PT_OFF_D0)| needed for strace
 	subql	#4,%sp
 	SAVE_SWITCH_STACK
@@ -210,6 +215,7 @@ do_trace_entry:
 	cmpl	#NR_syscalls,%d0
 	jcs	syscall
 badsys:
+	andb	#TIS_TRACE_OFF, %a1@(TINFO_STATUS+3)
 	movel	#-ENOSYS,%sp@(PT_OFF_D0)
 	jra	ret_from_syscall
 
@@ -219,6 +225,8 @@ do_trace_exit:
 	jbsr	syscall_trace
 	RESTORE_SWITCH_STACK
 	addql	#4,%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_TRACE_OFF, %a1@(TINFO_STATUS+3)
 	jra	.Lret_from_exception
 
 ENTRY(ret_from_signal)
-- 
2.7.4

