Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BC5466727
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 16:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359185AbhLBPxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 10:53:05 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:41950 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245536AbhLBPxA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 10:53:00 -0500
Date:   Thu, 2 Dec 2021 10:34:23 -0500
From:   Rich Felker <dalias@libc.org>
To:     Zack Weinberg <zack@owlfolio.org>
Cc:     Cyril Hrubis <chrubis@suse.cz>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, ltp@lists.linux.it
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Message-ID: <20211202153422.GH7074@brightrain.aerifal.cx>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 22, 2021 at 10:19:59PM +0000, Zack Weinberg via Libc-alpha wrote:
> On Mon, Nov 22, 2021, at 4:43 PM, Cyril Hrubis wrote:
> > This changes the __u64 and __s64 in userspace on 64bit platforms from
> > long long (unsigned) int to just long (unsigned) int in order to match
> > the uint64_t and int64_t size in userspace.
> ....
> > +
> > +#include <asm/bitsperlong.h>
> > +
> >  /*
> > - * int-ll64 is used everywhere now.
> > + * int-ll64 is used everywhere in kernel now.
> >   */
> > -#include <asm-generic/int-ll64.h>
> > +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
> > +# include <asm-generic/int-l64.h>
> > +#else
> > +# include <asm-generic/int-ll64.h>
> > +#endif
> 
> I am all for matching __uN / __sN to uintN_t / intN_t in userspace, but may I suggest the technically simpler and guaranteed-to-be-accurate
> 
>  /*
> - * int-ll64 is used everywhere now.
> + * int-ll64 is used everywhere in kernel now.
> + * In user space match <stdint.h>.
>   */
> +#ifdef __KERNEL__
>  # include <asm-generic/int-ll64.h>
> +#elif __has_include (<bits/types.h>)
> +# include <bits/types.h>
> +typedef __int8_t __s8;
> +typedef __uint8_t __u8;
> +typedef __int16_t __s16;
> +typedef __uint16_t __u16;
> +typedef __int32_t __s32;
> +typedef __uint32_t __u32;
> +typedef __int64_t __s64;
> +typedef __uint64_t __u64;
> +#else
> +# include <stdint.h>
> +typedef int8_t __s8;
> +typedef uint8_t __u8;
> +typedef int16_t __s16;
> +typedef uint16_t __u16;
> +typedef int32_t __s32;
> +typedef uint32_t __u32;
> +typedef int64_t __s64;
> +typedef uint64_t __u64;
> +#endif
> 
> The middle clause could be dropped if we are okay with all uapi
> headers potentially exposing the non-implementation-namespace names
> defined by <stdint.h>. I do not know what the musl libc equivalent
> of <bits/types.h> is.

We (musl) don't have an equivalent header or __-prefixed versions of
these types.

FWIW I don't think stdint.h exposes anything that would be problematic
alongside arbitrary use of kernel headers.

Rich
