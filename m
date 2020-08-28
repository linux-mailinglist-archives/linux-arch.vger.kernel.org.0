Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227EF25576A
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 11:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgH1JSi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 05:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1JSh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 05:18:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CAAC061264;
        Fri, 28 Aug 2020 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7oEiKFdKtw+fNVAzipGQKKCx4WxHDyWDHaSbCtVw8Hc=; b=SOTxbauG+aJgX2PjBxPuX6SqoA
        DwnLiY9B69lbseA4S62pEIvcb0QBu6EnWogxEy6L0/9MMcWoGka8PI55opXYzY9ew+Dgsi0ttyjQr
        /yzwyvQN4ZRaCr6/UmRlQomebL1qYBHoUmwhVb9LPP6Z/09JeZMAwHhevzIiUW7pRj2shkdGJaRnl
        T+0kfenZcuT4GGJxamXZG4xJEOBXaiTi5wIzDVA3634O6E3//6fJMI8QB3rEBFWgJLkPWtxkTIC5L
        gvh8J80hbXwFOCMwTJuf7CM0vfV4JLgFnpQHEXv4e955lb1UrKheek6WzMplDC/0wXHeSZmGYCap1
        AClRaoKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBaWU-0006xd-Qo; Fri, 28 Aug 2020 09:18:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15D28305C10;
        Fri, 28 Aug 2020 11:18:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C34E52C56DB16; Fri, 28 Aug 2020 11:18:13 +0200 (CEST)
Date:   Fri, 28 Aug 2020 11:18:13 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 7/7] kprobes: Replace rp->free_instance with freelist
Message-ID: <20200828091813.GU1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.594247581@infradead.org>
 <20200828084851.GQ1362448@hirez.programming.kicks-ass.net>
 <20200828181341.c1da066360c6085d48850e22@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828181341.c1da066360c6085d48850e22@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 06:13:41PM +0900, Masami Hiramatsu wrote:
> On Fri, 28 Aug 2020 10:48:51 +0200
> peterz@infradead.org wrote:
> 
> > On Thu, Aug 27, 2020 at 06:12:44PM +0200, Peter Zijlstra wrote:
> > >  struct kretprobe_instance {
> > >  	union {
> > > +		/*
> > > +		 * Dodgy as heck, this relies on not clobbering freelist::refs.
> > > +		 * llist: only clobbers freelist::next.
> > > +		 * rcu: clobbers both, but only after rp::freelist is gone.
> > > +		 */
> > > +		struct freelist_node freelist;
> > >  		struct llist_node llist;
> > > -		struct hlist_node hlist;
> > >  		struct rcu_head rcu;
> > >  	};
> > 
> > Masami, make sure to make this something like:
> > 
> > 	union {
> > 		struct freelist_node freelist;
> > 		struct rcu_head rcu;
> > 	};
> > 	struct llist_node llist;
> > 
> > for v4, because after some sleep I'm fairly sure what I wrote above was
> > broken.
> > 
> > We'll only use RCU once the freelist is gone, so sharing that storage
> > should still be okay.
> 
> Hmm, would you mean there is a chance that an instance belongs to
> both freelist and llist?

So the freelist->refs thing is supposed to pin freelist->next for
concurrent usage, but if we instantly stick it on the
current->kretprobe_instances llist while it's still elevated, we'll
overwrite ->next, which would be bad.

