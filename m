Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650D215ABA7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 16:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgBLPCi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 10:02:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLPCh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FaxeSXwVb9YdybUdnSUzUuefptnpP1pWk8I0wE1Oxzo=; b=iK5CEFVRW9fYTbRCi9CnjsGQfB
        uVCamwQdLUMJVwpRf1eQtmWuO9Qj/M/kZySXlUMYjzNM4uCxkJADTlqAcB7q4bjo4xF5ch9gbAkUm
        zPxzPqocEgc/coGG0VoB/fK9XoXmWH2JTNPhcAAOXflURp3evLfpjGP15o+fWaB+GUJ2lRzvUuG45
        43y57IhbEJ/PAANBIhWtTNqN+xn9Aje5JVdp1HEA/khkpqbeWDf4S8/UMTZS74qMOjpm3gjf+MXa1
        sZnoyTwWBt8UYDSQjczJnjR3MAAn33C4bu+3mgKweKYxehnoJ0OWcBRaLx3cz5IxPN/qfIXNs4+Ey
        bJDw3QLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1tWo-00061G-T4; Wed, 12 Feb 2020 15:02:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0ADA30066E;
        Wed, 12 Feb 2020 16:00:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE4CF2032662E; Wed, 12 Feb 2020 16:02:11 +0100 (CET)
Date:   Wed, 12 Feb 2020 16:02:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 4/8] sched,rcu,tracing: Mark preempt_count_{add,sub}()
 notrace
Message-ID: <20200212150211.GS14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094107.838108888@infradead.org>
 <20200212092417.04c3da8c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212092417.04c3da8c@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 09:24:17AM -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2020 10:32:14 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Because of the requirement that no tracing happens until after we've
> > incremented preempt_count, see nmi_enter() / trace_rcu_enter(), mark
> > these functions as notrace.
> 
> I actually depend on these function being traced.

Why? They already have a tracepoint inside.

> We do have
> "preempt_enable_notrace()" and "preempt_disable_notrace()" for places
> that shouldn't be traced. Can't we use those? (or simply
> __preempt_count_add()) in the nmi_enter() code instead? (perhaps create
> a preempt_count_add_notrace()).

My initial patch has __preempt_count_add/sub() in, but then I figured
someone would go complain the tracepoint would go missing.

