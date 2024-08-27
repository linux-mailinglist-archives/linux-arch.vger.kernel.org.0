Return-Path: <linux-arch+bounces-6664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601B960CD1
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 16:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D32284065
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780D1A0721;
	Tue, 27 Aug 2024 14:00:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FAC19CCE7;
	Tue, 27 Aug 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767246; cv=none; b=fnCZhgX8PKWxUWTW0Nkw8+XTkXdCce/wEmuMS9v4MhzwaJXWIPuxB80GxupPHxkUdDyC4AIFfjll81BATWcqqYxv8EnKgi25TqCPVarKoKDFD0pAeTCmO9JgDwMoVvknbxd2Icx7SobqHi+1zv3OmK0hRbG2qXMqj9XW1SyxXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767246; c=relaxed/simple;
	bh=0eF9JVWefjW4YLN6kujTfjGx0pT3wR+FBnpJJjWvaLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QySMh6tkqmxhttbdef8+o9TKJZLhzdZt8l6auB0tShrRVy++r3cOQ74O9CrqsQZ4y+QKJZ8kf2M/EbXpW2VUkfRIODZKxCCKYL5hYsYhCpdBiMSAna+Y3G+LFBKSXNDK92+j7EfMoR+xqMT5BTqQ3jG67DnCPDdKQX4eh0FHMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtThp5lGJz9sPd;
	Tue, 27 Aug 2024 16:00:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id txvSSu77Hl51; Tue, 27 Aug 2024 16:00:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtThp4RFrz9rvV;
	Tue, 27 Aug 2024 16:00:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 899978B787;
	Tue, 27 Aug 2024 16:00:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ltUNxcDq9EPE; Tue, 27 Aug 2024 16:00:42 +0200 (CEST)
