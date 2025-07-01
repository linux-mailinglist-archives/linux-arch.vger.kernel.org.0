Return-Path: <linux-arch+bounces-12548-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93202AF02D1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 20:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA7B3BFE72
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C3923B618;
	Tue,  1 Jul 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPDuZfxz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF191386B4;
	Tue,  1 Jul 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751394740; cv=none; b=smmxfB0q2/ZMseKHsCIJmoU5SYEOhHMt2Pjdsn32ilrnmveeiIaKOiRL+OMzdyBDIWxvfs0vunLbpYOASnEvmjkpbKGdIkb0vTOuE1QJHumwS0Y0Dhiamn02iphnOMsUwfozsz8PYuHDNPeIyvBDDC16SVqfCLtRvohqObtOzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751394740; c=relaxed/simple;
	bh=xOvQ4YveMJnngVcge4VPkxr/0JPaZcGRhNhGnGOPfxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BosOrC16T4bRBPGgG4uOyuf1wT2nzizMKneW0OvgvozZcEdIxWZT9EL5+5AcIMG7FpTF8WtLZPeIBM3Rm0+QDikwIu1/UaypT9XPMCrkJ9N62gX4PT8BFz3iwAunw7onTIaM0Z90g2Qf2+W9prHfiS9qkaIBelWxyRZpNJoNQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPDuZfxz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747fc7506d4so3317455b3a.0;
        Tue, 01 Jul 2025 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751394738; x=1751999538; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gY6mQVMmIl68dFLJH/SnrEytnvbgKUD06sOpURKt7zw=;
        b=HPDuZfxzyl67Xlx1HYXvBLRyldjxv7+c9rbstyD0k/XAdNyyFNz3j4pNNf4LvHL6n+
         u+MSaAAk8wEXisTC5t0P83v9OzXihxkNMD3L2XEG0yOvbWw+dZ+h4DUfg6wDad8I96nw
         1S4X3uD8vUxkG4BthwHhr49wzEajY4COAmtkIiASflcCko42owU3BHLwfbe7eVTjpRCc
         12l07JD+CE/wagYJOm2Rh/CTZd2LiH2g2Ambskeei3dmXARpiPefeCSYWSofsGLiBW17
         FcBthPu0rxDBuisN4ETSMU432vfNIo7mzPKWCym3cg7Cu5xt0UvDy10ifcGqGpXa4dSV
         oCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751394738; x=1751999538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY6mQVMmIl68dFLJH/SnrEytnvbgKUD06sOpURKt7zw=;
        b=X0MOXh7DFdOEB34ohnTsJVkuFCRZtt/++yHC8h0hY7cDHlof5r+egEum5ZLirTFmn8
         eL4jT7RKuxho9vAyGqyXL+Wn6lusl/zCky73MpVOdG6nMhKcnS+0wAIIfBd1r3Or4GNF
         SWQxpSbfGZQmsBuNniwzuhTeLoBY+ocejGbNDTAsRFwIYuhbkmmVIHkljMI4o0Q8uujw
         U5Kck1sk4QxhGqMqHlW/8216MApYknNkKDA9mqk5NQU5Solm0VlHYSlNUF9TVZ4JljL4
         g1PoEXIpYzyDNxwzKW5d7Td9K49prJdZ4Frgc+Bge5r1Mi9dTnr7xNYkZIpt0leHGJdo
         LmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOuPyeYfJ+QssMi5gFB4gl99h6AW8XxRovHJCdYqCrxJZanzqwT7iSnpMhUED3NTl2RIXLt7XOWgwW@vger.kernel.org, AJvYcCXAgphjytQUcZd12Zo69JycbDcS7eqgbwyeADe0IYdycK5YUFICyoNQZGncgQ6VxASaO1WDH7YUEGNsQI0n@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQ708wqseiN3YFAMkIO+1jT8/GOF1QOFGS8s2gysSDobUbGmE
	33TsCy8prp7XBUHGQI79gTg98C/iurcRSKNlBv/ijGJnwjWycgnxV7lk
X-Gm-Gg: ASbGncv5ZFyGhaw3gjFyxoEUyQsg1SZHTGVbPKjrWlvWAPpqZ1ak8IX+j1dP21D7Ur1
	MVDVxiEvSFmj6xjYEBRqQfJcsNXfI/lJeRYwK1+B7qQisbTPivjN4PIWE/D5iHONFtRBtTVTFer
	AggV78KP7CvtEeUrsPSYSPjOuvKy0B0s23PYltto3YGGBN3AmZWTJUYGxT6CT4jUl8QLtKZC3Vy
	xL45d5toBn9DyDzuYOIaML6xjQ4XasfZaLLzZal4QKhD2CCXcm6IAemQ2pURFFGazQtUD+bPXTO
	s7XrJLakFvuFLn3+1+gsxQ0iMiQCNfPrci32yYzbyVIRHkGYUUKZoNiQuVVk5Q==
X-Google-Smtp-Source: AGHT+IFHLL7P1lYF9UPZci0RSTG7Y6C/qYNbKwFfO//TmNisiNGsH7HgHOhmAuCFzDwIfvPTkGQc5Q==
X-Received: by 2002:a05:6a00:2e15:b0:732:2923:b70f with SMTP id d2e1a72fcca58-74af6f73b0emr24350576b3a.11.1751394737753;
        Tue, 01 Jul 2025 11:32:17 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c6d49sm12327550b3a.119.2025.07.01.11.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:32:16 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:32:14 -0400
