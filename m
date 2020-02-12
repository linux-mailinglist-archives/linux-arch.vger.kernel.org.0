Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4515AC21
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 16:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgBLPjE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 10:39:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgBLPjE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eCwIZ8Hf6W398rCvWhZ+i5ZRPRRZxaxzUmzv2wz82pE=; b=1JAp9IgMQN6yuuPOz8FEz6IG3t
        dc4IWKrCf+0M6ik8hAb2VJ5w1rGW+hPlEqE1EgRVVsrDHmfT5RzRxWfpezdA17dnXPpHUhx3wegav
        WXX3rtSjqMnUwIqLcHKoSbEV+KQhOXqK3Y1CyxTbiZIig1O8UwHwCNqDPHQczpl2Z5M8MsxJHajj7
        JIVjUS1Idgs1ngdUH0ggJeVXNk9nSOwjlEnHMCEYMeYuOQdtar/uXNKDXT+ckjy4Mx4E4As3Tc9AX
        hl6FdDOeY5a4lOsMkGp51wPs6YElRwxapa/T9tG/XDx6fN9UIVqcpsXNLWfFdvNkVhywgK/aUKuA9
        ZuQxRC2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1u5r-00046F-4s; Wed, 12 Feb 2020 15:38:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7E6E300E0C;
        Wed, 12 Feb 2020 16:36:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B17F120149390; Wed, 12 Feb 2020 16:38:23 +0100 (CET)
Date:   Wed, 12 Feb 2020 16:38:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 4/8] sched,rcu,tracing: Mark preempt_count_{add,sub}()
 notrace
Message-ID: <20200212153823.GW14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094107.838108888@infradead.org>
 <20200212092417.04c3da8c@gandalf.local.home>
 <20200212150211.GS14897@hirez.programming.kicks-ass.net>
 <20200212101415.3615d66c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212101415.3615d66c@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 10:14:15AM -0500, Steven Rostedt wrote:
> > My initial patch has __preempt_count_add/sub() in, but then I figured
> > someone would go complain the tracepoint would go missing.
> 
> Fine, but what bug are you trying to fix? I haven't seen one mentioned
> yet. Function tracing has recursion protection, and tracing
> preempt_count in nmi_enter() causes no problems. What's the problem you
> are trying to solve?

The same one as yesterday; if we hit a tracer in NMI context, when
!rcu_is_watching() and in_nmi() is still 0, we're fucked.
