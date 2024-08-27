Return-Path: <linux-arch+bounces-6677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C035796153A
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 19:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75887284485
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3631CCB4A;
	Tue, 27 Aug 2024 17:14:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558645025;
	Tue, 27 Aug 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778889; cv=none; b=FO4VNyknAFHvSc6INrzptyl+5M1vJMr+FgC3xORnVkpRvsDS6921NXa/9zcbIh//mx4+YPoX5lhbj5gcFFLkk3xf48oRPRRmOxOd4crF+uSrfeq+g0iZxW2rvUeazk+0InVU5nATNUMueAnixMVa5Y3PTAfPHEo5HLDNQkfnaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778889; c=relaxed/simple;
	bh=lmnE5YZLXWMk/RtQy14l6fhL3AlWi/vwmjxLHWV3pLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeTYhxjTR/oviJniNbVI4MyIpFMzw9hSqvtKclTpf0n0Ii4eBiH48gHKP20W+RPddUaPUBFwowqDLiYAaQgmh6bl/0iM6Ih8bKCrzHfc2gC3rJK+r3d6VAbaFb1xMMjAbK1lVTBosdKAzk+ix4svu5yzB2U8aLzZci9iOvMs/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtZ0j6MpFz9sRy;
	Tue, 27 Aug 2024 19:14:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d700GxHyWDBb; Tue, 27 Aug 2024 19:14:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtZ0j2yPhz9sRs;
	Tue, 27 Aug 2024 19:14:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DF298B78B;
	Tue, 27 Aug 2024 19:14:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oI_YXMVBxxRm; Tue, 27 Aug 2024 19:14:45 +0200 (CEST)
Received: from [192.168.233.149] (unknown [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 761A68B77C;
	Tue, 27 Aug 2024 19:14:44 +0200 (CEST)
Message-ID: <272cb38a-c0e3-4e6e-89ce-b503c75c2c33@csgroup.eu>
Date: Tue, 27 Aug 2024 19:14:44 +0200
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <17437f43-9d1f-4263-888e-573a355cb0b5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/08/2024 à 18:05, Vincenzo Frascino a écrit :
> Hi Christophe,
> 
> On 27/08/2024 11:49, Christophe Leroy wrote:
> 
> ...
> 
> 
>>>
>>> These are still two headers outside of the vdso/ namespace. For arm64
>>> we had concluded that this is never safe, and any vdso header should
>>> only include other vdso headers so we never pull in anything that
>>> e.g. depends on memory management headers that are in turn broken
>>> for the compat vdso.
>>>
>>> The array_size.h header is really small, so that one could
>>> probably just be moved into the vdso/ namespace. The minmax.h
>>> header is already rather complex, so it may be better to just
>>> open-code the usage of MIN/MAX where needed?
>>
>> It is used at two places only so yes can to that.
>>
> 
> Could you please clarify where minmax is needed? I tried to build Jason's master
> tree for x86, commenting the header and it seems building fine. I might be
> missing something.

Without it:

   VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
In file included from /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:11,
                  from <command-line>:
./arch/powerpc/include/asm/vdso/getrandom.h: In function 
'__arch_get_vdso_rng_data':
./arch/powerpc/include/asm/vdso/getrandom.h:46:9: error: implicit 
declaration of function 'BUILD_BUG' [-Werror=implicit-function-declaration]
    46 |         BUILD_BUG();
       |         ^~~~~~~~~
./arch/powerpc/include/asm/vdso/getrandom.h:47:1: error: no return 
statement in function returning non-void [-Werror=return-type]
    47 | }
       | ^
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c: In function 
'__cvdso_getrandom_data':
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:76:23: error: implicit 
declaration of function 'min_t' [-Werror=implicit-function-declaration]
    76 |         ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = 
MAX_RW_COUNT */, len);
       |                       ^~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:76:29: error: expected 
expression before 'size_t'
    76 |         ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = 
MAX_RW_COUNT */, len);
       |                             ^~~~~~
In file included from ./include/linux/array_size.h:5,
                  from /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:6:
./include/linux/compiler.h:243:33: error: implicit declaration of 
function 'BUILD_BUG_ON_ZERO' [-Werror=implicit-function-declaration]
   243 | #define __must_be_array(a) 
BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
       |                                 ^~~~~~~~~~~~~~~~~
./include/linux/array_size.h:11:59: note: in expansion of macro 
'__must_be_array'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       | 
^~~~~~~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:40: note: in 
expansion of macro 'ARRAY_SIZE'
    89 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                        ^~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:196:27: error: expected 
expression before 'size_t'
   196 |         batch_len = min_t(size_t, sizeof(state->batch) - 
state->pos, len);
       |                           ^~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:247:9: error: implicit 
declaration of function 'BUILD_BUG_ON' 
[-Werror=implicit-function-declaration]
   247 |         BUILD_BUG_ON(sizeof(state->batch_key) % 
CHACHA_BLOCK_SIZE != 0);
       |         ^~~~~~~~~~~~
cc1: some warnings being treated as errors
make[2]: *** [arch/powerpc/kernel/vdso/Makefile:93: 
arch/powerpc/kernel/vdso/vgetrandom-32.o] Error 1
make[1]: *** [arch/powerpc/Makefile:388: vdso_prepare] Error 2
make: *** [Makefile:224: __sub-make] Error 2


> 
>> Same for ARRAY_SIZE(->reserved) by the way, easy to do opencode, we also have it
>> only once
>>
> 
> I have a similar issue to figure out why linux/array_size.h and
> uapi/linux/random.h are needed. It seems that I can build the object without
> them. Could you please explain?

Without linux/array_size.h:

   VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
In file included from <command-line>:
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c: In function 
'__cvdso_getrandom_data':
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:40: error: implicit 
declaration of function 'ARRAY_SIZE' [-Werror=implicit-function-declaration]
    89 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                        ^~~~~~~~~~
cc1: some warnings being treated as errors
make[2]: *** [arch/powerpc/kernel/vdso/Makefile:93: 
arch/powerpc/kernel/vdso/vgetrandom-32.o] Error 1
make[1]: *** [arch/powerpc/Makefile:388: vdso_prepare] Error 2
make: *** [Makefile:224: __sub-make] Error 2

Without uapi/linux/random.h:

   VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
In file included from <command-line>:
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c: In function 
'__cvdso_getrandom_data':
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:86:23: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    86 |                 params->size_of_opaque_state = sizeof(*state);
       |                       ^~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:87:23: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    87 |                 params->mmap_prot = PROT_READ | PROT_WRITE;
       |                       ^~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:88:23: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    88 |                 params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
       |                       ^~
In file included from /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:6:
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:57: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    89 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                                         ^~
./include/linux/array_size.h:11:33: note: in definition of macro 
'ARRAY_SIZE'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       |                                 ^~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:57: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    89 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                                         ^~
./include/linux/array_size.h:11:48: note: in definition of macro 
'ARRAY_SIZE'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       |                                                ^~~
In file included from ./include/linux/minmax.h:5,
                  from /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:7:
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:57: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    89 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                                         ^~
./include/linux/build_bug.h:16:62: note: in definition of macro 
'BUILD_BUG_ON_ZERO'
    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { 
int:(-!!(e)); })))
       |                                                              ^
./include/linux/compiler.h:243:51: note: in expansion of macro '__same_type'
   243 | #define __must_be_array(a) 
BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
       |                                                   ^~~~~~~~~~~
./include/linux/array_size.h:11:59: note: in expansion of macro 
'__must_be_array'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       | 
^~~~~~~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:40: note: in 
expansion of macro 'ARRAY_SIZE'
    89 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                        ^~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:57: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    89 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                                         ^~
./include/linux/build_bug.h:16:62: note: in definition of macro 
'BUILD_BUG_ON_ZERO'
    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { 
int:(-!!(e)); })))
       |                                                              ^
./include/linux/compiler.h:243:51: note: in expansion of macro '__same_type'
   243 | #define __must_be_array(a) 
BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
       |                                                   ^~~~~~~~~~~
./include/linux/array_size.h:11:59: note: in expansion of macro 
'__must_be_array'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       | 
^~~~~~~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:40: note: in 
expansion of macro 'ARRAY_SIZE'
    89 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                        ^~~~~~~~~~
./include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width 
not an integer constant
    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { 
int:(-!!(e)); })))
       |                                                   ^
