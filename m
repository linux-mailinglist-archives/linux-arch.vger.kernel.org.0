Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159E117BCF7
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 13:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgCFMk7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 07:40:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51358 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgCFMk7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 07:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y5+pZtzu0asDWbYW6WbU4+GEumJh19O3WASyOWQCOnE=; b=qnt05fSR7hHcUS9c2W4dPLgQDD
        taCVVylc9OVwmuRRVmq2gAiqrwu9wnH37g+ogrSwtqKNoqnZfGd49LAXZLPLrg/wzNTN3zPJp7tcq
        IznscVrSd6LOWTl8caUOFHsB71YSjY5djz+6cOAMC4TfTXHpMWMR2ur3ZhpBe9111Tc/04w5PMzpE
        reOo8ZTJtB2Ek4rtF+q9GbKsccNbfP5QPzikDs1QNpyt7IQtV7eycNoh1Tih2gm25kmsKNT0Pz1iR
        qDNoy7nQXc/uabHKwwpOwmJhLUSt6fej5/z13yqCwWeTflzrggkemKTvjjn68KZDH8e2XVm9RPLak
        /2vXfPPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jACHC-00067e-Bv; Fri, 06 Mar 2020 12:40:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67336300606;
        Fri,  6 Mar 2020 13:40:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F86925F0DF11; Fri,  6 Mar 2020 13:40:23 +0100 (CET)
Date:   Fri, 6 Mar 2020 13:40:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 11/27] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200306124023.GA12584@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.673793889@infradead.org>
 <20200306115042.GG3348@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306115042.GG3348@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 06, 2020 at 12:50:42PM +0100, Peter Zijlstra wrote:
> > +static inline int trace_rcu_enter(void)
> > +{
> > +	int state = !rcu_is_watching();
> > +	if (state)
> > +		rcu_irq_enter_irqsave();
> > +	return state;
> > +}
> > +
> > +static inline void trace_rcu_exit(int state)
> > +{
> > +	if (state)
> > +		rcu_irq_exit_irqsave();
> > +}
> > +
> >  /*
> >   * The init_rcu_head_on_stack() and destroy_rcu_head_on_stack() calls
> >   * are needed for dynamic initialization and destruction of rcu_head

Also, I just noticed these read like tracepoints, so I'm going to rename
them: rcu_trace_{enter,exit}().
