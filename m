Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768F11261BF
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2019 13:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLSMLW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Dec 2019 07:11:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfLSMLV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Dec 2019 07:11:21 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEFF20716;
        Thu, 19 Dec 2019 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757481;
        bh=RE2T76IU/lncwRrDRAlG+ju/T9yNzhZZa+kkSWXB+hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ixnxT3uqPi6FVe/deKUePFfnKx9P1IGOKn1P09zsr5cJF5tc+Lb/RinNJ6zRexCz
         d4w/YFMVv6noAYAo12vcpw9/xsADKJmW1JkRrwXaOXPOxbKCpRgXB/UF6b9ftaH2wF
         dIhF3//DAkyn3jnXauqEMxnnraV8I9v9EaclRVHs=
Date:   Thu, 19 Dec 2019 12:11:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191219121115.GB32361@willie-the-truck>
References: <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck>
 <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
 <CAHk-=wjNLxSZZs+A0tyb-MnJ2YU-sqTAfy0-X+9vxjXfs_O4zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjNLxSZZs+A0tyb-MnJ2YU-sqTAfy0-X+9vxjXfs_O4zA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 17, 2019 at 10:32:35AM -0800, Linus Torvalds wrote:
> On Tue, Dec 17, 2019 at 10:04 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Let me think about it.
> 
> How about we just get rid of the union entirely, and just use
> 'unsigned long' or 'unsigned long long' depending on the size.
> 
> Something like the attached patch - it still requires that it be an
> arithmetic type, but now because of the final cast.
> 
> But it might still be a cast to a volatile type, of course. Then the
> result will be volatile, but at least now READ_ONCE() won't be taking
> the address of a volatile variable on the stack - does that at least
> fix some of the horrible code generation. Hmm?

Sounds like it according to mpe, but I'll confirm too for arm64.

> This is untested, because I obviously still have the cases of
> structures (page table entries) being accessed once..
> 
>               Linus

>  include/linux/compiler.h | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 5e88e7e33abe..8b4282194f16 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -179,18 +179,18 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  
>  #include <uapi/linux/types.h>
>  
> -#define __READ_ONCE_SIZE						\
> -({									\
> -	switch (size) {							\
> -	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
> -	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
> -	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
> -	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
> -	default:							\
> -		barrier();						\
> -		__builtin_memcpy((void *)res, (const void *)p, size);	\
> -		barrier();						\
> -	}								\
> +/* "unsigned long" or "unsigned long long" - make it fit in a register if possible */
> +#define __READ_ONCE_TYPE(size) \
> +	__typeof__(__builtin_choose_expr(size > sizeof(0UL), 0ULL, 0UL))

Ha, I wondered when '__builtin_choose_expr()' would make an appearance in
this thread! Nice trick. I'll try integrating this with what I have and see
what I run into next.

Back down the rabbit hole...

Will
