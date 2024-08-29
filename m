Return-Path: <linux-arch+bounces-6812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD3B964A25
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 17:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACDC1C230AF
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7DF1B2EF1;
	Thu, 29 Aug 2024 15:34:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1BF1B29B5;
	Thu, 29 Aug 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945698; cv=none; b=dZf3oQeXDlkYmDI9V/FHtPf1BwkY/ThFKgpZ9CFAD4IyXBymmL5o64bDNXTFIIy08Gm1bDKg3CKzJ3FCGOTlFvdT8YAhxSm0MeLGsc52lMX2KGuegYRIMu+cQ0zRH5wzHAnlqSsJfX4e1WoBSZOEpqOWmBcqrYb5cXq9kY65wIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945698; c=relaxed/simple;
	bh=Bm8wxKDl+oD7VrVzs48YkiSntz7eaaw4oQcAlH/HBWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkcYdmp4u5khs2px5BFsFYt980ET1VROYlX5KOOvi1UU1MrKz/XzQzfjGn9++/MVJfoCYXYKcB+MEgBu64lUPi2C0JcsE2wj+8OewPeUJ+GwmdYz90JanpWx40LLZc9q9cGwQC1N2KTyJKL17j29x0eqz2X8byxezv1cwwLBaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B77DA7;
	Thu, 29 Aug 2024 08:35:22 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BCA43F66E;
	Thu, 29 Aug 2024 08:34:54 -0700 (PDT)
Message-ID: <d0bcd439-0972-496a-8d77-bfbe10e0cd6a@arm.com>
Date: Thu, 29 Aug 2024 16:34:53 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
 <0085b19d-bb87-45bc-8a74-7464316f86a1@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <0085b19d-bb87-45bc-8a74-7464316f86a1@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


...


>>> Without linux/array_size.h:
>>>
>>>    VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
>>> In file included from <command-line>:
>>> /home/chleroy/linux-powerpc/lib/vdso/getrandom.c: In function
>>> '__cvdso_getrandom_data':
>>> /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:40: error: implicit
>> If this is the case, those headers should be defined for the powerpc
>> implementation only. The generic implementation should be interpreted as the
>> minimum common denominator in between all the architectures for what concerns
>> the headers.
>>
> 
> Sorry, I disagree. You can't rely on necessary headers being included indirectly
> by other arch specific headers. getrandom.c uses ARRAY_SIZE(), it must include
> the header that defines ARRAY_SIZE().
> 
> At the moment, on x86 you get linux/array.h by change through the following
> chain, that the reason why the build doesn't break:
> 
> In file included from ./include/linux/kernel.h:16,
>                  from ./include/linux/cpumask.h:11,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/vdso/gettimeofday.h:19,
>                  from ./include/vdso/datapage.h:164,
>                  from arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:9,
> 
> From my point of view you can't expect such a chain from each architecture.
> 

--->8---

> I can't see which header provides you with min_t() or ARRAY_SIZE().
>

Good point, this needs to be addressed by my patch, I will extend it, do some
more testing and post it again next week.

--->8---


As I explained in my other email (snippet above), my patch should address the
cases of ARRAY_SIZE() and min_t() which are directly used by getrandom.c. My
comment here refers to the cases not directly used by getrandom.c or the Generic
vDSO library more in general (if any).

Hope this clarifies.

> Christophe

-- 
Regards,
Vincenzo

