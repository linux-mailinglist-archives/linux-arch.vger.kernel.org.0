Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715B52A5C97
	for <lists+linux-arch@lfdr.de>; Wed,  4 Nov 2020 03:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgKDCI5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 21:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgKDCI5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Nov 2020 21:08:57 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D092206F9;
        Wed,  4 Nov 2020 02:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604455736;
        bh=qBXpwdmJhHsoLx/QiLWblIhxH+snDEjjhdDpYvqd8xc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XWGEK+Is04g6D8jeNxQI5tV+j7EfqX2Z30zToLYe+0pBIuuBsbO7N13ByuG7g5Qg/
         amU2sV4+14md/egFLm+EzhreyhNSKGvwvTX3kCPDCpuKFPVJlunwh6998BDWzZulMk
         YEkpsrLW0WAMGfaF336UOI/ESQiwrl8vg7HHKKtw=
Date:   Wed, 4 Nov 2020 11:08:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH v5 14/21] kprobes: Remove NMI context check
Message-Id: <20201104110852.5dcace1aa7f912020ca1be2e@kernel.org>
In-Reply-To: <20201103110913.2d7b4cea@rorschach.local.home>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <159870615628.1229682.6087311596892125907.stgit@devnote2>
        <20201030213831.04e81962@oasis.local.home>
        <20201102141138.1fa825113742f3bea23bc383@kernel.org>
        <20201102145334.23d4ba691c13e0b6ca87f36d@kernel.org>
        <20201102160234.fa0ae70915ad9e2b21c08b85@kernel.org>
        <20201102092726.57cb643f@gandalf.local.home>
        <20201103143938.704c7974e93c854511580c38@kernel.org>
        <20201103110913.2d7b4cea@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 3 Nov 2020 11:09:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 3 Nov 2020 14:39:38 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Ah, OK. This looks good to me.
> > 
> > BTW, in_nmi() in pre_handler_kretprobe() always be true because
> > now int3 is treated as an NMI. So you can always pass 1 there.
> 
> What about the below patch then?

kretprobe_hash_lock() and kretprobe_table_lock() will be called from
outside of the kprobe pre_handler context. So, please keep in_nmi()
in those functions.
for the pre_handler_kretprobe(), this looks good to me.

Thank you,

> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks!
> 
> From 29ac1a5c9068df06f3196173d4325c8076759551 Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Date: Mon, 2 Nov 2020 09:17:49 -0500
> Subject: [PATCH] kprobes: Tell lockdep about kprobe nesting
> 
> Since the kprobe handlers have protection that prohibits other handlers from
> executing in other contexts (like if an NMI comes in while processing a
> kprobe, and executes the same kprobe, it will get fail with a "busy"
> return). Lockdep is unaware of this protection. Use lockdep's nesting api to
> differentiate between locks taken in INT3 context and other context to
> suppress the false warnings.
> 
> Link: https://lore.kernel.org/r/20201102160234.fa0ae70915ad9e2b21c08b85@kernel.org
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/kprobes.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 8a12a25fa40d..30889ea5514f 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1249,7 +1249,12 @@ __acquires(hlist_lock)
>  
>  	*head = &kretprobe_inst_table[hash];
>  	hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
> +	/*
> +	 * Nested is a workaround that will soon not be needed.
> +	 * There's other protections that make sure the same lock
> +	 * is not taken on the same CPU that lockdep is unaware of.
> +	 */
> +	raw_spin_lock_irqsave_nested(hlist_lock, *flags, 1);
>  }
>  NOKPROBE_SYMBOL(kretprobe_hash_lock);
>  
> @@ -1258,7 +1263,12 @@ static void kretprobe_table_lock(unsigned long hash,
>  __acquires(hlist_lock)
>  {
>  	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
> +	/*
> +	 * Nested is a workaround that will soon not be needed.
> +	 * There's other protections that make sure the same lock
> +	 * is not taken on the same CPU that lockdep is unaware of.
> +	 */
> +	raw_spin_lock_irqsave_nested(hlist_lock, *flags, 1);
>  }
>  NOKPROBE_SYMBOL(kretprobe_table_lock);
>  
> @@ -2028,7 +2038,12 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  
>  	/* TODO: consider to only swap the RA after the last pre_handler fired */
>  	hash = hash_ptr(current, KPROBE_HASH_BITS);
> -	raw_spin_lock_irqsave(&rp->lock, flags);
> +	/*
> +	 * Nested is a workaround that will soon not be needed.
> +	 * There's other protections that make sure the same lock
> +	 * is not taken on the same CPU that lockdep is unaware of.
> +	 */
> +	raw_spin_lock_irqsave_nested(&rp->lock, flags, 1);
>  	if (!hlist_empty(&rp->free_instances)) {
>  		ri = hlist_entry(rp->free_instances.first,
>  				struct kretprobe_instance, hlist);
> @@ -2039,7 +2054,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  		ri->task = current;
>  
>  		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
> -			raw_spin_lock_irqsave(&rp->lock, flags);
> +			raw_spin_lock_irqsave_nested(&rp->lock, flags, 1);
>  			hlist_add_head(&ri->hlist, &rp->free_instances);
>  			raw_spin_unlock_irqrestore(&rp->lock, flags);
>  			return 0;
> -- 
> 2.25.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
