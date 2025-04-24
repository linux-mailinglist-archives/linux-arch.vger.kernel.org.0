Return-Path: <linux-arch+bounces-11564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E81E5A9B52D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 19:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76891BA43F4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B6288CA5;
	Thu, 24 Apr 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="kndgtCGk"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07028B50F
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515646; cv=none; b=IAuXYol3J14AYmGyfmx8VuCGKq+r1Hf+sE6GN0MIP7bBdA9ByjwQrquKwY16/qISfCIDuKxDHt2C+vI5Pe60AWDdq83Df13c6NI+ywAnc4UyvNlCn2/foVFG7uV+zqk7qDDlmUxX3KVKd2M7gep89SwAWi+6hbbyn2m3eWq7oZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515646; c=relaxed/simple;
	bh=pWlA5i0QwU5KSfSiQESYA+X0ALKKyDdQ6BF4SmpmQeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObV6UucEV9M+7ZwelRYNOwAWizO4Xe214SdTYMt66q667LdoUd5yVypD3tfSLCqtZvAUPcDd5P90enbxy9ipF8hPXZKdHOxln/VPJYVJnR9WQhpzKSh7u4WhRuDN6t+CQi7i4SoWvL2L4dcoLynqA0vMRPekupdfKaMcPLMYkHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=kndgtCGk; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <f5464e26-faa0-48f1-8585-9ce52c8c9f5f@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1745515637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gE3Ny+oVXXm4XaEkguFbKK9ma/30w0nfPWxX9kbduWE=;
	b=kndgtCGkFmDA6AIZSKwk7aZ9bcFQjmka74EYzotDUPhQOhGmQdqfvcxhJOxbkPnjNGszk6
	S5l10hZQKQQUrgUSJ2bwOeAb25zZDIbVkC45SIoK+EhpviV+6vaWtMiPuB483HZF9UPsva
	a8sxlaHQu/ZqdgzcnnB7ok2bcH/qTI4+tOqX9sJPb//Xt31EH1MMMfGbNOM2sGy1V6K5g7
	54My6MtEokc1ylIB/s1GXrR+echHNjIM89oWRUpFifmxJmaaL+c5NyGF5veS7BkPNuM/Te
	fzPZDf+z4izbFJ6/EuquIZ7QeLmuc4LkjiR4dUzWcTj8yuPCt+kBdCkOucLkOg==
Date: Thu, 24 Apr 2025 19:27:09 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] riscv: introduce asm/swab.h
To: Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>,
 Zhihang Shao <zhihang.shao.iscas@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
 <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
 <c6efcdca-5739-42b6-8cb4-f4d8cc85b6af@app.fastmail.com>
 <b3f8e641-9690-4792-974c-c895d2e4531a@iencinas.com>
 <66a5aba9-2a32-4ef9-a839-a389b975757d@ghiti.fr>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
Autocrypt: addr=ignacio@iencinas.com; keydata=
 xjMEZgaZEBYJKwYBBAHaRw8BAQdAYZxeXU5yoeLYkQpvN+eE3wmAF4V0JUzIlpm/DqiSeBnN
 LElnbmFjaW8gRW5jaW5hcyBSdWJpbyA8aWduYWNpb0BpZW5jaW5hcy5jb20+wo8EExYIADcW
 IQSXV5vKYfM26lUMmYnH3J3Ka8TsNgUCZgaZEAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEA
 AAoJEMfcncprxOw21F4BAJe+mYh3sIdSvydyDdDXLFqtVkzrFB8PVNSU9eZpvM0mAP9996LA
 N0gyY7Obnc3y59r9jOElOn/5fz5mOEU3nE5lCc44BGYGmRESCisGAQQBl1UBBQEBB0CVC5o6
 qnsTzmmtKY1UWa/GJE53dV/3UPJpZu42p/F0OAMBCAfCfgQYFggAJhYhBJdXm8ph8zbqVQyZ
 icfcncprxOw2BQJmBpkRBQkFo5qAAhsMAAoJEMfcncprxOw2N8ABAPcrkHouJPn2N8HcsL4S
 SVgqxNLVOpsMX9kAYgIMqM0WAQCA40v0iYH1q7QHa2IfgkrBzX2ZLdXdwoxfUr8EY5vtAg==
