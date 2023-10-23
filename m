Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C414E7D3014
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 12:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjJWKiH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 06:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJWKiG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 06:38:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348FDD66;
        Mon, 23 Oct 2023 03:38:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698057479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NV8omgEBFH7BzKZpP/nKdtpWk9EtkHBp6M/sRgzmhUc=;
        b=r8T1qQkeLPywonI87335b73C9oCYFkBrIUapkX1rrDhevbvHdmX+D/CB/c1uIMbQF0SVnS
        VZ7foChKzrKZF6i0k4kMDJVI4VSTU//JgV1dJWcLKCOlThhMDJPaQGpBZ/oTUBOOSGoMJx
        TAfb0F9AZmvxqkfPKdUDZkgUPbQpzM4PV73H3Yvi0hsIqkMBI8mScrCH1sgvwc7/Y3KxFv
        zEZR3iwExHrzbDQXAeOfFyWNnGsPuVljsjXUDQAtOVZhXKl1liQlNkfx3hwMUIWvxnwNP4
        tJDKdrI3Xue2f+4I05ZloOMjiPSuTztNhSrUh/SquMrRfW+WZcyeoFjuHFzT2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698057479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NV8omgEBFH7BzKZpP/nKdtpWk9EtkHBp6M/sRgzmhUc=;
        b=jYeTzjVAfzI4mp2pPUmFBMg4mnDNWbK0yKxWmKXibfhZbGO0K/k0RUClYhuGzg4kaWUqyJ
        ijgXMtHDrdXzuuAQ==
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org
Cc:     gus Gusenleitner Klaus <gus@keba.com>,
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
In-Reply-To: <20231022194618.GC800259@ZenIV>
References: <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV> <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV> <20231022194020.GA972254@ZenIV>
 <20231022194618.GC800259@ZenIV>
Date:   Mon, 23 Oct 2023 12:37:58 +0200
Message-ID: <87wmvdd3p5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 22 2023 at 20:46, Al Viro wrote:
> @@ -113,14 +113,14 @@ csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
>  		*dst = word | tmp;
>  		checksum += carry;
>  	}
> -	return checksum;
> +	return from64to16 (checksum);

  from64to16(checksum); all over the place

