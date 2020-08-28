Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26DE255744
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgH1JNr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 05:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgH1JNq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 05:13:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54DF42071B;
        Fri, 28 Aug 2020 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598606026;
        bh=0LYSf79a3WDCXGRveXivNmN6ae5e+lWHgvgnet5g+no=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R28jQCmPuweJSEHJUncejRpuC4SzCSZMTBUaQrSodwnybCu35ZKLoL4z0TYdfjRfp
         JS4YwonP8qEATXWLuh8j2B1RVq8ZtxezIxGtnbM0xqbwLyuy7dT1LRnYgGpFAMum+I
         69vTxPbV4KtJxG+PWUJQHVyykxDh0AgutPWarBMo=
Date:   Fri, 28 Aug 2020 18:13:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 7/7] kprobes: Replace rp->free_instance with
 freelist
Message-Id: <20200828181341.c1da066360c6085d48850e22@kernel.org>
In-Reply-To: <20200828084851.GQ1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
        <20200827161754.594247581@infradead.org>
        <20200828084851.GQ1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 10:48:51 +0200
peterz@infradead.org wrote:

> On Thu, Aug 27, 2020 at 06:12:44PM +0200, Peter Zijlstra wrote:
> >  struct kretprobe_instance {
> >  	union {
> > +		/*
> > +		 * Dodgy as heck, this relies on not clobbering freelist::refs.
> > +		 * llist: only clobbers freelist::next.
> > +		 * rcu: clobbers both, but only after rp::freelist is gone.
> > +		 */
> > +		struct freelist_node freelist;
> >  		struct llist_node llist;
> > -		struct hlist_node hlist;
> >  		struct rcu_head rcu;
> >  	};
> 
> Masami, make sure to make this something like:
> 
> 	union {
> 		struct freelist_node freelist;
> 		struct rcu_head rcu;
> 	};
> 	struct llist_node llist;
> 
> for v4, because after some sleep I'm fairly sure what I wrote above was
> broken.
> 
> We'll only use RCU once the freelist is gone, so sharing that storage
> should still be okay.

Hmm, would you mean there is a chance that an instance belongs to
both freelist and llist?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
