Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F1A1E3F9B
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbgE0LNB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 07:13:01 -0400
Received: from foss.arm.com ([217.140.110.172]:36162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387397AbgE0LNB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 07:13:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AC8F55D;
        Wed, 27 May 2020 04:13:00 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E76D3F305;
        Wed, 27 May 2020 04:12:58 -0700 (PDT)
Date:   Wed, 27 May 2020 12:12:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Patrick Daly <pdaly@codeaurora.org>, linux-arch@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Message-ID: <20200527111255.GB28101@gaia>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
 <20200518113103.GA32394@willie-the-truck>
 <20200518172054.GL9862@gaia>
 <20200522055710.GA25791@pdaly-linux.qualcomm.com>
 <20200522103714.GA26492@gaia>
 <20200527021153.GA24439@pdaly-linux.qualcomm.com>
 <20200527095504.GB11111@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527095504.GB11111@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 27, 2020 at 10:55:05AM +0100, Will Deacon wrote:
> On Tue, May 26, 2020 at 07:11:53PM -0700, Patrick Daly wrote:
> > On Fri, May 22, 2020 at 11:37:15AM +0100, Catalin Marinas wrote:
> > > On Thu, May 21, 2020 at 10:57:10PM -0700, Patrick Daly wrote:
> > > > On Mon, May 18, 2020 at 06:20:55PM +0100, Catalin Marinas wrote:
> > > > > On Mon, May 18, 2020 at 12:31:03PM +0100, Will Deacon wrote:
> > > > > > On Mon, May 18, 2020 at 12:26:30PM +0100, Vladimir Murzin wrote:
> > > > > > > On 5/15/20 6:16 PM, Catalin Marinas wrote:
> > > > > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > index f2a93c8679e8..7436e7462b85 100644
> > > > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > @@ -373,6 +373,10 @@
> > > > > > > >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> > > > > > > >  			Format: <io>,<irq>,<nodeID>
> > > > > > > >  
> > > > > > > > +	arm64.mte_disable=
> > > > > > > > +			[ARM64] Disable Linux support for the Memory
> > > > > > > > +			Tagging Extension (both user and in-kernel).
> > > > > > > > +
> > > > > > > 
> > > > > > > Should it really to take parameter (on/off/true/false)? It may lead to expectation
> > > > > > > that arm64.mte_disable=false should enable MT and, yes, double negatives make it
> > > > > > > look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?
> > > > > > 
> > > > > > I don't think "performance analysis" is a good justification for this
> > > > > > parameter tbh. We don't tend to add these options for other architectural
> > > > > > features, and I don't see why MTE is any different in this regard.
> > > > > 
> > > > > There is an expectation of performance impact with MTE enabled,
> > > > > especially if it's running in synchronous mode. For the in-kernel MTE,
> > > > > we could add a parameter which sets sync vs async at boot time rather
> > > > > than a big disable knob. It won't affect user space however.
> > > > > 
> > > > > The other 'justification' is if your hardware has weird unexpected
> > > > > behaviour but I'd like this handled via errata workarounds.
> > > > > 
> > > > > I'll let the people who asked for this to chip in ;). I agree with you
> > > > > that we rarely add these (and I rejected a similar option a few weeks
> > > > > ago on the AMU patchset).
> > > > 
> > > > We've been looking into other ways this on/off behavior could be achieved.
> > > 
> > > The actual question here is what the on/off behaviour is needed for. We
> > > can figure out the best mechanism for this once we know what we want to
> > > achieve. My wild guess above was performance analysis but that can be
> > > toggled by either kernel boot parameter or run-time sysctl (or just the
> > > Kconfig option).
> > > 
> > > If it is about forcing user space not to use MTE, we may look into some
> > > other sysctl controls (we already have one for the tagged address ABI).
> > 
> > We want to allow the end user to be able to easily "opt out" of MTE in favour
> > of better power, perf and battery life.
> 
> Who is "the end user" in this case?

Good question. I have a suspicion it's still the (kernel) developer ;).

> If MTE is bad enough for power, performance and battery life that we need a
> kill switch, then perhaps we shouldn't enable it by default and the few
> people that want to use it can build a kernel with it enabled. However, then
> I don't really see what MTE buys you over the existing KASAN implementations.

MTE is faster than KASan (with async mode the fastest), however I'd
expect it to still be noticeable compared to no-MTE. It's a trade-off if
you want to find security bugs in your code on a large scale.

> I thought the general idea was that you could run in the (cheap) "async"
> mode, and then re-run in the more expensive "sync" mode to further diagnose
> any failures. That model seems to work well with these patches, since
> reporting is disabled by default. Are you saying that there is a
> significant penalty incurred even when reporting is not enabled?

The tag checking mode is controlled by the user on a per-process basis.
The modes and hardware perf/power expectations:

1. no tag checking - no expected performance penalty from the hardware
   perspective (tags not fetched from memory).

2. async tag checking - tags fetched from memory but checked
   asynchronously, so it allows the hardware to perform as well as it
   can (I don't have numbers yet). Probably a small degradation vs (1).

3. sync tag checking - there is an expectation of further perf/power
   degradation vs (2).

In addition to the hardware aspects above, you have the software cost
for colouring memory both on allocation and on free. By default, a
malloc()/free() wouldn't touch the memory (maybe some red zones) but
with MTE the libc will have to set the colour. That's faster than a
memset since it need to store 4 bits for every 16 bytes of address but
slower than not doing it at all. For a calloc(), The memset + tag
setting can be combined in a single DC instruction.

So, it really depends on what the user is doing. If we want a knob where
the user doesn't even attempt to colour pages (not even (1) above),
maybe a user space env variable parsed by the libc is a better option.

While MTE and the tagged addr ABI are complementary (one can still set
PROT_MTE without enabling the tagged addr ABI), most likely a libc
implementation would try to enable the latter before using MTE. We
already have a sysctl to force the tagged addr ABI off. The side-effect
is that MTE will be disabled in the C library, so assuming no run-time
cost (the libc people to confirm).

The tagged addr sysctl doesn't cover the in-kernel MTE but we can leave
the discussion for when we have the patches.

> Anyway, we don't offer global runtime/cmdline switches for the vast majority
> of other architectural features -- instead, we choose a sensible default,
> and I think we should do the same here.

The sensible defaults are currently "off" with a user opt-in. I think
the question is whether we need a "safety" knob at the kernel level like
we did with the sysctl abi.tagged_addr_disabled or we leave it to the
user as it sees fit (e.g. env variables) since it doesn't affect the
kernel (unlike the tagged addr ABI).

-- 
Catalin
