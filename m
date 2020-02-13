Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0A15BACC
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 09:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgBMIaM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 03:30:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMIaM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 03:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lqYHniyuFF82g1hkULXfEHjo4HV1jpimDv0o2K20OUU=; b=HdWCTIPhz1Qqup3ZyZCHR7FwoA
        zWEfEKNgo3x7t8+smFyp0QXWcoE+WJVmBNcjK45jVIeqVVXG0n8eOwFoHSA8kaRhR4zbSM9usP1JC
        JXvNuUCtU2SddqMInPipINGFrrpqD/a/0yOEGrbFa9f21KFd6dK7qZABfYm6g/2oiX/wlnz0dC5Or
        qzHXAAuIq0Zmql9FTORDSbQlXabm4Cbqka71D5FyVxdbw1HrMSnpdlvFco3V6fjRLnTrwZKmf7Ff3
        r1IlfGsVZPnfBZYSmFmm/Zgv1FmELK9TvsI0Sd/yLAbgZH8OkVxmBBDCAZVC/4GXMiRxU2RzQuN9U
        XN+kZHhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j29sf-0003Jc-71; Thu, 13 Feb 2020 08:29:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18D2C300606;
        Thu, 13 Feb 2020 09:28:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A01072B4CEBC2; Thu, 13 Feb 2020 09:29:51 +0100 (CET)
Date:   Thu, 13 Feb 2020 09:29:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: Re: [PATCH v2 6/9] perf,tracing: Prepare the perf-trace interface
 for RCU changes
Message-ID: <20200213082951.GK14897@hirez.programming.kicks-ass.net>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.142334759@infradead.org>
 <20200212232830.GB170680@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212232830.GB170680@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 06:28:30PM -0500, Joel Fernandes wrote:
> On Wed, Feb 12, 2020 at 10:01:45PM +0100, Peter Zijlstra wrote:
> > The tracepoint interface will stop providing regular RCU context; make
> > sure we do it ourselves, since perf makes use of regular RCU protected
> > data.
> > 
> > Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/events/core.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
> >  {
> >  	struct perf_sample_data data;
> >  	struct perf_event *event;
> > +	unsigned long rcu_flags;
> 
> The flags are not needed I guess, if you agree on not using in_nmi() in
> trace_rcu_enter().

Even then we need to store the state: 'didn't do nothing' vs 'did call
rcu_needs_to_wake_up_and_pay_attention_noaw'. That is, we only need to
do something (expensive!) when !rcu_is_watching().
