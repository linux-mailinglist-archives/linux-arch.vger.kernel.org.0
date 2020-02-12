Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02315A871
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 12:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgBLL7B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 06:59:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgBLL7B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 06:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UtN8+ZGSwaPi4q3QVj9G5VCoQ9BSx691y8FRqSthTXE=; b=gfuS8CH6o/kkTpvRENuT4/WSp6
        Y1BM52nqcvQS6tgzL2xqmbDAkKG7Jr6sk9ZDzBWzdwXp7Iy9EJoUlEwTS/4xCj7vncjj0n3vSkoV9
        nahwIJUwMVAeXMgzUH0Oewx0QZU9xdoM6/MhGfPYhIIv7oALnyNi4aJT19l1/9n//M0qqDnMvnfT0
        fkbLe46TnBDnbrgTdk7xPQzJR7xs7O6UK2mcDbNLKYhuGt/08Zi7obelcfwVNU4DOZ/CkabnfSNIr
        6X5HPVho9NcDDmB9ABXR5kdCxjg4qcbeloJ3tfQVY275abz/7mAVKP50cbqNeEXgYtppW7MbCfbzo
        HJJBZbeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1qet-0000HP-OM; Wed, 12 Feb 2020 11:58:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C224300235;
        Wed, 12 Feb 2020 12:56:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1683120148932; Wed, 12 Feb 2020 12:58:20 +0100 (CET)
Date:   Wed, 12 Feb 2020 12:58:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, james.morse@arm.com, catalin.marinas@arm.com,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 0/8] tracing vs rcu vs nmi
Message-ID: <20200212115820.GQ14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212100106.GA14914@hirez.programming.kicks-ass.net>
 <20200212105646.GA4017@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212105646.GA4017@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 10:56:46AM +0000, Will Deacon wrote:
> On Wed, Feb 12, 2020 at 11:01:06AM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 12, 2020 at 10:32:10AM +0100, Peter Zijlstra wrote:
> > > Hi all,
> > > 
> > > These here patches are the result of Mathieu and Steve trying to get commit
> > > 865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
> > > tracepoints") reverted again.
> > > 
> > > One of the things discovered is that tracing MUST NOT happen before nmi_enter()
> > > or after nmi_exit(). I've only fixed x86, but quickly gone through other
> > > architectures and there is definitely more stuff to be fixed (simply grep for
> > > nmi_enter in your arch).
> > 
> > For ARM64:
> > 
> >  - apei_claim_sea()
> >  - __sdei_handler()
> >  - do_serror()
> >  - debug_exception_enter() / do_debug_exception()
> > 
> > all look dodgy.
> 
> Hmm, so looks like we need to spinkle some 'notrace' annotations around
> these. Are there are scenarios where you would want NOKPROBE_SYMBOL() but
> *not* 'notrace'? We've already got the former for the debug exception
> handlers and we probably (?) want it for the SDEI stuff too...

I'm not sure. In fact, I asked Steve on IRC if we'd want to teach
objtool to report such inconsitencies.
