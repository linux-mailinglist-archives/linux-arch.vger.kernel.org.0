Return-Path: <linux-arch+bounces-12520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E3FAEE500
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D523B8E2C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366EA28DF33;
	Mon, 30 Jun 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH8g4433"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6B28CF5C;
	Mon, 30 Jun 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302389; cv=none; b=AxtE+u7IS4+5tpQwd5aVMLqb2xPtf5jTyDOIHAMrxeTDTBGoRRof1mKkKTpyi5DQ+aN1A9Dus/oSGyPVUct1IVdPN7UuLsYFlMFIujGgpqm03l060a9TGkSPmPalkkJ0Mn58OwlhwB/KtSNhPldgGnkgxmHzhOGDfg1B+CAKUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302389; c=relaxed/simple;
	bh=ep4H5DS3MTQP8H3Wh337KJZSDRJFmcIqp3N4/7e5CoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFzO/Ii6Zi8GNVxbI/4vL9oVuZJGTHRFK2DtNlqLFHJVVqeIZbrjaQec2i21wOfdS0AMvzPAGlJMO3dAR6kWHVbqKky3DeyIG6j8c1205Q4Pq615Xqg1x5JN6qkJZvODYOZIpsDNdqgIVF+ds16SeFvKm+EjGe2npn4Qn6bpujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH8g4433; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23526264386so21071995ad.2;
        Mon, 30 Jun 2025 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751302387; x=1751907187; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rhwmu3jF4Je/8Qh/5IFiLV5HdTzjZvADtchCUmoZy+s=;
        b=eH8g4433xy2OQYhbkYSJLYLTVfZfUUF9PwYmZvJuzGgH3ldzZkoKi+7b1SoAyxWHq9
         smD6ei1jGlYhEx9U2OBmjX8JyRDbYrac/eolmQZOGBPQ5se8UJN38DVnhGcN1qU0lFID
         joGWmu6jUyFUNTsCusieBmYcVyj8DEgeQcPsNEC+2X9xRdmCKhBGx0UJfB4gPX+RZ0hj
         5pBD5ApTakKU58Uc2jzYJtbrv5j0e3CEhH1vkzeV9w2AE9B5znm44RvwKQ3Yqnh5bC5T
         ioddEQtClV3vkxVqQ8p6AdGiEjHtynu0guOlZ5RVKHU9v10xgDjf9bOecZuGwHsXsgF3
         4gWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751302387; x=1751907187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhwmu3jF4Je/8Qh/5IFiLV5HdTzjZvADtchCUmoZy+s=;
        b=oQtlQL4Gj9CbgJ+xH1tRkw8p+SMWy1srASSuJIk5Vklzxr0NliPmSJ4DX7yk8Mgl0I
         V+MbHqFaYm+BhnWnerK7VIFG6m0f9uR4QMK3sN1dkWBgZFX7YbWLCTlkj18rzIjgzJVx
         ElMGIQEvdI2N0mmvVHzgr6Ou6rVSoYVVKIryXgyXZhsJB1Hba/wLxQTuXQJPw7GQYN+E
         KZjjk8brvbEehRj0ooWnsMSUCBgOWUr1DTXsEoQ0hvh0r94e4O2N9PdZaSTWzPJnAX/u
         jfcsDjDVlc41OTSc7U0u+f7lHSlKFaN/GIQPD3zC/l7juF0VHGVwTEOZEYBzvN5PdLOU
         liOg==
X-Forwarded-Encrypted: i=1; AJvYcCU1fHki83q21Z5rbn22gqgiFUwfdTKc0ULxg/vPzQaaPXz2IuiU1mOMnyM0GVn5bGXoiDdE+ButYv5LcM8j@vger.kernel.org, AJvYcCUN/hQfBxoMFetRU4ba7sr/Y9u1OrrCtPt16bNH0VMIoq14iSjW7F19sbopiFd19SkNRpSt+F6nabD/@vger.kernel.org
X-Gm-Message-State: AOJu0YyZdr5XslLb1iXkLZiAJ7b2//Jq7wKPYTgRQo3xGUz2ZxJzYK2d
	4CuffZ8iiICcKRBiQGUghqryXPdQ5IwPeoAiX0H7T+Dc1EmdUEl2yNK+
X-Gm-Gg: ASbGnctzVtb2tHEk0tRg/+X7QQFNZclHaKUZ9iGGO2uvpnnf4zOrw+FyRowjDqLXO6s
	n4DvhjhFLn8gfBp4i5Cln6U+yEy83dIFyk/rudrox2OgbkRhtgzpB4DnoPdWD0a/DHZyZISCsvU
	1VNHscF7utfj3YmtIFsaqoiGsdpiu6oZ+dO7ttrj+kOk9NbnPE9BFBz3qdtATvx/GyqIRrlDBtS
	HO2uM3W5/KAUvpijBucpdsZwp74Ej5p2pIT6FN6iaqNVTkKefR7JZwYV70UNGYHr0yMFv+DgfVb
	Yy2xNz1Jq6q8Nt/76t+ICoWwWmwVEyDBIIeL6b6EGbafNgWA/PBTjMBbtdx4rA==