Received: from [192.168.233.149] (unknown [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E09F98B77C;
	Tue, 27 Aug 2024 16:00:41 +0200 (CEST)
Message-ID: <4d966dc6-655e-4700-bc59-e03693d874cb@csgroup.eu>
Date: Tue, 27 Aug 2024 16:00:41 +0200
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
 <Zs3V3FYwz57tyGgp@zx2c4.com>
 <907e86f6-c9e8-41b1-9538-b1bb13d481ae@linaro.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <907e86f6-c9e8-41b1-9538-b1bb13d481ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/08/2024 à 15:39, Adhemerval Zanella Netto a écrit :
> [Vous ne recevez pas souvent de courriers de adhemerval.zanella@linaro.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 27/08/24 10:34, Jason A. Donenfeld wrote:
>> On Tue, Aug 27, 2024 at 10:17:18AM -0300, Adhemerval Zanella Netto wrote:
>>>
>>>
>>> On 26/08/24 17:27, Jason A. Donenfeld wrote:
>>>> Hi Adhemerval,
>>>>
>>>> Thanks for posting this! Exciting to have it here.
>>>>
>>>> Just some small nits for now:
>>>>
>>>> On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
>>>>> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
>>>>> +{
>>>>> +  register long int x8 asm ("x8") = __NR_getrandom;
>>>>> +  register long int x0 asm ("x0") = (long int) buffer;
>>>>> +  register long int x1 asm ("x1") = (long int) len;
>>>>> +  register long int x2 asm ("x2") = (long int) flags;
>>>>
>>>> Usually it's written just as `long` or `unsigned long`, and likewise
>>>> with the cast. Also, no space after the cast.
>>>
>>> Ack.
>>>
>>>>
>>>>> +#define __VDSO_RND_DATA_OFFSET  480
>>>>
>>>> This is the size of the data currently there?
>>>
>>> Yes, I used the same strategy x86 did.
>>>
>>>>
>>>>>   #include <asm/page.h>
>>>>>   #include <asm/vdso.h>
>>>>>   #include <asm-generic/vmlinux.lds.h>
>>>>> +#include <vdso/datapage.h>
>>>>> +#include <asm/vdso/vsyscall.h>
>>>>
>>>> Possible to keep the asm/ together?
>>>
>>> Ack.
>>>
>>>>
>>>>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
>>>>> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
>>>>
>>>> nonnce -> nonce
>>>
>>> Ack.
>>>
>>>>
>>>>> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>>>>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
>>>>>   SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>>>>>
>>>>>   TEST_GEN_PROGS := vdso_test_gettimeofday
>>>>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>>>>   TEST_GEN_PROGS += vdso_standalone_test_x86
>>>>>   endif
>>>>>   TEST_GEN_PROGS += vdso_test_correctness
>>>>> -ifeq ($(uname_M),x86_64)
>>>>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
>>>>>   TEST_GEN_PROGS += vdso_test_getrandom
>>>>>   ifneq ($(SODIUM),)
>>>>>   TEST_GEN_PROGS += vdso_test_chacha
>>>>
>>>> You'll need to add the symlink to get the chacha selftest running:
>>>>
>>>>    $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vdso
>>>>    $ git add tools/arch/arm64/vdso
>>>>
>>>> Also, can you confirm that the chacha selftest runs and works?
>>>
>>> Yes, last time I has to built it manually since the Makefile machinery seem
>>> to be broken even on x86_64.  In a Ubuntu vm I have:
>>>
>>> tools/testing/selftests/vDSO$ make
>>>    CC       vdso_test_gettimeofday
>>>    CC       vdso_test_getcpu
>>>    CC       vdso_test_abi
>>>    CC       vdso_test_clock_getres
>>>    CC       vdso_standalone_test_x86
>>>    CC       vdso_test_correctness
>>>    CC       vdso_test_getrandom
>>>    CC       vdso_test_chacha
>>> In file included from /home/azanella/Projects/linux/linux-git/include/linux/limits.h:7,
>>>                   from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
>>>                   from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
>>>                   from /usr/include/limits.h:195,
>>>                   from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:205,
>>>                   from /usr/lib/gcc/x86_64-linux-gnu/13/include/syslimits.h:7,
>>>                   from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:34,
>>>                   from /usr/include/sodium/export.h:7,
>>>                   from /usr/include/sodium/crypto_stream_chacha20.h:14,
>>>                   from vdso_test_chacha.c:6:
>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
>>>     99 | # if INT_MAX == 32767
>>>        |      ^~~~~~~
>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
>>>    102 | #  if INT_MAX == 2147483647
>>>        |       ^~~~~~~
>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
>>>    126 | # if LONG_MAX == 2147483647
>>>        |      ^~~~~~~~
>>> make: *** [../lib.mk:222: /home/azanella/Projects/linux/linux-git/tools/testing/selftests/vDSO/vdso_test_chacha] Error 1
>>
>> You get that even with the latest random.git? I thought Christophe's
>> patch fixed that, but maybe not and I should just remove the dependency
>> on the sodium header instead.
> 
> On x86_64 I tested with Linux master.  With random.git it is a different issue:
> 
> linux-git/tools/testing/selftests/vDSO$ make
>    CC       vdso_test_gettimeofday
>    CC       vdso_test_getcpu
>    CC       vdso_test_abi
>    CC       vdso_test_clock_getres
>    CC       vdso_standalone_test_x86
>    CC       vdso_test_correctness
>    CC       vdso_test_getrandom
>    CC       vdso_test_chacha
> /usr/bin/ld: /tmp/ccKpjnSM.o: in function `main':
> vdso_test_chacha.c:(.text+0x276): undefined reference to `crypto_stream_chacha20'
> collect2: error: ld returned 1 exit status
> 
> If I move -lsodium to the end of the compiler command it works.
> 
> 

Try a "make clean" maybe ?

I have Fedora 38 and no build problem with latest random tree:

$ make V=1
gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_gettimeofday.c parse_vdso.c 
-o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday
gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_getcpu.c parse_vdso.c  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getcpu
gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_abi.c parse_vdso.c  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_abi
gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_clock_getres.c  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_clock_getres
gcc -std=gnu99 -D_GNU_SOURCE= -nostdlib -fno-asynchronous-unwind-tables 
-fno-stack-protector    vdso_standalone_test_x86.c parse_vdso.c  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_standalone_test_x86
gcc -std=gnu99 -D_GNU_SOURCE=  -ldl  vdso_test_correctness.c  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_correctness
gcc -std=gnu99 -D_GNU_SOURCE= -isystem 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include 
-isystem 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../include/uapi 
    vdso_test_getrandom.c parse_vdso.c  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getrandom
gcc -std=gnu99 -D_GNU_SOURCE= -idirafter 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include 
-idirafter 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../arch/x86/include 
-idirafter 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../include 
-D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 
-Wa,--noexecstack -lsodium     vdso_test_chacha.c 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/arch/x86/vdso/vgetrandom-chacha.S 
  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_chacha
$

