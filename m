Return-Path: <linux-arch+bounces-6658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B572960B9F
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 15:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4DE281D7B
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7EA1BCA17;
	Tue, 27 Aug 2024 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPsZic3+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0FF1BAED5
	for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764646; cv=none; b=C/locKB2D6YYrR+OtfLKPwN/PzFduVVYxm+FihUt/6Dw59ez3UNsqaUb+d41yGweMPGNXDv3Y2GGDeXn1vj1+C1mf7OIAwwlOLIrbFpEOi6uTdBr2qPuO/d2n5H/fsOaDqq0WvivJJtnR1rufKyKizXFW30HbI2zrKydzmuap9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764646; c=relaxed/simple;
	bh=vwt6e777tT51vo7BVYhsyOE+lwnCOE+ATUVN8ZFprPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRTxIGS+hYm/gEAfaeOhfGpFzqyILHDAHx63aXEft4dKlVL8uwbbn9SlEPQLiZa46zJjXOjOquj+Tno/zxSodCf8I1SADr2moGBiMpikawmYIqnqlHRujvsp3rWPj0m4cgypfuUpLNGFXA16xi/mLy8+UzHUU0hyHCjPu0A0vhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VPsZic3+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-714262f1bb4so3966173b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724764644; x=1725369444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vNDvQ0p8YG1nUDHlej3r9c38HmVmkFpUvXQbHfKwb18=;
        b=VPsZic3+JuNkNkvidzsT9nyttmCBlF7lNwoOALRsmd8keH8M6tunuUA8s+DE/rJMQi
         eruyNe8cNWJXXjlCFgHsKSJGRzcQy5X5E0+qOOQ4S5rN1okatLo3Zop3NsMr5t9/Zjif
         lrV+a+ErSpJtjyo5DHeITkBi5Hq3HEwHYN3maj5seSKd3w8Cpr9SeJJPKVQU75yyB0Xr
         A6AhSgZ5zgC4CXqLYYmB0b5y2Jom8W4Kd2PbVaGj2mJmI8ThzFexA9SNWVHHE7f6MZyC
         LMzoqXMCicS6qjmNYAiJkahq94RmKlKo4+8tJks1if9UjRSQ+cd+z7os7yp79VT67QqN
         8KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764644; x=1725369444;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNDvQ0p8YG1nUDHlej3r9c38HmVmkFpUvXQbHfKwb18=;
        b=tZ8sO/0Jig+M6kF3nx8wtFvyxtiBfk3HCmQIyPel5xJ/0+bwJvivnEuU5yetZTmhaO
         3VRMPwYkETsPBprXqvGP0M8Jo2a4o6a6MYT0eoN3p9sknNuBKbkuVExX+uh7Ms8HIFqv
         FmpS4qkAdgb6mXVLjcn40VoUn+6NW/h8UQgCgxJxPAIA9+hXRF4tDjOiu9VwC5sC8jUd
         6sdPZ0iC2jl9o+T1hyKLjHJnzD3k6+W+gmJOPdMn+RlvfCJ0UhTaFv77Ocd7bHJPR+en
         +FvRVFLpYDeDADiI35bHTV3rUNaHRTggr9uWjhMsRryQO9BxW1eAf03u/UpF7c2QM4B4
         AcRA==
X-Forwarded-Encrypted: i=1; AJvYcCVaKYv6PQzQyHdv2CdEIhV6m4YJ42fQiEWWoM3paEErTvcKmvuWe+PCtTsVryNnDuWJILPtYqxeY/xJ@vger.kernel.org
X-Gm-Message-State: AOJu0YycR4s0YYZwdSHdN3uOt42/1cVw5XxYfefeFg/Qr6ZITNVBFM3Y
	mSqT8ykwTbp2eu+jzgxlEZ6lXACGuyivaMuCZc9b73SyxNd6FQ3/I1B3Z3NE448=
