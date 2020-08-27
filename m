Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96017254A8B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgH0QV2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgH0QV1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:21:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90888C061264;
        Thu, 27 Aug 2020 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BWEl8bF4KSKcL/2rh1UKiQEUDsP7RnkAC7synKLKMUY=; b=vG1pkpfuPkP+zUTmvLIr+DU1pU
        yDXq7tNnW5j0KccQI5XGojZuTPJ9Vt+tP58+PNuAuv35KufMh5cMsNxZtGwm40hDHdZ77q8ki/8RC
        Um9bGgMXwQJ+SAA24FX129Ntdrp/89xZ7h/3G72zfI26y55qJMshMEApWiYtGOYKyaVXSDt4NXin0
        fGIlj6Jqx8BhxkGAm20wG7yEnbra+MXu29YKA+VNtmZxg96/WY4qSoBYTFfhap4g2iOSNMThJEqQU
        3ModKNPKuhs3ij9Bys4pWeI85e+0AIexRcSOzyzNm0o8VOSCijD2le83HX/xrpNDA8jttKzZLN4Gk
        A04K8QMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKe5-0003xm-B6; Thu, 27 Aug 2020 16:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B11DC305C22;
        Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7F7AA2C2868F6; Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Message-ID: <20200827161754.418488259@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Aug 2020 18:12:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 4/7] kprobe: Dont kfree() from breakpoint context
References: <20200827161237.889877377@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Breakpoint context might not be a safe context for kfree(), push it
out to RCU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/kprobes.h |    2 +-
 kernel/kprobes.c        |   27 ++++++---------------------
 2 files changed, 7 insertions(+), 22 deletions(-)

--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -159,6 +159,7 @@ struct kretprobe_instance {
 	union {
 		struct llist_node llist;
 		struct hlist_node hlist;
+		struct rcu_head rcu;
 	};
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
@@ -398,7 +399,6 @@ int register_kretprobes(struct kretprobe
 void unregister_kretprobes(struct kretprobe **rps, int num);
 
 void kprobe_flush_task(struct task_struct *tk);
-void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
 
 int disable_kprobe(struct kprobe *kp);
 int enable_kprobe(struct kprobe *kp);
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1214,8 +1214,7 @@ void kprobes_inc_nmissed_count(struct kp
 }
 NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 
-void recycle_rp_inst(struct kretprobe_instance *ri,
-		     struct hlist_head *head)
+static void recycle_rp_inst(struct kretprobe_instance *ri)
 {
 	struct kretprobe *rp = ri->rp;
 
@@ -1226,9 +1225,9 @@ void recycle_rp_inst(struct kretprobe_in
 		raw_spin_lock(&rp->lock);
 		hlist_add_head(&ri->hlist, &rp->free_instances);
 		raw_spin_unlock(&rp->lock);
-	} else
-		/* Unregistering */
-		hlist_add_head(&ri->hlist, head);
+	} else {
+		kfree_rcu(ri, rcu);
+	}
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
@@ -1261,15 +1260,12 @@ void kprobe_busy_end(void)
 void kprobe_flush_task(struct task_struct *tk)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_head empty_rp;
 	struct llist_node *node;
-	struct hlist_node *tmp;
 
 	/* Early boot, not yet initialized. */
 	if (unlikely(!kprobes_initialized))
 		return;
 
-	INIT_HLIST_HEAD(&empty_rp);
 
 	kprobe_busy_begin();
 
@@ -1280,12 +1276,7 @@ void kprobe_flush_task(struct task_struc
 		ri = container_of(node, struct kretprobe_instance, llist);
 		node = node->next;
 
-		recycle_rp_inst(ri, &empty_rp);
-	}
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
+		recycle_rp_inst(ri);
 	}
 
 	kprobe_busy_end();
@@ -1937,7 +1928,6 @@ unsigned long __kretprobe_trampoline_han
 	unsigned long orig_ret_address = 0;
 	struct llist_node *first, *node;
 	struct hlist_head empty_rp;
-	struct hlist_node *tmp;
 
 	INIT_HLIST_HEAD(&empty_rp);
 
@@ -1980,16 +1970,11 @@ unsigned long __kretprobe_trampoline_han
 			__this_cpu_write(current_kprobe, &kprobe_busy);
 		}
 
-		recycle_rp_inst(ri, &empty_rp);
+		recycle_rp_inst(ri);
 
 		first = node;
 	}
 
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
 	return orig_ret_address;
 }
 NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)


