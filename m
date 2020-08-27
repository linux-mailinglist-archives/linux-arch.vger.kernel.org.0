Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4D2548D7
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgH0PO3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 11:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbgH0Lib (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 07:38:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E592073A;
        Thu, 27 Aug 2020 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598528273;
        bh=cEjm4UlbBMPWGbgIopyTUYmvQaJ0GXlaku6V6ViozRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KR6uba1Hdptq3GIGj2zlhWYR67rr4oL0448CEbb30/2jve4OvrSVRemt73hbHSKN8
         fbwS64tMbduPQzCK3rFYeijyQA+4bm17xIg9bgZ4+x0H4ScI6qvHAMjv3ew1VI5tsq
         VYL4xVj6TkAiLZFh6d4zSBtov5+VbkMyBCXZmRyQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 15/15] kprobes: Free kretprobe_instance with rcu callback
Date:   Thu, 27 Aug 2020 20:37:49 +0900
Message-Id: <159852826969.707944.15092569392287597887.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159852811819.707944.12798182250041968537.stgit@devnote2>
References: <159852811819.707944.12798182250041968537.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Free kretprobe_instance with rcu callback instead of directly
freeing the object in the kretprobe handler context.

This will make kretprobe run safer in NMI context.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    3 ++-
 kernel/kprobes.c        |   25 ++++++-------------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 46a7afcf5ec0..97557f820d9b 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -160,6 +160,7 @@ struct kretprobe_instance {
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
 	struct task_struct *task;
+	struct rcu_head rcu;
 	void *fp;
 	char data[];
 };
@@ -395,7 +396,7 @@ int register_kretprobes(struct kretprobe **rps, int num);
 void unregister_kretprobes(struct kretprobe **rps, int num);
 
 void kprobe_flush_task(struct task_struct *tk);
-void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
+void recycle_rp_inst(struct kretprobe_instance *ri);
 
 int disable_kprobe(struct kprobe *kp);
 int enable_kprobe(struct kprobe *kp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 311033e4b8e4..c19b8ccc67ec 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1223,8 +1223,7 @@ void kprobes_inc_nmissed_count(struct kprobe *p)
 }
 NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 
-void recycle_rp_inst(struct kretprobe_instance *ri,
-		     struct hlist_head *head)
+void recycle_rp_inst(struct kretprobe_instance *ri)
 {
 	struct kretprobe *rp = ri->rp;
 
@@ -1236,8 +1235,7 @@ void recycle_rp_inst(struct kretprobe_instance *ri,
 		hlist_add_head(&ri->hlist, &rp->free_instances);
 		raw_spin_unlock(&rp->lock);
 	} else
-		/* Unregistering */
-		hlist_add_head(&ri->hlist, head);
+		kfree_rcu(ri, rcu);
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
@@ -1313,7 +1311,7 @@ void kprobe_busy_end(void)
 void kprobe_flush_task(struct task_struct *tk)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_head *head, empty_rp;
+	struct hlist_head *head;
 	struct hlist_node *tmp;
 	unsigned long hash, flags = 0;
 
@@ -1323,19 +1321,14 @@ void kprobe_flush_task(struct task_struct *tk)
 
 	kprobe_busy_begin();
 
-	INIT_HLIST_HEAD(&empty_rp);
 	hash = hash_ptr(tk, KPROBE_HASH_BITS);
 	head = &kretprobe_inst_table[hash];
 	kretprobe_table_lock(hash, &flags);
 	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
 		if (ri->task == tk)
-			recycle_rp_inst(ri, &empty_rp);
+			recycle_rp_inst(ri);
 	}
 	kretprobe_table_unlock(hash, &flags);
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
 
 	kprobe_busy_end();
 }
@@ -1936,13 +1929,12 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					void *frame_pointer)
 {
 	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
+	struct hlist_head *head;
 	struct hlist_node *tmp;
 	unsigned long flags, orig_ret_address = 0;
 	kprobe_opcode_t *correct_ret_addr = NULL;
 	bool skipped = false;
 
-	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
 
 	/*
@@ -2009,7 +2001,7 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 			__this_cpu_write(current_kprobe, &kprobe_busy);
 		}
 
-		recycle_rp_inst(ri, &empty_rp);
+		recycle_rp_inst(ri);
 
 		if (orig_ret_address != trampoline_address)
 			/*
@@ -2022,11 +2014,6 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 
 	kretprobe_hash_unlock(current, &flags);
 
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
 	return orig_ret_address;
 }
 NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)

