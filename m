Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D3164966
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSQDp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:03:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBSQDp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JqMAMmw8mBmK17Px3HpOSkmtfqAbT6lmm4Y0zdln3UY=; b=gRbtHsdxI10YrBY9HvsffsrtV7
        F+ojNkMevvnVWup+Qg9+CxYUoecJmPp1FFsiDdustsK7vEscyhXWOqnkbeMPVFfz1PBCojIc7oH0A
        S/MBtmrnXF6c6uUXP9I/DRiFqy5UymJce2atQbd7hzpScMiXJAD5oyN+6ySa4RwhazRR8a1gjAcBg
        POsVykBTzM213QwsZYWTjqJCNFl9iML0Xe5nkU5LEALvDO0IK6EIjGtrZjc+EAFStbcw4PfOFcfOy
        e4cxbmwblYrt5mvrW3V1Ak/ud5AsTV/3yYVICC7txx2aSY9QwF/xqOuaW9OlJifM3jVZrlUsDhdfh
        Lywn3fPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Rom-0000lm-Jw; Wed, 19 Feb 2020 16:03:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F09833007F2;
        Wed, 19 Feb 2020 17:01:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E4C5201E47AE; Wed, 19 Feb 2020 17:03:18 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:03:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 16/22] locking/atomics, kcsan: Add KCSAN
 instrumentation
Message-ID: <20200219160318.GG18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.299217979@infradead.org>
 <20200219104626.633f0650@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219104626.633f0650@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 10:46:26AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2020 15:47:40 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > From: Marco Elver <elver@google.com>
> > 
> > This adds KCSAN instrumentation to atomic-instrumented.h.
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > [peterz: removed the actual kcsan hooks]
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  include/asm-generic/atomic-instrumented.h |  390 +++++++++++++++---------------
> >  scripts/atomic/gen-atomic-instrumented.sh |   14 -
> >  2 files changed, 212 insertions(+), 192 deletions(-)
> > 
> 
> 
> Does this and the rest of the series depend on the previous patches in
> the series? Or can this be a series on to itself (patches 16-22)?

It can probably stand on its own, but it very much is related in so far
that it's fallout from staring at all this nonsense.

Without these the do_int3() can actually have accidental tracing before
reaching it's nmi_enter().
