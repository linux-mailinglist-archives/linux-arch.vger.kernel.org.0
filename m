Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8879C13942A
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 16:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAMPAA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 10:00:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgAMPAA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jan 2020 10:00:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9D6207FF;
        Mon, 13 Jan 2020 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578927599;
        bh=aa9EO2uekBujHfVtcvhLTBuPFLejzJ8R98SroFJlRlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w+RfN76orFFirc2tM4axk9pWZCEaqU4hy00VCYWN+oAs799sNABs+VESEs1g/ToMM
         fESl4+A/K/hkPREmlcWrobsTIMmVBBSNfUUpARLK6wwitllEcSBIbwOsARsS3ujke5
         UtpTmgNbX2M2cjeOzC6Gg/BLqtMGpCm3T14KGats=
Date:   Mon, 13 Jan 2020 14:59:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Message-ID: <20200113145954.GB4458@willie-the-truck>
References: <20200110165636.28035-1-will@kernel.org>
 <20200110165636.28035-7-will@kernel.org>
 <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 10:54:27AM -0800, Linus Torvalds wrote:
> On Fri, Jan 10, 2020 at 8:56 AM Will Deacon <will@kernel.org> wrote:
> >
> > +/* Declare an unqualified scalar type. Leaves non-scalar types unchanged. */
> > +#define __unqual_scalar_typeof(x) typeof(                                      \
> 
> Ugh. My eyes. That's horrendous.
> 
> I can't see any better alternatives, but it does make me go "Eww".

I can't disagree with that, but the only option we've come up with so far
that solves this in the READ_ONCE() macro itself is the thing from PeterZ:

// Insert big fat comment here
#define unqual_typeof(x)    typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))

That apparently *requires* GCC 4.8, but I think the question is more about
whether it's easier to stomach the funny use of _Atomic or the nested
__builtin_choose_expr() I have here. I'm also worried about how reliable
the _Atomic thing is, or whether it's just an artifact of how GCC happens
to work today.

> Well, I do see one possible alternative: just re-write the bitop
> implementations in terms of "atomic_long_t", and just avoid the issue
> entirely.
> 
> IOW, do something like the attached (but fleshed out and tested - this
> patch has not seen a compiler, much less any thought at all).

The big downside of this approach in preference to the proposal here is that
as long as we've got volatile-qualified pointer arguments describing shared
memory, I fear that we'll be playing a constant game of whack-a-mole adding
non-volatile casts as you do below. The same problem manifests for the
acquire/release accessors, which is why having something like
__unqual_typeof() would be beneficial and at least the awfulness is
contained in one place.

So I suppose my question is: how ill does this code really make you feel?
The disassembly is really nice!

Will

>  include/asm-generic/bitops/lock.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
> index 3ae021368f48..071d8bfd86e5 100644
> --- a/include/asm-generic/bitops/lock.h
> +++ b/include/asm-generic/bitops/lock.h
> @@ -6,6 +6,12 @@
>  #include <linux/compiler.h>
>  #include <asm/barrier.h>
>  
> +/* Drop the volatile, we will be doing READ_ONCE by hand */
> +static inline atomic_long_t *atomic_long_bit_word(unsigned int nr, volatile unsigned long *p)
> +{
> +	return BIT_WORD(nr) + (atomic_long_t *)p;
> +}
> +
>  /**
>   * test_and_set_bit_lock - Set a bit and return its old value, for lock
>   * @nr: Bit to set
> @@ -20,12 +26,12 @@ static inline int test_and_set_bit_lock(unsigned int nr,
>  {
>  	long old;
>  	unsigned long mask = BIT_MASK(nr);
> +	atomic_long_t *loc = atomic_long_bit_word(nr, p);
>  
> -	p += BIT_WORD(nr);
> -	if (READ_ONCE(*p) & mask)
> +	if (atomic_read(loc) & mask)
>  		return 1;
>  
> -	old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
> +	old = atomic_long_fetch_or_acquire(mask, loc);
>  	return !!(old & mask);
>  }
>  

