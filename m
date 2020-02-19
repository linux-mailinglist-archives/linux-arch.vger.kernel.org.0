Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88E8164AE9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSQsK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:48:10 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34976 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSQsJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+twXkb0MM6lyW/+mRFtRYePLegQuh9Rt7grngnS4+RM=; b=QyusD8Wo4gf9XQcPoKFLBoHqKp
        CQo8Iml3Bo9U6smjWnWGhl6ISRtOQ9yD8D7Re0KZiAYMshRpsZ5wwk3WOv3jBUfzDDglGex8GG2CH
        LQ9aB+UvyaPm0TDb4TaBx2+8zcMktYjMtcPWAIjUYUWPvHkonn2d3TDIJiaHEqGHaEqOqqYvRRVHy
        MYqo1+S+MIXq0RVwzlxlsySb3pTMEAylI8pT2oJ8RW6Mf4RyYIgy6Wy7z+Zk61fbl9vxOOqVMb/hs
        8oyEk4DU+/V2od1UTVJEBzQtMwFRNk3H+B38OW6boIqCTncAnRDnUHPMoqV/qHAOM7Hqmf0UETySl
        iLIoVN5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SVd-0001F0-Rm; Wed, 19 Feb 2020 16:47:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA6C9300565;
        Wed, 19 Feb 2020 17:45:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 432FA201E47A2; Wed, 19 Feb 2020 17:47:36 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:47:36 +0100
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
Message-ID: <20200219164736.GL18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.125119627@infradead.org>
 <20200219164356.GB2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219164356.GB2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 08:43:56AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2020 at 03:47:37PM +0100, Peter Zijlstra wrote:
> > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > taught perf how to deal with not having an RCU context provided.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/tracepoint.h |    8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
> 
> Shouldn't we also get rid of this line above?
> 
> 		int __maybe_unused __idx = 0;				\
> 

Probably makes a lot of sense, lemme fix that!