>  
>  #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
>  #define _HAVE_ARCH_CSUM_AND_COPY
>  static inline
> -__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
> +__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len)
>  {
>  	if (!access_ok(src, len))
> -		return 0;
> +		return -1;

  return CSUM_FAULT; 
  
>  /*
> diff --git a/arch/arm/lib/csumpartialcopygeneric.S b/arch/arm/lib/csumpartialcopygeneric.S
> index 0fd5c10e90a7..5db935eaf165 100644
> --- a/arch/arm/lib/csumpartialcopygeneric.S
> +++ b/arch/arm/lib/csumpartialcopygeneric.S
> @@ -86,7 +86,7 @@ sum	.req	r3
>  
>  FN_ENTRY
>  		save_regs
> -		mov	sum, #-1
> +		mov	sum, #0
>  
>  		cmp	len, #8			@ Ensure that we have at least
>  		blo	.Lless8			@ 8 bytes to copy.
> @@ -160,6 +160,7 @@ FN_ENTRY
>  		ldr	sum, [sp, #0]		@ dst
>  		tst	sum, #1
>  		movne	r0, r0, ror #8
> +		mov	r1, #0
>  		load_regs
>  
>  .Lsrc_not_aligned:
> diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
> index 6928781e6bee..f273c9667914 100644
> --- a/arch/arm/lib/csumpartialcopyuser.S
> +++ b/arch/arm/lib/csumpartialcopyuser.S
> @@ -73,11 +73,11 @@
>  #include "csumpartialcopygeneric.S"
>  
>  /*
> - * We report fault by returning 0 csum - impossible in normal case, since
> - * we start with 0xffffffff for initial sum.
> + * We report fault by returning ~0ULL csum
>   */

There is also a stale comment a few lines further up.

>  		.pushsection .text.fixup,"ax"
>  		.align	4
> -9001:		mov	r0, #0
> +9001:		mov	r0, #-1
> +		mov	r1, #-1
>  		load_regs
>  		.popsection
>  #include <linux/errno.h>
> -#include <asm/types.h>
> +#include <linux/bitops.h>
>  #include <asm/byteorder.h>
> +
> +typedef u64 __bitwise __wsum_fault;

newline please.

> +static inline __wsum_fault to_wsum_fault(__wsum v)
> +{
> +#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
> +	return (__force __wsum_fault)v;
> +#else
> +	return (__force __wsum_fault)((__force u64)v << 32);
> +#endif
> +}
> +
> +static inline __wsum_fault from_wsum_fault(__wsum v)
> +{
> +#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
> +	return (__force __wsum)v;
> +#else
> +	return (__force __wsum)((__force u64)v >> 32);
> +#endif
> +}
> +
> +static inline bool wsum_fault_check(__wsum_fault v)
> +{
> +#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
> +	return (__force s64)v < 0;
> +#else
> +	return (int)(__force u32)v < 0;

Why not __force s32 right away?

>  #include <asm/checksum.h>
>  #if !defined(_HAVE_ARCH_COPY_AND_CSUM_FROM_USER) || !defined(HAVE_CSUM_COPY_USER)
>  #include <linux/uaccess.h>
> @@ -25,24 +57,24 @@
>  
>  #ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
>  static __always_inline
> -__wsum csum_and_copy_from_user (const void __user *src, void *dst,
> +__wsum_fault csum_and_copy_from_user (const void __user *src, void *dst,
>  				      int len)
>  {
>  	if (copy_from_user(dst, src, len))
> -		return 0;
> -	return csum_partial(dst, len, ~0U);
> +		return CSUM_FAULT;
> +	return to_wsum_fault(csum_partial(dst, len, 0));
>  }
>  #endif
>  #ifndef HAVE_CSUM_COPY_USER
> -static __always_inline __wsum csum_and_copy_to_user
> +static __always_inline __wsum_fault csum_and_copy_to_user
>  (const void *src, void __user *dst, int len)
>  {
> -	__wsum sum = csum_partial(src, len, ~0U);
> +	__wsum sum = csum_partial(src, len, 0);
>  
>  	if (copy_to_user(dst, src, len) == 0)
> -		return sum;
> -	return 0;
> +		return to_wsum_fault(sum);
> +	return CSUM_FAULT;

  	if (copy_to_user(dst, src, len))
		return CSUM_FAULT;
	return to_wsum_fault(sum);

So it follows the pattern of csum_and_copy_from_user() above?

>  size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
>  			       struct iov_iter *i)
>  {
> -	__wsum sum, next;
> +	__wsum sum;
> +	__wsum_fault next;
>  	sum = *csum;
>  	if (WARN_ON_ONCE(!i->data_source))
>  		return 0;
>  
>  	iterate_and_advance(i, bytes, base, len, off, ({
>  		next = csum_and_copy_from_user(base, addr + off, len);
> -		sum = csum_block_add(sum, next, off);
> -		next ? 0 : len;
> +		sum = csum_block_add(sum, from_wsum_fault(next), off);
> +		likely(!wsum_fault_check(next)) ? 0 : len;

This macro maze is confusing as hell.

Looking at iterate_buf() which is the least convoluted. That resolves to
the following:

     len = bytes;
     ...
     next = csum_and_copy_from_user(...);
     ...
     len -= !wsum_fault_check(next) ? 0 : len;
     ...
     bytes = len;
     ...
     return bytes;

So it correctly returns 'bytes' for the success case and 0 for the fault
case.

Now decrypting iterate_iovec():

    off = 0;
    
    do {
       ....
       len -= !wsum_fault_check(next) ? 0 : len;
       off += len;
       skip += len;
       bytes- -= len;
       if (skip < __p->iov_len)        <- breaks on fault
          break;
       ...
    } while(bytes);

    bytes = off;
    ...
    return bytes;

Which means that if the first vector is successfully copied, then 'off'
is greater 0. A fault on the second one will correctly break out of the
loop, but the function will incorrectly return a value > 0, i.e. the
length of the first iteration.

As the callers just check for != 0 such a partial copy is considered
success, no?

So instead of 

	likely(!wsum_fault_check(next)) ? 0 : len;

shouldn't this just do:

	if (unlikely(wsum_fault_check(next))
		return 0;
        len;

for simplicity and mental sanity sake?

Thanks,

        tglx



