Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC755B08
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 00:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFYWYy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 18:24:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44570 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfFYWYx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 18:24:53 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hftrr-00020M-H0; Wed, 26 Jun 2019 00:24:47 +0200
Date:   Wed, 26 Jun 2019 00:24:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] lib/vdso: Delay mask application in do_hres()
In-Reply-To: <CALCETrWE3zYN-6h0RkMV9j5kSkSWbJ-nQnjhH=md=ybSR0eZ9Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906260009260.32342@nanos.tec.linutronix.de>
References: <20190624133607.GI29497@fuggles.cambridge.arm.com> <20190625161804.38713-1-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906251851350.32342@nanos.tec.linutronix.de> <alpine.DEB.2.21.1906252024350.32342@nanos.tec.linutronix.de>
 <CALCETrWE3zYN-6h0RkMV9j5kSkSWbJ-nQnjhH=md=ybSR0eZ9Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 25 Jun 2019, Andy Lutomirski wrote:
> On Tue, Jun 25, 2019 at 11:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Tue, 25 Jun 2019, Thomas Gleixner wrote:
> >
> > > On Tue, 25 Jun 2019, Vincenzo Frascino wrote:
> > >
> > > CC+ Andy
> > >
> > > > do_hres() in the vDSO generic library masks the hw counter value
> > > > immediately after reading it.
> > > >
> > > > Postpone the mask application after checking if the syscall fallback is
> > > > enabled, in order to be able to detect a possible fallback for the
> > > > architectures that have masks smaller than ULLONG_MAX.
> > >
> > > Right. This only worked on x86 because the mask is there ULLONG_MAX for all
> > > VDSO capable clocksources, i.e. that ever worked just by chance.
> > >
> > > As we talked about that already yesterday, I tested this on a couple of
> > > machines and as expected the outcome is uarch dependent. Minimal deviations
> > > to both sides and some machines do not show any change at all. I doubt it's
> > > possible to come up with a solution which makes all uarchs go faster
> > > magically.
> > >
> > > Though, thinking about it, we could remove the mask operation completely on
> > > X86. /me runs tests
> >
> > Unsurprisingly the results vary. Two uarchs do not care, but they did not
> > care about moving the mask either. The other two gain performance and the
> > last one falls back to the state before moving the mask. So in general it
> > looks like a worthwhile optimization.
> >
> 
> At one point, I contemplated a different approach: have the "get the
> counter" routine return 0 and then do if (unlikely(cycles <= last))
> goto fallback.  This will remove one branch from the hot path.  I got
> dubious results when I tried benchmarking it, probably because the
> branch in question was always correctly predicted.

Just tried and it's the same thing. One drops, one does not care and one
gains. Did not test the other two as they are asleep already. There is no
universal cure for this I fear. I even tried a uarch optimized build a few
days ago which came out worse than the generic one...

The issue in that code path is the fencing of the TSC read. That seems to
screw up every uarch in a different way.

If you have no objections I'll queue this change (moving the mask) along
with the other two ARM64 ones to unbreak the fallback path for these errata
inflicted machines.

Thanks,

	tglx

