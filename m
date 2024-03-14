Return-Path: <linux-arch+bounces-3000-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E725087C025
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 16:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4421C20FF0
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FA571B40;
	Thu, 14 Mar 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvR9xwts"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937C51C3B;
	Thu, 14 Mar 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430167; cv=none; b=BsIHQ/s84aI8XJtRIAdmY7ekcinfboVqUHwUaAIc5zfeTdtHTJ4OE1wkW1vSpwODegrhQG4UQ0ndNm7/uIZzTp7Csi4qYDKxxQYZMGUVyNIPkVoS8mAsSCU3C9kZwTnId/ZsovwnL5rSUAqxCznFrTyBulvbqitquslcumzxRqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430167; c=relaxed/simple;
	bh=axzaJFZSKZfoX9OkhzkdxoizeN5X7Yl7arW8iAYQwcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q43GszfHE+oGNAk8A3r0K+i2shVK9E+zBq0VHy73iqUw82oPYzx97BzLDeGgl9w1lgS6k0bZc/bwqu+z5MZbrwNP+JQ/WHJYRCpO7JYakuHXTOeGUptBnE8g63a3x0e3IeUqrZX3YZ+td1GCIrCU7bB02/pHkilWi0n2CGwM+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvR9xwts; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso820261b3a.2;
        Thu, 14 Mar 2024 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710430165; x=1711034965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LY7692bTyayLkoksNBH6BmxzoRrgRDh0JILFH+Hu4mE=;
        b=SvR9xwtsyosXGni1zroqTcnys2O/S2vpJPRo5I7SEBRwk6F3veBDRUHWX36thr1OQN
         3NMFtQF7cr+h/fFyjm5ncr/Z3KFUuU3ql5pq2+nTa/XOhdUlzJCDiR2rOOObmn/LHCan
         Yhtl5YgSb1dEk32NC7zl+8U4oUQSr828s41G5XNcxtmQ8a47xdGUXZZQRgXRLRP3R5q6
         lC/A47Y2CVV0OwUYX0rVS9iuGzeKPGOTC6kf0Q2HJTRR+V8/AOZLlZZbdO9alStXFzZD
         a8eVchGgN+sqtrVI360RzDsE34Ir7Ll6bFAzysXPzxDjt6em+PZxJxtAdGS2YR5xF8Hq
         xXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430165; x=1711034965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LY7692bTyayLkoksNBH6BmxzoRrgRDh0JILFH+Hu4mE=;
        b=W1dhrrwZK5FfCPS5XG+ZZCERXA7S7+PSXt/J9MuDxd1qlOE0b2z1+sm6kozWKP4NtA
         UHRFKSfY2HErfby5BVMXAqZs5985jBZJml9g7g/dbzLcn5bpmJf06SB8ZQkD8EtlD4U8
         im8yBNE45TWW5rf++w8wdjR83Cy4mC94GfOW+2KmBLUHy1Z/fntss82qfD8Sxt94AHMV
         KsBz08QZIP94hcCL5glsfd4WBCjWqmN+a9UHOe912LOrg70+T/BVzGBqfuNkD7BThF0u
         ElXziHwv3ceEBWs0/Q7Chf2h9tV+GHWMbHGZ4rmAi07BVtWvJb5oZ0zFu660enx2Ysjc
         GvIw==
X-Forwarded-Encrypted: i=1; AJvYcCVSOk4fTl0kJgcMBrK2IUYeqtK16TObG0bp6Any4uXnM6Uvo6eFXlq9V1XreCt9s+i8iMSGN64GH9lq+E9TlGD7A0vQU4hoph+qVqeTHQfj+KwcwSwYA2svLwJ6+8/0uTBXykzWet+6BvwB1OwdTgaDfx3csmn+fkdqwORzfBJUumFpKXAJ52HKppPgwh2Ero6G7ej3ixBCkhBoBlzY7a+eUN9LdSJy0dxqIre3qKCwey7zIYG9oELz/eQBwg9sq94sgE8+B0Jwgzm+S4XDEKlGzSiEhUxqO78ANX5XIy3ISzUtU4Um/UxkUuiWbD+RaMsxud5S8I1BHg==
X-Gm-Message-State: AOJu0Yxz9Gz3dmrU62WNrcasronLgvRi8Tp54HGM/444v1ueTsAuI3j6
	KTA9GN0UJ5z5qbtmvf0szlKmygMznxHmehjY1lcR3BJIEtgigVyP
X-Google-Smtp-Source: AGHT+IEWwlqh10aaLXnz79mTPQ/n+RJWvWMKiaSxEVVrgfvkkAPUMESJkl3thWtTXScKP4Egfyd75w==
X-Received: by 2002:a17:903:1cf:b0:1dd:afa1:3094 with SMTP id e15-20020a17090301cf00b001ddafa13094mr2404810plh.36.1710430164855;
        Thu, 14 Mar 2024 08:29:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902f29200b001dee5da5f3dsm425201plc.100.2024.03.14.08.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:29:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3f43bbdf-7ad2-4ca8-ba06-e32876cc8e53@roeck-us.net>
Date: Thu, 14 Mar 2024 08:29:22 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Add support for suppressing warning backtraces
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Kees Cook <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>,
 David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, loongarch@lists.linux.dev, netdev@lists.linux.dev
