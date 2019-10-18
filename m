Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E0DC63A
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 15:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410368AbfJRNhD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 09:37:03 -0400
Received: from [217.140.110.172] ([217.140.110.172]:39522 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbfJRNhC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 09:37:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A62E03BB;
        Fri, 18 Oct 2019 06:36:39 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC903F6C4;
        Fri, 18 Oct 2019 06:36:36 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:36:34 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>
Subject: Re: [PATCH v2 05/12] arm64: Basic Branch Target Identification
 support
Message-ID: <20191018133628.GC27757@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
 <20191011151028.GE33537@lakrids.cambridge.arm.com>
 <4e09ca54-f353-9448-64ed-4ba1e38c6ebc@linaro.org>
 <20191011153225.GL27757@arm.com>
 <20191011154043.GG33537@lakrids.cambridge.arm.com>
 <20191011154444.GN27757@arm.com>
 <20191011160113.GO27757@arm.com>
 <20191011164159.GP27757@arm.com>
 <20191018110551.GB27759@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018110551.GB27759@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 18, 2019 at 12:05:52PM +0100, Mark Rutland wrote:
> On Fri, Oct 11, 2019 at 05:42:00PM +0100, Dave Martin wrote:
> > On Fri, Oct 11, 2019 at 05:01:13PM +0100, Dave Martin wrote:
> > > On Fri, Oct 11, 2019 at 04:44:45PM +0100, Dave Martin wrote:
> > > > On Fri, Oct 11, 2019 at 04:40:43PM +0100, Mark Rutland wrote:
> > > > > On Fri, Oct 11, 2019 at 04:32:26PM +0100, Dave Martin wrote:

[...]

> > > > > > Either way, I feel we should do this: any function in a PROT_BTI page
> > > > > > should have a suitable landing pad.  There's no reason I can see why
> > > > > > a protection given to any other callback function should be omitted
> > > > > > for a signal handler.
> > > > > > 
> > > > > > Note, if the signal handler isn't in a PROT_BTI page then overriding
> > > > > > BTYPE here will not trigger a Branch Target exception.
> > > > > > 
> > > > > > I'm happy to drop a brief comment into the code also, once we're
> > > > > > agreed on what the code should be doing.
> > > > > 
> > > > > So long as there's a comment as to why, I have no strong feelings here.
> > > > > :)
> > > > 
> > > > OK, I think it's worth a brief comment in the code either way, so I'll
> > > > add something.
> > > 
> > > Hmm, come to think of it we do need special logic for a particular case
> > > here:
> > > 
> > > If we are delivering a SIGILL here and the SIGILL handler was registered
> > > with SA_NODEFER then we will get into a spin, repeatedly delivering
> > > the BTI-triggered SIGILL to the same (bad) entry point.
> > > 
> > > Without SA_NODEFER, the SIGILL becomes fatal, which is the desired
> > > behaviour, but we'll need to catch this recursion explicitly.
> > > 
> > > 
> > > It's similar to the special force_sigsegv() case in
> > > linux/kernel/signal.c...
> > > 
> > > Thoughts?
> > 
> > On second thought, maybe we don't need to do anything special.
> > 
> > A SIGSEGV handler registered with (SA_NODEFER & ~SA_RESETHAND) and that
> > dereferences a duff address would spin similarly.
> > 
> > This SIGILL case doesn't really seem different.  Either way it's a
> > livelock of the user task that doesn't compromise the kernel.  There
> > are plenty of ways for such a livelock to happen.
> 
> That sounds reasonable to me.

OK, I guess we can park this discussion for now.

Cheers
---Dave
