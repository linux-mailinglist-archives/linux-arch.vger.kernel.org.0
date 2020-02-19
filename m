Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27778164B23
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgBSQzW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:55:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgBSQzW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QqyerBI8yEhUA0Wp9HLALebGxnV9rbRcO0VkF0bRWsE=; b=A3jLqbuo+jjdtMLs//IizDIfnI
        JaleiIdMH6H74Zu+9PnKz9jyRM6FiLDdLF6EYqZ2Ro1tygxUKEepY5RiC3KP/AtgF9+03uuS9XppA
        77GsIYT90Xc2iJFXBKq2Tckv5seS8zxOmProd9GfD/QdN0l1YZhYpIjs/FFOobYDevWNaHEG48KmS
        8wT4GNafyPbSd9NNKmSqthqXIsWGUGRCGiztLG1Kr7R4AoF4vI9jD9AsA2V3Ad/ArYCwHcgCJuN1d
        1tKeAoZ2YyGJ9EW4mdIJTxIu+OAfgfWM+EdMbo79x4Q9CIERw1KzVsNJGTmQh3AzdjqREQcfFO6GK
        NMbrG9Rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Scj-0004NV-F3; Wed, 19 Feb 2020 16:54:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFC82300606;
        Wed, 19 Feb 2020 17:53:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B363201BADC9; Wed, 19 Feb 2020 17:54:55 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:54:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 16/22] locking/atomics, kcsan: Add KCSAN
 instrumentation
Message-ID: <20200219165455.GM18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.299217979@infradead.org>
 <20200219104626.633f0650@gandalf.local.home>
 <20200219160318.GG18400@hirez.programming.kicks-ass.net>
 <20200219165020.GF2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219165020.GF2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 08:50:20AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2020 at 05:03:18PM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 19, 2020 at 10:46:26AM -0500, Steven Rostedt wrote:
> > > On Wed, 19 Feb 2020 15:47:40 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > From: Marco Elver <elver@google.com>
> > > > 
> > > > This adds KCSAN instrumentation to atomic-instrumented.h.
> > > > 
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > [peterz: removed the actual kcsan hooks]
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > > > ---
> > > >  include/asm-generic/atomic-instrumented.h |  390 +++++++++++++++---------------
> > > >  scripts/atomic/gen-atomic-instrumented.sh |   14 -
> > > >  2 files changed, 212 insertions(+), 192 deletions(-)
> > > > 
> > > 
> > > 
> > > Does this and the rest of the series depend on the previous patches in
> > > the series? Or can this be a series on to itself (patches 16-22)?
> > 
> > It can probably stand on its own, but it very much is related in so far
> > that it's fallout from staring at all this nonsense.
> > 
> > Without these the do_int3() can actually have accidental tracing before
> > reaching it's nmi_enter().
> 
> The original is already in -tip, so some merge magic will be required.

Yes, So I don't strictly need this one, but I do need the two next
patches adding __always_inline to everything. I figured it was easier to
also pick this one (and butcher it) than to rebase everything.

I didn't want to depend on the locking/kcsan tree, and if this goes in,
we do have to do something 'funny' there. Maybe rebase, maybe put in a
few kcsan stubs so the original patch at least compiles. We'll see :/