In-Reply-To: <66a5aba9-2a32-4ef9-a839-a389b975757d@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



Hello!

On 23/4/25 13:08, Alexandre Ghiti wrote:
> Hi Ignacio,
> 
> On 04/04/2025 19:35, Ignacio Encinas wrote:
>>
>> On 4/4/25 7:58, Arnd Bergmann wrote:
>>> On Thu, Apr 3, 2025, at 22:34, Ignacio Encinas wrote:
>>>> +#define ARCH_SWAB(size) \
>>>> +static __always_inline unsigned long __arch_swab##size(__u##size value) \
>>>> +{                                    \
>>>> +    unsigned long x = value;                    \
>>>> +                                    \
>>>> +    if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
>>>> +        asm volatile (".option push\n"                \
>>>> +                  ".option arch,+zbb\n"            \
>>>> +                  "rev8 %0, %1\n"                \
>>>> +                  ".option pop\n"                \
>>>> +                  : "=r" (x) : "r" (x));            \
>>>> +        return x >> (BITS_PER_LONG - size);            \
>>>> +    }                                                               \
>>>> +    return  ___constant_swab##size(value);                \
>>>> +}
>> Hello Arnd!
>>
>>> I think the fallback should really just use the __builtin_bswap
>>> helpers instead of the ___constant_swab variants. The output
>>> would be the same, but you can skip patch 1/2.
>> I tried, but that change causes build errors:
>>
>> ```
>> undefined reference to `__bswapsi2'
>>
>> [...]
>>
>> undefined reference to `__bswapdi2
>> ```
>>
>> I tried working around those, but couldn't find a good solution. I'm a
>> bit out of my depth here, but I "summarized" everything here [1]. Let me
>> know if I'm missing something.
>>
>> [1] https://lore.kernel.org/linux-riscv/b3b59747-0484-4042-bdc4-c067688e3bfe@iencinas.com/
> 
> Note that I only encountered those issues in the purgatory.
> 
> So to me we have 3 solutions:
> 
> - either implementing both __bswapsi2 and __bswapdi2

Which would be fine but seems a bit pointless to me: these __bswapsi2
and __bswapdi2 implementations will be ___constant_swab with a different
name: same code or hardcoded (and equivalent) assembly

> - or linking against libgcc
>
> - or merging patch 1.
>
> Given the explanation in commit d67703a8a69e ("arm64: kill off the libgcc dependency"), I would not use libgcc.
> 
> The less intrusive solution (for us riscv) is merging patch 1.

I also think this seems the best solution. I'll send a v4 taking the
tips that were pointed during review (and fixing the issue pointed out
by the kernel test robot) keeping patch 1.

> But please let me know if I missed another solution or if I'm wrong.
> 
> Thanks,
> 
> Alex
> 
> 
>>
>>> I would also suggest dumbing down the macro a bit so you can
>>> still find the definition with 'git grep __arch_swab64'. Ideally
>>> just put the function body into a macro but leave the three
>>> separate inline function definitions.
>> Good point, thanks for bringing it up. Just to be sure, is this what you
>> had in mind? (Give or take formatting + naming of variables)
>>
>> #define arch_swab(size, value)                         \
>> ({                                              \
>>     unsigned long x = value;                    \
>>                                     \
>>     if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
>>         asm volatile (".option push\n"                \
>>                   ".option arch,+zbb\n"            \
>>                   "rev8 %0, %1\n"                \
>>                   ".option pop\n"                \
>>                   : "=r" (x) : "r" (x));            \
>>         x = x >> (BITS_PER_LONG - size);            \
>>     } else {                                                        \
>>         x = ___constant_swab##size(value);                      \
>>     }                                \
>>     x;                                \
>> })
>>
>> static __always_inline unsigned long __arch_swab64(__u64 value) {
>>     return arch_swab(64, value);
>> }
>>
>> Thanks!
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


