Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50F1285CB8
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgJGKTk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 06:19:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgJGKTk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Oct 2020 06:19:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4407D11B3;
        Wed,  7 Oct 2020 03:19:39 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61C433F71F;
        Wed,  7 Oct 2020 03:19:37 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:19:34 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Dave Martin via Libc-alpha <libc-alpha@sourceware.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/4] x86: Improve Minimum Alternate Stack Size
Message-ID: <20201007101933.GF6642@arm.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20201005134534.GT6642@arm.com>
 <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
 <20201006092532.GU6642@arm.com>
 <CAMe9rOq_nKa6xjHju3kVZephTiO+jEW3PqxgAhU9+RdLTo-jgg@mail.gmail.com>
 <20201006152553.GY6642@arm.com>
 <7663eff0-6c94-f6bf-f3e2-93ede50e75ed@intel.com>
 <20201006170020.GB6642@arm.com>
 <87362rp65v.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87362rp65v.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 06, 2020 at 08:21:00PM +0200, Florian Weimer wrote:
> * Dave Martin via Libc-alpha:
> 
> > On Tue, Oct 06, 2020 at 08:33:47AM -0700, Dave Hansen wrote:
> >> On 10/6/20 8:25 AM, Dave Martin wrote:
> >> > Or are people reporting real stack overruns on x86 today?
> >> 
> >> We have real overruns.  We have ~2800 bytes of XSAVE (regisiter) state
> >> mostly from AVX-512, and a 2048 byte MINSIGSTKSZ.
> >
> > Right.  Out of interest, do you believe that's a direct consequence of
> > the larger kernel-generated signal frame, or does the expansion of
> > userspace stack frames play a role too?
> 
> I must say that I do not quite understand this question.
> 
> 32 64-*byte* registers simply need 2048 bytes of storage space worst
> case, there is really no way around that.

If the architecture grows more or bigger registers, and if those
registers are used in general-purpose code, then all stack frames will
tend to grow, not just the signal frame.

So a stack overflow might be caused by the larger signal frame by
itself; or it might be caused by the growth of the stack of 20 function
frames created by someone's signal handler.

In the latter case, this is just a "normal" stack overflow, and nothing
really to do with signals or SIGSTKSZ.  Rebuilding with different
compiler flags could also grow the stack usage and cause just the same
problem.

I also strongly suspect that people often don't think about signal
nesting when allocating signal stacks.  So, there might be a pre-
existing potential overflow that just becomes more likely when the
signal frame grows.  That's not really SIGSTKSZ's fault.


Of course, AVX-512 might never be used in general-purpose code.  On
AArch64, SVE can be used in general-purpose code, but it's too early to
say what its prevalence will be in signal handlers.  Probably low.


> > In practice software just assumes SIGSTKSZ and then ignores the problem
> > until / unless an actual stack overflow is seen.
> >
> > There's probably a lot of software out there whose stack is
> > theoretically too small even without AVX-512 etc. in the mix, especially
> > when considering the possibility of nested signals...
> 
> That is certainly true.  We have seen problems with ntpd, which
> requested a 16 KiB stack, at a time when there were various deductions
> from the stack size, and since the glibc dynamic loader also uses XSAVE,
> ntpd exceeded the remaining stack space.  But in this case, we just
> fudged the stack size computation in pthread_create and made it less
> likely that the dynamic loader was activated, which largely worked
> around this particular problem.  For MINSIGSTKSZ, we just don't have
> this option because it's simply too small in the first place.
> 
> I don't immediately recall a bug due to SIGSTKSZ being too small.  The
> test cases I wrote for this were all artificial, to raise awareness of
> this issue (applications treating these as recommended values, rather
> than minimum value to avoid immediately sigaltstack/phtread_create
> failures, same issue with PTHREAD_STACK_MIN).

Ack, I think if SIGSTKSZ was too small significantly often, there would
be more awareness of the issue.

Cheers
---Dave
