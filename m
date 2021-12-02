Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A505466DC4
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 00:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356582AbhLBXdS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 18:33:18 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:42150 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353903AbhLBXdS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 18:33:18 -0500
Date:   Thu, 2 Dec 2021 18:29:54 -0500
From:   Rich Felker <dalias@libc.org>
To:     Zack Weinberg <zack@owlfolio.org>
Cc:     linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Message-ID: <20211202232954.GI7074@brightrain.aerifal.cx>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
 <20211202153422.GH7074@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202153422.GH7074@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 02, 2021 at 10:34:23AM -0500, Rich Felker wrote:
> On Mon, Nov 22, 2021 at 10:19:59PM +0000, Zack Weinberg via Libc-alpha wrote:
> > On Mon, Nov 22, 2021, at 4:43 PM, Cyril Hrubis wrote:
> > > This changes the __u64 and __s64 in userspace on 64bit platforms from
> > > long long (unsigned) int to just long (unsigned) int in order to match
> > > the uint64_t and int64_t size in userspace.
> > ....
> > > +
> > > +#include <asm/bitsperlong.h>
> > > +
> > >  /*
> > > - * int-ll64 is used everywhere now.
> > > + * int-ll64 is used everywhere in kernel now.
> > >   */
> > > -#include <asm-generic/int-ll64.h>
> > > +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
> > > +# include <asm-generic/int-l64.h>
> > > +#else
> > > +# include <asm-generic/int-ll64.h>
> > > +#endif
> > 
> > I am all for matching __uN / __sN to uintN_t / intN_t in userspace, but may I suggest the technically simpler and guaranteed-to-be-accurate
> > 
> >  /*
> > - * int-ll64 is used everywhere now.
> > + * int-ll64 is used everywhere in kernel now.
> > + * In user space match <stdint.h>.
> >   */
> > +#ifdef __KERNEL__
> >  # include <asm-generic/int-ll64.h>
> > +#elif __has_include (<bits/types.h>)
> > +# include <bits/types.h>
> > +typedef __int8_t __s8;
> > +typedef __uint8_t __u8;
> > +typedef __int16_t __s16;
> > +typedef __uint16_t __u16;
> > +typedef __int32_t __s32;
> > +typedef __uint32_t __u32;
> > +typedef __int64_t __s64;
> > +typedef __uint64_t __u64;
> > +#else
> > +# include <stdint.h>
> > +typedef int8_t __s8;
> > +typedef uint8_t __u8;
> > +typedef int16_t __s16;
> > +typedef uint16_t __u16;
> > +typedef int32_t __s32;
> > +typedef uint32_t __u32;
> > +typedef int64_t __s64;
> > +typedef uint64_t __u64;
> > +#endif
> > 
> > The middle clause could be dropped if we are okay with all uapi
> > headers potentially exposing the non-implementation-namespace names
> > defined by <stdint.h>. I do not know what the musl libc equivalent
> > of <bits/types.h> is.
> 
> We (musl) don't have an equivalent header or __-prefixed versions of
> these types.
> 
> FWIW I don't think stdint.h exposes anything that would be problematic
> alongside arbitrary use of kernel headers.

Also, per glibc's bits/types.h:

/*
 * Never include this file directly; use <sys/types.h> instead.
 */

it's not permitted (not supported usage) to #include <bits/types.h>.
So I think the above patch is wrong for glibc too. As I understand it,
this is general policy for bits/* -- they're only intended to work as
included by the libc system headers, not directly by something else.

Rich
