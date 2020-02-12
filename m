Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5199F15AC23
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 16:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBLPkH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 10:40:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBLPkH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NVmIUrc7SlkFu/lFWAF3oDypK2YDswVYnVYCxpf/YFE=; b=YLrEpiwEmXjOdrPzrxD3cAW7yX
        bC1owqMLMyyx7b0b1GN/+goA/eayR9rU74kekLeC5uCN9mE4rjKLhusWeMI1bfuCf1ifBJECtsTW7
        7dofmd4/lyW4mVsaWLSN1D+t2Z+kdRWrRqJ+qWs1DHlkZ+URyKn1yfxuSqLib9zkBKRcC+9hAGLJT
        rfWuCfFGjnCK8s1X1tA3f2u0eC1c+mSzRvHdkmUS5rCSjtqAkNAixgOUruKNWr/klO/MGPJbvw5W0
        DKH+HBaWebDQ9kalUqAgQkry1csZr/0+hdO+NyZmmA2kUk03uY3UpS01SsNu8Z/Q4NttlO7ELlYnA
        tTOJrJoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1u7A-0003wW-DT; Wed, 12 Feb 2020 15:39:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B3D3300446;
        Wed, 12 Feb 2020 16:37:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9566420149390; Wed, 12 Feb 2020 16:39:46 +0100 (CET)
Date:   Wed, 12 Feb 2020 16:39:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 5/8] x86,tracing: Mark debug_stack_{set_zero,reset)()
 notrace
Message-ID: <20200212153946.GX14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094107.894657838@infradead.org>
 <20200212092539.135934e1@gandalf.local.home>
 <20200212150440.GT14897@hirez.programming.kicks-ass.net>
 <20200212101826.23d394eb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212101826.23d394eb@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 10:18:26AM -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2020 16:04:40 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > This entire file is notrace:
> > > 
> > >  arch/x86/kernel/cpu/Makefile:
> > > 
> > >    CFLAGS_REMOVE_common.o = -pg  
> > 
> > Urgh, I hate it that that annotation is so hard to find :/ Also, there
> > seem to be various flavours of that Makefile magic around.
> > 
> >   CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
> > 
> > is another variant I encountered.
> 
> Actually, that should be the only variant. That was added for various
> archs, and should be used consistently throughout.
> 
> There's a clean up series for you ;-) (or whoever)

If I'm going to clean this up I'd remove the Makefile rules entirely.
I hate these Makefile rules, they make it entirely non-obvious what is
and is not being traced.
