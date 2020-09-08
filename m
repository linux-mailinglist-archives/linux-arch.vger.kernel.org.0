Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA1261011
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgIHKiv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbgIHKiq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 06:38:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E253C061573;
        Tue,  8 Sep 2020 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ISh9u6ihC6dsEdEFWUT5lsWp0yYMA219sfvjogaE8k=; b=RMq48vfEHkq10ewZxKMyV0cJTU
        d77ECXoAzBMqZ1yIhTkuY5cN6cMbnEBH8jiPxfD9YmPzbhUrJpMvWby2OzIs2NdgJob0ckc1t4fec
        V+ibArMDnCJEgpQd9gHFKX1H4u+o4ncbUO1ONCh53IyHT7pHg15uySS//p2zEgjML8jxKQMbExswQ
        8JHGvmr4wnEJrBoKylE/SyaBQ3O5nrksh1fC9SRIV3H/J9y7p0YMcKxMqDbyWaMUKnUdEQjqY63Z0
        galX/vXXWZ056/5fU3dwLHeI/3QTEPQbpag6X3mvm+JKWgTjJrDB3MVGVU/Ws2BA6CnNzs220DepV
        g8XJBbEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFb0L-0006I4-VN; Tue, 08 Sep 2020 10:37:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9D87305C10;
        Tue,  8 Sep 2020 12:37:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D77520240A53; Tue,  8 Sep 2020 12:37:36 +0200 (CEST)
Date:   Tue, 8 Sep 2020 12:37:36 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, systemtap@sourceware.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-ID: <20200908103736.GP1362448@hirez.programming.kicks-ass.net>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
 <20200901190808.GK29142@worktop.programming.kicks-ass.net>
 <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
 <20200902070226.GG2674@hirez.programming.kicks-ass.net>
 <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
 <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
 <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
 <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
 <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 10:39:54AM +0900, Masami Hiramatsu wrote:

> > There's a bug, that might make it miss it. I have a patch. I'll send it
> > shortly.
> 
> OK, I've confirmed that the lockdep warns on kretprobe from INT3
> with your fix.

I'm now trying and failing to reproduce.... I can't seem to make it use
int3 today. It seems to want to use ftrace or refuses everything. I'm
probably doing it wrong.

Could you verify the below actually works? It's on top of the first 16
patches.

> Of course make it lockless then warning is gone.
> But even without the lockless patch, this warning can be false-positive
> because we prohibit nested kprobe call, right?

Yes, because the actual nesting is avoided by kprobe_busy, but lockdep
can't tell. Lockdep sees a regular lock user and an in-nmi lock user and
figures that's a bad combination.


---
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1241,48 +1241,47 @@ void recycle_rp_inst(struct kretprobe_in
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
-void kretprobe_hash_lock(struct task_struct *tsk,
-			 struct hlist_head **head, unsigned long *flags)
-__acquires(hlist_lock)
-{
-	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
-	raw_spinlock_t *hlist_lock;
-
-	*head = &kretprobe_inst_table[hash];
-	hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_lock_irqsave(hlist_lock, *flags);
-}
-NOKPROBE_SYMBOL(kretprobe_hash_lock);
-
 static void kretprobe_table_lock(unsigned long hash,
 				 unsigned long *flags)
 __acquires(hlist_lock)
 {
 	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_lock_irqsave(hlist_lock, *flags);
+	/*
+	 * HACK, due to kprobe_busy we'll never actually recurse, make NMI
+	 * context use a different lock class to avoid it reporting.
+	 */
+	raw_spin_lock_irqsave_nested(hlist_lock, *flags, !!in_nmi());
 }
 NOKPROBE_SYMBOL(kretprobe_table_lock);
 
-void kretprobe_hash_unlock(struct task_struct *tsk,
-			   unsigned long *flags)
+static void kretprobe_table_unlock(unsigned long hash,
+				   unsigned long *flags)
 __releases(hlist_lock)
 {
+	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
+	raw_spin_unlock_irqrestore(hlist_lock, *flags);
+}
+NOKPROBE_SYMBOL(kretprobe_table_unlock);
+
+void kretprobe_hash_lock(struct task_struct *tsk,
+			 struct hlist_head **head, unsigned long *flags)
+__acquires(hlist_lock)
+{
 	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
-	raw_spinlock_t *hlist_lock;
 
-	hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_unlock_irqrestore(hlist_lock, *flags);
+	*head = &kretprobe_inst_table[hash];
+	kretprobe_table_lock(hash, flags);
 }
-NOKPROBE_SYMBOL(kretprobe_hash_unlock);
+NOKPROBE_SYMBOL(kretprobe_hash_lock);
 
-static void kretprobe_table_unlock(unsigned long hash,
-				   unsigned long *flags)
+void kretprobe_hash_unlock(struct task_struct *tsk,
+			   unsigned long *flags)
 __releases(hlist_lock)
 {
-	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_unlock_irqrestore(hlist_lock, *flags);
+	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
+	kretprobe_table_unlock(hash, flags);
 }
-NOKPROBE_SYMBOL(kretprobe_table_unlock);
+NOKPROBE_SYMBOL(kretprobe_hash_unlock);
 
 struct kprobe kprobe_busy = {
 	.addr = (void *) get_kprobe,
