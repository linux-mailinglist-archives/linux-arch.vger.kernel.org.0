Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0333E1A7AFE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440150AbgDNMlo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 08:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440146AbgDNMlm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 08:41:42 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D44AC20768;
        Tue, 14 Apr 2020 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586868101;
        bh=9KRqqTKaIASeKnXv5UC9x+S15ibXz/EkB3du77R8j4I=;
        h=From:To:Cc:Subject:Date:From;
        b=cs0VnoGUuOKql4W/lnTEp6dYcykdwAiqsSrzh50bWdKeHZkRzdnKDbwQdN+aQtdrQ
         z3peq0s4qbpEn/U4llX3yw+Vxr/eKj9b7MU721nGm0HM9067E8r6B9jv1aGWjPhg70
         tSifnl9A3Ss1T1nIzNUg/C1MFT4pEakcKPplTPSE=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] csky: Fixup perf probe -x hungup
Date:   Tue, 14 Apr 2020 20:41:29 +0800
Message-Id: <20200414124129.9048-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

case:
 # perf probe -x /lib/libc-2.28.9000.so memcpy
 # perf record -e probe_libc:memcpy -aR sleep 1

System hangup and cpu get in trap_c loop, because our hardware
singlestep state could still get interrupt signal. When we get in
uprobe_xol singlestep slot, we should disable irq in pt_regs->psr.

And is_swbp_insn() need a csky arch implementation with a low 16bit
mask.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/csky/kernel/probes/uprobes.c | 5 +++++
 arch/csky/kernel/ptrace.c         | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/csky/kernel/probes/uprobes.c b/arch/csky/kernel/probes/uprobes.c
index b3a56c260e3e..1a9e0961b2b5 100644
--- a/arch/csky/kernel/probes/uprobes.c
+++ b/arch/csky/kernel/probes/uprobes.c
@@ -11,6 +11,11 @@
 
 #define UPROBE_TRAP_NR	UINT_MAX
 
+bool is_swbp_insn(uprobe_opcode_t *insn)
+{
+	return (*insn & 0xffff) == UPROBE_SWBP_INSN;
+}
+
 unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 {
 	return instruction_pointer(regs);
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 21ac2608f205..5a82230bddf9 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -41,6 +41,9 @@ static void singlestep_disable(struct task_struct *tsk)
 
 	regs = task_pt_regs(tsk);
 	regs->sr = (regs->sr & TRACE_MODE_MASK) | TRACE_MODE_RUN;
+
+	/* Enable irq */
+	regs->sr |= BIT(6);
 }
 
 static void singlestep_enable(struct task_struct *tsk)
@@ -49,6 +52,9 @@ static void singlestep_enable(struct task_struct *tsk)
 
 	regs = task_pt_regs(tsk);
 	regs->sr = (regs->sr & TRACE_MODE_MASK) | TRACE_MODE_SI;
+
+	/* Disable irq */
+	regs->sr &= ~BIT(6);
 }
 
 /*
-- 
2.17.0

