Return-Path: <linux-arch+bounces-10928-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED31AA679E6
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 17:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F848817B4
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDD0210192;
	Tue, 18 Mar 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8FnYU5/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99D18EFD1;
	Tue, 18 Mar 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315981; cv=none; b=ulzw5neRKLq9M2mCzrscmkWeQQ1vEBFjz12Sgb44NxeJH7/l/0qCjNaRzsRMTG98bZOGg88BUQ9utzJxApTWqmXACqQb4vaqTXisoBd/YTKFgzaNPt/hCtZc1Mc5CMQdXfUA6m9hhBfeyUS6XjY8cx440j7o5KzznRd98R0QtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315981; c=relaxed/simple;
	bh=jE/6C5rGqrc0B9YcKKbdnAyiGvo6gzJX96tTS9sn92s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6yhoM2rODb/z1MhZEDCzOlA+EWVRQ1WsHaZjeQGs4IfDf/rcoG0QLhnjCCWt2/cZYj0moDhL8PPze5sK6ipqczY5VqxwpQzddn11/YgD7QH0x+y2gGuge6dqYBYA5R+MNOwJtwLZj6ouWpI0xhcNS0c0hgEk5J/x0wAZe2I1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8FnYU5/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225e3002dffso65077935ad.1;
        Tue, 18 Mar 2025 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742315979; x=1742920779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0OMo6kY73E1DUQ5n4WQl1+v1FiQJTXExWUjOORF3Lm0=;
        b=W8FnYU5/uE3ev6d6NL2edPu7kIk4/sipP0cHKMXLlfSVgQgq8hUbrmOYVQnsW/+tqg
         pJQX1kPM+/9R9vXpzyU1sHZs14xhxVlqCrfgpixPjsOG1zKHnVhlklIDI+6vDSFjXZkJ
         aZo03575yHqJNzzQpfhLczVK21N7BmPkR2y2vZ9Xm+GaBfEWTV4dxXAyVl7/N0Ppk4VJ
         FA8qwR/KeTnSLJa/Ti6M1adBWCRn/y2ZjWsXfbOckAXLImf4LY9X7ZZzZqFGtoWFxkfX
         5RH7Eb299Y5HqLhHjGxJQAlumAeg8P4yaDdXplXeo2xQyOgpR791MRx71qSZkwGjOL3S
         UY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315979; x=1742920779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OMo6kY73E1DUQ5n4WQl1+v1FiQJTXExWUjOORF3Lm0=;
        b=OwvKdO9Js0ch6DYTCTnmKbc16Np9IJcg3rm8iKxyrMgsQg7rIKo9gdXgaRXYctFSBy
         K4sqhfBxyyW5QrfCO75dVFriCV2talJPHEra/H5VwhzhsKCknOw1BeyDqdTS6ld9IIQL
         y1f1cxgy6uv4Fvt1jjtWoHxnoTos59LYSTkL5N44CiPLrRter/7da1EMfH2BzyeG+Q+j
         NWzjp35C4VAi2uF8bxTaHELMSCIN+ui+tfv8hiPY1xebcAK+hQZIL0Kq2CsbGIC+s/u9
         OqgtOEIP8YkAks8fEajNE7xLYM25hzeilpb8cF8L/5kplqabffU7DzfesPQZoix2HV5u
         /8qA==
X-Forwarded-Encrypted: i=1; AJvYcCU0w+kKU0e6wr36ic0By9JXny99R+/8OdklIO+3UyNKsLn1/1Ag5KOAaWSVIDUmX07B7+jVRMnLKJkt@vger.kernel.org, AJvYcCUEul8xpxhTxXvCmPDMAohCWPByI2kBVuNciIwavMO5Q7220l/nRehep4DhpULhYSWBW536U3bLfaM=@vger.kernel.org, AJvYcCW9Gdim/9C5GMh4S92Gz1aUcOvxLr+E4NhGV/TwUPPodq/j1nCnjKgQGVQdzPWEHpHKlBxa+676PyI3MPYZ@vger.kernel.org, AJvYcCWTZleaVlltuj/+PjP2qtBGcw0r1ElIyF9aUzj4j0VZRwIRVEyegegoJKGnHeGWdDWqlPsJctFK52Wi@vger.kernel.org, AJvYcCWhKDNo/E1RiCgJpLM1HuJ6CwuHqokMnC1sYWzzYmCtR/Taj+PEbcr3XGJHwNlubmWPReS5hYtac7kQUYam@vger.kernel.org, AJvYcCWtvbrPiude2a5bvqmQFd68KmniooYIeQNtLKJSXXgOf1f3L15KCoCLZESWijI+qo9jsnRENqw/TRGzMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrZyUdQpuw+PNqZerLQQ1D2dFBT6hBj7cEemGwbPO2qbY/mxj
	PdO6UlehGuHRuXweOYME9JtGF47rRkXVaRANNBeaP/9Wp1N0xI94
X-Gm-Gg: ASbGncuw2WPEkh4JkSHjgDV6u3H1tszIe3qVh1Tq6yZvGQ/N92De4r66FNsy+Opqbx5
	N70XB4vamyixTle564X2yi3xGd/AeMPFxpJ5CuvlwIl7svHrwMnlL5rhVf+ZqSBkzv+Ao7vAX7I
	3aUXWsvQDZdeqUmZmIjWFnTJMd7JHYB0b6BP8Hd10RcWeP6Och2swZKJsJimpssKWT+R3m0Rrxt
	YH2jV9EjQ2vR3UK5nKB/fkijCv60WIkbJNGP06Kx0nxcMiN4bWmk64CfomEu5GymMA557oZzajl
	W+uixxQFm3QJepWNvPoPJpyz2sGXc8SEVCLsbwlznvrWwzH3HQNE9q9LviXS2hZTJ1pXxq278gH
	EVX8yZMpVw4z/2DhtyQ==
X-Google-Smtp-Source: AGHT+IGE5m6c7zPdMBD4x7LWCETtpVBn2q4Mh4LJo0JYKNyDmFsLhMqkHIw+PJnwPR3g3D5sK0aeCQ==
X-Received: by 2002:a17:902:ea0c:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-2262c5383e0mr62696385ad.12.1742315979380;
        Tue, 18 Mar 2025 09:39:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa906sm97145285ad.88.2025.03.18.09.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:39:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <17a383b4-2add-4e74-b7ca-d7ef2baac4f9@roeck-us.net>
Date: Tue, 18 Mar 2025 09:39:35 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250318155946.GC13829@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/25 08:59, Will Deacon wrote:
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
> 

It has been a long time, but I seem to recall that I ran into trouble when
trying to use a different constraint.

Guenter


