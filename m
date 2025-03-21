Return-Path: <linux-arch+bounces-11023-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DD0A6C296
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 19:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470CD3B778B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2ECB664;
	Fri, 21 Mar 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="LQr8od9E"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8B22D4C3
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582353; cv=none; b=kqbtojEZ/N0MSgeShFZK3PW5CDo/hJcFIlVrSN7srYRLhLh1fwAx0u6HoB4/J64cwy4urzyvaAVSsxYieFnMmvhLbmpmGbCFMWHJh75Skpda+dZOOaM8EhULSA1yvxIjhZMFgv1VDYIh6EdRTMp8D1332BaHzdeZQQUIgqMgEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582353; c=relaxed/simple;
	bh=n+K0u+Wd6us+fG8T0NJ0mq5za5Sn6Pp6ZvidZGcV8+4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tky33i4m9NFyhzpFK0qaAaD7T/Bh+CAd627ADTESfPM/bAGBMSHNOZRyiJGiLHbRSXF7XAx1mcAegradDtBwNMOB7sIa9zsKEb6hx2H16kukkEI+LwYwJOPKxsyA39Gafq7xPJfJCzEHp9LMf6GZ0Si2oVnrmHl8mBGgLMn4o/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=LQr8od9E; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <b3b59747-0484-4042-bdc4-c067688e3bfe@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742582339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/l61PMZ8ZONjm1VBcYbvcyTIE/eIAlBdEyNM703h8Wg=;
	b=LQr8od9Eoo1BpEq7o+7c/an+WLbBfCL0f8tZSGR68BOyccf1eIvgALCsoOWT+7qHzhfGwd
	yn0NDKfsiZoX26dbpZT1+rz9C9U1DMXK/0pTwtqI34yXRlZFbkzgqXuEjoyrlPlcJ0LJuK
	Bj0fXQFBZAtzXpgmscYRilgQjjdj5++IwrQhlHkMVw+0ZodToECeslq47XrqyuM+WzjI7s
	e352THyHY4+OVl7l9mLaOERKk71lq/DVWr2JrB3jTN03qYKQzUoP97bRvAVZ3lwq2pJX4v
	6FZOSzOf/sskaOtvO/1ffD9W8jxenGDR/LxEDH+kkX3WyNCQKT/fE8xP6AJd/Q==
Date: Fri, 21 Mar 2025 19:38:54 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
Subject: Re: [PATCH v2 1/2] include/uapi/linux/swab.h: move default
 implementation for swab macros into asm-generic
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>,
 Zhihang Shao <zhihang.shao.iscas@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
References: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
 <20250319-riscv-swab-v2-1-d53b6d6ab915@iencinas.com>
 <2afab9dc-e39c-4399-ac5a-87ade4da5ab0@app.fastmail.com>
 <4d45df0c-d44e-4bb6-8daa-0dba1b834bc4@iencinas.com>
 <07b8051b-9d5e-440e-b74d-1ca97402fe2a@app.fastmail.com>
 <ac0b1f3e-6abe-4de2-bf5a-a4b3207a22c3@iencinas.com>
 <583340a9-411d-406f-aee9-d3e2eb80ca43@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <583340a9-411d-406f-aee9-d3e2eb80ca43@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 21/3/25 11:23, Arnd Bergmann wrote:
> On Thu, Mar 20, 2025, at 23:36, Ignacio Encinas Rubio wrote:
>> On 19/3/25 22:49, Arnd Bergmann wrote:
>>> On Wed, Mar 19, 2025, at 22:37, Ignacio Encinas Rubio wrote:
>>>> On 19/3/25 22:12, Arnd Bergmann wrote:
>>> Right, I do remember when we had a discussion about this maybe
>>> 15 years ago when gcc didn't have the builtins on all architectures
>>> yet, but those versions are long gone, and we never cleaned it up.
>>
>> I just had a chance to look at this and it looks a bit more complex than
>> I initially thought. ___constant_swab macros are used in more places
>> than I expected, and {little,big}_endian.h define their own macros that
>> are used elsewhere, ...
>>
>> It is not clear to me how to proceed here. I could:
>>
>>   1) Just remove ___constant_swab macros and replace them with
>>   __builtin_swap everywhere
>>
>>   2) Go a step further and evaluate removing __constant_htonl and
>>   relatives
>>
>> Let me know what you think is the best option :)
> 
> I think we can start enabling CONFIG_ARCH_USE_BUILTIN_BSWAP
> on all architectures and removing the custom versions
> from arch/*/include/uapi/asm/swab.h, which all seem to
> predate the compiler builtins and likely produce worse code.

This seems fine for some architectures but I don't think we can use
this approach for RISC-V. RISC-V code assumes that the bitmanip 
extension might not be available (see arch/riscv/include/asm/bitops.h).

The current approach [1] is to detect this at boot and patch the kernel 
to adapt it to the actual hardware running it (using specific 
instructions or not).

On the other hand, I tried using __builtin_swap for the RISC-V version 
as an alternative to the "optimized" one (instead of relying on
___constant_swab, see [2]) and I immediately got compilation errors. 

Some architectures seem to require definitions for __bswapsi2 and 
__bswapdi2 [3]. I'm guessing this happens for the architectures that
don't require bit manipulation instructions but have them as extensions.

arm,csky,mips and xtensa seem to fit this description as they 
feature their own __bswapsi2 implementations. Note that they simply
call ___constant_swab or are ___constant_swab written in assembly
language [4] [5].

Unless I'm missing something, it seems to me that using compiler 
builtins (at least for RISC-V, and potentially others) is even more 
problematic than keeping ___constant_swab around. What do you think, 
should we keep patch 1 after all?

We could remove __arch_swab for architectures that always assume bit 
manipulation instructions availability, but then the kernel would fall
back into ___constant_swab when CONFIG_ARCH_USE_BUILTIN_BSWAP=n. Turning
their custom implementations into 

	#define __arch_swabXY __builtin_bswapXY

would solve this issue, but I'm not sure it is an acceptable approach.

Thanks!

[1] https://lore.kernel.org/all/ce034f2b-2f6e-403a-81f1-680af4c72929@ghiti.fr/
[2] https://lore.kernel.org/all/20250319-riscv-swab-v2-2-d53b6d6ab915@iencinas.com/
[3] https://gcc.gnu.org/onlinedocs/gcc-13.3.0/gccint.pdf
[4] https://lore.kernel.org/all/20230512164815.2150839-1-jcmvbkbc@gmail.com/
[5] https://lore.kernel.org/all/1664437198-31260-3-git-send-email-yangtiezhu@loongson.cn/

