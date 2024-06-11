Return-Path: <linux-arch+bounces-4835-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FC9043E4
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 20:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C30289800
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142A959162;
	Tue, 11 Jun 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qeF2Gg3q"
X-Original-To: linux-arch@vger.kernel.org
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597738FA1;
	Tue, 11 Jun 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131456; cv=none; b=I0ILCpgmaNEqJQo9c8iIN3TCsdRtkpGFuiZ8bnWLhgIVFPUd0k0bmXM8hdgkE1mnpiTtlot24VPKck30nbo3EZnTqWsaNRugK//u8ioUHoNDjHVCYp6cnHBJPSDw8jDBkZmTesPh0/H3L80yL7LhUTCG9JtLK3g5odngtgYF6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131456; c=relaxed/simple;
	bh=g1Q7qhG14yUPW9rk+97eEEMsOIkCtIcGn38GoRYuZSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qa569DxaucX2GkIRSX9O+pfUSQhs7tS89ZfI5vJcqoMu9jcsDqXERiOO/O6NFCgIKw/XJvp5d5cagg8w5TttUSmDSg7yt6mzgIs7a7v9xr946T+bHasF2d5kg8yhvJp0rHdNxbghXb281ojc3NXJHOQeZW5zLWFUH588B+jIWJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qeF2Gg3q; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45BIMaUu3409249
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 11:22:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45BIMaUu3409249
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718130158;
	bh=3mnT2Bwkk0vQJgnckDkHQNv+VtpPWp5qOEVzxmzIxI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qeF2Gg3qVflPKKclkjRTOBCOM/fqAUAO37scpIV5HUO7ia+egHSHYeaqjigZtI1Ce
	 On1u308bBkJB3xoX3lKeU4nz9j0E7Mel0Frwxpbe/x28yKYDsAH5oWeA2bIxQwDgAN
	 zhVPged9gzWdCPLznRUmnE45KmYRRhgNp6gJSl1Dde1k3qaZOT68jkQVOqhTDZmLaU
	 uAQywa2fnm+Cp07NacwmXf/d1VihLnGcesvfZK8gqNHzcBCk+kBECEYtZ2an4lKMZA
	 r19zG8VyHgjCaVUz6CK301py09Ujezshi0i1hUnzOpPoEX32aJKaXGiFmToyCLrD4Z
	 DZ2eTm8vf068Q==
Message-ID: <c380a87d-a5b2-4782-8bb0-2a10ed4fb9ad@zytor.com>
Date: Tue, 11 Jun 2024 11:22:31 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net>
 <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local>
 <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com>
 <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com>
 <CAHk-=wjTzFYo2+eQJpb56Df8sNDW7JEV=_6Di2v-M5x2kv06_g@mail.gmail.com>
 <CAHk-=wjdsN=dH41MO+gASWZkexCgrwK6CGT=NvpA3xsVXEhxBw@mail.gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAHk-=wjdsN=dH41MO+gASWZkexCgrwK6CGT=NvpA3xsVXEhxBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 18:24, Linus Torvalds wrote:
> On Mon, 10 Jun 2024 at 18:09, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Doing it in general is actually very very painful. Feel free to try -
>> but I can almost guarantee that you will throw out the "Keep It Simple
>> Stupid" approach and your patch will be twice the size if you do some
>> "rewrite the whole instruction" stuff.
>>
>> I really think there's a fundamental advantage to keeping things simple.
> 
> I guess the KISS approach would be to have a debug mode that just adds
> an 'int3' instruction *after* the constant. And then the constant
> rewriting rewrites the constant and just changes the 'int3' into the
> standard single-byte 'nop' instruction.
> 
> That wouldn't be complicated, and the cost would be minimal. But I
> don't see it being worth it, at least not for the current use where
> the unrewritten constant will just cause an oops on use.
> 

A general enough way to do it would be to put an int $3 and replace it 
with a ds: dummy prefix.

The issue there is "current use". I'm really, really worried about 
someone in the future putting this where it won't get properly patched 
and then all hell will be breaking loose.

Perhaps a better idea would be to provide the initial value as part of 
the declaration, so that the value is never "uninitialized" (much like a 
static variable can be initialized at compile time)?

