Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC1285C62
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgJGKGF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 06:06:05 -0400
Received: from foss.arm.com ([217.140.110.172]:41114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbgJGKGE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Oct 2020 06:06:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00865113E;
        Wed,  7 Oct 2020 03:06:04 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 032763F71F;
        Wed,  7 Oct 2020 03:06:01 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:05:59 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 1/4] x86/signal: Introduce helpers to get the maximum
 signal frame size
Message-ID: <20201007100558.GE6642@arm.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20200929205746.6763-2-chang.seok.bae@intel.com>
 <20201005134230.GS6642@arm.com>
 <74ca7e8a61f051eadc895cf8b29e591cc3d0f548.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ca7e8a61f051eadc895cf8b29e591cc3d0f548.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 06, 2020 at 05:45:24PM +0000, Bae, Chang Seok wrote:
> On Mon, 2020-10-05 at 14:42 +0100, Dave Martin wrote:
> > On Tue, Sep 29, 2020 at 01:57:43PM -0700, Chang S. Bae wrote:
> > > 
> > > +/*
> > > + * The FP state frame contains an XSAVE buffer which must be 64-byte aligned.
> > > + * If a signal frame starts at an unaligned address, extra space is required.
> > > + * This is the max alignment padding, conservatively.
> > > + */
> > > +#define MAX_XSAVE_PADDING	63UL
> > > +
> > > +/*
> > > + * The frame data is composed of the following areas and laid out as:
> > > + *
> > > + * -------------------------
> > > + * | alignment padding     |
> > > + * -------------------------
> > > + * | (f)xsave frame        |
> > > + * -------------------------
> > > + * | fsave header          |
> > > + * -------------------------
> > > + * | siginfo + ucontext    |
> > > + * -------------------------
> > > + */
> > > +
> > > +/* max_frame_size tells userspace the worst case signal stack size. */
> > > +static unsigned long __ro_after_init max_frame_size;
> > > +
> > > +void __init init_sigframe_size(void)
> > > +{
> > > +	/*
> > > +	 * Use the largest of possible structure formats. This might
> > > +	 * slightly oversize the frame for 64-bit apps.
> > > +	 */
> > > +
> > > +	if (IS_ENABLED(CONFIG_X86_32) ||
> > > +	    IS_ENABLED(CONFIG_IA32_EMULATION))
> > > +		max_frame_size = max((unsigned long)SIZEOF_sigframe_ia32,
> > > +				     (unsigned long)SIZEOF_rt_sigframe_ia32);
> > > +
> > > +	if (IS_ENABLED(CONFIG_X86_X32_ABI))
> > > +		max_frame_size = max(max_frame_size, (unsigned long)SIZEOF_rt_sigframe_x32);
> > > +
> > > +	if (IS_ENABLED(CONFIG_X86_64))
> > > +		max_frame_size = max(max_frame_size, (unsigned long)SIZEOF_rt_sigframe);
> > > +
> > > +	max_frame_size += fpu__get_fpstate_sigframe_size() + MAX_XSAVE_PADDING;
> > 
> > For arm64, we round the worst-case padding up by one.
> > 
> 
> Yeah, I saw that. The ARM code adds the max padding, too:
> 
> 	signal_minsigstksz = sigframe_size(&user) +
> 		round_up(sizeof(struct frame_record), 16) +
> 		16; /* max alignment padding */
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/signal.c#n973
> 
> > I can't remember the full rationale for this, but it at least seemed a
> > bit weird to report a size that is not a multiple of the alignment.
> > 
> 
> Because the last state size of XSAVE may not be 64B aligned, the (reported)
> sum of xstate size here does not guarantee 64B alignment.
> 
> > I'm can't think of a clear argument as to why it really matters, though.
> 
> We care about the start of XSAVE buffer for the XSAVE instructions, to be
> 64B-aligned.

Ah, I see.  That makes sense.

For arm64, there is no additional alignment padding inside the frame,
only the padding inserted after the frame to ensure that the base
address is 16-byte aligned.

However, I wonder whether people will tend to assume that AT_MINSIGSTKSZ
is a sensible (if minimal) amount of stack to allocate.  Allocating an
odd number of bytes, or any amount that isn't a multiple of the
architecture's preferred (or mandated) stack alignment probably doesn't
make sense.

AArch64 has a mandatory stack alignment of 16 bytes; I'm not sure about
x86.

Cheers
---Dave
