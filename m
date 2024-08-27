Return-Path: <linux-arch+bounces-6669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A1960D4E
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82D01F23648
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB101C460A;
	Tue, 27 Aug 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tz3WpFzH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B3126F1E
	for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768077; cv=none; b=Pd1koMQVCB5iYZXVpXD9RAgArhAa4a8gNLdcvtrAM46tkcsUYgKovZaZHIAxmq25T8QYjerTfokJxD/gj2ajIKFUF3MO6oYfgNE2hzFQrIyL1r/6Yj3Regf1sKmO0Jnfx/ngu2G3+0vpelfxQnXOkmEtwrttv2eHVwlD+bOrmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768077; c=relaxed/simple;
	bh=FtCsYyTEhnOhFMjLlmPWyHGrYzTAOvTZcY/AeK14cfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFiC3y2vC0E2LTkmBnOWELN3414PojlwLNk865S4KoETCknhDO/ptXlB82t4w4zKUTL+jVJlXTwlouU5tNIWGSh2xlUjplk4vlyxH4WrgjSkHR3HKL01r/sctlDt5wGpkxwM2uJWJ4+Vv61iy/V2T+WtUQSjm6G54LNHveQZ93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tz3WpFzH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714226888dfso4994330b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724768074; x=1725372874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o+3+2r1N550PeKLOTnfGm8K3KcAqOLonmiMQjmp4lxY=;
        b=tz3WpFzHhWNbE+idgznff6a2eExtLst1Qnicih8G6muaIOb4OMeuH4uMDDMbS1c3er
         hU4ZX06PjgCuD5/ordzGKHouCow+I9w1IGwPOZ2GO3CJd01yWktUdpz7P4k9w861ZhyX
         aZdmzh+pf0ZA3UgKStQdrrDKhYkIgfC0kNKCCAbblKcB1ZJHn5Bq21F9F2pFbJsCoKGM
         3oCYE9qpXpJAEDtQUkgzeM6XcDBu/Y5yEl83Nwot/ERkkKd34CLumNxHqa/dKTV7cVYs
         gGPdhoOF4fe1mVpmq0EdpM1w9tvFVoJue8S9W89Q3gQU2isPow0qajEXNtspUNN07e7r
         VLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768074; x=1725372874;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+3+2r1N550PeKLOTnfGm8K3KcAqOLonmiMQjmp4lxY=;
        b=XO0eaF86fArAfyZLrFflweHZiaheRetTkx2iou+f94A0RUyK45/WrYe8lwXRMpqIer
         J+H3H/5wI0CYiUZIDsYnlYG8Z3TdVDXt2MI/r9IzR+AYwIUpCeOlCNomle7N+6sU35QR
         /3px3lVovtO/OUtETyDjmbN6wYVGm3QO+4OlytgJqTjHaj3eJvHc0Huwczw9H3OYN1NQ
         Tet5iK+JUl4NPaFOeAwPbtyTV9IjB/UztVmOkagKenOxzXnuMG6iWtmvmcbbVJRrLTvS
         B340zn2r5fE05IgfzWa3Kksfj9dA0OYLcHNlpJA1D/DUqEEPXJg2EWnZEsCARWoFfZgJ
         mFKA==
X-Forwarded-Encrypted: i=1; AJvYcCVyqTW1FBWAIv7SI5AVWN/zkGGZTNzxQQpguUy9Ub1ArykCs2DauU3g1SjEVPpbHWXcCQ9B5xwQ/Dph@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCRxOzS2x5qEiux589xumlpjjjC7DRkdSQDrvAGzKWMpJU9pC
	klH8CklOX3xHw+yQzH/EGr3aEzpUa95BNVIVPwpuoDVXzNsQTUHx+5oRLGEDCHQ=
