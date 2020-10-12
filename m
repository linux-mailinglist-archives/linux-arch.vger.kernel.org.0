Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8128B626
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgJLN0p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 09:26:45 -0400
Received: from foss.arm.com ([217.140.110.172]:45998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbgJLN0p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 09:26:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03B1BD6E;
        Mon, 12 Oct 2020 06:26:44 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051B93F66B;
        Mon, 12 Oct 2020 06:26:41 -0700 (PDT)
Date:   Mon, 12 Oct 2020 14:26:39 +0100
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
Message-ID: <20201012132638.GC32292@arm.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20200929205746.6763-2-chang.seok.bae@intel.com>
 <20201005134230.GS6642@arm.com>
 <74ca7e8a61f051eadc895cf8b29e591cc3d0f548.camel@intel.com>
 <20201007100558.GE6642@arm.com>
 <20ae46ae9b74036723ff7b9f731374f78536dc88.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20ae46ae9b74036723ff7b9f731374f78536dc88.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 08, 2020 at 10:43:50PM +0000, Bae, Chang Seok wrote:
> On Wed, 2020-10-07 at 11:05 +0100, Dave Martin wrote:
> > On Tue, Oct 06, 2020 at 05:45:24PM +0000, Bae, Chang Seok wrote:
> > > On Mon, 2020-10-05 at 14:42 +0100, Dave Martin wrote:
> > > > On Tue, Sep 29, 2020 at 01:57:43PM -0700, Chang S. Bae wrote:
> > > > > 
> > > > > +/*
> > > > > + * The FP state frame contains an XSAVE buffer which must be 64-byte aligned.
> > > > > + * If a signal frame starts at an unaligned address, extra space is required.
> > > > > + * This is the max alignment padding, conservatively.
> > > > > + */
> > > > > +#define MAX_XSAVE_PADDING	63UL
> > > > > +
> > > > > +/*
> > > > > + * The frame data is composed of the following areas and laid out as:
> > > > > + *
> > > > > + * -------------------------
> > > > > + * | alignment padding     |
> > > > > + * -------------------------
> > > > > + * | (f)xsave frame        |
> > > > > + * -------------------------
> > > > > + * | fsave header          |
> > > > > + * -------------------------
> > > > > + * | siginfo + ucontext    |
> > > > > + * -------------------------
> > > > > + */
> > > > > +
> > > > > +/* max_frame_size tells userspace the worst case signal stack size. */
> > > > > +static unsigned long __ro_after_init max_frame_size;
> > > > > +
> > > > > +void __init init_sigframe_size(void)
> > > > > +{
> > > > > +	/*
> > > > > +	 * Use the largest of possible structure formats. This might
> > > > > +	 * slightly oversize the frame for 64-bit apps.
> > > > > +	 */
> > > > > +
> > > > > +	if (IS_ENABLED(CONFIG_X86_32) ||
> > > > > +	    IS_ENABLED(CONFIG_IA32_EMULATION))
> > > > > +		max_frame_size = max((unsigned long)SIZEOF_sigframe_ia32,
> > > > > +				     (unsigned long)SIZEOF_rt_sigframe_ia32);
> > > > > +
> > > > > +	if (IS_ENABLED(CONFIG_X86_X32_ABI))
> > > > > +		max_frame_size = max(max_frame_size, (unsigned long)SIZEOF_rt_sigframe_x32);
> > > > > +
> > > > > +	if (IS_ENABLED(CONFIG_X86_64))
> > > > > +		max_frame_size = max(max_frame_size, (unsigned long)SIZEOF_rt_sigframe);
> > > > > +
> > > > > +	max_frame_size += fpu__get_fpstate_sigframe_size() + MAX_XSAVE_PADDING;
> > > > 
> > > > For arm64, we round the worst-case padding up by one.
> > > > 
> > > 
> > > Yeah, I saw that. The ARM code adds the max padding, too:
> > > 
> > > 	signal_minsigstksz = sigframe_size(&user) +
> > > 		round_up(sizeof(struct frame_record), 16) +
> > > 		16; /* max alignment padding */
> > > 
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/signal.c#n973
> > > 
> > > > I can't remember the full rationale for this, but it at least seemed a
> > > > bit weird to report a size that is not a multiple of the alignment.
> > > > 
> > > 
> > > Because the last state size of XSAVE may not be 64B aligned, the (reported)
> > > sum of xstate size here does not guarantee 64B alignment.
> > > 
> > > > I'm can't think of a clear argument as to why it really matters, though.
> > > 
> > > We care about the start of XSAVE buffer for the XSAVE instructions, to be
> > > 64B-aligned.
> > 
> > Ah, I see.  That makes sense.
> > 
> > For arm64, there is no additional alignment padding inside the frame,
> > only the padding inserted after the frame to ensure that the base
> > address is 16-byte aligned.
> > 
> > However, I wonder whether people will tend to assume that AT_MINSIGSTKSZ
> > is a sensible (if minimal) amount of stack to allocate.  Allocating an
> > odd number of bytes, or any amount that isn't a multiple of the
> > architecture's preferred (or mandated) stack alignment probably doesn't
> > make sense.
> > 
> > AArch64 has a mandatory stack alignment of 16 bytes; I'm not sure about
> > x86.
> 
> The x86 ABI looks to require 16-byte alignment (for both 32-/64-bit modes).
> FWIW, the 32-bit ABI got changed from 4-byte alignement.
> 
> Thank you for brining up the point. Ack. The kernel is expected to return a
> 16-byte aligned size. I made this change after a discussion with H.J.:
> 
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index c042236ef52e..52815d7c08fb 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -212,6 +212,11 @@ do {							
> 		\
>   * Set up a signal frame.
>   */
>  
> +/* x86 ABI requires 16-byte alignment */
> +#define FRAME_ALIGNMENT	16UL
> +
> +#define MAX_FRAME_PADDING	FRAME_ALIGNMENT - 1
> +

You might want () here, to avoid future surpsises.

>  /*
>   * Determine which stack to use..
>   */
> @@ -222,9 +227,9 @@ static unsigned long align_sigframe(unsigned long sp)
>  	 * Align the stack pointer according to the i386 ABI,
>  	 * i.e. so that on function entry ((sp + 4) & 15) == 0.
>  	 */
> -	sp = ((sp + 4) & -16ul) - 4;
> +	sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
>  #else /* !CONFIG_X86_32 */
> -	sp = round_down(sp, 16) - 8;
> +	sp = round_down(sp, FRAME_ALIGNMENT) - 8;
>  #endif
>  	return sp;
>  }
> @@ -404,7 +409,7 @@ static int __setup_rt_frame(int sig, struct ksignal
> *ksig,
>  	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set,
> Efault);
>  	unsafe_put_sigmask(set, frame, Efault);
>  	user_access_end();
> -	
> +
>  	if (copy_siginfo_to_user(&frame->info, &ksig->info))
>  		return -EFAULT;
>  
> @@ -685,6 +690,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
>   * -------------------------
>   * | fsave header          |
>   * -------------------------
> + * | alignment padding     |
> + * -------------------------
>   * | siginfo + ucontext    |
>   * -------------------------
>   */
> @@ -710,7 +717,12 @@ void __init init_sigframe_size(void)
>  	if (IS_ENABLED(CONFIG_X86_64))
>  		max_frame_size = max(max_frame_size, (unsigned
> long)SIZEOF_rt_sigframe);
>  
> +	max_frame_size += MAX_FRAME_PADDING;
> +
>  	max_frame_size += fpu__get_fpstate_sigframe_size() +
> MAX_XSAVE_PADDING;
> +
> +	/* Userspace expects an aligned size. */
> +	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);
>  }

[...]

Seems reasonable, I guess.

(I won't comment on the x86 ABI specifics.)

Cheers
---Dave
