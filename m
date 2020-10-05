Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4E2836C1
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgJENmg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 09:42:36 -0400
Received: from foss.arm.com ([217.140.110.172]:47766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgJENmg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 09:42:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBBC4106F;
        Mon,  5 Oct 2020 06:42:35 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE8B43F70D;
        Mon,  5 Oct 2020 06:42:33 -0700 (PDT)
Date:   Mon, 5 Oct 2020 14:42:30 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, mpe@ellerman.id.au, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] x86/signal: Introduce helpers to get the maximum
 signal frame size
Message-ID: <20201005134230.GS6642@arm.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20200929205746.6763-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929205746.6763-2-chang.seok.bae@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 29, 2020 at 01:57:43PM -0700, Chang S. Bae wrote:
> Signal frames do not have a fixed format and can vary in size when a number
> of things change: support XSAVE features, 32 vs. 64-bit apps. Add the code
> to support a runtime method for userspace to dynamically discover how large
> a signal stack needs to be.
> 
> Introduce a new variable, max_frame_size, and helper functions for the
> calculation to be used in a new user interface. Set max_frame_size to a
> system-wide worst-case value, instead of storing multiple app-specific
> values.
> 
> Locate the body of the helper function -- fpu__get_fpstate_sigframe_size()
> in fpu/signal.c for its relevance.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/include/asm/fpu/signal.h |  2 ++
>  arch/x86/include/asm/sigframe.h   | 23 ++++++++++++++++
>  arch/x86/kernel/cpu/common.c      |  3 +++
>  arch/x86/kernel/fpu/signal.c      | 20 ++++++++++++++
>  arch/x86/kernel/signal.c          | 45 +++++++++++++++++++++++++++++++
>  5 files changed, 93 insertions(+)

[...]

> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index be0d7d4152ec..239a0b23a4b0 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -663,6 +663,51 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  	return 0;
>  }
>  
> +/*
> + * The FP state frame contains an XSAVE buffer which must be 64-byte aligned.
> + * If a signal frame starts at an unaligned address, extra space is required.
> + * This is the max alignment padding, conservatively.
> + */
> +#define MAX_XSAVE_PADDING	63UL
> +
> +/*
> + * The frame data is composed of the following areas and laid out as:
> + *
> + * -------------------------
> + * | alignment padding     |
> + * -------------------------
> + * | (f)xsave frame        |
> + * -------------------------
> + * | fsave header          |
> + * -------------------------
> + * | siginfo + ucontext    |
> + * -------------------------
> + */
> +
> +/* max_frame_size tells userspace the worst case signal stack size. */
> +static unsigned long __ro_after_init max_frame_size;
> +
> +void __init init_sigframe_size(void)
> +{
> +	/*
> +	 * Use the largest of possible structure formats. This might
> +	 * slightly oversize the frame for 64-bit apps.
> +	 */
> +
> +	if (IS_ENABLED(CONFIG_X86_32) ||
> +	    IS_ENABLED(CONFIG_IA32_EMULATION))
> +		max_frame_size = max((unsigned long)SIZEOF_sigframe_ia32,
> +				     (unsigned long)SIZEOF_rt_sigframe_ia32);
> +
> +	if (IS_ENABLED(CONFIG_X86_X32_ABI))
> +		max_frame_size = max(max_frame_size, (unsigned long)SIZEOF_rt_sigframe_x32);
> +
> +	if (IS_ENABLED(CONFIG_X86_64))
> +		max_frame_size = max(max_frame_size, (unsigned long)SIZEOF_rt_sigframe);
> +
> +	max_frame_size += fpu__get_fpstate_sigframe_size() + MAX_XSAVE_PADDING;

For arm64, we round the worst-case padding up by one.

I can't remember the full rationale for this, but it at least seemed a
bit weird to report a size that is not a multiple of the alignment.

I'm can't think of a clear argument as to why it really matters, though.

[...]

Cheers
---Dave
