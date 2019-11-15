Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0AFE301
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2019 17:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKOQmC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Nov 2019 11:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfKOQmB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Nov 2019 11:42:01 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D54220718;
        Fri, 15 Nov 2019 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573836120;
        bh=jkErE5GY/mWn/HAQI9cUc0wleSx4QKoShYxAgztG5XE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jKeRzm1CqhWwhTOzvKLKTOqY8ZuNPidt2GWCVinFuuMMZXNeqrLAasv7MSXXprvyw
         WKFvnCPoHjdbqYUxA/5m6WhK2VCHyGzSwDCcp0dgUPpVa4AA66nzNeIhM3rpHnhr4+
         SVw3qrsT+UW6bLbgxtLO6DLHoVJxo+hOSp8TOSHo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F1C0035207BD; Fri, 15 Nov 2019 08:41:59 -0800 (PST)
Date:   Fri, 15 Nov 2019 08:41:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191115164159.GU2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191114180303.66955-1-elver@google.com>
 <20191114195046.GP2865@paulmck-ThinkPad-P72>
 <20191114213303.GA237245@google.com>
 <20191114221559.GS2865@paulmck-ThinkPad-P72>
 <CANpmjNPxAOUAxXHd9tka5gCjR_rNKmBk+k5UzRsXT0a0CtNorw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPxAOUAxXHd9tka5gCjR_rNKmBk+k5UzRsXT0a0CtNorw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 15, 2019 at 01:02:08PM +0100, Marco Elver wrote:
> On Thu, 14 Nov 2019 at 23:16, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Nov 14, 2019 at 10:33:03PM +0100, Marco Elver wrote:
> > > On Thu, 14 Nov 2019, Paul E. McKenney wrote:
> > >
> > > > On Thu, Nov 14, 2019 at 07:02:53PM +0100, Marco Elver wrote:
> > > > > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > > > > KCSAN is a sampling watchpoint-based *data race detector*. More details
> > > > > are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> > > > > only enables KCSAN for x86, but we expect adding support for other
> > > > > architectures is relatively straightforward (we are aware of
> > > > > experimental ARM64 and POWER support).
> > > > >
> > > > > To gather early feedback, we announced KCSAN back in September, and have
> > > > > integrated the feedback where possible:
> > > > > http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> > > > >
> > > > > The current list of known upstream fixes for data races found by KCSAN
> > > > > can be found here:
> > > > > https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan
> > > > >
> > > > > We want to point out and acknowledge the work surrounding the LKMM,
> > > > > including several articles that motivate why data races are dangerous
> > > > > [1, 2], justifying a data race detector such as KCSAN.
> > > > >
> > > > > [1] https://lwn.net/Articles/793253/
> > > > > [2] https://lwn.net/Articles/799218/
> > > >
> > > > I queued this and ran a quick rcutorture on it, which completed
> > > > successfully with quite a few reports.
> > >
> > > Great. Many thanks for queuing this in -rcu. And regarding merge window
> > > you mentioned, we're fine with your assumption to targeting the next
> > > (v5.6) merge window.
> > >
> > > I've just had a look at linux-next to check what a future rebase
> > > requires:
> > >
> > > - There is a change in lib/Kconfig.debug and moving KCSAN to the
> > >   "Generic Kernel Debugging Instruments" section seems appropriate.
> > > - bitops-instrumented.h was removed and split into 3 files, and needs
> > >   re-inserting the instrumentation into the right places.
> > >
> > > Otherwise there are no issues. Let me know what you recommend.
> >
> > Sounds good!
> >
> > I will be rebasing onto v5.5-rc1 shortly after it comes out.  My usual
> > approach is to fix any conflicts during that rebasing operation.
> > Does that make sense, or would you prefer to send me a rebased stack at
> > that point?  Either way is fine for me.
> 
> That's fine with me, thanks!  To avoid too much additional churn on
> your end, I just replied to the bitops patch with a version that will
> apply with the change to bitops-instrumented infrastructure.

My first thought was to replace 8/10 of the previous version of your
patch in -rcu (047ca266cfab "asm-generic, kcsan: Add KCSAN instrumentation
for bitops"), but this does not apply.  So I am guessing that I instead
do this substitution when a rebase onto -rc1..

Except...

> Also considering the merge window, we had a discussion and there are
> some arguments for targeting the v5.5 merge window:
> - we'd unblock ARM and POWER ports;
> - we'd unblock people wanting to use the data_race macro;
> - we'd unblock syzbot just tracking upstream;
> Unless there are strong reasons to not target v5.5, I leave it to you
> if you think it's appropriate.

My normal process is to send the pull request shortly after -rc5 comes
out, but you do call out some benefits of getting it in sooner, so...

What I will do is to rebase your series onto (say) -rc7, test it, and
see about an RFC pull request.

One possible complication is the new 8/10 patch.  But maybe it will
apply against -rc7?

Another possible complication is this:

scripts/kconfig/conf  --syncconfig Kconfig
*
* Restart config...
*
*
* KCSAN: watchpoint-based dynamic data race detector
*
KCSAN: watchpoint-based dynamic data race detector (KCSAN) [N/y/?] (NEW)

Might be OK in this case because it is quite obvious what it is doing.
(Avoiding pain from this is the reason that CONFIG_RCU_EXPERT exists.)

But I will just mention this in the pull request.

If there is a -rc8, there is of course a higher probability of making it
into the next merge window.

Fair enough?

							Thanx, Paul