In other words:

runtime_const_ptr(sym,init)

Unfortunately gas doesn't seem to properly implement the {nooptimize} 
prefix that is documented. This does require some gentle assembly hacking:

- Loading a pointer/long requires using the "movabs" mnemonic on x86-64. 
Combining that with

  (but not on x86-32 as there are no compacted forms of mov immediate; 
on x86-32 it is also legit to allow =rm rather than =r, but for an 8-bit 
immediate "=qm" has to be used.)

A size/type-generic version (one nice thing here is that init also ends 
up specifying the type):

#define _RUNTIME_CONST(where, sym, size) 				\
	"\n\t"							\
	".pushsection \"runtime_const_" #sym "\",\"a\"\n\t"	\
	".long (" #where ") - (" #size ") - .\n\t"		\
	".popsection"

extern void __noreturn __runtime_const_bad_size(void);

#define runtime_const(_sym, _init) ({ 				\
	typeof(_init) __ret; 					\
	const size_t __sz = sizeof(__ret); 			\
	switch (__sz) { 					\
	case 1:							\
		asm_inline("mov %[init],%[ret]\n1:"		\
		    _RUNTIME_CONST(1b, _sym, 1)			\
		    : [ret] "=qm" (__ret)			\
		    : [init] "i" (_init));			\
		break;						\
	case 8:							\
		asm_inline("movabs %[init],%[ret]\n1:"		\
		    _RUNTIME_CONST(1b, _sym, 8)			\
		    : [ret] "=r" (__ret)			\
		    : [init] "i" (_init));			\
		break;						\
	default:						\
		asm_inline("mov %[init],%[ret]\n1:"		\
		    _RUNTIME_CONST(1b, _sym, %c[sz])		\
		    : [ret] "=rm" (__ret)			\
		    : [init] "i" (_init), [sz] "n" (__sz)));	\
		break;						\
	}							\
	__ret; })


- For a shift count, it is unfortunately necessary to explicitly stitch 
together the instruction using .insn to avoid truncating the case where 
the operand is 1.

Size- and operand-generic version:

#define _runtime_const_shift(_val, _sym, _init, _op2) ({ 	\
	typeof(_val) __ret = (_val); 				\
	switch (sizeof(__ret)) {				\
	case 1:							\
		asm_inline(".insn 0xc0/%c[op2],%[ret],%[init]{:u8}\n1:" \
			_RUNTIME_CONST(1b, _sym, 1)		\
			: [ret] "+qm" (__ret)			\
			: [init] "i" ((u8)(_init)),		\
		 	  [op2] "n" (_op2));			\
		break; 						\
	default:						\
		asm_inline(".insn 0xc1/%c[op2],%[ret],%[init]{:u8}\n1:" \
			_RUNTIME_CONST(1b, _sym, 1)		\
			: [ret] "+rm" (__ret)			\
			: [init] "i" ((u8)(_init)),		\
		  	  [op2] "n" (_op2));			\
		break;						\
	}							\
	__ret; })						\

#define runtime_const_rol(v,s,i) _runtime_const_shift(v,s,i,0)
#define runtime_const_ror(v,s,i) _runtime_const_shift(v,s,i,1)
#define runtime_const_shl(v,s,i) _runtime_const_shift(v,s,i,4)
#define runtime_const_shr(v,s,i) _runtime_const_shift(v,s,i,5)
#define runtime_const_sar(v,s,i) _runtime_const_shift(v,s,i,7)

I am not sure if I'm missing something, but there really isn't a reason 
to use different section names for the shift counts specifically, is there?

NOTE: if we are *not* making these type-generic there is no reason 
whatsoever to not make these inlines...

	***


Also: one thing I would *really* like to see this being used for is 
cr4_pinned_bits, in which case one can, indeed, safely use a zero value 
at init time as long as cr4_pinned_mask is patched at the same time, 
which very much goes along with the above.

Again, this is a slightly less minimal versus what I had which was a 
maximal solution.

My approach would pretty much have targeted doing this for nearly all 
instances, which I eventually felt called for compiler support (or C++!) 
as adding a bunch of static_imm_*() macros all over the kernel really 
felt unpleasant.

	-hpa

