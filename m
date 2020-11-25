Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0F2C3EEC
	for <lists+linux-arch@lfdr.de>; Wed, 25 Nov 2020 12:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKYLRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Nov 2020 06:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgKYLRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Nov 2020 06:17:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45852C0613D4;
        Wed, 25 Nov 2020 03:17:35 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c9b00f4753587c2084c67.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9b00:f475:3587:c208:4c67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D6C31EC04DA;
        Wed, 25 Nov 2020 12:17:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606303051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hCGeOA/AVUI0db3HyJ7Wy3EPXuycxaWqWfQH0yDERSs=;
        b=TMoSchPOyOy3kZ5VUtSbZJJA38QvqyKqM1hqlS3m1k5ukOigq/UyFUoT/nGJEoENfdijjq
        7+Ie/RRfsr8uggkO7nHLDYK+tmKq8Od0DJwAjAfVgRy2AM+jGGzcyVVk2JRv3dwRbIfB2E
        X1wgW1Vzg4cxd27JMLYy+Ok2vqUr9qY=
Date:   Wed, 25 Nov 2020 12:17:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, Dave.Martin@arm.com, mpe@ellerman.id.au,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] x86/signal: Introduce helpers to get the maximum
 signal frame size
Message-ID: <20201125111630.GA10378@zn.tnic>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119190237.626-2-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 11:02:34AM -0800, Chang S. Bae wrote:
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

This sentence is strange and not needed.

> diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
> index 84eab2724875..ac77f3f90bc9 100644
> --- a/arch/x86/include/asm/sigframe.h
> +++ b/arch/x86/include/asm/sigframe.h
> @@ -52,6 +52,15 @@ struct rt_sigframe_ia32 {
>  	char retcode[8];
>  	/* fp state follows here */
>  };
> +
> +#define SIZEOF_sigframe_ia32	sizeof(struct sigframe_ia32)
> +#define SIZEOF_rt_sigframe_ia32	sizeof(struct rt_sigframe_ia32)
> +
> +#else
> +
> +#define SIZEOF_sigframe_ia32	0
> +#define SIZEOF_rt_sigframe_ia32	0
> +
>  #endif /* defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION) */
>  
>  #ifdef CONFIG_X86_64
> @@ -81,8 +90,22 @@ struct rt_sigframe_x32 {
>  	/* fp state follows here */
>  };
>  
> +#define SIZEOF_rt_sigframe_x32	sizeof(struct rt_sigframe_x32)
> +
>  #endif /* CONFIG_X86_X32_ABI */
>  
> +#define SIZEOF_rt_sigframe	sizeof(struct rt_sigframe)
> +
> +#else
> +
> +#define SIZEOF_rt_sigframe	0
> +
>  #endif /* CONFIG_X86_64 */
>  
> +#ifndef SIZEOF_rt_sigframe_x32
> +#define SIZEOF_rt_sigframe_x32	0
> +#endif

Those are defined here to be used in only one place -
init_sigframe_size() - where there already is ifdeffery. Just use the
normal sizeof() operator there instead of adding more gunk here.

> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index a4ec65317a7f..9f009525f551 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -507,6 +507,26 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
>  
>  	return sp;
>  }
> +
> +unsigned long fpu__get_fpstate_sigframe_size(void)
> +{
> +	unsigned long xstate_size = xstate_sigframe_size();
> +	unsigned long fsave_header_size = 0;
> +
> +	/*
> +	 * This space is needed on (most) 32-bit kernels, or when a 32-bit
> +	 * app is running on a 64-bit kernel. To keep things simple, just
> +	 * assume the worst case and always include space for 'freg_state',
> +	 * even for 64-bit apps on 64-bit kernels. This wastes a bit of
> +	 * space, but keeps the code simple.
> +	 */
> +	if ((IS_ENABLED(CONFIG_IA32_EMULATION) ||
> +	     IS_ENABLED(CONFIG_X86_32)) && use_fxsr())
> +		fsave_header_size = sizeof(struct fregs_state);
> +
> +	return fsave_header_size + xstate_size;
> +}

I guess this can be simplified to:

unsigned long fpu__get_fpstate_sigframe_size(void)
{
        unsigned long ret = xstate_sigframe_size();

        /*
         * This space is needed on (most) 32-bit kernels, or when a 32-bit
         * app is running on a 64-bit kernel. To keep things simple, just
         * assume the worst case and always include space for 'freg_state',
         * even for 64-bit apps on 64-bit kernels. This wastes a bit of
         * space, but keeps the code simple.
         */
        if ((IS_ENABLED(CONFIG_IA32_EMULATION) ||
             IS_ENABLED(CONFIG_X86_32)) && use_fxsr())
                ret += sizeof(struct fregs_state);

        return ret;
}

Also, this function simply gives you the xstate size, there's no need
for "sigframe" in the name.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