X-Google-Smtp-Source: AGHT+IEmFMevE61JIIhxjfqXIXzmFTxoOXP+TrZSJsfekpW7RtNiIWAOkgeLlYYE+hQ/hbBgC3aQNw==
X-Received: by 2002:a05:6a00:98d:b0:70d:2c8d:bed0 with SMTP id d2e1a72fcca58-714458adb88mr17055436b3a.24.1724768074398;
        Tue, 27 Aug 2024 07:14:34 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb? ([2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e10b4sm8583973b3a.113.2024.08.27.07.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 07:14:33 -0700 (PDT)
Message-ID: <84975137-de73-4ac9-a691-d87d9c0a5b75@linaro.org>
Date: Tue, 27 Aug 2024 11:14:27 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
 <4d966dc6-655e-4700-bc59-e03693d874cb@csgroup.eu>
 <b0e44997-06e0-4b03-b94a-1c54da5516ac@linaro.org>
 <8631deef-c2f0-4499-8e30-8bc48001ef5a@csgroup.eu>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <8631deef-c2f0-4499-8e30-8bc48001ef5a@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/08/24 11:10, Christophe Leroy wrote:
> 
> 
> Le 27/08/2024 à 16:01, Adhemerval Zanella Netto a écrit :
>> [Vous ne recevez pas souvent de courriers de adhemerval.zanella@linaro.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On 27/08/24 11:00, Christophe Leroy wrote:
>>>
>>>
>>> Le 27/08/2024 à 15:39, Adhemerval Zanella Netto a écrit :
>>>> [Vous ne recevez pas souvent de courriers de adhemerval.zanella@linaro.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> On 27/08/24 10:34, Jason A. Donenfeld wrote:
>>>>> On Tue, Aug 27, 2024 at 10:17:18AM -0300, Adhemerval Zanella Netto wrote:
>>>>>>
>>>>>>
>>>>>> On 26/08/24 17:27, Jason A. Donenfeld wrote:
>>>>>>> Hi Adhemerval,
>>>>>>>
>>>>>>> Thanks for posting this! Exciting to have it here.
>>>>>>>
>>>>>>> Just some small nits for now:
>>>>>>>
>>>>>>> On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
>>>>>>>> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
>>>>>>>> +{
>>>>>>>> +  register long int x8 asm ("x8") = __NR_getrandom;
>>>>>>>> +  register long int x0 asm ("x0") = (long int) buffer;
>>>>>>>> +  register long int x1 asm ("x1") = (long int) len;
>>>>>>>> +  register long int x2 asm ("x2") = (long int) flags;
>>>>>>>
>>>>>>> Usually it's written just as `long` or `unsigned long`, and likewise
>>>>>>> with the cast. Also, no space after the cast.
>>>>>>
>>>>>> Ack.
>>>>>>
>>>>>>>
>>>>>>>> +#define __VDSO_RND_DATA_OFFSET  480
>>>>>>>
>>>>>>> This is the size of the data currently there?
>>>>>>
>>>>>> Yes, I used the same strategy x86 did.
>>>>>>
>>>>>>>
>>>>>>>>    #include <asm/page.h>
>>>>>>>>    #include <asm/vdso.h>
>>>>>>>>    #include <asm-generic/vmlinux.lds.h>
>>>>>>>> +#include <vdso/datapage.h>
>>>>>>>> +#include <asm/vdso/vsyscall.h>
>>>>>>>
>>>>>>> Possible to keep the asm/ together?
>>>>>>
>>>>>> Ack.
>>>>>>
>>>>>>>
>>>>>>>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
>>>>>>>> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
>>>>>>>
>>>>>>> nonnce -> nonce
>>>>>>
>>>>>> Ack.
>>>>>>
>>>>>>>
>>>>>>>> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>>>>>>>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
>>>>>>>>    SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>>>>>>>>
>>>>>>>>    TEST_GEN_PROGS := vdso_test_gettimeofday
>>>>>>>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>>>>>>>    TEST_GEN_PROGS += vdso_standalone_test_x86
>>>>>>>>    endif
>>>>>>>>    TEST_GEN_PROGS += vdso_test_correctness
>>>>>>>> -ifeq ($(uname_M),x86_64)
>>>>>>>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
>>>>>>>>    TEST_GEN_PROGS += vdso_test_getrandom
>>>>>>>>    ifneq ($(SODIUM),)
>>>>>>>>    TEST_GEN_PROGS += vdso_test_chacha
>>>>>>>
>>>>>>> You'll need to add the symlink to get the chacha selftest running:
>>>>>>>
>>>>>>>     $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vdso
>>>>>>>     $ git add tools/arch/arm64/vdso
>>>>>>>
>>>>>>> Also, can you confirm that the chacha selftest runs and works?
>>>>>>
>>>>>> Yes, last time I has to built it manually since the Makefile machinery seem
>>>>>> to be broken even on x86_64.  In a Ubuntu vm I have:
>>>>>>
>>>>>> tools/testing/selftests/vDSO$ make
>>>>>>     CC       vdso_test_gettimeofday
>>>>>>     CC       vdso_test_getcpu
>>>>>>     CC       vdso_test_abi
>>>>>>     CC       vdso_test_clock_getres
>>>>>>     CC       vdso_standalone_test_x86
>>>>>>     CC       vdso_test_correctness
>>>>>>     CC       vdso_test_getrandom
>>>>>>     CC       vdso_test_chacha
>>>>>> In file included from /home/azanella/Projects/linux/linux-git/include/linux/limits.h:7,
>>>>>>                    from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
>>>>>>                    from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
>>>>>>                    from /usr/include/limits.h:195,
>>>>>>                    from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:205,
>>>>>>                    from /usr/lib/gcc/x86_64-linux-gnu/13/include/syslimits.h:7,
>>>>>>                    from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:34,
>>>>>>                    from /usr/include/sodium/export.h:7,
>>>>>>                    from /usr/include/sodium/crypto_stream_chacha20.h:14,
>>>>>>                    from vdso_test_chacha.c:6:
>>>>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
>>>>>>      99 | # if INT_MAX == 32767
>>>>>>         |      ^~~~~~~
>>>>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
>>>>>>     102 | #  if INT_MAX == 2147483647
>>>>>>         |       ^~~~~~~
>>>>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
>>>>>>     126 | # if LONG_MAX == 2147483647
>>>>>>         |      ^~~~~~~~
>>>>>> make: *** [../lib.mk:222: /home/azanella/Projects/linux/linux-git/tools/testing/selftests/vDSO/vdso_test_chacha] Error 1
>>>>>
>>>>> You get that even with the latest random.git? I thought Christophe's
>>>>> patch fixed that, but maybe not and I should just remove the dependency
>>>>> on the sodium header instead.
>>>>
>>>> On x86_64 I tested with Linux master.  With random.git it is a different issue:
>>>>
>>>> linux-git/tools/testing/selftests/vDSO$ make
>>>>     CC       vdso_test_gettimeofday
>>>>     CC       vdso_test_getcpu
>>>>     CC       vdso_test_abi
>>>>     CC       vdso_test_clock_getres
>>>>     CC       vdso_standalone_test_x86
>>>>     CC       vdso_test_correctness
>>>>     CC       vdso_test_getrandom
>>>>     CC       vdso_test_chacha
>>>> /usr/bin/ld: /tmp/ccKpjnSM.o: in function `main':
>>>> vdso_test_chacha.c:(.text+0x276): undefined reference to `crypto_stream_chacha20'
>>>> collect2: error: ld returned 1 exit status
>>>>
>>>> If I move -lsodium to the end of the compiler command it works.
>>>>
>>>>
>>>
>>> Try a "make clean" maybe ?
>>>
>>> I have Fedora 38 and no build problem with latest random tree:
>>>
>>> $ make V=1
>>> gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_gettimeofday.c parse_vdso.c -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday
>>> gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_getcpu.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getcpu
>>> gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_abi.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_abi
>>> gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_clock_getres.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_clock_getres
>>> gcc -std=gnu99 -D_GNU_SOURCE= -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector    vdso_standalone_test_x86.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_standalone_test_x86
>>> gcc -std=gnu99 -D_GNU_SOURCE=  -ldl  vdso_test_correctness.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_correctness
>>> gcc -std=gnu99 -D_GNU_SOURCE= -isystem /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include -isystem /home/chleroy/linux-powerpc/tools/testing/selftests/../../../include/uapi    vdso_test_getrandom.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getrandom
>>> gcc -std=gnu99 -D_GNU_SOURCE= -idirafter /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include -idirafter /home/chleroy/linux-powerpc/tools/testing/selftests/../../../arch/x86/include -idirafter /home/chleroy/linux-powerpc/tools/testing/selftests/../../../include -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 -Wa,--noexecstack -lsodium     vdso_test_chacha.c /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/arch/x86/vdso/vgetrandom-chacha.S  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_chacha
>>> $
>>
>> It is a clean tree (git clean -dfx), and I take there is no need to build a kernel
>> prior hand.
> 
> I meeant 'make clean'
> 
> 
> Right, I have not built any x86 kernel at the moment.
> 
> Just :
> $ pwd
> /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO
> 
> $ make clean
> 
> then
> 
> $ make V=1

The issue is Ubuntu linker is configure to use --as-needed by default, this
patch fixes the issue:

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 10ffdda3f2fa..151baf650e4c 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -45,4 +45,4 @@ $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -idirafter $(top_srcdir)/arch/$(ARCH)/include \
                                       -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 \
-                                      -Wa,--noexecstack $(SODIUM)
+                                      -Wa,--noexecstack -Wl,-no-as-needed $(SODIUM)

