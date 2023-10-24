Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2D7D46B5
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 06:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjJXE0y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 00:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJXE0x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 00:26:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2B1125;
        Mon, 23 Oct 2023 21:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kry6XAEjZW+AJ9FoGZbhDGjQPVuRuTT9bve3BJ1xdbg=; b=NO4MDcbuJCYfeSSG4HeYFAKV7u
        HO6ADQuGek0V0WRdzxGs7ddwODrAqBNAz+xpag/TK78/uOG66j5s8lyxmtyFfmdxZqQ2vLaN6ucIy
        kmUFdFU5U/3mWrqrdyaouiGse3UGnHFuJv+ly5uL1VlB2c9r3soNK4GEJOPAa36J2jZSJb9RWpXQK
        QEKtn8uFmIrxibMk1DNcxVcR2GXFyBdEZ/j22Ixn1v59VM6yRoglfm6I/gMbSzDTB0CfiRkyLgAG/
        lBTdfNNUWWukOJTwmW9aAX98XKDa+0qkzAKEQcfzvASg8iigo1W/Sz/Ml1L4o/FBRxuWo1hEaMqMY
        w0/H33XQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qv909-004lGJ-0p;
        Tue, 24 Oct 2023 04:26:45 +0000
Date:   Tue, 24 Oct 2023 05:26:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch@vger.kernel.org, gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCH] fix csum_and_copy_..._user() idiocy.  Re: AW:
 [PATCH] amd64: Fix csum_partial_copy_generic()
Message-ID: <20231024042645.GF800259@ZenIV>
References: <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <20231022194020.GA972254@ZenIV>
 <20231022194618.GC800259@ZenIV>
 <87wmvdd3p5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmvdd3p5.ffs@tglx>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 23, 2023 at 12:37:58PM +0200, Thomas Gleixner wrote:
> On Sun, Oct 22 2023 at 20:46, Al Viro wrote:
> > @@ -113,14 +113,14 @@ csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
> >  		*dst = word | tmp;
> >  		checksum += carry;
> >  	}
> > -	return checksum;
> > +	return from64to16 (checksum);
> 
>   from64to16(checksum); all over the place

Umm...  Is that about whitespace?
 
> >  #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
> >  #define _HAVE_ARCH_CSUM_AND_COPY
> >  static inline
> > -__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
> > +__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len)
> >  {
> >  	if (!access_ok(src, len))
> > -		return 0;
> > +		return -1;
> 
>   return CSUM_FAULT; 

Already caught and fixed...

> > --- a/arch/arm/lib/csumpartialcopyuser.S
> > +++ b/arch/arm/lib/csumpartialcopyuser.S
> > @@ -73,11 +73,11 @@
> >  #include "csumpartialcopygeneric.S"
> >  
> >  /*
> > - * We report fault by returning 0 csum - impossible in normal case, since
> > - * we start with 0xffffffff for initial sum.
> > + * We report fault by returning ~0ULL csum
> >   */
> 
> There is also a stale comment a few lines further up.

Umm...
 *  Returns : r0:r1 = checksum:0 on success or -1:-1 on fault  
perhaps?

> > +typedef u64 __bitwise __wsum_fault;
> 
> newline please.

Done...

> > +static inline __wsum_fault to_wsum_fault(__wsum v)
> > +{
> > +#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
> > +	return (__force __wsum_fault)v;
> > +#else
> > +	return (__force __wsum_fault)((__force u64)v << 32);
> > +#endif
> > +}
> > +
> > +static inline __wsum_fault from_wsum_fault(__wsum v)
> > +{
> > +#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
> > +	return (__force __wsum)v;
> > +#else
> > +	return (__force __wsum)((__force u64)v >> 32);
> > +#endif
> > +}
> > +
> > +static inline bool wsum_fault_check(__wsum_fault v)
> > +{
> > +#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
> > +	return (__force s64)v < 0;
> > +#else
> > +	return (int)(__force u32)v < 0;
> 
> Why not __force s32 right away?

Mostly to keep the reader within more familiar cases
of conversion - u64 to u32 is "throw the upper 32 bits
away", u32 to s32 - "treat MSB as sign".

It's still a nasal demon country, of course - the proper
solution is

static inline bool wsum_fault_check(__wsum_fault v)
{
#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
	return (__force u64)v & (1ULL << 63);
#else
	return (__force u32)v & (1ULL << 31);
#endif
}

Incidentally, in this case we really want a cast to u32
rather than u64 - gcc is smart enough to figure out that
checking MSB in 32bit can be done as signed 32bit comparison
with 0, but bit 31 in 64bit is not special as far as it's
concerned, even though it's a bit 31 of 32bit register...
 
>   	if (copy_to_user(dst, src, len))
> 		return CSUM_FAULT;
> 	return to_wsum_fault(sum);
> 
> So it follows the pattern of csum_and_copy_from_user() above?

Let's not mix that with the rest of changes...

> Which means that if the first vector is successfully copied, then 'off'
> is greater 0. A fault on the second one will correctly break out of the
> loop, but the function will incorrectly return a value > 0, i.e. the
> length of the first iteration.
> 
> As the callers just check for != 0 such a partial copy is considered
> success, no?

Check the callers...

static __always_inline __must_check
bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
                                  __wsum *csum, struct iov_iter *i)
{
        size_t copied = csum_and_copy_from_iter(addr, bytes, csum, i);
        if (likely(copied == bytes))
                return true;
        iov_iter_revert(i, copied);
        return false;
}

and
static int skb_copy_and_csum_datagram(const struct sk_buff *skb, int offset,
                                      struct iov_iter *to, int len,
                                      __wsum *csump)
{
        struct csum_state csdata = { .csum = *csump };
        int ret;

        ret = __skb_datagram_iter(skb, offset, to, len, true,
                                  csum_and_copy_to_iter, &csdata);
        if (ret)
                return ret;

        *csump = csdata.csum;
        return 0;
}

with __skb_datagram_iter() treating short copies as "revert everything
and return -EFAULT".

> So instead of 
> 
> 	likely(!wsum_fault_check(next)) ? 0 : len;
> 
> shouldn't this just do:
> 
> 	if (unlikely(wsum_fault_check(next))
> 		return 0;
>         len;
> 
> for simplicity and mental sanity sake?

Let's not.  The macros are still too convoluted, but I really hate the
idea of having to cope with non-trivial control flow in the thunks.
It's really *NOT* helping mental state of anyone having to touch those...
