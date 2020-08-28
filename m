Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BAD2556BE
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgH1IpP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 04:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgH1Iot (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 04:44:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D6C06121B;
        Fri, 28 Aug 2020 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TQPuTYQQB4pOJ2VUNBqFXHekENNLvmCPnFhX6nzKkZk=; b=AFwI67gz692Isbnzz0zmHkhP9h
        rgWUbjvv0vtvVMurV25ZzlWTnRX4oi9p+2IfPJfPtfQ+y7cD2fcTJ2zC3Ka6dNgoVoun+dQPxTVGy
        fHGjUK8wBUN4HlEKlU7g9JXja8Po/j/WUzuKIRHBd7ng1/JwR+Jsbav+Py+NfVI3ZukRh0GULhVFu
        /oUXFozYJJclo4iCgYkc87m4H9XPmrh6e9kl/AK/L93W5zoLiE3uCVDyf0bVeTUKT2jGLY47JOv0l
        BCEg9z2CWLXlht0gb9FinnkmgX2DbgZfuB3lITyOdqOc0qL5eI85iIL0ClOBLK+1OqPs6e5jZmPpR
        QF8UkRRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBZza-0004nk-Om; Fri, 28 Aug 2020 08:44:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6B353003E5;
        Fri, 28 Aug 2020 10:44:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CF392C5F134E; Fri, 28 Aug 2020 10:44:11 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:44:11 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Message-ID: <20200828084411.GP1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.359432340@infradead.org>
 <20200828030059.d6618caf5b0214c424b941df@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828030059.d6618caf5b0214c424b941df@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 03:00:59AM +0900, Masami Hiramatsu wrote:
> On Thu, 27 Aug 2020 18:12:40 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +static void invalidate_rp_inst(struct task_struct *t, struct kretprobe *rp)
> > +{
> > +	struct invl_rp_ipi iri = {
> > +		.task = t,
> > +		.rp = rp,
> > +		.done = false
> > +	};
> > +
> > +	for (;;) {
> > +		if (try_invoke_on_locked_down_task(t, __invalidate_rp_inst, rp))
> > +			return;
> > +
> > +		smp_call_function_single(task_cpu(t), __invalidate_rp_ipi, &iri, 1);
> > +		if (iri.done)
> > +			return;
> > +	}
> 
> Hmm, what about making a status place holder and point it from
> each instance to tell it is valid or not?
> 
> struct kretprobe_holder {
> 	atomic_t refcnt;
> 	struct kretprobe *rp;
> };
> 
> struct kretprobe {
> ...
> 	struct kretprobe_holder	*rph;	// allocate at register
> ...
> };
> 
> struct kretprobe_instance {
> ...
> 	struct kretprobe_holder	*rph; // free if refcnt == 0
> ...
> };
> 
> cleanup_rp_inst(struct kretprobe *rp)
> {
> 	rp->rph->rp = NULL;
> }
> 
> kretprobe_trampoline_handler()
> {
> ...
> 	rp = READ_ONCE(ri->rph-rp);
> 	if (likely(rp)) {
> 		// call rp->handler
> 	} else
> 		rcu_call(ri, free_rp_inst_rcu);
> ...
> }
> 
> free_rp_inst_rcu()
> {
> 	if (!atomic_dec_return(ri->rph->refcnt))
> 		kfree(ri->rph);
> 	kfree(ri);
> }
> 
> This increase kretprobe_instance a bit, but make things simpler.
> (and still keep lockless, atomic op is in the rcu callback).

Yes, much better.

Although I'd _love_ to get rid of rp->data_size, then we can simplify
all of this even more. I was thinking we could then have a single global
freelist thing and add some per-cpu cache to it (say 4-8 entries) to
avoid the worst contention.

And then make function-graph use this, instead of the other way around
:-)
