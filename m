Return-Path: <linux-arch+bounces-7111-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0619296F34D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 13:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319FD1C22A59
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA761CBE9A;
	Fri,  6 Sep 2024 11:42:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AD11CB338;
	Fri,  6 Sep 2024 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622928; cv=none; b=W7UFl+1MSaP8oPqB22bChjwv9xPTJVAtpaxjCFToKWtf6rmm+BuDkrr6zfRPq08yZCwhiwq5LbThyWvjHJWqdrkqRScz4Dv0UIEyVpPPEVLXSrUuUbVbkhFUC0cag9xxAIRWtdRdB+tgPVwV9hBJiiVsN83V3sTL5SghEXJcpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622928; c=relaxed/simple;
	bh=n79CBpFhVYSTVoBciUCHzjp+ivBLUAqIR/JPy8AxHVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bovt1Jq9V+IuZ3k62M37kGQp/GjgPv0IohmTcF2BIV02oHZbuCsZNjWXOp5ffFuE2B3gFuRVPyELxMPAVuAxpx1qUqpdFaDIviOEjlFaNQT8uLc0md416Q5GVnS1W7Qaas4FYxMEMmLzGK2vUihZYg+8jQimKZVtl0t+nkqilp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69335113E;
	Fri,  6 Sep 2024 04:42:33 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B34953F836;
	Fri,  6 Sep 2024 04:42:03 -0700 (PDT)
Message-ID: <7490988c-734f-4bfd-9756-a1356bb8b18e@arm.com>
Date: Fri, 6 Sep 2024 12:42:02 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] vdso: Split linux/array_size.h
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-7-vincenzo.frascino@arm.com>
 <8fbb8fed-e8d4-475c-8093-373d0afb62cc@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <8fbb8fed-e8d4-475c-8093-373d0afb62cc@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/09/2024 18:18, Christophe Leroy wrote:
> 
> 
> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
>> The VDSO implementation includes headers from outside of the
>> vdso/ namespace.
>>
>> Split linux/array_size.h to make sure that the generic library
>> uses only the allowed namespace.
> 
> There is only one place using ARRAY_SIZE(x), can be open coded as
> sizeof(x)/sizeof(*x) instead.
> 

Agreed, as per previous comment on MIN()/MAX(). I will refactor my code accordingly.

> Christophe
> 
>>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>   include/linux/array_size.h |  8 +-------
>>   include/vdso/array_size.h  | 13 +++++++++++++
>>   2 files changed, 14 insertions(+), 7 deletions(-)
>>   create mode 100644 include/vdso/array_size.h
>>
>> diff --git a/include/linux/array_size.h b/include/linux/array_size.h
>> index 06d7d83196ca..ca9e63b419c4 100644
>> --- a/include/linux/array_size.h
>> +++ b/include/linux/array_size.h
>> @@ -2,12 +2,6 @@
>>   #ifndef _LINUX_ARRAY_SIZE_H
>>   #define _LINUX_ARRAY_SIZE_H
>>   -#include <linux/compiler.h>
>> -
>> -/**
>> - * ARRAY_SIZE - get the number of elements in array @arr
>> - * @arr: array to be sized
>> - */
>> -#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>> +#include <vdso/array_size.h>
>>     #endif  /* _LINUX_ARRAY_SIZE_H */
>> diff --git a/include/vdso/array_size.h b/include/vdso/array_size.h
>> new file mode 100644
>> index 000000000000..4079f7a5f86e
>> --- /dev/null
>> +++ b/include/vdso/array_size.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _VDSO_ARRAY_SIZE_H
>> +#define _VDSO_ARRAY_SIZE_H
>> +
>> +#include <linux/compiler.h>
>> +
>> +/**
>> + * ARRAY_SIZE - get the number of elements in array @arr
>> + * @arr: array to be sized
>> + */
>> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>> +
>> +#endif  /* _VDSO_ARRAY_SIZE_H */

-- 
Regards,
Vincenzo

