Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E35254AFC
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH0Qk7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgH0Qk7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 12:40:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE812087C;
        Thu, 27 Aug 2020 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598546458;
        bh=vsH/gmyUNk+CX8I+Mu9SytE2Mxci2rpQHxcNz0kXh3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3gCg1Liq5ZXYk+eZtmrcOwTzpMKDE4OmyPkn4GuAIF4RxIkyBUGJplxt/WkBnaAF
         SodYZh00vBBqLVoyJ1FNkqHae83NzOV7+nlVzpEBT5MFpXMc+6OtEMUukCOMxCyTe5
         A2IugSmpqybDaA5xbFutfWJ5t7cXwmzIEgwJtSN8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org, guoren@kernel.org
Subject: [PATCH v3 16/16] kprobes: Make local used functions static
Date:   Fri, 28 Aug 2020 01:40:55 +0900
Message-Id: <159854645522.736475.5296257647578367884.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159854631442.736475.5062989489155389472.stgit@devnote2>
References: <159854631442.736475.5062989489155389472.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since we unified the kretprobe trampoline handler from arch/* code,
some functions and objects no need to be exported anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |   15 ---------------
 kernel/kprobes.c        |   12 ++++++++----
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b4388abedecf..e2dbf5bb7560 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -190,7 +190,6 @@ static inline int kprobes_built_in(void)
 	return 1;
 }
 
-extern struct kprobe kprobe_busy;
 void kprobe_busy_begin(void);
 void kprobe_busy_end(void);
 
@@ -235,16 +234,6 @@ static inline int arch_trampoline_kprobe(struct kprobe *p)
 
 extern struct kretprobe_blackpoint kretprobe_blacklist[];
 
-static inline void kretprobe_assert(struct kretprobe_instance *ri,
-	unsigned long orig_ret_address, unsigned long trampoline_address)
-{
-	if (!orig_ret_address || (orig_ret_address == trampoline_address)) {
-		printk("kretprobe BUG!: Processing kretprobe %p @ %p\n",
-				ri->rp, ri->rp->kp.addr);
-		BUG();
-	}
-}
-
 #ifdef CONFIG_KPROBES_SANITY_TEST
 extern int init_test_probes(void);
 #else
@@ -364,10 +353,6 @@ int arch_check_ftrace_location(struct kprobe *p);
 
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
-void kretprobe_hash_lock(struct task_struct *tsk,
-			 struct hlist_head **head, unsigned long *flags);
-void kretprobe_hash_unlock(struct task_struct *tsk, unsigned long *flags);
-struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
 
 /* kprobe_running() will just return the current_kprobe on this CPU */
 static inline struct kprobe *kprobe_running(void)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ce788574883b..55874dc1c182 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1239,7 +1239,7 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
-void kretprobe_hash_lock(struct task_struct *tsk,
+static void kretprobe_hash_lock(struct task_struct *tsk,
 			 struct hlist_head **head, unsigned long *flags)
 __acquires(hlist_lock)
 {
@@ -1261,7 +1261,7 @@ __acquires(hlist_lock)
 }
 NOKPROBE_SYMBOL(kretprobe_table_lock);
 
-void kretprobe_hash_unlock(struct task_struct *tsk,
+static void kretprobe_hash_unlock(struct task_struct *tsk,
 			   unsigned long *flags)
 __releases(hlist_lock)
 {
@@ -1282,7 +1282,7 @@ __releases(hlist_lock)
 }
 NOKPROBE_SYMBOL(kretprobe_table_unlock);
 
-struct kprobe kprobe_busy = {
+static struct kprobe kprobe_busy = {
 	.addr = (void *) get_kprobe,
 };
 
@@ -1983,7 +1983,11 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 			break;
 	}
 
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
+	if (!orig_ret_address || (orig_ret_address == trampoline_address)) {
+		pr_err("kretprobe BUG!: Processing kretprobe %p @ %p\n",
+				ri->rp, ri->rp->kp.addr);
+		BUG();
+	}
 
 	correct_ret_addr = ri->ret_addr;
 	hlist_for_each_entry_safe(ri, tmp, head, hlist) {

