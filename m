Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD8255D80
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 17:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgH1PKW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 11:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgH1PKO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 11:10:14 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887672075B;
        Fri, 28 Aug 2020 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598627413;
        bh=PrP0KZRG1DhLRFzzw3mCFk9aegopKVVxyDcozCLP1kI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G3n2U5YJTocDbjExwq1mwio5Hrb3nbiNDRk68jsl+Z9eAA3bundz55ry2lAZ6+NUz
         bpfIPU5an5dJFD3mnvUX3JpSkNW+1SEPJbdCITt3zj/KZzvJ+53yI/Up4/Jlag3E+x
         4ZI1uBgb5zfAyI48//YtXRbfjESqmHv2LohQOhzE=
Date:   Sat, 29 Aug 2020 00:10:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 20/23] [RFC] kprobes: Remove task scan for updating
 kretprobe_instance
Message-Id: <20200829001010.7ec1a183c2294f7bd843b153@kernel.org>
In-Reply-To: <20200828125236.GA1362448@hirez.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
        <159861781740.992023.4956784710984854658.stgit@devnote2>
        <20200828125236.GA1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 14:52:36 +0200
peterz@infradead.org wrote:

> 
> If you do this, can you merge this into the previos patch and then
> delete the sched try_to_invoke..() patch?

Yes, this is just for making code review easy. :)

> 
> Few comments below.
> 
> On Fri, Aug 28, 2020 at 09:30:17PM +0900, Masami Hiramatsu wrote:
> 
> 
> > +static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
> > +{
> > +	/* rph->rp can be updated by unregister_kretprobe() on other cpu */
> > +	smp_rmb();
> > +	return ri->rph->rp;
> > +}
> 
> That ordering doesn't really make sense, ordering requires at least two
> variables, here there is only 1. That said, get functions usually need
> an ACQUIRE order to make sure subsequent accesses are indeed done later.

So, 
	return smp_load_acquire(ri->rph->rp);
will be enough?

> 
> >  #else /* CONFIG_KRETPROBES */
> >  static inline void arch_prepare_kretprobe(struct kretprobe *rp,
> >  					struct pt_regs *regs)
> 
> > @@ -1922,6 +1869,7 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> >  	kprobe_opcode_t *correct_ret_addr = NULL;
> >  	struct kretprobe_instance *ri = NULL;
> >  	struct llist_node *first, *node;
> > +	struct kretprobe *rp;
> >  
> >  	first = node = current->kretprobe_instances.first;
> >  	while (node) {
> > @@ -1951,12 +1899,13 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> >  	/* Run them..  */
> >  	while (first) {
> >  		ri = container_of(first, struct kretprobe_instance, llist);
> > +		rp = get_kretprobe(ri);
> >  		node = first->next;
> 
> (A)
> 
> > -		if (ri->rp && ri->rp->handler) {
> > -			__this_cpu_write(current_kprobe, &ri->rp->kp);
> > +		if (rp && rp->handler) {
> > +			__this_cpu_write(current_kprobe, &rp->kp);
> >  			ri->ret_addr = correct_ret_addr;
> > -			ri->rp->handler(ri, regs);
> > +			rp->handler(ri, regs);
> >  			__this_cpu_write(current_kprobe, &kprobe_busy);
> >  		}
> 
> So here we're using get_kretprobe(), but what is to stop anybody from
> doing unregister_kretprobe() right at (A) such that we did observe our
> rp, but by the time we use it, it's a goner.

In kprobe_busy_begin() we disable preempt, so this block is not preemptive.
And as you may know, the unregister_kretprobe() is waiting rcu grace period
after it clear the rp->rph->rp. So, someone does unregister_kretprobe() at
(A), rph->rp = NULL but rp itself is not released until all running
trampoline_handlers exit. 

> 
> 
> > +	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
> > +	rp->rph->rp = rp;
> 
> I think you'll need to check the allocation succeeded, no? :-)

Oops, I had found it once but forgot to fix :( 

> 
> 
> > @@ -2114,16 +2065,20 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
> >  	if (num <= 0)
> >  		return;
> >  	mutex_lock(&kprobe_mutex);
> > -	for (i = 0; i < num; i++)
> > +	for (i = 0; i < num; i++) {
> >  		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
> >  			rps[i]->kp.addr = NULL;
> > +		rps[i]->rph->rp = NULL;
> > +	}
> > +	/* Ensure the rph->rp updated after this */
> > +	smp_wmb();
> >  	mutex_unlock(&kprobe_mutex);
> 
> That ordering is dodgy again, those barriers don't help anything if
> someone else is at (A) above.
> 
> >  
> >  	synchronize_rcu();
> 
> This one might help, this means we can do rcu_read_lock() around
> get_kretprobe() and it's usage. Can we call rp->handler() under RCU?

Yes, as I said above, the get_kretprobe() (and kretprobe handler) must be
called under preempt-disabled.

Thank you,

> 
> >  	for (i = 0; i < num; i++) {
> >  		if (rps[i]->kp.addr) {
> >  			__unregister_kprobe_bottom(&rps[i]->kp);
> > -			cleanup_rp_inst(rps[i]);
> > +			free_rp_inst(rps[i]);
> >  		}
> >  	}
> >  }


-- 
Masami Hiramatsu <mhiramat@kernel.org>
