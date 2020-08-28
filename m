Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD93255AA2
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgH1MxM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgH1MxJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 08:53:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F21C061264;
        Fri, 28 Aug 2020 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eNFyxaEj7t6vlSUAnZyQPMyYFO6YdgRp/R5bl4UKOTw=; b=AbbL1l/Zp2y4WpHkdgCPgPgh6f
        vmOIYHfSmuD6w3mOZcgGJxsWISlDHqROgko8fCH56TD7hPRTLyeEsZbdiYjws3OM4MzqXby/2EbXA
        BVGijqq1gmJdszha5QL/gi+mx4p7F6HzI9ZJN8ORn/LLL2iwKFKW7diL2FAwbnojR9kUslPwiQ8gy
        v+7Gzmzm0bV0LF/uiy1PLK6GQ64PNx6mcEgKh2DxDk0gtZErTjFK0h7MnYNPVKTm+5Jmd3aszff5E
        nq0YW6bVNWHJjBnPJd1I+Nn3xO1PVqFPR2PEW3SQRguIwhBxPHZfb1yu8fci60ZCykQYo6O6V1Oqv
        q6HvBKHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBdrx-0007sz-To; Fri, 28 Aug 2020 12:52:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 586C73007CD;
        Fri, 28 Aug 2020 14:52:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F5E22C5F8E91; Fri, 28 Aug 2020 14:52:36 +0200 (CEST)
Date:   Fri, 28 Aug 2020 14:52:36 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 20/23] [RFC] kprobes: Remove task scan for updating
 kretprobe_instance
Message-ID: <20200828125236.GA1362448@hirez.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861781740.992023.4956784710984854658.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159861781740.992023.4956784710984854658.stgit@devnote2>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


If you do this, can you merge this into the previos patch and then
delete the sched try_to_invoke..() patch?

Few comments below.

On Fri, Aug 28, 2020 at 09:30:17PM +0900, Masami Hiramatsu wrote:


> +static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
> +{
> +	/* rph->rp can be updated by unregister_kretprobe() on other cpu */
> +	smp_rmb();
> +	return ri->rph->rp;
> +}

That ordering doesn't really make sense, ordering requires at least two
variables, here there is only 1. That said, get functions usually need
an ACQUIRE order to make sure subsequent accesses are indeed done later.

>  #else /* CONFIG_KRETPROBES */
>  static inline void arch_prepare_kretprobe(struct kretprobe *rp,
>  					struct pt_regs *regs)

> @@ -1922,6 +1869,7 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  	kprobe_opcode_t *correct_ret_addr = NULL;
>  	struct kretprobe_instance *ri = NULL;
>  	struct llist_node *first, *node;
> +	struct kretprobe *rp;
>  
>  	first = node = current->kretprobe_instances.first;
>  	while (node) {
> @@ -1951,12 +1899,13 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  	/* Run them..  */
>  	while (first) {
>  		ri = container_of(first, struct kretprobe_instance, llist);
> +		rp = get_kretprobe(ri);
>  		node = first->next;

(A)

> -		if (ri->rp && ri->rp->handler) {
> -			__this_cpu_write(current_kprobe, &ri->rp->kp);
> +		if (rp && rp->handler) {
> +			__this_cpu_write(current_kprobe, &rp->kp);
>  			ri->ret_addr = correct_ret_addr;
> -			ri->rp->handler(ri, regs);
> +			rp->handler(ri, regs);
>  			__this_cpu_write(current_kprobe, &kprobe_busy);
>  		}

So here we're using get_kretprobe(), but what is to stop anybody from
doing unregister_kretprobe() right at (A) such that we did observe our
rp, but by the time we use it, it's a goner.


> +	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
> +	rp->rph->rp = rp;

I think you'll need to check the allocation succeeded, no? :-)


> @@ -2114,16 +2065,20 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
>  	if (num <= 0)
>  		return;
>  	mutex_lock(&kprobe_mutex);
> -	for (i = 0; i < num; i++)
> +	for (i = 0; i < num; i++) {
>  		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
>  			rps[i]->kp.addr = NULL;
> +		rps[i]->rph->rp = NULL;
> +	}
> +	/* Ensure the rph->rp updated after this */
> +	smp_wmb();
>  	mutex_unlock(&kprobe_mutex);

That ordering is dodgy again, those barriers don't help anything if
someone else is at (A) above.

>  
>  	synchronize_rcu();

This one might help, this means we can do rcu_read_lock() around
get_kretprobe() and it's usage. Can we call rp->handler() under RCU?

>  	for (i = 0; i < num; i++) {
>  		if (rps[i]->kp.addr) {
>  			__unregister_kprobe_bottom(&rps[i]->kp);
> -			cleanup_rp_inst(rps[i]);
> +			free_rp_inst(rps[i]);
>  		}
>  	}
>  }
