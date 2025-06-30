Return-Path: <linux-arch+bounces-12509-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C212EAEDC36
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 14:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C31218967BA
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDA3283FE6;
	Mon, 30 Jun 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ciLFrLcP"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7F27726;
	Mon, 30 Jun 2025 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285110; cv=none; b=q5aUc1w4w1NmFAk5zQBM5aftv+yIqSkTIhn6/JHMVblKURuZ07Xr2CMqXUPeQ+vYIxlbYEQpNvcwkNsKTcfC5bM0NKddLplbyNJO+svol/+MM2A9PlkyBszPBWprIvzQ5l/5M5wvXMn+/10C1kH4aSb0o/4ZmQd5FB0HOBP6Eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285110; c=relaxed/simple;
	bh=n+176Hqk73YdNtUEpYApofCzd1fmowR9CSTTTZt6dmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdJDIuFzOkZnmkWU7PjUVnJuHFmONiT54VtMU6FOONzfnxF17aPuYH9ndKSmpyj18Fu64ahbNtfg1sSai2zVqw0V7mDLqXbNwdmKIZnYQGjW22v5/rrY4pUsS8lWHYcnyHgtdxUNBYmfT7Mc3ZpqmUP+8ebkLDYebxw5yo4yvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ciLFrLcP; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751285104; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=DvTpPcJk2p/JaNDemgjUWLgjS7l0dR1b8xj6HI7SB5I=;
	b=ciLFrLcPZZm4sAorMyMA0FuCgNGE+1VxLFqsxz0sKdvgkBIfsI080AWXFDQ35UstUnTPFbmde/eM2I8uoIbMzXmcLUj2G88gWf36VOUhEX7dx7BXjNGhKMzO3uXIIvYWdmrypWu2w2zxV9uVtLkHKrk+PuMhPhi4t33FzJBFsFQ=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WgBCaxG_1751285097 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 20:05:03 +0800
From: cp0613@linux.alibaba.com
To: yury.norov@gmail.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	cp0613@linux.alibaba.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb extension
Date: Mon, 30 Jun 2025 20:04:53 +0800
Message-ID: <20250630120457.1941-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aGCbRguHwFY372Ut@yury>
References: <aGCbRguHwFY372Ut@yury>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 28 Jun 2025 21:48:02 -0400, yury.norov@gmail.com wrote:

> > > > +static inline u8 variable_ror8(u8 word, unsigned int shift)
> > > > +{
> > > > +	u32 word32 = ((u32)word << 24) | ((u32)word << 16) | ((u32)word << 8) | word;
> > > 
> > > Can you add a comment about what is happening here? Are you sure it's
> > > optimized out in case of the 'legacy' alternative?
> > 
> > Thank you for your review. Yes, I referred to the existing variable__fls()
> > implementation, which should be fine.
> 
> No, it's not fine. Because you trimmed your original email completely,
> so there's no way to understand what I'm asking about; and because you
> didn't answer my question. So I'll ask again: what exactly you are doing
> in the line you've trimmed out?

Sorry, I misunderstood your question. Now I have made up for the lost original
email. This is my answer. The RISC-V Zbb extension only provides 64-bit data
rotation instructions rol/ror and 32-bit data rotation instructions rolw/rorw.
Therefore, for 16-bit and 8-bit data, in order to use the rolw/rorw instruction
optimization, the data is cyclically spliced ​​here, and the corresponding number
of bits is truncated after processing to achieve the function.

This data preparation process does introduce additional operations. Compared with
genneric's implementation, I use the web tool provided by David to illustrate.

The two functions that need to be compared are briefly summarized as follows:
```
unsigned char generic_ror8(unsigned char word, unsigned int shift)
{
	return (word >> (shift & 7)) | (word << ((-shift) & 7));
}

unsigned char zbb_opt_ror8(unsigned char word, unsigned int shift)
{
	unsigned int word32 = ((unsigned int)word << 24) | \
	    ((unsigned int)word << 16) | ((unsigned int)word << 8) | word;
#ifdef __riscv
	__asm__ volatile("nop"); // ALTERNATIVE(nop)

	__asm__ volatile(
		".option push\n"
		".option arch,+zbb\n"
		"rorw %0, %1, %2\n"
		".option pop\n"
		: "=r" (word32) : "r" (word32), "r" (shift) :);
#endif
	return (unsigned char)word32;
}
```
The disassembly obtained is:
```
generic_ror8:
    andi    a1,a1,7
    negw    a5,a1
    andi    a5,a5,7
    sllw    a5,a0,a5
    srlw    a0,a0,a1
    or      a0,a0,a5
    andi    a0,a0,0xff
    ret

zbb_opt_ror8:
    slli    a5,a0,8
    add     a0,a5,a0
    slliw   a5,a0,16
    addw    a5,a5,a0
    nop
    rorw a5, a5, a1
    andi    a0,a5,0xff
    ret
```
From the perspective of the total number of instructions, although zbb_opt_ror8 has
one more instruction, one of them is a nop, so the difference with generic_ror8 should
be very small, or using the solution provided by David would be better for non-x86.

> > I did consider it, but I did not find any toolchain that provides an
> > implementation similar to __builtin_ror or __builtin_rol. If there is one,
> > please help point it out.
> 
> This is the example of the toolchain you're looking for:
> 
>   /**
>    * rol64 - rotate a 64-bit value left
>    * @word: value to rotate
>    * @shift: bits to roll
>    */
>   static inline __u64 rol64(__u64 word, unsigned int shift)
>   {
>           return (word << (shift & 63)) | (word >> ((-shift) & 63));
>   }
> 
> What I'm asking is: please show me that compile-time rol/ror is still
> calculated at compile time, i.e. ror64(1234, 12) is evaluated at
> compile time.

I see what you mean, I didn't consider the case of constants being evaluated
at compile time, as you pointed out earlier:
"you wire ror/rol() to the variable_ror/rol() unconditionally, and that breaks
compile-time rotation if the parameter is known at compile time."

In the absence of compiler built-in function support, I think it can be handled
like this:
```
#define rol16(word, shift) \
	(__builtin_constant_p(word) && __builtin_constant_p(shift) ? \
	generic_ror16(word, shift) : variable_rol16(word, shift))
```
How do you see?

> > In addition, I did not consider it carefully before. If the rotate function
> > is to be genericized, all archneed to include <asm-generic/bitops/rotate.h>.
> > I missed this step.
> 
> Sorry, I'm lost here about what you've considered and what not. I'm OK
> about accelerating ror/rol, but I want to make sure that;
> 
> 1. The most trivial compile-case is actually evaluated at compile time; and
> 2. Any arch-specific code is well explained; and
> 3. legacy case optimized just as well as non-legacy.

1. As in the above reply, use the generic implementation when compile-time evaluation
   is possible。
2. I will improve the comments later.
3. As mentioned before, only 8-bit rotation should have no optimization effect, and
   16-bit and above will have significant optimization.

Thanks,
Pei


