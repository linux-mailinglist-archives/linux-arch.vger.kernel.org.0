Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38D3954A1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 04:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfHTCvQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 22:51:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40866 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfHTCvQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 22:51:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so2397389pfn.7
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 19:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4MweJtv161U2CMaz91jtsrp2c+G77sFGRYDZ+W7nfdg=;
        b=fgruBeYmDYjHvLQHebmeva7fwnQHs0+/Z6wsXd5E3ryQtiaOB3/v1Iz3OfDQ8SOwoe
         d3JauzEDi3UztFk78Q4dniYiUurft7FSaOek7t8io4cuYwPejYYTnXeRvtpEJyfWTCeq
         +rH7S2J4LIelNMoN8PcIk3h6dYtqDDXtWpmIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4MweJtv161U2CMaz91jtsrp2c+G77sFGRYDZ+W7nfdg=;
        b=cxNPFar5htYT7LXynjy3YqD8i+5PORyyW+Hwk9y1cvtdUnHxkgPQBSRB5iFeQNy9Uw
         CNbL+UIGoyTLCOuRMjkCnZs9Onw5tz+Evn05503AuF+XiwE2EJe0+XZUc207JN6vbiaC
         zGGIDGVUzj1sqUVMT6r9wh5wAJRINh+H8G5InXaOPEy5rxSGSrBu8f8KYtJLlwNSWZP7
         DZtPRGdC3uK58xlnAJzrUL+REzhmAd8c7NBVioKAh2m7ONwwI1bkKe1VLmuNDKJh0x6L
         Qiu1UfshERBnzXPB7rdc6InWDluRHwhsYdi0WoyhMy3fjXyhbDosA9d0HKXllXyRee6U
         0HBw==
X-Gm-Message-State: APjAAAX+SKbDl1LQUveRRS6nPntk9/hxePu+ZHzCSckVpKgroxFUFUG+
        bL+KBIXfjGTeKelJTTKGcJO2vg==
X-Google-Smtp-Source: APXvYqxp2okAga8LhM46tOHeHFi51HcWAGlkDncJQeQqDjxa9iWdWKTGxCFmJEhCsVYUPYWdc37O/Q==
X-Received: by 2002:a63:f342:: with SMTP id t2mr21527124pgj.2.1566269475088;
        Mon, 19 Aug 2019 19:51:15 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id 203sm23555877pfz.107.2019.08.19.19.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 19:51:14 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     kasan-dev@googlegroups.com, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc: support KASAN instrumentation of bitops
In-Reply-To: <a1932e9e-3697-b8a0-c936-098b390b817f@c-s.fr>
References: <20190819062814.5315-1-dja@axtens.net> <20190819062814.5315-2-dja@axtens.net> <a1932e9e-3697-b8a0-c936-098b390b817f@c-s.fr>
Date:   Tue, 20 Aug 2019 12:51:10 +1000
Message-ID: <87d0h0tuqp.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 19/08/2019 =C3=A0 08:28, Daniel Axtens a =C3=A9crit=C2=A0:
>> In KASAN development I noticed that the powerpc-specific bitops
>> were not being picked up by the KASAN test suite.
>
> I'm not sure anybody cares about who noticed the problem. This sentence=20
> could be rephrased as:
>
> The powerpc-specific bitops are not being picked up by the KASAN test sui=
te.
>
>>=20
>> Instrumentation is done via the bitops/instrumented-{atomic,lock}.h
>> headers. They require that arch-specific versions of bitop functions
>> are renamed to arch_*. Do this renaming.
>>=20
>> For clear_bit_unlock_is_negative_byte, the current implementation
>> uses the PG_waiters constant. This works because it's a preprocessor
>> macro - so it's only actually evaluated in contexts where PG_waiters
>> is defined. With instrumentation however, it becomes a static inline
>> function, and all of a sudden we need the actual value of PG_waiters.
>> Because of the order of header includes, it's not available and we
>> fail to compile. Instead, manually specify that we care about bit 7.
>> This is still correct: bit 7 is the bit that would mark a negative
>> byte.
>>=20
>> Cc: Nicholas Piggin <npiggin@gmail.com> # clear_bit_unlock_negative_byte
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> Note that this patch might be an opportunity to replace all the=20
> '__inline__' by the standard 'inline' keyword.

