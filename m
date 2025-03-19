Return-Path: <linux-arch+bounces-10957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F93A68D78
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 14:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36CD17A3C7E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30D255E4E;
	Wed, 19 Mar 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYkmuEQ8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AEF255241;
	Wed, 19 Mar 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389893; cv=none; b=IlN79BWTjoX6BI6ncao+GcXrBdePOiBqRfeqwzESJHzmsZobzr5E2IIhRiIubO4AAEqx7IBlcvm5zpD9mdi/hqJw7SxlarTiNx6tPbxLiQ7Sc6xJDK8xgct4aLOZxWr5ZTa+3i0t2+QsD1JXtULJEN2+UCZfKW4wW8ciFDWhWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389893; c=relaxed/simple;
	bh=7z2QeMdxOzSLIrBnl1x85KA6hGxJO1bQRKSWgGeuNPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHa+jktQsEXzH4jMyPE/5xwu7MuMEe0OYfXupnGA966KeJ55XvSCRWrqnyP+aj2fZ1i0vQ1zyDjlTdtIZLfQVJE6f40pVqVDK6M48OemE20c6pXJXtQCX9R4OJoqHSlFanhsnPODjFhW/vWm8Kc2QT8eIZpEBukLtItuQXVLCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYkmuEQ8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225b5448519so129846215ad.0;
        Wed, 19 Mar 2025 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742389891; x=1742994691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/CKiUxIsp+RiAjt+4CW+mXa9kqAZnMY4uY5XJZebADk=;
        b=lYkmuEQ8CEZI6JXXHtorSYZXxt9Ut2R1PEpbpXU1Ww2yK6p5GHOlJlZB4RBDPf29ch
         de58a79TsN2XlwmlFBZfCZluZPs5Ft/AMhqa9QshhjopFHGvbdkVHLjQ6+XZFD7mkxj1
         xctmlt9ytGKTOPSVa2fxu3diZrgr24rTYF6+Mexcu2YFCYpQ+zWEu4JyviJIa9lNTcB8
         JekgjqMyKsG3l1CEJv7ouUqK1sD0/BoxSoqPpGHqIw8lv9CeS8v2pitzP7N757+PjfWm
         /h6qBlHWZL8AIFf5fgikKy90L/dKv/ZDj4eLhOzj/OTSdIbsF/mL9ucIGfYVMlAqhu6i
         VaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742389891; x=1742994691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CKiUxIsp+RiAjt+4CW+mXa9kqAZnMY4uY5XJZebADk=;
        b=YhYSJOzUsDEsFmBReA2dq8toJtPImagDk+X/HyzvZ/xJxTTw53TO9nJhSLo06GS2KX
         tx5zHThJkli+hEC+B3LDD+Mhd1ruft5AU7KnagXbF1+twIFD4gpUFYuVcVwjwH9ViZnP
         akYomnB8oVIQTFPcL/HPfYujDPAxxh9DPZy86NLQ3KBsz8aKlcRAkmETvdR4UeBvIz8v
         qdsS9MPN1NP6zkVxSfcP2d20rc/1pPVKl3qP3hhTedCuWAzL2+4qb8yGXl/ixVnRx45Q
         +a498PTir8I/uln8fbMAhG747by/WrqKr9UVwS7K6pzbeuLg0xIGE3Tc/g3bCJIzcRPu
         C3yg==
X-Forwarded-Encrypted: i=1; AJvYcCU3gxdscukephkn1jklkrLZw5XU5OdxTb3szaAdztN/bN3yPsGcshgbf5rWbuNPtbIlnQeOIBAPZLQYW2li@vger.kernel.org, AJvYcCV6ZYrnkS9mh5kJGisEoLgdQUsVb3hs7RDLph4yFLerFpoSuf5FTyJ5n0eIdKGAVF1/HBWLjcSC6j8=@vger.kernel.org, AJvYcCVQL+VOhV0HUk7cj5ZYHBB+ZVbKG/CWdINS4ZluyFMtaf/XuMkJOpa1j9R6k2lqeYwlWdYIVyLzXUEpsA==@vger.kernel.org, AJvYcCVXqlgTOa57XG9b8zVX/9O+PYrAO6kN3k3DSePMy072kN/kmSv2wNGyLTKZT1JWFHnB1CrlS6zw7c2+@vger.kernel.org, AJvYcCWWegHkOdQRrEvN5eB7s7fQVvYrzjYDe7Ktfb1InySdtND6s8Yyg/pDkrlhwGgkHLdYzLixRz/0ZRLY@vger.kernel.org, AJvYcCXGy5RKjnjMhrLfgiCB7g5JPj6Z1Uulo+JLvnYo+ub4BtbTrEwwudIs5/WT2YPlL7CY92NahenKHTq4tyKC@vger.kernel.org
X-Gm-Message-State: AOJu0YzGzWgvjbfMCS8rF4v9kYtdMHOu0RIC6EhioanqjX9G3+zEM8Xf
	9b582tIQrmMf6C4ZPRmZdYbmn5fwjYFwIC4E4NFw7GLgYUPof3J5
