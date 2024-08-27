Return-Path: <linux-arch+bounces-6657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1989607D0
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 12:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D45D282E00
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A319DF9F;
	Tue, 27 Aug 2024 10:49:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AA19DF86;
	Tue, 27 Aug 2024 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755788; cv=none; b=nSjfMacxXr9BXE+kBzddUSoBEcwWJ3knVCZXDLFIyaXqzrkfQkjx4vE1r9lVERdV3NcEXLZDFDtSjQ/9jvh3Q/2kd2s0lMaIdFpwuy5nsxb/2bNmI78WE5vjI5BFblUezIRAzCjgEmSNnKQcNy60b25IsVGqheuORKuXYh5G0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755788; c=relaxed/simple;
	bh=ZDJ7fs2o1CiKem7XmOHuYWruR8Ul0RGs3Vo7u7isH4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLOqFu3OPWf6qI5Ofs6NkUqvNWl2a4iGpI71QwdDPdoDy/xUgKoLu4LkMF9QhjXRrZwGxzJHhYa9Uvu6oaVIa3tWr8qqvuVDRVC7h/c+zmPufFAF1lArmRJFVpmMwphPotIn36Gw00lBDv8WBTNbhgoIpq3ZFwaXVSHiYOIhoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtPSS2j9wz9sPd;
	Tue, 27 Aug 2024 12:49:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t6VbwRGJyrl0; Tue, 27 Aug 2024 12:49:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtPSS1j1pz9rvV;
	Tue, 27 Aug 2024 12:49:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 277298B783;
	Tue, 27 Aug 2024 12:49:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id upuflTr8zwv6; Tue, 27 Aug 2024 12:49:44 +0200 (CEST)
Received: from [192.168.233.149] (unknown [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C5778B77C;
	Tue, 27 Aug 2024 12:49:43 +0200 (CEST)
Message-ID: <0f9255f1-5860-408c-8eaa-ccb4dd3747fa@csgroup.eu>
Date: Tue, 27 Aug 2024 12:49:43 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
To: Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Linux-Arch <linux-arch@vger.kernel.org>
References: <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>
 <Zs2RCfMgfNu_2vos@zx2c4.com>
 <cb66b582-ba63-4a5a-9df8-b07288f1f66d@app.fastmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <cb66b582-ba63-4a5a-9df8-b07288f1f66d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/08/2024 à 11:59, Arnd Bergmann a écrit :
> On Tue, Aug 27, 2024, at 10:40, Jason A. Donenfeld wrote:
>> I don't love this, but it might be the lesser of evils, so sure, let's
>> do it.
>>
>> I think I'll combine these header fixups so that the whole operation is
>> a bit more clear. The commit is still pretty small. Something like
>> below:
>>
>>  From 0d9a3d68cd6222395a605abd0ac625c41d4cabfa Mon Sep 17 00:00:00 2001
>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Date: Tue, 27 Aug 2024 09:31:47 +0200
>> Subject: [PATCH] random: vDSO: clean header inclusion in getrandom
>>
>> Depending on the architecture, building a 32-bit vDSO on a 64-bit kernel
>> is problematic when some system headers are included.
>>
>> Minimise the amount of headers by moving needed items, such as
>> __{get,put}_unaligned_t, into dedicated common headers and in general
>> use more specific headers, similar to what was done in commit
>> 8165b57bca21 ("linux/const.h: Extract common header for vDSO") and
>> commit 8c59ab839f52 ("lib/vdso: Enable common headers").
>>
>> On some architectures this results in missing PAGE_SIZE, as was
>> described by commit 8b3843ae3634 ("vdso/datapage: Quick fix - use
>> asm/page-def.h for ARM64"), so define this if necessary, in the same way
>> as done prior by commit cffaefd15a8f ("vdso: Use CONFIG_PAGE_SHIFT in
>> vdso/datapage.h").
>>
>> Removing linux/time64.h leads to missing 'struct timespec64' in
>> x86's asm/pvclock.h. Add a forward declaration of that struct in
>> that file.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> This is clearly better, but there are still a couple of inaccuracies
> that may end up biting us again later. Not sure whether it's worth
> trying to fix it all at once or if we want to address them when that
> happens:
> 
>>   #include <linux/array_size.h>
>> -#include <linux/cache.h>
>> -#include <linux/kernel.h>
>> -#include <linux/time64.h>
>> +#include <linux/minmax.h>
> 
> These are still two headers outside of the vdso/ namespace. For arm64
> we had concluded that this is never safe, and any vdso header should
> only include other vdso headers so we never pull in anything that
> e.g. depends on memory management headers that are in turn broken
> for the compat vdso.
> 
> The array_size.h header is really small, so that one could
> probably just be moved into the vdso/ namespace. The minmax.h
> header is already rather complex, so it may be better to just
> open-code the usage of MIN/MAX where needed?

It is used at two places only so yes can to that.

Same for ARRAY_SIZE(->reserved) by the way, easy to do opencode, we also 
have it only once


> 
>>   #include <vdso/datapage.h>
>>   #include <vdso/getrandom.h>
>> +#include <vdso/unaligned.h>
>>   #include <asm/vdso/getrandom.h>
>> -#include <asm/vdso/vsyscall.h>
>> -#include <asm/unaligned.h>
>>   #include <uapi/linux/mman.h>
>> +#include <uapi/linux/random.h>
>> +
>> +#undef PAGE_SIZE
>> +#undef PAGE_MASK
>> +#define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
>> +#define PAGE_MASK (~(PAGE_SIZE - 1))
> 
> Since these are now the same across all architectures, maybe we
> can just have the PAGE_SIZE definitions a vdso header instead
> and include that from asm/page.h.

I gave it a quick look yesterday, there are still some subtleties 
between architectures.

For instance, most architectures use 1UL for the shift but powerpc use 1 
and has the following comment:

/*
  * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
  * assign PAGE_MASK to a larger type it gets extended the way we want
  * (i.e. with 1s in the high bits)
  */

So we'll have to look at all this carefully when we want something 
common, or am I missing something ?

> 
> Including uapi/linux/mman.h may still be problematic on
> some architectures if they change it in a way that is
> incompatible with compat vdso, but at least that can't
> accidentally rely on CONFIG_64BIT or something else that
> would be wrong there.

Yes that one is tricky. Because uapi/linux/mman.h includes asm/mman.h 
with the intention to include uapi/asm/mman.h but when built from the 
kernel in reality you get arch/powerpc/include/asm/mman.h and I had to 
add some ifdefery to kick-out kernel oddities it contains that pull 
additional kernel headers.

diff --git a/arch/powerpc/include/asm/mman.h 
b/arch/powerpc/include/asm/mman.h
index 17a77d47ed6d..42a51a993d94 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -6,7 +6,7 @@

  #include <uapi/asm/mman.h>

-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) && !defined(BUILD_VDSO)

  #include <asm/cputable.h>
  #include <linux/mm.h>


Christophe

