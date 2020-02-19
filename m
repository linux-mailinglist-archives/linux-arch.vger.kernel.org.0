Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F8164B73
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBSRFa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:05:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSRFa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ePiOu1LnxWN4mdSQI8iwc4P9sH/T13jtaDHZl9HWyyg=; b=3L91a3/voxU1lxybogdMIVKgaf
        5901Bum2dxH+eLzb1LI6MsZ3mt6hn4uYcp3H5IXg2LUXOZpbw6PmHXShkj0vh75K4mBAFafKjIIXn
        uEUY7iUkve8dDiVFQ3Gp67cNeoniFkkQ7v51RYMcwtz1wSgtu+3UTqNpE8fjj2PXnPGZ4LaDU/Mjd
        jByrkzgUEPxQiVTvhcZf2FF7J19pPDmKCbWjYrghmXn6grNk+rWvvIIOkoxtd4/KJ38KdXMVSk12D
        bjAp+GT3KuT5TypQxft2zT0FtQo3M8GYIyQ/LJCKTP+M4IZPBHfMfTo+CQUorkO28EHmDEVj9EV9A
        D9iZXTow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Smb-0001eZ-FR; Wed, 19 Feb 2020 17:05:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50315300606;
        Wed, 19 Feb 2020 18:03:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4164202287EF; Wed, 19 Feb 2020 18:05:07 +0100 (CET)
Date:   Wed, 19 Feb 2020 18:05:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 13/22] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200219170507.GH14946@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.125119627@infradead.org>
 <20200219164356.GB2935@paulmck-ThinkPad-P72>
 <20200219164736.GL18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219164736.GL18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 05:47:36PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 08:43:56AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2020 at 03:47:37PM +0100, Peter Zijlstra wrote:
> > > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > > taught perf how to deal with not having an RCU context provided.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  include/linux/tracepoint.h |    8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > 
> > > --- a/include/linux/tracepoint.h
> > > +++ b/include/linux/tracepoint.h
> > > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
> > 
> > Shouldn't we also get rid of this line above?
> > 
> > 		int __maybe_unused __idx = 0;				\
> > 
> 
> Probably makes a lot of sense, lemme fix that!

Oh wait, no! SRCU is the one that remains !
