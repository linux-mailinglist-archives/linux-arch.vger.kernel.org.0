Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27C0254AFA
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgH0Qkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbgH0Qku (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 12:40:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CAA2177B;
        Thu, 27 Aug 2020 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598546449;
        bh=99qlixoES1XGgdUzUQy3aMnH6fHb80jko6dmcJ0RG6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4720MpCI+wDtv2Tq0YmEcQtKV2f2tCV1nU7+ITLPRxaOHm3/PdsklTcNC7Gw3rzt
         Te4FWzhPSYNWT3gw1OS5p7OjPi0i2zF1SET/xAmG2YR5PfPAT7Tl/DpcC7opaAMavL
         +H7wEOxPylob5iYZQt1vePcKlS3PZpGTbaOJqR3g=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org, guoren@kernel.org
Subject: [PATCH v3 15/16] kprobes: Free kretprobe_instance with rcu callback
Date:   Fri, 28 Aug 2020 01:40:46 +0900
Message-Id: <159854644641.736475.2495205002588583050.stgit@devnote2>
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

Free kretprobe_instance with rcu callback instead of directly
freeing the object in the kretprobe handler context.

This will make kretprobe run safer in NMI context.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
   - Stick the rcu_head with hlist_node in kretprobe_instance
   - Make recycle_rp_inst() static
---
 include/linux/kprobes.h |    6 ++++--
 kernel/kprobes.c        |   25 ++++++-------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 46a7afcf5ec0..b4388abedecf 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -156,7 +156,10 @@ struct kretprobe {
 };
 
 struct kretprobe_instance {
-	struct hlist_node hlist;
+	union {
+		struct hlist_node hlist;
+		struct rcu_head rcu;
+	};
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
 	struct task_struct *task;
@@ -395,7 +398,6 @@ int register_kretprobes(struct kretprobe **rps, int num);
 void unregister_kretprobes(struct kretprobe **rps, int num);
 
 void kprobe_flush_task(struct task_struct *tk);
-void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
 
 int disable_kprobe(struct kprobe *kp);
 int enable_kprobe(struct kprobe *kp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 311033e4b8e4..ce788574883b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1223,8 +1223,7 @@ void kprobes_inc_nmissed_count(struct kprobe *p)
 }
 NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 
-void recycle_rp_inst(struct kretprobe_instance *ri,
-		     struct hlist_head *head)
+static void recycle_rp_inst(struct kretprobe_instance *ri)
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

