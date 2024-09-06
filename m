Return-Path: <linux-arch+bounces-7108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B1B96F309
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 13:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48911F23B2A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF911C8FC7;
	Fri,  6 Sep 2024 11:26:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1811A2C39;
	Fri,  6 Sep 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622014; cv=none; b=ed0i+kqHNz+DsWGkIFJh1tvaHMN0N3lSAEyWfYQkui3xrvi0Aiw6rTwIWBbqwTFahdsYDT4A2u205WR6eF5IgNw6SfeeiXGgo5g6Zdkzd19ldWvv/xYPUCFUFjrJVwioHhbf21Di3afHyhftS2VWXFNo/mmBJTrKrCtw2BXwxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622014; c=relaxed/simple;
	bh=6USmevgAKj0TyTAIi4ocDh6np/lUc3s/1UeLS1HvASo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqYx6/de7uYRDd7pKGrTi1BsbZRshoWspKAekicuqIJEt37yffk8DpsziLVquV/+ixmrZWE1ee06Ah8+tJ863R9osx+eJtZllHI9tw4VxrE/kTAJnPkx6bARUkMmYD86r5KxNawPko7jAdSH+ceXvGB4+KF6dOFpy9C99zyJSx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7FD7FEC;
	Fri,  6 Sep 2024 04:27:18 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 497F23F73B;
	Fri,  6 Sep 2024 04:26:49 -0700 (PDT)
Message-ID: <fa3d3397-4e5f-437d-b73e-439f4f336c90@arm.com>
Date: Fri, 6 Sep 2024 12:26:47 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-4-vincenzo.frascino@arm.com>
 <cfb5ea05-0322-492b-815d-17a4aad4da99@app.fastmail.com>
 <a298ba4e-cbbf-4f50-b175-8ee3063963bc@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <a298ba4e-cbbf-4f50-b175-8ee3063963bc@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/09/2024 16:05, Christophe Leroy wrote:
> 
> 
> Le 04/09/2024 à 16:52, Arnd Bergmann a écrit :
>> On Tue, Sep 3, 2024, at 15:14, Vincenzo Frascino wrote:
>>
...

>>> +
>>> +#ifndef __ASSEMBLY__
>>> +
>>> +#include <asm/page_types.h>
>>> +
>>> +#define VDSO_PAGE_MASK    PAGE_MASK
>>> +#define VDSO_PAGE_SIZE    PAGE_SIZE
>>> +
>>> +#endif /* !__ASSEMBLY__ */
>>> +
>>> +#endif /* __ASM_VDSO_PAGE_H */
>>
>> I don't get this one: the x86 asm/page_types.h still includes other
>> headers outside of the vdso namespace, but you seem to only need these
>> two definitions that are the same across everything.
>>
>> Why not put PAGE_MASK and PAGE_SIZE into a global vdso/page.h
>> header? I did spend a lot of time a few months ago ensuring that
>> we can have a single definition for all architectures based on
>> CONFIG_PAGE_SHIFT, so all the extra copies should just go away.
>>
> 
> Just wondering, after looking at x86, powerpc and arm64, is there any difference
> between:
> 
> X86,ARM64:
> #define PAGE_SIZE        (_AC(1,UL) << PAGE_SHIFT)
> #define PAGE_MASK        (~(PAGE_SIZE-1))
> 
> POWERPC:
> #define PAGE_SIZE        (ASM_CONST(1) << PAGE_SHIFT)
> /*
>  * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
>  * assign PAGE_MASK to a larger type it gets extended the way we want
>  * (i.e. with 1s in the high bits)
>  */
> #define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
> 
> 
> Which one should be taken in vdso/page.h ?
>

I am not sure either on this point. That's the main reason why I proposed an
indirection for the definitions.

> Christophe

-- 
Regards,
Vincenzo