X-Google-Smtp-Source: AGHT+IEmP9coDGlfmU5ZCxbp02gfgkkPWL9aLzFkh3gfnmqdK4vHzSxpJeZniUGXfUtnHdsMYRf2oA==
X-Received: by 2002:a17:902:db10:b0:235:1706:1fe7 with SMTP id d9443c01a7336-23ac3bffb5fmr204787945ad.4.1751302386491;
        Mon, 30 Jun 2025 09:53:06 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c94b3sm84031335ad.245.2025.06.30.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:53:06 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:53:03 -0400
From: Yury Norov <yury.norov@gmail.com>
To: cp0613@linux.alibaba.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, arnd@arndb.de,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux@rasmusvillemoes.dk,
	palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb
 extension
Message-ID: <aGLA78usaJOnpols@yury>
References: <aGCbRguHwFY372Ut@yury>
 <20250630120457.1941-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630120457.1941-1-cp0613@linux.alibaba.com>

On Mon, Jun 30, 2025 at 08:04:53PM +0800, cp0613@linux.alibaba.com wrote:
> On Sat, 28 Jun 2025 21:48:02 -0400, yury.norov@gmail.com wrote:
> 
> > > > > +static inline u8 variable_ror8(u8 word, unsigned int shift)
> > > > > +{
> > > > > +	u32 word32 = ((u32)word << 24) | ((u32)word << 16) | ((u32)word << 8) | word;
> > > > 
> > > > Can you add a comment about what is happening here? Are you sure it's
> > > > optimized out in case of the 'legacy' alternative?
> > > 
> > > Thank you for your review. Yes, I referred to the existing variable__fls()
> > > implementation, which should be fine.
> > 
> > No, it's not fine. Because you trimmed your original email completely,
> > so there's no way to understand what I'm asking about; and because you
> > didn't answer my question. So I'll ask again: what exactly you are doing
> > in the line you've trimmed out?
> 
> Sorry, I misunderstood your question. Now I have made up for the lost original
> email. This is my answer. The RISC-V Zbb extension only provides 64-bit data
> rotation instructions rol/ror and 32-bit data rotation instructions rolw/rorw.
> Therefore, for 16-bit and 8-bit data, in order to use the rolw/rorw instruction
> optimization, the data is cyclically spliced ​​here, and the corresponding number
> of bits is truncated after processing to achieve the function.
> 
> This data preparation process does introduce additional operations. Compared with
> genneric's implementation, I use the web tool provided by David to illustrate.
> 
> The two functions that need to be compared are briefly summarized as follows:
> ```
> unsigned char generic_ror8(unsigned char word, unsigned int shift)
> {
> 	return (word >> (shift & 7)) | (word << ((-shift) & 7));
> }
> 
> unsigned char zbb_opt_ror8(unsigned char word, unsigned int shift)
> {
> 	unsigned int word32 = ((unsigned int)word << 24) | \
> 	    ((unsigned int)word << 16) | ((unsigned int)word << 8) | word;
> #ifdef __riscv
> 	__asm__ volatile("nop"); // ALTERNATIVE(nop)
> 
> 	__asm__ volatile(
> 		".option push\n"
> 		".option arch,+zbb\n"
> 		"rorw %0, %1, %2\n"
> 		".option pop\n"
> 		: "=r" (word32) : "r" (word32), "r" (shift) :);
> #endif
> 	return (unsigned char)word32;
> }
> ```
> The disassembly obtained is:
> ```
> generic_ror8:
>     andi    a1,a1,7
>     negw    a5,a1
>     andi    a5,a5,7
>     sllw    a5,a0,a5
>     srlw    a0,a0,a1
>     or      a0,a0,a5
>     andi    a0,a0,0xff
>     ret
> 
> zbb_opt_ror8:
>     slli    a5,a0,8
>     add     a0,a5,a0
>     slliw   a5,a0,16
>     addw    a5,a5,a0
>     nop
>     rorw a5, a5, a1
>     andi    a0,a5,0xff
>     ret
> ```
> From the perspective of the total number of instructions, although zbb_opt_ror8 has
> one more instruction, one of them is a nop, so the difference with generic_ror8 should
> be very small, or using the solution provided by David would be better for non-x86.

And what about performance?

> > > I did consider it, but I did not find any toolchain that provides an
> > > implementation similar to __builtin_ror or __builtin_rol. If there is one,
> > > please help point it out.
> > 
> > This is the example of the toolchain you're looking for:
> > 
> >   /**
> >    * rol64 - rotate a 64-bit value left
> >    * @word: value to rotate
> >    * @shift: bits to roll
> >    */
> >   static inline __u64 rol64(__u64 word, unsigned int shift)
> >   {
> >           return (word << (shift & 63)) | (word >> ((-shift) & 63));
> >   }
> > 
> > What I'm asking is: please show me that compile-time rol/ror is still
> > calculated at compile time, i.e. ror64(1234, 12) is evaluated at
> > compile time.
> 
> I see what you mean, I didn't consider the case of constants being evaluated
> at compile time, as you pointed out earlier:
> "you wire ror/rol() to the variable_ror/rol() unconditionally, and that breaks
> compile-time rotation if the parameter is known at compile time."
> 
> In the absence of compiler built-in function support, I think it can be handled
> like this:
> ```
> #define rol16(word, shift) \
> 	(__builtin_constant_p(word) && __builtin_constant_p(shift) ? \
> 	generic_ror16(word, shift) : variable_rol16(word, shift))
> ```
> How do you see?

That's what I meant.
 
> > > In addition, I did not consider it carefully before. If the rotate function
> > > is to be genericized, all archneed to include <asm-generic/bitops/rotate.h>.
> > > I missed this step.
> > 
> > Sorry, I'm lost here about what you've considered and what not. I'm OK
> > about accelerating ror/rol, but I want to make sure that;
> > 
> > 1. The most trivial compile-case is actually evaluated at compile time; and
> > 2. Any arch-specific code is well explained; and
> > 3. legacy case optimized just as well as non-legacy.
> 
> 1. As in the above reply, use the generic implementation when compile-time evaluation
>    is possible。
> 2. I will improve the comments later.

I'm particularly interested in ror8/rol8 case:

        u32 word32 = ((u32)word << 24) | ((u32)word << 16) | ((u32)word << 8) | word;

When you expand it to 32-bit word, and want to rotate, you obviously
need to copy lower quarterword to the higher one:

        0xab >> 0xab0000ab

That way generic (u8)ror32(0xab, shift) would work. But I don't understand
why you copy the lower 8 bits to inner quarterwords. Is that a hardware
requirement? Can you point to any arch documentation 

> 3. As mentioned before, only 8-bit rotation should have no optimization effect, and
>    16-bit and above will have significant optimization.

I asked you about the asm goto ("legacy") thing: you calculate that
complex word32 _before_ evaluating the goto. So this word32 may get
unused, and you waste cycles. I want to make sure this isn't the case.

Please find attached a test for compile-time ror/rol evaluation.
Please consider prepending your series with it.

Thanks,
Yury

From 5c5be22117a2bd0a656efae0efd6ed159d4168c5 Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 30 Jun 2025 12:07:47 -0400
Subject: [PATCH] bitops: add compile-time test for ror() and rol()

If parameters for the functions are passed at compile time, the compiler
must calculate the result at compile time, as well.

Now that architectures introduce accelerated implementations for bit
rotation, we must make sure that they don't break compile-time
evaluation.

This patch adds a test for it, similarly to test_bitmap_const_eval().

Tested on x86_64.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 lib/test_bitops.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/lib/test_bitops.c b/lib/test_bitops.c
index 55669624bb28..aa4c06df34f7 100644
--- a/lib/test_bitops.c
+++ b/lib/test_bitops.c
@@ -76,6 +76,56 @@ static int __init test_fns(void)
 	return 0;
 }
 
