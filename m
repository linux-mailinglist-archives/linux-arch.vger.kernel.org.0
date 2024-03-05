Return-Path: <linux-arch+bounces-2822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D902E872870
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 21:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B7DB2BB51
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 20:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD5512882E;
	Tue,  5 Mar 2024 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyStNYIa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5295C17BDC;
	Tue,  5 Mar 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669881; cv=none; b=ooxHAzupuagjH78U/yFHQRIuxx/4dISZZNXPLA5ZbGsQLOVasuZd4yLvNvSwmb/IQJjmCfvuukxmE5kF3ruy7odeOIOd8prvfTWJDToz+ufGjGyCXr7QJDNrnMFgHXk1escN8r6XViR+j412mNY9I/kmzPMnZSKTQwEfzOy9cX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669881; c=relaxed/simple;
	bh=6pEQdOMKnglEA7miuqAmY2L0CFdEnrgC3c/Lp1/D3p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbyRGHfZpKrOzZTznBnzXKufSbY18tpfBBrGGcIOKm2e0MPk95cnSmJT6PiITWnzPeRLYUBgbJKQZlFPV91ZbAXfhoOr8C4f9a53acvJarF1fOmmHhL36VWodOZh4+yJ39aaOUHZ3Wsz9AQwdA/P1XNau18qpm61KwiRvLvvHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyStNYIa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dba177c596so1066565ad.0;
        Tue, 05 Mar 2024 12:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709669880; x=1710274680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=u75UHgD7a/puwbE31XmdJlh2oHQkaeR2WPurDlkvFxs=;
        b=WyStNYIa3X6srKZCcikYEpIpeTB4DSAbxUD/45FrVL/NlHz42qslPxKFwCULkPIKsK
         ar97Ns3k+CC3bM5bKqqIZp7ez1YlBQJFIIs0c5TLTOW5BZLf0Ym4gTLQz5FlYVL5YXBQ
         lyWTzYFY2ouQtW/yXK5esCYE7gK/jer1Oj8yyscFJqi4Feh26iXig3IBQU1lSRJa8JjY
         yS0a10jViVwUCcvTJ1H/A8EuzktPuSK5iAYmAyCdsIAiOuchti1xCu02LG0VIUt84lBZ
         CuHnOTDD6Sxh5e0XMIaVKwln0C/oz6n86ms1mTsm1o0b5PcSMBx9rp9RSYE7y/QNu8WY
         epDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669880; x=1710274680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u75UHgD7a/puwbE31XmdJlh2oHQkaeR2WPurDlkvFxs=;
        b=QcKc6RxbxeqZmy0Gfnmj65hyETPtl81dvE7vM9C/sy7sHBWwcrQX/Fp3jTrBZqY5xw
         RjKyJO0yS6jv5MWZAPk/AH34xZshQe0t1+1QjIXXWEFq2a9DEXlhlAavIS4vP4TxeTBI
         LMleXCGVLUR2yKwxG0wnceib+J8pOJwIS4iUNLab57BuVsIVfcN1q4Tly3SVBn57wDjG
         cT8U7Y+AV8Qi69PXxUxVd2Ay0Ww325n3LhKDBeRVeL/T2Ksbq+4nAQhoxDirNM6o0pp4
         UXPDXaIrzKCPqHzBVU6nPsAc+Cjxu1B7z3z9UOYxLp0TeUcM9sg7zKopuK7QpuYv0LDo
         NlVA==
X-Forwarded-Encrypted: i=1; AJvYcCVmk3DRf4OZqnsNoqzNUXcivp8cW8QdgHRRrZq8j80Mq9/jLEy6suDbUBWovXlpRcQtt0sFNTIymyvJ4E4Y10Xd17rtX6vBLbTrjgqZ0EoyUa6sv1gDd/Y9ATEMmh3Zo7vO4P18BxAtmg==
X-Gm-Message-State: AOJu0YyCmsIf4aoHS949buiKVjXpAEItWYTDWD/f2dy+zw2d1fS82d+4
	wYoio8vXgatkpWm5HQvK5i6iiejIhNZShu5TKQ5T09LUssu1P85I
X-Google-Smtp-Source: AGHT+IEzppj7Rc6MwIEzr5vFBm31zeBZGSTf6g/BXEVWUWYDnqM35wjDu6BJVJP5wIMvV3ydNl0ICQ==
X-Received: by 2002:a17:902:e74a:b0:1dc:de7f:517e with SMTP id p10-20020a170902e74a00b001dcde7f517emr4239510plf.22.1709669879566;
        Tue, 05 Mar 2024 12:17:59 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001db2b8b2da7sm10893418plh.122.2024.03.05.12.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:17:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0f5d6a76-98dc-4cbb-9896-da4891f1de5f@roeck-us.net>
Date: Tue, 5 Mar 2024 12:17:55 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] bug: Core support for suppressing warning
 backtraces
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>,
 Arthur Grillo <arthurgrillo@riseup.net>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard
 <mripard@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
 linux-arch@vger.kernel.org
References: <20240305184033.425294-1-linux@roeck-us.net>
 <20240305184033.425294-2-linux@roeck-us.net>
 <202403051149.547235C794@keescook>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <202403051149.547235C794@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/24 11:54, Kees Cook wrote:
> On Tue, Mar 05, 2024 at 10:40:29AM -0800, Guenter Roeck wrote:
>> [...]
>>   	warning = (bug->flags & BUGFLAG_WARNING) != 0;
>>   	once = (bug->flags & BUGFLAG_ONCE) != 0;
>>   	done = (bug->flags & BUGFLAG_DONE) != 0;
>>   
>> +	if (warning && IS_SUPPRESSED_WARNING(function))
>> +		return BUG_TRAP_TYPE_WARN;
>> +
> 
> I had to re-read __report_bug() more carefully, but yes, this works --
> it's basically leaving early, like "once" does.
> 
> This looks like a reasonable approach!
> 
> Something very similar to this is checking that a warning happens. i.e.
> you talk about drm selftests checking function return values, but I've
> got a bunch of tests (LKDTM) that live outside of KUnit because I haven't
> had a clean way to check for specific warnings/bugs. I feel like future
> changes built on top of this series could add counters or something that
> KUnit could examine. E.g. I did this manually for some fortify tests:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/hardening&id=4ce615e798a752d4431fcc52960478906dec2f0e
> 

Sounds like a good idea. It should be straightforward to add a counter
to struct __suppressed_warning. This way the calling code could easily
check if an expected warning backtrace actually happened.

Thanks,
Guenter


