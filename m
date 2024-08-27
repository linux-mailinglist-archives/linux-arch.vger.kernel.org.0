Return-Path: <linux-arch+bounces-6662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C82960C94
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 15:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD871F23434
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43CC1C4619;
	Tue, 27 Aug 2024 13:52:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5C1C460C;
	Tue, 27 Aug 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766746; cv=none; b=bXeDd54ccV8F9EVU0zQmnztw88R5Kk+Fe7AJhV6ufklcex2OaST6XxZzsruEzuyUqqs4AnTUAj1q6bnO07poE+0hKZ65bVt/14HYnfk6+0PvVdQ1tqbj1kJYa6HeaFUnYFjRZqK40D2KO+Ai+i0fsAbXanQX2dVH0GcTX1VaFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766746; c=relaxed/simple;
	bh=QtBWaqTGdUAGgNmIlwBBGUsERV466m5iQc0yT2aplFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeM3QNxhc7yWTofKyW9f6/1v0Ib8mW9M9LNt9Ct4G/lfR4ybx6rKW4XWTZH37Igc/taJeDxa85hSU6O/Z/Vzs1et1TDdXgkl533VSamA3OTzvB5GQYqjNbyQF+OGP/S/jA2Uk02wYseyavMU6nz+1o976r1+j82sTMMjW8fEPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtTWB1vtLz9sPd;
	Tue, 27 Aug 2024 15:52:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eYDrvO0daCfp; Tue, 27 Aug 2024 15:52:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtTWB0wK1z9rvV;
	Tue, 27 Aug 2024 15:52:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BE968B787;
	Tue, 27 Aug 2024 15:52:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WM9csDU1aTaJ; Tue, 27 Aug 2024 15:52:21 +0200 (CEST)
Received: from [192.168.233.149] (unknown [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FC368B77C;
	Tue, 27 Aug 2024 15:52:21 +0200 (CEST)
Message-ID: <df354c7e-e93b-4697-a373-c68c72c73adf@csgroup.eu>
Date: Tue, 27 Aug 2024 15:52:21 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Biggers <ebiggers@kernel.org>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <ZszlGPqfrULzi3KG@zx2c4.com>
 <fd3cd385-131a-43b2-8ce9-05547a4f2d1d@linaro.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <fd3cd385-131a-43b2-8ce9-05547a4f2d1d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/08/2024 à 15:17, Adhemerval Zanella Netto a écrit :
> [Vous ne recevez pas souvent de courriers de adhemerval.zanella@linaro.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 26/08/24 17:27, Jason A. Donenfeld wrote:
>> Hi Adhemerval,
>>
>> Thanks for posting this! Exciting to have it here.
>>
>> Just some small nits for now:
>>
>> On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
>>> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
>>> +{
>>> +    register long int x8 asm ("x8") = __NR_getrandom;
>>> +    register long int x0 asm ("x0") = (long int) buffer;
>>> +    register long int x1 asm ("x1") = (long int) len;
>>> +    register long int x2 asm ("x2") = (long int) flags;
>>
>> Usually it's written just as `long` or `unsigned long`, and likewise
>> with the cast. Also, no space after the cast.
> 
> Ack.
> 
>>
>>> +#define __VDSO_RND_DATA_OFFSET  480
>>
>> This is the size of the data currently there?
> 
> Yes, I used the same strategy x86 did.
> 
>>
>>>   #include <asm/page.h>
>>>   #include <asm/vdso.h>
>>>   #include <asm-generic/vmlinux.lds.h>
>>> +#include <vdso/datapage.h>
>>> +#include <asm/vdso/vsyscall.h>
>>
>> Possible to keep the asm/ together?
> 
> Ack.
> 
>>
>>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
>>> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
>>
>> nonnce -> nonce
> 
> Ack.
> 
>>
>>> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
>>>   SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>>>
>>>   TEST_GEN_PROGS := vdso_test_gettimeofday
>>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>>   TEST_GEN_PROGS += vdso_standalone_test_x86
>>>   endif
>>>   TEST_GEN_PROGS += vdso_test_correctness
>>> -ifeq ($(uname_M),x86_64)
>>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
>>>   TEST_GEN_PROGS += vdso_test_getrandom
>>>   ifneq ($(SODIUM),)
>>>   TEST_GEN_PROGS += vdso_test_chacha
>>
>> You'll need to add the symlink to get the chacha selftest running:
>>
>>    $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vdso
>>    $ git add tools/arch/arm64/vdso
>>
>> Also, can you confirm that the chacha selftest runs and works?
> 
> Yes, last time I has to built it manually since the Makefile machinery seem
> to be broken even on x86_64.  In a Ubuntu vm I have:
> 
> tools/testing/selftests/vDSO$ make
>    CC       vdso_test_gettimeofday
>    CC       vdso_test_getcpu
>    CC       vdso_test_abi
>    CC       vdso_test_clock_getres
>    CC       vdso_standalone_test_x86
>    CC       vdso_test_correctness
>    CC       vdso_test_getrandom
>    CC       vdso_test_chacha
> In file included from /home/azanella/Projects/linux/linux-git/include/linux/limits.h:7,
>                   from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
>                   from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
>                   from /usr/include/limits.h:195,
>                   from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:205,
>                   from /usr/lib/gcc/x86_64-linux-gnu/13/include/syslimits.h:7,
>                   from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:34,
>                   from /usr/include/sodium/export.h:7,
>                   from /usr/include/sodium/crypto_stream_chacha20.h:14,
>                   from vdso_test_chacha.c:6:
> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
>     99 | # if INT_MAX == 32767
>        |      ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
>    102 | #  if INT_MAX == 2147483647
>        |       ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
>    126 | # if LONG_MAX == 2147483647
>        |      ^~~~~~~~
> make: *** [../lib.mk:222: /home/azanella/Projects/linux/linux-git/tools/testing/selftests/vDSO/vdso_test_chacha] Error 1
> 
> 
> I will try to figure out to be build it correctly, but I think it would be
> better to vgetrandom-chacha.S with a different rule.

Hi, can you try with the following commit : 
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=e1af61334ade39a9af3031b7189f9acb419648a4

Thanks
Christophe

