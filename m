Return-Path: <linux-arch+bounces-3192-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4079788B99C
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 06:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D741C2D195
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 05:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961EB7352D;
	Tue, 26 Mar 2024 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB4MOcbz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44D73514;
	Tue, 26 Mar 2024 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711429361; cv=none; b=kClbWuiWgvHY0ORxPq5TtSF8R9SWSrG89TthBoX4Iow8V5E5M1SSJO0ye+qpgqKeeUKzEtKF+1v7vtRLvbBaCbPCdBocwMpxNjbHHxv0RT83V85w/eZfSuysBk6R5v7y59cZHMRcUkQ6cSPP1xLT9aQiBPiiDNMrCEndVQP7iKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711429361; c=relaxed/simple;
	bh=kLFdQikJ3pP/Ye1r7/bcEA6VEXSjRgAqw+Lz3/ACtKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCsp7CKgJirGiweLIJ8XLjo6Ax7TNTm51o89C6GwUWwhTILcxubs4Z6ekwG7U+stadmdbT56JyhpqioQTAeYsmSHgQ6yfRqGPETGawNWz+HMwG4PyhxxplZRlADVT6x/Df3mhbqhR13+3V0n5ymZH4O1muDfQsJYs7+122DEIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB4MOcbz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0d82d441bso8634785ad.3;
        Mon, 25 Mar 2024 22:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711429358; x=1712034158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nIhrywFoGE/FB0l12vjAjrM2buYxUGncKgITpiq2JlY=;
        b=GB4MOcbz9MMYmlU+kOFLPmeDJzXHuC8R/qU/v/nUlRdmb22V6xOFZE2avaNtEdyPCa
         debr9rX5j8HAIqliHiPn28L8di6b8mECzIM8kCXpj+HzlaeWkRlTJpL7pDWtLsfSpO1s
         +qyQ1JjRaS70xcZIUMoNccS4Vulpivm2HX2V/VnDBzXO4Rw07Vlz/7SgHAm7QsIm01Ye
         TF4edpxg0FmkKWt22V+SNckTPPBdVjl0VOeiuUjTW2vhHYT1VETogXM/9aR6a3Cr0SBg
         C7QDvRBCvcRXkMREn02QpHFnucHP20t4oPVZNZA/d5mFy9fcyuBPGIthGtkaMK2y3MPd
         YoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711429358; x=1712034158;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIhrywFoGE/FB0l12vjAjrM2buYxUGncKgITpiq2JlY=;
        b=ZrC0BzaRowVzsDFiICRdtwUctq8tnRxQ61lKPJ3qCs6i5FMEjRIg0JgokBltqcM/wx
         VKfZEqB7oHxukiwsEHTFjz0DoaDt9XCT0HmUMf0Insm/n8NPmwB2nN8zj19KgNghAaIy
         SxolG5WhBP0R9I6L4R8/WTbWUqlKhln0B/ChkoSz7aWFNKCosMTIzkr0jWcjJVkoQVRq
         L4C/OSWz29e3DCLqe14WqUQoZegevtEQw5z+UmFukRqJyVeajMNrKFJnAr9RNG7H7qso
         WWB1c9kLh9eU7Y7jL/o//0Ow44JYmsXaq+iWxhId5ce4pYKuk7Zp/pRVt/HWIGrB3dbv
         1NWA==
X-Forwarded-Encrypted: i=1; AJvYcCUGY+Ryn+zoyK7+XKacRpknyWime9SnyFszdTChVYsfq2fVLZEtOeXcVdnI/K8Ahuu5rj+F/Z8w26O1T0GwUIhHwysxw8b7G/h+yxdUqjM0MeZoS72oDoSywl93ZUIz4E+5lUsk8bDpQRaF8ePS4q74yvv3+XtGiuTZQPBiH9YtlEOmP3VYT8tNRfN6dSClm2jKatJKKIvFMWt/DduVFvIJ2AhmlUdGxGhojRcOgPSspyvijTuX4UsU4gu7CmHxLJtuqmIDlkpXvHSG9MQdVW1k9TQHHd6v1hp5ITmSdv5+lOFNjXDgQMz0r78vF6++1w==
X-Gm-Message-State: AOJu0Yz8CSE56DFTTgjMBF9PjNpazfti9Bs+0LU1NF3G2Gta6sXmzl+h
	/SaIeHKSPdjgzrBTmoDOTJyYSA/9r6sOO1/IVJFlIsU82MKRKRoA
X-Google-Smtp-Source: AGHT+IEcTHB/02f9HaB1tS0cP2ZsRx971NBiGwEGqHnjokk6umDjAiHMd//taF/o4xULvRj25jCExA==
X-Received: by 2002:a17:902:a586:b0:1e0:cd8a:581 with SMTP id az6-20020a170902a58600b001e0cd8a0581mr42211plb.23.1711429357721;
        Mon, 25 Mar 2024 22:02:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902690b00b001dd64048f78sm5700013plk.211.2024.03.25.22.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 22:02:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4799424e-8dfc-4848-8c4f-affedaec9dfe@roeck-us.net>
Date: Mon, 25 Mar 2024 22:02:33 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] drm: Suppress intentional warning backtraces in
 scaling unit tests
Content-Language: en-US
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Kees Cook <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>,
 David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard
 <mripard@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 Linux Kernel Functional Testing <lkft@linaro.org>
References: <20240325175248.1499046-1-linux@roeck-us.net>
 <20240325175248.1499046-6-linux@roeck-us.net>
 <0729b218-53f1-4139-b165-a324794a9abd@igalia.com>
 <e880828b-552e-488e-9f31-3989bec276ae@roeck-us.net>
 <7f6a223f-f432-4e1b-a67e-3816448224a1@igalia.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7f6a223f-f432-4e1b-a67e-3816448224a1@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/24 18:09, Maíra Canal wrote:
> On 3/25/24 16:24, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Mar 25, 2024 at 04:05:06PM -0300, Maíra Canal wrote:
>>> Hi Guenter,
>>>
>>> On 3/25/24 14:52, Guenter Roeck wrote:
>>>> The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
>>>> intentionally trigger warning backtraces by providing bad parameters to
>>>> the tested functions. What is tested is the return value, not the existence
>>>> of a warning backtrace. Suppress the backtraces to avoid clogging the
>>>> kernel log.
>>>>
>>>> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> - Rebased to v6.9-rc1
>>>> - Added Tested-by:, Acked-by:, and Reviewed-by: tags
>>>>
>>>>    drivers/gpu/drm/tests/drm_rect_test.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
>>>> index 76332cd2ead8..75614cb4deb5 100644
>>>> --- a/drivers/gpu/drm/tests/drm_rect_test.c
>>>> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
>>>> @@ -406,22 +406,28 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
>>>>    static void drm_test_rect_calc_hscale(struct kunit *test)
>>>>    {
>>>> +    DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
>>>>        const struct drm_rect_scale_case *params = test->param_value;
>>>>        int scaling_factor;
>>>> +    START_SUPPRESSED_WARNING(drm_calc_scale);
>>>
>>> I'm not sure if it is not that obvious only to me, but it would be nice
>>> to have a comment here, remembering that we provide bad parameters in
>>> some test cases.
>>
>> Sure. Something like this ?
>>
>>          /*
>>           * drm_rect_calc_hscale() generates a warning backtrace whenever bad
>>           * parameters are passed to it. This affects all unit tests with an
>>           * error code in expected_scaling_factor.
>>           */
>>
> 
> Yeah, perfect. With that, feel free to add my
> 
> Acked-by: Maíra Canal <mcanal@igalia.com>
> 

Thanks!
Guenter