./include/linux/compiler.h:243:33: note: in expansion of macro 
'BUILD_BUG_ON_ZERO'
   243 | #define __must_be_array(a) 
BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
       |                                 ^~~~~~~~~~~~~~~~~
./include/linux/array_size.h:11:59: note: in expansion of macro 
'__must_be_array'
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       | 
^~~~~~~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:40: note: in 
expansion of macro 'ARRAY_SIZE'
    89 |                 for (size_t i = 0; i < 
ARRAY_SIZE(params->reserved); ++i)
       |                                        ^~~~~~~~~~
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:90:31: error: invalid 
use of undefined type 'struct vgetrandom_opaque_params'
    90 |                         params->reserved[i] = 0;
       |                               ^~
In file included from ./include/linux/array_size.h:5:
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:99:32: error: 
'GRND_NONBLOCK' undeclared (first use in this function); did you mean 
'MAP_NONBLOCK'?
    99 |         if (unlikely(flags & ~(GRND_NONBLOCK | GRND_RANDOM | 
GRND_INSECURE)))
       |                                ^~~~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
       |                                             ^
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:99:32: note: each 
undeclared identifier is reported only once for each function it appears in
    99 |         if (unlikely(flags & ~(GRND_NONBLOCK | GRND_RANDOM | 
GRND_INSECURE)))
       |                                ^~~~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
       |                                             ^
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:99:48: error: 
'GRND_RANDOM' undeclared (first use in this function)
    99 |         if (unlikely(flags & ~(GRND_NONBLOCK | GRND_RANDOM | 
GRND_INSECURE)))
       |                                                ^~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
       |                                             ^
/home/chleroy/linux-powerpc/lib/vdso/getrandom.c:99:62: error: 
'GRND_INSECURE' undeclared (first use in this function)
    99 |         if (unlikely(flags & ~(GRND_NONBLOCK | GRND_RANDOM | 
GRND_INSECURE)))
       | 
^~~~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
       |                                             ^
make[2]: *** [arch/powerpc/kernel/vdso/Makefile:93: 
arch/powerpc/kernel/vdso/vgetrandom-32.o] Error 1
make[1]: *** [arch/powerpc/Makefile:388: vdso_prepare] Error 2
make: *** [Makefile:224: __sub-make] Error 2


> 
> In general, the philosophy adopted to split the headers is to extract the set of
> functions used by vDSOs from the linux headers and place them in the vdso headers.
> Consequently the linux header includes to vdso one. E.g.: linux/time64.h
> includes vdso/time64.h.
> 
> IMHO we should follow the same approach, if at all for consistency, unless there
> is a valid reason.

Indeed I started with something that didn't build and I did the simplest 
I could to get it build. I agree with you at the end that would be a 
best, can be done in follow-up patches I guess.

> 
> ...
> 
>>>
>>> Including uapi/linux/mman.h may still be problematic on
>>> some architectures if they change it in a way that is
>>> incompatible with compat vdso, but at least that can't
>>> accidentally rely on CONFIG_64BIT or something else that
>>> would be wrong there.
>>
>> Yes that one is tricky. Because uapi/linux/mman.h includes asm/mman.h with the
>> intention to include uapi/asm/mman.h but when built from the kernel in reality
>> you get arch/powerpc/include/asm/mman.h and I had to add some ifdefery to
>> kick-out kernel oddities it contains that pull additional kernel headers.
>>
>> diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
>> index 17a77d47ed6d..42a51a993d94 100644
>> --- a/arch/powerpc/include/asm/mman.h
>> +++ b/arch/powerpc/include/asm/mman.h
>> @@ -6,7 +6,7 @@
>>
>>   #include <uapi/asm/mman.h>
>>
>> -#ifdef CONFIG_PPC64
>> +#if defined(CONFIG_PPC64) && !defined(BUILD_VDSO)
>>
>>   #include <asm/cputable.h>
>>   #include <linux/mm.h>
>>
> 
> I agree with Arnd here. uapi/linux/mman.h can cause us problems in the long run.

Fully agree.

> 
> I am attaching a patch to provide my view on how to minimize the headers
> included and use only the vdso/ namespace. Please, before using the code,
> consider that I conducted very limited testing.
> 
> Note: It should apply clean on Jason's tree.
> 
> Let me know your thoughts.
> 
>>
>> Christophe
> 

