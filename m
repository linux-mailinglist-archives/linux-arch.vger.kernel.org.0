Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4958115ABAA
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 16:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBLPE7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 10:04:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgBLPE7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MDNa4LpUKCpXhbe5C9lELzg7pzo1OMQ9rXl+zV0WZfw=; b=Z8ot2vLL44MRH+4LWg8a1tY03u
        7A3aahoVUp7RisA/UlUX2roXx9hWLLMYzFTzd35DW+aL7DMcPzcIWrCaY2vD255k+72XIENisB0Ll
        uTHNZcZROQS0sSfSSYo3vm7hTDg4PhDnKTzTQogBMFR/e5hraCOLE0ib9k8to/fxz2nAHQh2XZPB9
        q4YQirCXemwVhkqdiQGF1yiIxmYnFhBIFplHoW/Cd8a9Sa5CBtcWGjIj4bezLSK5lgSdB+TEfWsCL
        x4FZPOg39lHi5gM021QhH5WfbYcZtXoEDxh0C8mmVgWKgpUbojJyMZqldNhlaCQafCNCD+YBqSeoQ
        w+EBN03g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1tZC-0006AV-RX; Wed, 12 Feb 2020 15:04:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24E7630066E;
        Wed, 12 Feb 2020 16:02:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 387832032662E; Wed, 12 Feb 2020 16:04:40 +0100 (CET)
Date:   Wed, 12 Feb 2020 16:04:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 5/8] x86,tracing: Mark debug_stack_{set_zero,reset)()
 notrace
Message-ID: <20200212150440.GT14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094107.894657838@infradead.org>
 <20200212092539.135934e1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212092539.135934e1@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 09:25:39AM -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2020 10:32:15 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Because do_nmi() must not call into tracing outside of
> > nmi_enter()/nmi_exit(), these functions must be notrace.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kernel/cpu/common.c |    4 ++--
> >  arch/x86/kernel/nmi.c        |    6 ++++++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> 
> This entire file is notrace:
> 
>  arch/x86/kernel/cpu/Makefile:
> 
>    CFLAGS_REMOVE_common.o = -pg

Urgh, I hate it that that annotation is so hard to find :/ Also, there
seem to be various flavours of that Makefile magic around.

  CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)

is another variant I encountered.