References: <20240312170309.2546362-1-linux@roeck-us.net>
 <CAMuHMdUkvagJVEfnhq=Nx2jnmdS0Ax+zy1CvyN0k7k1EwUpu+g@mail.gmail.com>
 <6d9269c0-bd38-4965-a454-4358e0a182e3@roeck-us.net>
 <20240314-victorious-chupacabra-of-management-baa5c4@houat>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240314-victorious-chupacabra-of-management-baa5c4@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/24 08:02, Maxime Ripard wrote:
> On Thu, Mar 14, 2024 at 07:37:13AM -0700, Guenter Roeck wrote:
>> On 3/14/24 06:36, Geert Uytterhoeven wrote:
>>> Hi Günter,
>>>
>>> On Tue, Mar 12, 2024 at 6:03 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> Some unit tests intentionally trigger warning backtraces by passing bad
>>>> parameters to kernel API functions. Such unit tests typically check the
>>>> return value from such calls, not the existence of the warning backtrace.
>>>>
>>>> Such intentionally generated warning backtraces are neither desirable
>>>> nor useful for a number of reasons.
>>>> - They can result in overlooked real problems.
>>>> - A warning that suddenly starts to show up in unit tests needs to be
>>>>     investigated and has to be marked to be ignored, for example by
>>>>     adjusting filter scripts. Such filters are ad-hoc because there is
>>>>     no real standard format for warnings. On top of that, such filter
>>>>     scripts would require constant maintenance.
>>>>
>>>> One option to address problem would be to add messages such as "expected
>>>> warning backtraces start / end here" to the kernel log.  However, that
>>>> would again require filter scripts, it might result in missing real
>>>> problematic warning backtraces triggered while the test is running, and
>>>> the irrelevant backtrace(s) would still clog the kernel log.
>>>>
>>>> Solve the problem by providing a means to identify and suppress specific
>>>> warning backtraces while executing test code. Support suppressing multiple
>>>> backtraces while at the same time limiting changes to generic code to the
>>>> absolute minimum. Architecture specific changes are kept at minimum by
>>>> retaining function names only if both CONFIG_DEBUG_BUGVERBOSE and
>>>> CONFIG_KUNIT are enabled.
>>>>
>>>> The first patch of the series introduces the necessary infrastructure.
>>>> The second patch introduces support for counting suppressed backtraces.
>>>> This capability is used in patch three to implement unit tests.
>>>> Patch four documents the new API.
>>>> The next two patches add support for suppressing backtraces in drm_rect
>>>> and dev_addr_lists unit tests. These patches are intended to serve as
>>>> examples for the use of the functionality introduced with this series.
>>>> The remaining patches implement the necessary changes for all
>>>> architectures with GENERIC_BUG support.
>>>
>>> Thanks for your series!
>>>
>>> I gave it a try on m68k, just running backtrace-suppression-test,
>>> and that seems to work fine.
>>>
>>>> Design note:
>>>>     Function pointers are only added to the __bug_table section if both
>>>>     CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE are enabled to avoid image
>>>>     size increases if CONFIG_KUNIT=n. There would be some benefits to
>>>>     adding those pointers all the time (reduced complexity, ability to
>>>>     display function names in BUG/WARNING messages). That change, if
>>>>     desired, can be made later.
>>>
>>> Unfortunately this also increases kernel size in the CONFIG_KUNIT=m
>>> case (ca. 80 KiB for atari_defconfig), making it less attractive to have
>>> kunit and all tests enabled as modules in my standard kernel.
>>>
>>
>> Good point. Indeed, it does. I wanted to avoid adding a configuration option,
>> but maybe I should add it after all. How about something like this ?
>>
>> +config KUNIT_SUPPRESS_BACKTRACE
>> +       bool "KUnit - Enable backtrace suppression"
>> +       default y
>> +       help
>> +         Enable backtrace suppression for KUnit. If enabled, backtraces
>> +         generated intentionally by KUnit tests can be suppressed. Disable
>> +         to reduce kernel image size if image size is more important than
>> +         suppression of backtraces generated by KUnit tests.
>> +
> 
> How are tests using that API supposed to handle it then?
> 
> Select the config option or put an ifdef?
> 
> If the former, we end up in the same situation than without the symbol.
> If the latter, we end up in a similar situation than disabling KUNIT
> entirely, with some tests not being run which is just terrible.
> 

The API definitions are themselves within #ifdef and dummies if
KUNIT_SUPPRESS_BACKTRACE (currently CONFIG_KUNIT) is disabled.
In include/kunit/bug.h:

#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
...
#else
#define DEFINE_SUPPRESSED_WARNING(func)
#define START_SUPPRESSED_WARNING(func)
#define END_SUPPRESSED_WARNING(func)
#define IS_SUPPRESSED_WARNING(func) (false)
#define SUPPRESSED_WARNING_COUNT(func) (0)
#endif

Only difference to the current patch series would be

- #if IS_ENABLED(CONFIG_KUNIT)
+ #ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE

in that file and elsewhere.

With KUNIT_SUPPRESS_BACKTRACE=n you'd still get warning backtraces
triggered by the tests, but the number of tests executed as well
as the test results would still be the same.

Thanks,
Guenter