X-Google-Smtp-Source: AGHT+IH9wVCtiNWpud5VecI+or3EQC2B6MQxmB4kaQPqUnITYluTDe+8K/OQr6CZCu9mmsY3lcLP0g==
X-Received: by 2002:a05:6a21:6f83:b0:1ca:edfc:8550 with SMTP id adf61e73a8af0-1cc8b59174dmr13599820637.38.1724764643822;
        Tue, 27 Aug 2024 06:17:23 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb? ([2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acabe0esm9315176a12.35.2024.08.27.06.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:17:23 -0700 (PDT)
Message-ID: <fd3cd385-131a-43b2-8ce9-05547a4f2d1d@linaro.org>
Date: Tue, 27 Aug 2024 10:17:18 -0300
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
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <ZszlGPqfrULzi3KG@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/08/24 17:27, Jason A. Donenfeld wrote:
> Hi Adhemerval,
> 
> Thanks for posting this! Exciting to have it here.
> 
> Just some small nits for now:
> 
> On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
>> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
>> +{
>> +	register long int x8 asm ("x8") = __NR_getrandom;
>> +	register long int x0 asm ("x0") = (long int) buffer;
>> +	register long int x1 asm ("x1") = (long int) len;
>> +	register long int x2 asm ("x2") = (long int) flags;
> 
> Usually it's written just as `long` or `unsigned long`, and likewise
> with the cast. Also, no space after the cast.

Ack.

> 
>> +#define __VDSO_RND_DATA_OFFSET  480
> 
> This is the size of the data currently there?

Yes, I used the same strategy x86 did.

> 
>>  #include <asm/page.h>
>>  #include <asm/vdso.h>
>>  #include <asm-generic/vmlinux.lds.h>
>> +#include <vdso/datapage.h>
>> +#include <asm/vdso/vsyscall.h>
> 
> Possible to keep the asm/ together?

Ack.

> 
>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
>> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
> 
> nonnce -> nonce

Ack.

> 
>> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
>>  SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>>  
>>  TEST_GEN_PROGS := vdso_test_gettimeofday
>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>  TEST_GEN_PROGS += vdso_standalone_test_x86
>>  endif
>>  TEST_GEN_PROGS += vdso_test_correctness
>> -ifeq ($(uname_M),x86_64)
>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
>>  TEST_GEN_PROGS += vdso_test_getrandom
>>  ifneq ($(SODIUM),)
>>  TEST_GEN_PROGS += vdso_test_chacha
> 
> You'll need to add the symlink to get the chacha selftest running:
> 
>   $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vdso
>   $ git add tools/arch/arm64/vdso
> 
> Also, can you confirm that the chacha selftest runs and works?

Yes, last time I has to built it manually since the Makefile machinery seem 
to be broken even on x86_64.  In a Ubuntu vm I have:

tools/testing/selftests/vDSO$ make
  CC       vdso_test_gettimeofday
  CC       vdso_test_getcpu
  CC       vdso_test_abi
  CC       vdso_test_clock_getres
  CC       vdso_standalone_test_x86
  CC       vdso_test_correctness
  CC       vdso_test_getrandom
  CC       vdso_test_chacha
In file included from /home/azanella/Projects/linux/linux-git/include/linux/limits.h:7,
                 from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
                 from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
                 from /usr/include/limits.h:195,
                 from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:205,
                 from /usr/lib/gcc/x86_64-linux-gnu/13/include/syslimits.h:7,
                 from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:34,
                 from /usr/include/sodium/export.h:7,
                 from /usr/include/sodium/crypto_stream_chacha20.h:14,
                 from vdso_test_chacha.c:6:
/usr/include/x86_64-linux-gnu/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
   99 | # if INT_MAX == 32767
      |      ^~~~~~~
/usr/include/x86_64-linux-gnu/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
  102 | #  if INT_MAX == 2147483647
      |       ^~~~~~~
/usr/include/x86_64-linux-gnu/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
  126 | # if LONG_MAX == 2147483647
      |      ^~~~~~~~
make: *** [../lib.mk:222: /home/azanella/Projects/linux/linux-git/tools/testing/selftests/vDSO/vdso_test_chacha] Error 1


I will try to figure out to be build it correctly, but I think it would be
better to vgetrandom-chacha.S with a different rule.

