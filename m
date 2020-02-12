Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C31F15ABD6
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 16:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBLPSa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 10:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgBLPS3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 10:18:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57B0206D7;
        Wed, 12 Feb 2020 15:18:27 +0000 (UTC)
Date:   Wed, 12 Feb 2020 10:18:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 5/8] x86,tracing: Mark debug_stack_{set_zero,reset)()
 notrace
Message-ID: <20200212101826.23d394eb@gandalf.local.home>
In-Reply-To: <20200212150440.GT14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
        <20200212094107.894657838@infradead.org>
        <20200212092539.135934e1@gandalf.local.home>
        <20200212150440.GT14897@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 12 Feb 2020 16:04:40 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > This entire file is notrace:
> > 
> >  arch/x86/kernel/cpu/Makefile:
> > 
> >    CFLAGS_REMOVE_common.o = -pg  
> 
> Urgh, I hate it that that annotation is so hard to find :/ Also, there
> seem to be various flavours of that Makefile magic around.
> 
>   CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
> 
> is another variant I encountered.

Actually, that should be the only variant. That was added for various
archs, and should be used consistently throughout.

There's a clean up series for you ;-) (or whoever)

-- Steve
