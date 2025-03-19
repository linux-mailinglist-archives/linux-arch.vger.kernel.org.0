Return-Path: <linux-arch+bounces-10955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC09A68696
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 09:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2CC19C0F93
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C5E2512D3;
	Wed, 19 Mar 2025 08:20:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A53C250BF6;
	Wed, 19 Mar 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372406; cv=none; b=ny9fw6RmHy/pgwviwLs9LDxYKL8YYHB2XvZzOllM4ipdXUSw1UQGb7HaOcSEAefNCJMbR5HS0eLpi4vb1jyGRmJiyJGdP1hv3pRlmn+kJutOyU3XnFZFnrmMhn6igENy5KeCLNSihus0YpP0igameG5Fx4E9qi0iKYCMH/YKwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372406; c=relaxed/simple;
	bh=9OlvM4XUWWvrHJOd2iYbZSXPoeKrvur3cTL1QmV2LNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGPJqRUmdTHdWfAUsr7ntxP/W8arq3G/Iffg08MrASUp/VinXPonljuAYzkK09NwFa5LW256RcQKiQlbpa3nO9gVg/akVdb+kbdE6zGg2iHxeMZU/vNdIWv3DZnmvfggYrbvm7+1mN8FpBwV1uXHo4CO0bx/W3CS98Eh0Msc7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZHh8p3p47z9sSY;
	Wed, 19 Mar 2025 09:05:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Pdv_1f5SWZW; Wed, 19 Mar 2025 09:05:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZHh8p2Mb8z9sSX;
	Wed, 19 Mar 2025 09:05:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2617E8B78F;
	Wed, 19 Mar 2025 09:05:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id K6S1MuFrSThd; Wed, 19 Mar 2025 09:05:30 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 585CB8B763;
	Wed, 19 Mar 2025 09:05:28 +0100 (CET)
Message-ID: <a64bf821-ea90-4fd9-92ec-13bf7b7a3067@csgroup.eu>
Date: Wed, 19 Mar 2025 09:05:27 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] arm64: Add support for suppressing warning
 backtraces
To: Will Deacon <will@kernel.org>, Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Kees Cook <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>,
 David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard
 <mripard@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, Guenter Roeck <linux@roeck-us.net>,
 Alessandro Carminati <alessandro.carminati@gmail.com>,
 Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 loongarch@lists.linux.dev, x86@kernel.org,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-8-acarmina@redhat.com>
 <20250313122503.GA7438@willie-the-truck>
 <CAGegRW5r3V2-_44-X353vS-GZwDYG=SVwc6MzSGE8GdFQuFoKA@mail.gmail.com>
 <20250318155946.GC13829@willie-the-truck>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250318155946.GC13829@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/03/2025 à 16:59, Will Deacon a écrit :
> On Thu, Mar 13, 2025 at 05:40:59PM +0100, Alessandro Carminati wrote:
>> On Thu, Mar 13, 2025 at 1:25 PM Will Deacon <will@kernel.org> wrote:
>>>
>>> On Thu, Mar 13, 2025 at 11:43:22AM +0000, Alessandro Carminati wrote:
>>>> diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
>>>> index 28be048db3f6..044c5e24a17d 100644
>>>> --- a/arch/arm64/include/asm/bug.h
>>>> +++ b/arch/arm64/include/asm/bug.h
>>>> @@ -11,8 +11,14 @@
>>>>
>>>>   #include <asm/asm-bug.h>
>>>>
>>>> +#ifdef HAVE_BUG_FUNCTION
>>>> +# define __BUG_FUNC  __func__
>>>> +#else
>>>> +# define __BUG_FUNC  NULL
>>>> +#endif
>>>> +
>>>>   #define __BUG_FLAGS(flags)                           \
>>>> -     asm volatile (__stringify(ASM_BUG_FLAGS(flags)));
>>>> +     asm volatile (__stringify(ASM_BUG_FLAGS(flags, %c0)) : : "i" (__BUG_FUNC));
>>>
>>> Why is 'i' the right asm constraint to use here? It seems a bit odd to
>>> use that for a pointer.
>>
>> I received this code as legacy from a previous version.
>> In my review, I considered the case when HAVE_BUG_FUNCTION is defined:
>> Here, __BUG_FUNC is defined as __func__, which is the name of the
>> current function as a string literal.
>> Using the constraint "i" seems appropriate to me in this case.
>>
>> However, when HAVE_BUG_FUNCTION is not defined:
>> __BUG_FUNC is defined as NULL. Initially, I considered it literal 0,
>> but after investigating your concern, I found:
>>
>> ```
>> $ echo -E "#include <stdio.h>\n#include <stddef.h>\nint main()
>> {\nreturn 0;\n}" | aarch64-linux-gnu-gcc -E -dM - | grep NULL
>> #define NULL ((void *)0)
>> ```
>>
>> I realized that NULL is actually a pointer that is not a link time
>> symbol, and using the "i" constraint with NULL may result in undefined
>> behavior.
>>
>> Would the following alternative definition for __BUG_FUNC be more convincing?
>>
>> ```
>> #ifdef HAVE_BUG_FUNCTION
>>      #define __BUG_FUNC __func__
>> #else
>>      #define __BUG_FUNC (uintptr_t)0
>> #endif
>> ```
>> Let me know your thoughts.
> 
> Thanks for the analysis; I hadn't noticed this specific issue, it just
> smelled a bit fishy. Anyway, the diff above looks better, thanks.

That propably deserves a comment.

Doesn't sparse and/or checkpatch complain about 0 being used in lieu of 
NULL ?

By the way I had similar problem in the past with GCC not seeing NULL as 
a __builtin_constant_p(), refer commit 1d8f739b07bd ("powerpc/kuap: Fix 
set direction in allow/prevent_user_access()")

Christophe

