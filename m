Return-Path: <linux-arch+bounces-4837-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5A90451C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 21:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A0B1F2250B
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 19:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178394D8BB;
	Tue, 11 Jun 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S3jaMlWO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E68488;
	Tue, 11 Jun 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135010; cv=none; b=OeTuBBJqfvQd9Qm+lYm0VPw/YpLOnU6jjadyOCQSIgwtSnIxx3y3jlETjP1D4v8+KWaAGOp0OeacA7gUUrO8nboBNTFLxO7AP673BW4MKRdRD3lRFoL2y8MXteU7HQ/fwzrnDWiH136a8SfkxvbPnLp2Vf8AfmQByf0vDpbrMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135010; c=relaxed/simple;
	bh=q6dVLoc6xaa+c4TeiH9wlg/kfNuEFlrw+sWsnsKuGX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAPpx7ebVfoJgGdtlaw2654h5rkZJpbqkXhPIHIUq1WOc2dFExSp0WRhVSHSTr8nNUnWHlTooX+LacKx9py/iG9wTIO5F15QATpMhtCUYhtbZ9WWGUSaAPVXlFnrCeDSnCHX00NzsVd1j0W+DlOzpdL4Z+TOxdC4rUNo0O+DVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=S3jaMlWO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.0.16] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45BJh23K3459830
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 12:43:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45BJh23K3459830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718134983;
	bh=kjF1JEwdZfsZFiNYs3Gm4hdblgjMzMkSigOzOIxzg/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S3jaMlWOQsPIcOZADgx+VDh1iaNiYEUNmQg8qI5MGrOh+LLoVlqoooYop2zkKFdmR
	 Iix4DptJqYfOySq4eA6KQi0JEaUmfFQkapy8ETVnYPd/ZZXH++BP6dywVyJ/94sGSa
	 yY/Y1duJhhGmmzmUnuIPkVIoUNb1Rg0kdV6+ENWqIfXG9AG+0D9uRSDZ7Ql7QglbQ4
	 o23/hX2JC3SLTOixLNddhb+188aAw6B0yfudHh0wxBEBzfY/5MMr9nzsE3MpyUwSc7
	 6i7K285OGJ1T8HcWLB8tJCy37D7bi4E6TlMrBzr0FG6EQmdKsB59VdN9n2kKH5quSE
	 vlTj++h8tv91g==
Message-ID: <8eb5960f-17f9-4d94-9b52-dea8b475e9dc@zytor.com>
Date: Tue, 11 Jun 2024 12:43:02 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net>
 <f967d835-d26e-47af-af35-c3c79746f7d9@rasmusvillemoes.dk>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <f967d835-d26e-47af-af35-c3c79746f7d9@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 06:38, Rasmus Villemoes wrote:
> On 10/06/2024 12.43, Peter Zijlstra wrote:
>> On Sat, Jun 08, 2024 at 12:35:05PM -0700, Linus Torvalds wrote:
> 
>>> Comments?
>>
>> It obviously has the constraint of never running the code before the
>> corresponding runtime_const_init() has been done, otherwise things will
>> go sideways in a hurry, but this also makes the whole thing a *lot*
>> simpler.
>>
>> The only thing I'm not sure about is it having a section per symbol,
>> given how jump_label and static_call took off, this might not be
>> scalable.
>>
>> Yes, the approach is super simple and straight forward, but imagine
>> there being like a 100 symbols soon :/
>>
>> The below hackery -- it very much needs cleanup and is only compiled on
>> x86_64 and does not support modules, boots for me.
> 
> As can be seen in my other reply, yes, I'm also worried about the
> scalability and would like to see this applied to more stuff.
> 
> But if we do this, surely that's what scripts/sorttable is for, right?
> 
> Alternatively, if we just keep emitting to per-symbol
> __runtime_const_##sym sections but collect them in one __runtime_const,
> just using __runtime_const { *(SORT_BY_NAME(__runtime_const_*)) } in the
> linker script should already be enough to allow that binary search to
> work (with whatever : AT(ADDR() ... ) magic is also required), with no
> post-processing at build or runtime required.
> 

As far as one section per symbol, this is *exactly* what the linker 
table infrastructure was intended to make clean and scalable.

I think rejecting it was a big mistake. It is really a very useful 
general piece of infrastructure, and IMNSHO the whole notion of "oh, we 
won't ever need that many such tables" is just plain wrong (as evidenced 
here.)

Either way, the problem isn't that hard; you end up doing something like:

struct runtime_const {
	unsigned int size;
	reladdr_t entries[0];
};

#define DECLARE_RUNTIME_CONST(sym,type) \
extern struct runtime_const sym;\
asm(".pushsection \"runtime_const_" #sym ".Start\",\"a\"\n\t"
     ".globl " #sym "\n"
     #sym ": .int 2f - 1f\n\t"
     "1:\n"
     ".popsection\n\t"
     ".pushsection \"runtime_const_" #sym "._end\",\"a\"\n\t"
     "2:\n"
     ".popsection\n\t");

... and add a common suffix, say, ".entry", for the entry section names. 
Then SORT_BY_NAME() will handle the rest.

	-hpa


