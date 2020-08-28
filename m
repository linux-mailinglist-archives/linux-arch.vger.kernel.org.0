Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A592B2558C7
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgH1Ko4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 06:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgH1Koz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 06:44:55 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2C8208CA;
        Fri, 28 Aug 2020 10:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598611494;
        bh=hgX2QECXy5MlJkQZXxuPE3ywxUra609CbNlUd8fZrWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qIpikyXykAX/Foacgzl2TatAVyOBf2/rpacIrW1noBixkk8bSTQ145gR6NQekKcmq
         sRVR+WQSjCPRFJvp96+dZtOlXVBHT7ntxUVlYLzgQQCLbhNZUy0HM9qHlWgO4ueKRp
         4jyN5L9UeeE26xGexDd/hRKL7EqH9tGHvF5veQrk=
Date:   Fri, 28 Aug 2020 19:44:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 7/7] kprobes: Replace rp->free_instance with
 freelist
Message-Id: <20200828194449.deaae48c36211a61822a1943@kernel.org>
In-Reply-To: <20200828091813.GU1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
        <20200827161754.594247581@infradead.org>
        <20200828084851.GQ1362448@hirez.programming.kicks-ass.net>
        <20200828181341.c1da066360c6085d48850e22@kernel.org>
        <20200828091813.GU1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 11:18:13 +0200
peterz@infradead.org wrote:

> On Fri, Aug 28, 2020 at 06:13:41PM +0900, Masami Hiramatsu wrote:
> > On Fri, 28 Aug 2020 10:48:51 +0200
> > peterz@infradead.org wrote:
> > 
> > > On Thu, Aug 27, 2020 at 06:12:44PM +0200, Peter Zijlstra wrote:
> > > >  struct kretprobe_instance {
> > > >  	union {
> > > > +		/*
> > > > +		 * Dodgy as heck, this relies on not clobbering freelist::refs.
> > > > +		 * llist: only clobbers freelist::next.
> > > > +		 * rcu: clobbers both, but only after rp::freelist is gone.
> > > > +		 */
> > > > +		struct freelist_node freelist;
> > > >  		struct llist_node llist;
> > > > -		struct hlist_node hlist;
> > > >  		struct rcu_head rcu;
> > > >  	};
> > > 
> > > Masami, make sure to make this something like:
> > > 
> > > 	union {
> > > 		struct freelist_node freelist;
> > > 		struct rcu_head rcu;
> > > 	};
> > > 	struct llist_node llist;
> > > 
> > > for v4, because after some sleep I'm fairly sure what I wrote above was
> > > broken.
> > > 
> > > We'll only use RCU once the freelist is gone, so sharing that storage
> > > should still be okay.
> > 
> > Hmm, would you mean there is a chance that an instance belongs to
> > both freelist and llist?
> 
> So the freelist->refs thing is supposed to pin freelist->next for
> concurrent usage, but if we instantly stick it on the
> current->kretprobe_instances llist while it's still elevated, we'll
> overwrite ->next, which would be bad.

OK, I'll pick these up for my v4 series with that fix.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
