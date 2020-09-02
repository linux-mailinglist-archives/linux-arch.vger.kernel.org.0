Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA425A8B3
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIBJgs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 05:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBJgr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 05:36:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7FFC061244;
        Wed,  2 Sep 2020 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CVKEqJ8VyRUxV18RMo+VlglQJ7cxy86dcBr7cGPxf7Y=; b=m5yZH7JL8dt+/qaFKkqSkHCry4
        pWPuDkOH4lEEQIGy6PkdEl2zH4iSODB+w69Ktxi/JQdBqbiMOeY97fRfrKqosnwimzLCIQh4e8GkZ
        luum03hjmwT1uYHLsKB7T4qrNMsbSY3EvnStY4kIvdIwYOv4nOtIBCfNEZyhxwM9mpSsA+d+nIFlY
        jRHyOq0uUHQX4ZShGk2QAUUAh93kD7zrxmWd8ISYKR0oocjVwR9uJ9UycvNJEha9ODECfEQf9pxVV
        ChN36dgeYob5bsQ6gZDdVr1VYD06wr917Xro7usDZTiEwSuPd91dz0+Wvjkl8kS/9i0QhOomRDk3g
        VJZ6bMxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDPBf-0006nb-Nh; Wed, 02 Sep 2020 09:36:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B06F63003E5;
        Wed,  2 Sep 2020 11:36:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66A1323D3D729; Wed,  2 Sep 2020 11:36:13 +0200 (CEST)
Date:   Wed, 2 Sep 2020 11:36:13 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-ID: <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
 <20200901190808.GK29142@worktop.programming.kicks-ass.net>
 <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
 <20200902070226.GG2674@hirez.programming.kicks-ass.net>
 <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 05:17:55PM +0900, Masami Hiramatsu wrote:

> > Ok, but then lockdep will yell at you if you have that enabled and run
> > the unoptimized things.
> 
> Oh, does it warn for all spinlock things in kprobes if it is unoptimized?
> Hmm, it has to be noted in the documentation.

Lockdep will warn about spinlocks used in NMI context that are also used
outside NMI context.

Now, for the kretprobe that kprobe_busy flag prevents the actual
recursion self-deadlock, but lockdep isn't smart enough to see that.

One way around this might be to use SINGLE_DEPTH_NESTING for locks when
we use them from INT3 context. That way they'll have a different class
and lockdep will not see the recursion.

pre_handler_kretprobe() is always called from INT3, right?

Something like the below might then work...

---
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 287b263c9cb9..b78f4fe08e86 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1255,11 +1255,11 @@ __acquires(hlist_lock)
 NOKPROBE_SYMBOL(kretprobe_hash_lock);
 
 static void kretprobe_table_lock(unsigned long hash,
-				 unsigned long *flags)
+				 unsigned long *flags, int nesting)
 __acquires(hlist_lock)
 {
 	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_lock_irqsave(hlist_lock, *flags);
+	raw_spin_lock_irqsave_nested(hlist_lock, *flags, nesting);
 }
 NOKPROBE_SYMBOL(kretprobe_table_lock);
 
@@ -1326,7 +1326,7 @@ void kprobe_flush_task(struct task_struct *tk)
 	INIT_HLIST_HEAD(&empty_rp);
 	hash = hash_ptr(tk, KPROBE_HASH_BITS);
 	head = &kretprobe_inst_table[hash];
-	kretprobe_table_lock(hash, &flags);
+	kretprobe_table_lock(hash, &flags, 0);
 	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
 		if (ri->task == tk)
 			recycle_rp_inst(ri, &empty_rp);
@@ -1361,7 +1361,7 @@ static void cleanup_rp_inst(struct kretprobe *rp)
 
 	/* No race here */
 	for (hash = 0; hash < KPROBE_TABLE_SIZE; hash++) {
-		kretprobe_table_lock(hash, &flags);
+		kretprobe_table_lock(hash, &flags, 0);
 		head = &kretprobe_inst_table[hash];
 		hlist_for_each_entry_safe(ri, next, head, hlist) {
 			if (ri->rp == rp)
@@ -1950,7 +1950,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 
 	/* TODO: consider to only swap the RA after the last pre_handler fired */
 	hash = hash_ptr(current, KPROBE_HASH_BITS);
-	raw_spin_lock_irqsave(&rp->lock, flags);
+	raw_spin_lock_irqsave_nested(&rp->lock, flags, SINGLE_DEPTH_NESTING);
 	if (!hlist_empty(&rp->free_instances)) {
 		ri = hlist_entry(rp->free_instances.first,
 				struct kretprobe_instance, hlist);
@@ -1961,7 +1961,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 		ri->task = current;
 
 		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-			raw_spin_lock_irqsave(&rp->lock, flags);
+			raw_spin_lock_irqsave_nested(&rp->lock, flags, SINGLE_DEPTH_NESTING);
 			hlist_add_head(&ri->hlist, &rp->free_instances);
 			raw_spin_unlock_irqrestore(&rp->lock, flags);
 			return 0;
@@ -1971,7 +1971,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 
 		/* XXX(hch): why is there no hlist_move_head? */
 		INIT_HLIST_NODE(&ri->hlist);
-		kretprobe_table_lock(hash, &flags);
+		kretprobe_table_lock(hash, &flags, SINGLE_DEPTH_NESTING);
 		hlist_add_head(&ri->hlist, &kretprobe_inst_table[hash]);
 		kretprobe_table_unlock(hash, &flags);
 	} else {