X-Gm-Gg: ASbGncthkRo9Tl1Q6LAbVCLknRGZ9RDj7jS+QuSxacFSCbeof8NjpItztrt+yXqy/M+
	ZjAoMlm2Kwgub1nJmENJlDlntpzejKEUV1tWR3luOldphZPHWNebvsOaRST7C68NBkIBQVsYr6o
	LpBKIat0KvTh3eNWm0iexTY1msZ/YN7yIjOHSElWRfh6aulXBk6igmYH3s+5YFNudWksjdXq9hZ
	Pbd/KELj9zW7esswGfLfvm5J+z0Uxuds7GwNsTvYl3r8UC0jHTU1KB13MyaolTtYKSU4dHcnsA6
	FXCqSajhx0dKaeUN6JN9UG2Mfo6m4HNealyCVN79n/88aeEYMQH+DyNxXO3eJqm06adyA9xOpbL
	4HZpVygDeZI9x5rqE5A==
X-Google-Smtp-Source: AGHT+IEioVgtuSEfAYuAE8IAAYiDjsUn61PAgb/S9UQkSNM/19B6DRuSeEADVUHZxIm2XFZUlNalCg==
X-Received: by 2002:a05:6a21:6e48:b0:1f5:839e:ece8 with SMTP id adf61e73a8af0-1fbeb1854bcmr4348609637.2.1742389891204;
        Wed, 19 Mar 2025 06:11:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371157369bsm11469895b3a.75.2025.03.19.06.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 06:11:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9030a298-fcb6-48ea-a941-ad6916bf9fa7@roeck-us.net>
Date: Wed, 19 Mar 2025 06:11:28 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] arm64: Add support for suppressing warning
 backtraces
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Will Deacon <will@kernel.org>, Alessandro Carminati <acarmina@redhat.com>
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
 Thomas Zimmermann <tzimmermann@suse.de>,
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
 <a64bf821-ea90-4fd9-92ec-13bf7b7a3067@csgroup.eu>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <a64bf821-ea90-4fd9-92ec-13bf7b7a3067@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/19/25 01:05, Christophe Leroy wrote:
> 
> 
> Le 18/03/2025 à 16:59, Will Deacon a écrit :
>> On Thu, Mar 13, 2025 at 05:40:59PM +0100, Alessandro Carminati wrote:
>>> On Thu, Mar 13, 2025 at 1:25 PM Will Deacon <will@kernel.org> wrote:
>>>>
>>>> On Thu, Mar 13, 2025 at 11:43:22AM +0000, Alessandro Carminati wrote:
>>>>> diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
>>>>> index 28be048db3f6..044c5e24a17d 100644
>>>>> --- a/arch/arm64/include/asm/bug.h
>>>>> +++ b/arch/arm64/include/asm/bug.h
>>>>> @@ -11,8 +11,14 @@
>>>>>
>>>>>   #include <asm/asm-bug.h>
>>>>>
>>>>> +#ifdef HAVE_BUG_FUNCTION
>>>>> +# define __BUG_FUNC  __func__
>>>>> +#else
>>>>> +# define __BUG_FUNC  NULL
>>>>> +#endif
>>>>> +
>>>>>   #define __BUG_FLAGS(flags)                           \
>>>>> -     asm volatile (__stringify(ASM_BUG_FLAGS(flags)));
>>>>> +     asm volatile (__stringify(ASM_BUG_FLAGS(flags, %c0)) : : "i" (__BUG_FUNC));
>>>>
>>>> Why is 'i' the right asm constraint to use here? It seems a bit odd to
>>>> use that for a pointer.
>>>
>>> I received this code as legacy from a previous version.
>>> In my review, I considered the case when HAVE_BUG_FUNCTION is defined:
>>> Here, __BUG_FUNC is defined as __func__, which is the name of the
>>> current function as a string literal.
>>> Using the constraint "i" seems appropriate to me in this case.
>>>
>>> However, when HAVE_BUG_FUNCTION is not defined:
>>> __BUG_FUNC is defined as NULL. Initially, I considered it literal 0,
>>> but after investigating your concern, I found:
>>>
>>> ```
>>> $ echo -E "#include <stdio.h>\n#include <stddef.h>\nint main()
>>> {\nreturn 0;\n}" | aarch64-linux-gnu-gcc -E -dM - | grep NULL
>>> #define NULL ((void *)0)
>>> ```
>>>
>>> I realized that NULL is actually a pointer that is not a link time
>>> symbol, and using the "i" constraint with NULL may result in undefined
>>> behavior.
>>>
>>> Would the following alternative definition for __BUG_FUNC be more convincing?
>>>
>>> ```
>>> #ifdef HAVE_BUG_FUNCTION
>>>      #define __BUG_FUNC __func__
>>> #else
>>>      #define __BUG_FUNC (uintptr_t)0
>>> #endif
>>> ```
>>> Let me know your thoughts.
>>
>> Thanks for the analysis; I hadn't noticed this specific issue, it just
>> smelled a bit fishy. Anyway, the diff above looks better, thanks.
> 
> That propably deserves a comment.
> 
> Doesn't sparse and/or checkpatch complain about 0 being used in lieu of NULL ?
> 

__BUG_FUNC is only used as parameter to asm code, not as pointer.

 From the diff:

-                    : : "i" (__FILE__), "i" (__LINE__),                \
+                    : : "i" (__FILE__), "i" (__BUG_FUNC), "i" (__LINE__),\

The use is quite similar to __FILE__ and __LINE__. It might even be possible
and appropriate to just define __BUG_FUNC as 0 if HAVE_BUG_FUNCTION is not defined.

Guenter