New patches sent with these things fixed, thanks.=20
>
> Some () alignment to be fixes as well, see checkpatch warnings/checks at=
=20
> https://openpower.xyz/job/snowpatch/job/snowpatch-linux-checkpatch/8601//=
artifact/linux/checkpatch.log
>
>> ---
>>   arch/powerpc/include/asm/bitops.h | 31 +++++++++++++++++++------------
>>   1 file changed, 19 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/as=
m/bitops.h
>> index 603aed229af7..8615b2bc35fe 100644
>> --- a/arch/powerpc/include/asm/bitops.h
>> +++ b/arch/powerpc/include/asm/bitops.h
>> @@ -86,22 +86,22 @@ DEFINE_BITOP(clear_bits, andc, "")
>>   DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
>>   DEFINE_BITOP(change_bits, xor, "")
>>=20=20=20
>> -static __inline__ void set_bit(int nr, volatile unsigned long *addr)
>> +static __inline__ void arch_set_bit(int nr, volatile unsigned long *add=
r)
>>   {
>>   	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>>   }
>>=20=20=20
>> -static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
>> +static __inline__ void arch_clear_bit(int nr, volatile unsigned long *a=
ddr)
>>   {
>>   	clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>>   }
>>=20=20=20
>> -static __inline__ void clear_bit_unlock(int nr, volatile unsigned long =
*addr)
>> +static __inline__ void arch_clear_bit_unlock(int nr, volatile unsigned =
long *addr)
>>   {
>>   	clear_bits_unlock(BIT_MASK(nr), addr + BIT_WORD(nr));
>>   }
>>=20=20=20
>> -static __inline__ void change_bit(int nr, volatile unsigned long *addr)
>> +static __inline__ void arch_change_bit(int nr, volatile unsigned long *=
addr)
>>   {
>>   	change_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>>   }
>> @@ -138,26 +138,26 @@ DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMI=
C_ENTRY_BARRIER,
>>   DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
>>   	      PPC_ATOMIC_EXIT_BARRIER, 0)
>>=20=20=20
>> -static __inline__ int test_and_set_bit(unsigned long nr,
>> +static __inline__ int arch_test_and_set_bit(unsigned long nr,
>>   				       volatile unsigned long *addr)
>>   {
>>   	return test_and_set_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) !=3D 0;
>>   }
>>=20=20=20
>> -static __inline__ int test_and_set_bit_lock(unsigned long nr,
>> +static __inline__ int arch_test_and_set_bit_lock(unsigned long nr,
>>   				       volatile unsigned long *addr)
>>   {
>>   	return test_and_set_bits_lock(BIT_MASK(nr),
>>   				addr + BIT_WORD(nr)) !=3D 0;
>>   }
>>=20=20=20
>> -static __inline__ int test_and_clear_bit(unsigned long nr,
>> +static __inline__ int arch_test_and_clear_bit(unsigned long nr,
>>   					 volatile unsigned long *addr)
>>   {
>>   	return test_and_clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) !=3D 0;
>>   }
>>=20=20=20
>> -static __inline__ int test_and_change_bit(unsigned long nr,
>> +static __inline__ int arch_test_and_change_bit(unsigned long nr,
>>   					  volatile unsigned long *addr)
>>   {
>>   	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) !=3D 0;
>> @@ -185,15 +185,18 @@ static __inline__ unsigned long clear_bit_unlock_r=
eturn_word(int nr,
>>   	return old;
>>   }
>>=20=20=20
>> -/* This is a special function for mm/filemap.c */
>> -#define clear_bit_unlock_is_negative_byte(nr, addr)			\
>> -	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(PG_waiters))
>> +/*
>> + * This is a special function for mm/filemap.c
>> + * Bit 7 corresponds to PG_waiters.
>> + */
>> +#define arch_clear_bit_unlock_is_negative_byte(nr, addr)		\
>> +	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(7))
>>=20=20=20
>>   #endif /* CONFIG_PPC64 */
>>=20=20=20
>>   #include <asm-generic/bitops/non-atomic.h>
>>=20=20=20
>> -static __inline__ void __clear_bit_unlock(int nr, volatile unsigned lon=
g *addr)
>> +static __inline__ void arch___clear_bit_unlock(int nr, volatile unsigne=
d long *addr)
>>   {
>>   	__asm__ __volatile__(PPC_RELEASE_BARRIER "" ::: "memory");
>>   	__clear_bit(nr, addr);
>> @@ -239,6 +242,10 @@ unsigned long __arch_hweight64(__u64 w);
>>=20=20=20
>>   #include <asm-generic/bitops/find.h>
>>=20=20=20
>> +/* wrappers that deal with KASAN instrumentation */
>> +#include <asm-generic/bitops/instrumented-atomic.h>
>> +#include <asm-generic/bitops/instrumented-lock.h>
>> +
>>   /* Little-endian versions */
>>   #include <asm-generic/bitops/le.h>
>>=20=20=20
>>=20
