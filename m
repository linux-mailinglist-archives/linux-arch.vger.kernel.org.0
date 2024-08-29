Return-Path: <linux-arch+bounces-6811-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B6E964958
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 17:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98452B24937
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B453A1A8;
	Thu, 29 Aug 2024 15:01:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162EA36B0D;
	Thu, 29 Aug 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943673; cv=none; b=tgStRduWG5wD/69Dw5PwBhwONn3lUzfmaxTqCRRxZOtj8YTzSLXGIrPciaG8K5MCaX8ajHS/RWoLO98zW6h+242gPvS9rIwPrbB908nNRZSwlmH7bNh7f4J9tLzVa0QTsTAiOay4gRsXp2NqRb0P9B/pqG3XCZzVzfM876ciqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943673; c=relaxed/simple;
	bh=yxT/CITz2Ev+XRlXd/JOk8lr2Jz4zNqFFvpl/UT9/tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TloShmt8ouALh+lWDAY5+Pod21bLa731GqLKD/LuSs7c+FKIslEtl1B2cFp0oJ+SVZjUYALvt7+jvyaq1fW59ZQhG5OyhEPHwcJvHEMWRUs1iKw8EP1Ujf/gj4Gg+jTfOoIbCBFuPYHkGjf4d04meXLGKnG+ulKtKbZvv96GgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WvkxW5xyLz9sTX;
	Thu, 29 Aug 2024 17:01:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CjnhSQGtSteZ; Thu, 29 Aug 2024 17:01:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wvkwf6YQGz9sSX;
	Thu, 29 Aug 2024 17:00:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF1CB8B794;
	Thu, 29 Aug 2024 17:00:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Ebp-7Axw5H8e; Thu, 29 Aug 2024 17:00:18 +0200 (CEST)
Received: from [192.168.234.40] (unknown [192.168.234.40])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 398B98B764;
	Thu, 29 Aug 2024 17:00:18 +0200 (CEST)
Message-ID: <0085b19d-bb87-45bc-8a74-7464316f86a1@csgroup.eu>
Date: Thu, 29 Aug 2024 17:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linux-Arch <linux-arch@vger.kernel.org>
References: <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>
 <Zs2RCfMgfNu_2vos@zx2c4.com>
 <cb66b582-ba63-4a5a-9df8-b07288f1f66d@app.fastmail.com>
 <0f9255f1-5860-408c-8eaa-ccb4dd3747fa@csgroup.eu>
 <17437f43-9d1f-4263-888e-573a355cb0b5@arm.com>
 <272cb38a-c0e3-4e6e-89ce-b503c75c2c33@csgroup.eu>
 <bab7286c-e27e-450a-8bb6-e5b09063a033@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <bab7286c-e27e-450a-8bb6-e5b09063a033@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincenzo,

Le 29/08/2024 à 14:01, Vincenzo Frascino a écrit :
> Hi Christophe,
> 
> On 27/08/2024 18:14, Christophe Leroy wrote:
>>
>>
>> Le 27/08/2024 à 18:05, Vincenzo Frascino a écrit :
>>> Hi Christophe,
>>>
>>> On 27/08/2024 11:49, Christophe Leroy wrote:
>>>
>>> ...
> 
> ...
> 
>>>
>>> Could you please clarify where minmax is needed? I tried to build Jason's master
>>> tree for x86, commenting the header and it seems building fine. I might be
>>> missing something.
>>
>> Without it:
>>
>>    VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
>> In file included from /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:11,
>>                   from <command-line>:
> ...
> 
>>
>>
>>>
>>>> Same for ARRAY_SIZE(->reserved) by the way, easy to do opencode, we also have it
>>>> only once
>>>>
>>>
>>> I have a similar issue to figure out why linux/array_size.h and
>>> uapi/linux/random.h are needed. It seems that I can build the object without
>>> them. Could you please explain?
>>
>> Without linux/array_size.h:
>>
>>    VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
>> In file included from <command-line>:
>> /home/chleroy/linux-powerpc/lib/vdso/getrandom.c: In function
>> '__cvdso_getrandom_data':
>> /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:40: error: implicit
> If this is the case, those headers should be defined for the powerpc
> implementation only. The generic implementation should be interpreted as the
> minimum common denominator in between all the architectures for what concerns
> the headers.
> 

Sorry, I disagree. You can't rely on necessary headers being included 
indirectly by other arch specific headers. getrandom.c uses 
ARRAY_SIZE(), it must include the header that defines ARRAY_SIZE().

At the moment, on x86 you get linux/array.h by change through the 
following chain, that the reason why the build doesn't break:

In file included from ./include/linux/kernel.h:16,
                  from ./include/linux/cpumask.h:11,
                  from ./arch/x86/include/asm/cpumask.h:5,
                  from ./arch/x86/include/asm/msr.h:11,
                  from ./arch/x86/include/asm/vdso/gettimeofday.h:19,
                  from ./include/vdso/datapage.h:164,
                  from 
arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:9,

 From my point of view you can't expect such a chain from each architecture.

Christophe

