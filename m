Return-Path: <linux-arch+bounces-6660-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E2960C56
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2ECB2651E
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2302F19D076;
	Tue, 27 Aug 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agSNKx9C"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19F1A01BC
	for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765997; cv=none; b=DvJd1HKPUCni2+Kdi6cI6SGQ95q82imlL5fSwZSgLBDvpewgesAwJ3TJnlCOUsQcXLN+0d2GcK3sE59wAgZx44C0GOzkdXieswGx+7hQIDpxEfT1XYoqr80Gjiz+7qs9OAjMJJUcPQnNrblHhbt9v9d+oOPLT43aUdReLies7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765997; c=relaxed/simple;
	bh=MX3EwZScRW6mwSew8N3PVYl0YBo2MMA5K8nCYwAL0To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ailMIEaGteRvP1rzRdUA0Zb8Y+CmO/enmzNxSRRpHdrViqeYnZJGh4hHjPWgc+NNbFtRn7RyRnvCTKprZ6p2Q8oLLwOIPTsqTuyBdteU18NGpTOPpgwqTxabyjpvKxp4mZuscsLGm0YoSfKAEOO0ZlJ05ZT5rkYPvU9fby5NIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agSNKx9C; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7106cf5771bso4542422b3a.2
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724765994; x=1725370794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xZNMf9txr/rf/ppLU5NluSyXdD3QzQLidZzz55QzwiI=;
        b=agSNKx9COKiqxwHT69LWb10XReGyluXdeN+Ss4PcELfJg5aezdSNRc5zgE5pX2i1yi
         QcJDSHYfywW3Ioa7s/SWzhT1VtKozdbQNO8SiE3qCbYyh6JIgMXbQGMDqZ+91TxgKvRn
         xGZnpZfZhcy4Wag2Lh5v50ar4ZmG5YsYCQs3kigEijdHL4b3BvD5361Kijd99ClVI4d2
         kH0J31nVGurE6F2XWs1pSrrhG3+tp0u1hm1AT/w/sVRsCGrle9e/xkcM+CEufuErT2Dw
         qd11s3MTu6mMtru4Apr8KB4F9+sDPbW3oD2dHgz2S0yhpLOGQGwDZ5eD0SgrJxdWqw72
         TQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724765994; x=1725370794;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZNMf9txr/rf/ppLU5NluSyXdD3QzQLidZzz55QzwiI=;
        b=sJ/he2na/W+yhdrLADZJ4Ka8LKLBFJ67qMFxZ5Q8fHEzvezexsRcBLtrL9OxaV/m8U
         0xzclV3I8ewm3c1+6RZrbH5mJcmN1cZ20sBKPB+B/wcQqIMzNXcYYud0qt65upl03s9R
         IU1z6OqIzRNVjgDklqv/eO0upmDBzrlRuOFPkOIxRsZTA/XmgrisEtvvU7pQq/AM/B6w
         yjMfDzDbXHbIH8blVfOe375+3LQ8rHeTNf91E4Napt2ygvd4fj0vDNbFbuT/8eTuCdtI
         XhhXbgC24DOtrkq6IDgVv6zL6KUXalrnkkSUcrCTvbiUotNgoPY1LrhR9UTSd4IGAYD1
         XL2g==
X-Forwarded-Encrypted: i=1; AJvYcCVnmLW02Q2PpvIhs46Jr84huzuhavR6IiiwBDyTlP2KO8RToDH9RO9KOhzTMgBlSgf/x6mGWtLnmszx@vger.kernel.org
X-Gm-Message-State: AOJu0Yznyps6i4ZLt6EEOJET/8tdAiqdlqLyX0DyTIKAZxUnUVLkpXN0
	Fd52y+zQzFCS4H3h33vQDARTvc24TAK1XGXpfBOP8kDHmYX15af+OY9EHFaj/U8=