+static void __init test_bitops_const_eval(void)
+{
+	/*
+	 * ror/rol operations on parameters known at compile-time must be
+	 * optimized to compile-time constants on any supported optimization
+	 * level (-O2, -Os) and all architectures. Otherwise, trigger a build
+	 * bug.
+	 */
+
+	u64 r64 = ror64(0x1234567890abcdefull, 24);
+
+	BUILD_BUG_ON(!__builtin_constant_p(r64));
+	BUILD_BUG_ON(r64 != 0xabcdef1234567890ull);
+
+	u64 l64 = rol64(0x1234567890abcdefull, 24);
+
+	BUILD_BUG_ON(!__builtin_constant_p(l64));
+	BUILD_BUG_ON(l64 != 0x7890abcdef123456ull);
+
+	u32 r32 = ror32(0x12345678, 24);
+
+	BUILD_BUG_ON(!__builtin_constant_p(r32));
+	BUILD_BUG_ON(r32 != 0x34567812);
+
+	u32 l32 = rol32(0x12345678, 24);
+
+	BUILD_BUG_ON(!__builtin_constant_p(l32));
+	BUILD_BUG_ON(l32 != 0x78123456);
+
+	u16 r16 = ror16(0x1234, 12);
+
+	BUILD_BUG_ON(!__builtin_constant_p(r16));
+	BUILD_BUG_ON(r16 != 0x2341);
+
+	u16 l16 = rol16(0x1234, 12);
+
+	BUILD_BUG_ON(!__builtin_constant_p(l16));
+	BUILD_BUG_ON(l16 != 0x4123);
+
+	u8 r8 = ror8(0x12, 6);
+
+	BUILD_BUG_ON(!__builtin_constant_p(r16));
+	BUILD_BUG_ON(r8 != 0x48);
+
+	u8 l8 = rol8(0x12, 6);
+
+	BUILD_BUG_ON(!__builtin_constant_p(l16));
+	BUILD_BUG_ON(l8 != 0x84);
+}
+
 static int __init test_bitops_startup(void)
 {
 	int i, bit_set;
@@ -121,6 +171,7 @@ static int __init test_bitops_startup(void)
 		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
 
 	test_fns();
+	test_bitops_const_eval();
 
 	pr_info("Completed bitops test\n");
 
-- 
2.43.0