From: Yury Norov <yury.norov@gmail.com>
To: cp0613@linux.alibaba.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, arnd@arndb.de,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux@rasmusvillemoes.dk,
	palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb
 extension
Message-ID: <aGQprv3HTplw9r-q@yury>
References: <aGLA78usaJOnpols@yury>
 <20250701124737.687-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701124737.687-1-cp0613@linux.alibaba.com>

On Tue, Jul 01, 2025 at 08:47:01PM +0800, cp0613@linux.alibaba.com wrote:
> On Mon, 30 Jun 2025 12:53:03 -0400, yury.norov@gmail.com wrote:
> 
> > > > 1. The most trivial compile-case is actually evaluated at compile time; and
> > > > 2. Any arch-specific code is well explained; and
> > > > 3. legacy case optimized just as well as non-legacy.
> > > 
> > > 1. As in the above reply, use the generic implementation when compile-time evaluation
> > >    is possible。
> > > 2. I will improve the comments later.
> > 
> > I'm particularly interested in ror8/rol8 case:
> > 
> >         u32 word32 = ((u32)word << 24) | ((u32)word << 16) | ((u32)word << 8) | word;
> > 
> > When you expand it to 32-bit word, and want to rotate, you obviously
> > need to copy lower quarterword to the higher one:
> > 
> >         0xab >> 0xab0000ab
> > 
> > That way generic (u8)ror32(0xab, shift) would work. But I don't understand
> > why you copy the lower 8 bits to inner quarterwords. Is that a hardware
> > requirement? Can you point to any arch documentation 
> > 
> > > 3. As mentioned before, only 8-bit rotation should have no optimization effect, and
> > >    16-bit and above will have significant optimization.
> > 
> > I asked you about the asm goto ("legacy") thing: you calculate that
> > complex word32 _before_ evaluating the goto. So this word32 may get
> > unused, and you waste cycles. I want to make sure this isn't the case.
> 
> Thank you for your suggestion and reminder. This is not a hardware requirement, but it

Sure. Please add

Suggested-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> is somewhat related because the zbb instruction only supports word-sized rotate [1].
> Considering the case where the shift is greater than 8, if the modulus of the shift is
> not taken, it is required to continuously concatenate 8-bit data into 32 bits.
> 
> So, I considered the case of taking the remainder of shift and found that this
> implementation would have one less instruction, so the final implementation is as follows:
> ```
> static inline u8 variable_rol8(u8 word, unsigned int shift)

Now that it has assembler inlines, would it help to add the __pure
qualifier?

> {
> 	u32 word32;
> 
> 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> 				      RISCV_ISA_EXT_ZBB, 1)
> 			  : : : : legacy);
> 
> 	word32 = ((u32)word << 24) | word;
> 	shift = shift % 8;

        shift %= 8;

> 
> 	asm volatile(
> 		".option push\n"
> 		".option arch,+zbb\n"
> 		"rolw %0, %1, %2\n"
> 		".option pop\n"
> 		: "=r" (word32) : "r" (word32), "r" (shift) :);
> 
> 	return (u8)word32;
> 
> legacy:
> 	return generic_rol8(word, shift);
> }
> 
> static inline u8 variable_ror8(u8 word, unsigned int shift)
> {
> 	u32 word32;
> 
> 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> 				      RISCV_ISA_EXT_ZBB, 1)
> 			  : : : : legacy);
> 
> 	word32 = ((u32)word << 8) | word;
> 	shift = shift % 8;
> 
> 	asm volatile(
> 		".option push\n"
> 		".option arch,+zbb\n"
> 		"rorw %0, %1, %2\n"
> 		".option pop\n"
> 		: "=r" (word32) : "r" (word32), "r" (shift) :);
> 
> 	return (u8)word32;
> 
> legacy:
> 	return generic_ror8(word, shift);
> }
> ```

OK, this looks better.

> I compared the performance of ror8 (zbb optimized) and generic_ror8 on the XUANTIE C908
> by looping them. ror8 is better, and the advantage of ror8 becomes more obvious as the
> number of iterations increases. The test code is as follows:
> ```
> 	u8 word = 0x5a;
> 	u32 shift = 9;
> 	u32 i, loop = 100;
> 	u8 ret1, ret2;
> 
> 	u64 t1 = ktime_get_ns();
> 	for (i = 0; i < loop; i++) {
> 		ret2 = generic_ror8(word, shift);
> 	}
> 	u64 t2 = ktime_get_ns();
> 	for (i = 0; i < loop; i++) {
> 		ret1 = ror8(word, shift);
> 	}
> 	u64 t3 = ktime_get_ns();
> 
> 	pr_info("t2-t1=%lld t3-t2=%lld\n", t2 - t1, t3 - t2);
> ```

Please do the following:

1. Drop the generic_ror8() and keep only ror/l8()
2. Add ror/l16, 34 and 64 tests.
3. Adjust the 'loop' so that each subtest will take 1-10 ms on your hw.
4. Name the function like test_rorl(), and put it next to the test_fns()
   in lib/test_bitops.c. Refer the 0a2c6664e56f0 for implementation.
5. Prepend the series with the benchmark patch, just as with const-eval
   one, and report before/after for your series. 

> > Please find attached a test for compile-time ror/rol evaluation.
> > Please consider prepending your series with it.
> 
> Okay, I'll bring it to the next series.

Still waiting for bloat-o-meter results.

Thanks,
Yury

> 
> [1] https://github.com/riscv/riscv-bitmanip