X-Google-Smtp-Source: AGHT+IG0TMWG9ibEycazi56XX7PTQzy+Tj0LiYVLm5nzmD3udnpEAULYghm+XQbVVPT3zRBn2YdXHw==
X-Received: by 2002:a05:6a20:4f89:b0:1cc:bb4e:a905 with SMTP id adf61e73a8af0-1ccbb4ea95amr3503746637.1.1724765994029;
        Tue, 27 Aug 2024 06:39:54 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb? ([2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdc7c6sm8058304a12.46.2024.08.27.06.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:39:53 -0700 (PDT)
Message-ID: <907e86f6-c9e8-41b1-9538-b1bb13d481ae@linaro.org>
Date: Tue, 27 Aug 2024 10:39:49 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Biggers <ebiggers@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <ZszlGPqfrULzi3KG@zx2c4.com>
 <fd3cd385-131a-43b2-8ce9-05547a4f2d1d@linaro.org>
 <Zs3V3FYwz57tyGgp@zx2c4.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <Zs3V3FYwz57tyGgp@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/08/24 10:34, Jason A. Donenfeld wrote:
> On Tue, Aug 27, 2024 at 10:17:18AM -0300, Adhemerval Zanella Netto wrote:
>>
>>
>> On 26/08/24 17:27, Jason A. Donenfeld wrote:
>>> Hi Adhemerval,
>>>
>>> Thanks for posting this! Exciting to have it here.
>>>
>>> Just some small nits for now:
>>>
>>> On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
>>>> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
>>>> +{
>>>> +	register long int x8 asm ("x8") = __NR_getrandom;
>>>> +	register long int x0 asm ("x0") = (long int) buffer;
>>>> +	register long int x1 asm ("x1") = (long int) len;
>>>> +	register long int x2 asm ("x2") = (long int) flags;
>>>
>>> Usually it's written just as `long` or `unsigned long`, and likewise
>>> with the cast. Also, no space after the cast.
>>
>> Ack.
>>
>>>
>>>> +#define __VDSO_RND_DATA_OFFSET  480
>>>
>>> This is the size of the data currently there?
>>
>> Yes, I used the same strategy x86 did.
>>
>>>
>>>>  #include <asm/page.h>
>>>>  #include <asm/vdso.h>
>>>>  #include <asm-generic/vmlinux.lds.h>
>>>> +#include <vdso/datapage.h>
>>>> +#include <asm/vdso/vsyscall.h>
>>>
>>> Possible to keep the asm/ together?
>>
>> Ack.
>>
>>>
>>>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
>>>> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
>>>
>>> nonnce -> nonce
>>
>> Ack.
>>
>>>
>>>> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>>>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
>>>>  SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>>>>  
>>>>  TEST_GEN_PROGS := vdso_test_gettimeofday
>>>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>>>  TEST_GEN_PROGS += vdso_standalone_test_x86
>>>>  endif
>>>>  TEST_GEN_PROGS += vdso_test_correctness
>>>> -ifeq ($(uname_M),x86_64)
>>>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
>>>>  TEST_GEN_PROGS += vdso_test_getrandom
>>>>  ifneq ($(SODIUM),)
>>>>  TEST_GEN_PROGS += vdso_test_chacha
>>>
>>> You'll need to add the symlink to get the chacha selftest running:
>>>
>>>   $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vdso
>>>   $ git add tools/arch/arm64/vdso
>>>
>>> Also, can you confirm that the chacha selftest runs and works?
>>
>> Yes, last time I has to built it manually since the Makefile machinery seem 
>> to be broken even on x86_64.  In a Ubuntu vm I have:
>>
>> tools/testing/selftests/vDSO$ make
>>   CC       vdso_test_gettimeofday
>>   CC       vdso_test_getcpu
>>   CC       vdso_test_abi
>>   CC       vdso_test_clock_getres
>>   CC       vdso_standalone_test_x86
>>   CC       vdso_test_correctness
>>   CC       vdso_test_getrandom
>>   CC       vdso_test_chacha
>> In file included from /home/azanella/Projects/linux/linux-git/include/linux/limits.h:7,
>>                  from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
>>                  from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
>>                  from /usr/include/limits.h:195,
>>                  from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:205,
>>                  from /usr/lib/gcc/x86_64-linux-gnu/13/include/syslimits.h:7,
>>                  from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:34,
>>                  from /usr/include/sodium/export.h:7,
>>                  from /usr/include/sodium/crypto_stream_chacha20.h:14,
>>                  from vdso_test_chacha.c:6:
>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
>>    99 | # if INT_MAX == 32767
>>       |      ^~~~~~~
>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
>>   102 | #  if INT_MAX == 2147483647
>>       |       ^~~~~~~
>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
>>   126 | # if LONG_MAX == 2147483647
>>       |      ^~~~~~~~
>> make: *** [../lib.mk:222: /home/azanella/Projects/linux/linux-git/tools/testing/selftests/vDSO/vdso_test_chacha] Error 1
> 
> You get that even with the latest random.git? I thought Christophe's
> patch fixed that, but maybe not and I should just remove the dependency
> on the sodium header instead.

On x86_64 I tested with Linux master.  With random.git it is a different issue:

linux-git/tools/testing/selftests/vDSO$ make
  CC       vdso_test_gettimeofday
  CC       vdso_test_getcpu
  CC       vdso_test_abi
  CC       vdso_test_clock_getres
  CC       vdso_standalone_test_x86
  CC       vdso_test_correctness
  CC       vdso_test_getrandom
  CC       vdso_test_chacha
/usr/bin/ld: /tmp/ccKpjnSM.o: in function `main':
vdso_test_chacha.c:(.text+0x276): undefined reference to `crypto_stream_chacha20'
collect2: error: ld returned 1 exit status

If I move -lsodium to the end of the compiler command it works.



