Return-Path: <linux-arch+bounces-2996-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C37687BE17
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 14:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F06285E6C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658C6EB79;
	Thu, 14 Mar 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7EJN+DR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5785D8F8;
	Thu, 14 Mar 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424478; cv=none; b=VxQwbX8LySOiWgdAQUcWP1T1GRTGCc+RnKkl6zV+eqy0RM+FOPKgFZeHCqPb8f59WjXUczRbuxuWGjJFVT+XB9omz4wAYh+NWPx3K2qTlL8SeAVSG6Yz5Ui57W1Kz20b2YtOxAvNCocOwDnfgKzNPP2Uk6m/YH0bw16lnKOXEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424478; c=relaxed/simple;
	bh=FNV5T9NIZtwTe7vw9OneotxdbKRbZTrJQVawh1BYalE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ve/jmCvGFjiUWTGjdSHETFGF2Ag1/v7+hjY6IrzWrBqbW9qDlsXQo1c2rTPfcxm6RqNAvq/osm9K6m3Vp1TYCQ4mLEEvovodZfa78/qMoB1Yj/5mDK+YKMc4S3YbozEl84deC511JMNMcjuhr024VjsUkuRM7GFlbkHqI6jqt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7EJN+DR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc09556599so7552825ad.1;
        Thu, 14 Mar 2024 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710424476; x=1711029276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VYCoE6x/5FFdiDNbW6/F39BZo8+6Gfyjcn8t3LZwS0o=;
        b=A7EJN+DRwst1iuoGfgDJhqxtHJOMVWAwe4dXYfIxhptr4KZ54TyfsPyJ72GZS/0KiT
         2D3FXO5ERcV8JbDi/NyYroLrucfJhpt/1DZZTtIPTC+yvT2XKbH3ArzAYycBS9TRoqlf
         dqPqI5Yc5h/Ffx76FFByVPe73lUr+Vnkw0KjjhX5R/GnmIKPwcNgGlvrlvMvF+6p2027
         2SfMxW8ppo19TbQrYOQkG8BuStkzFfIDOA0k9eQgX+qg91E5sKVEIKZBTFWllLRE2Bum
         Njnq//DmF/5AkYF0EpbvH2hAtjgCOlP5eofFxJ/IM2Q//hEDGYurwoJ1Lbip6eBgqJdt
         /Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424476; x=1711029276;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYCoE6x/5FFdiDNbW6/F39BZo8+6Gfyjcn8t3LZwS0o=;
        b=nohz5S2eFvlSN4uWI+9Vqe1qP2M5ZQRdHnu8y7jYPVPxkGUB/Xyj0tv4+w3jhm6FBP
         BAOoV3MBNcDD/W1x2Yts+trFFqvZ1Hn7i0Riyy9iZPOdnZHy4HJ/g/fbPX9K+683MDjg
         Bs5JuOk3yANDCP+QAWDoXXYQQ7jXCwqiSgYNavHSkDPMX3GBTloO+ohnqdDNeFBVgF4r
         bFB3zk7vr0BWI5y5YAfIf0BKwe9jv/MO49bhXlt69hWYKJAgrRnpbzUvdGDIYd8XlWpA
         0CmfYrfWPRugMjNnpb3UrKRvl3KBH++9dOv/KqBeyBVEOhW6hQD0RTSh3EszzRkXGtbC
         nvZA==
X-Forwarded-Encrypted: i=1; AJvYcCWythKINyjROHuBP517XfvcZxPueLzgpyajvUaxMdumNfP3wpTYFkmsoO/CRc6SgSGQpVps1WRZ4ykqDHHb8u+zakFoUtxOS9i4vOAxvaV9+sPq9A3T54EVRFhB5NY/SYMxYoSArIdHrqFKggic9rnGzl7+Zu0KenSiOgj8jvvMs0YMeSxekryiRFbWEsL0p0jxRhNphwEVtrXG6Ju0JWUBk7Pg9jwWV/MFhpL1o0P3MP1HnjKUo+vFel1wTCcZZnsx/a+fJ9Ixjy1voinLv8eFzxwNuMZYsQ==
X-Gm-Message-State: AOJu0YxfcUzQ0vD2YZuVb2Wlxpry/ffsTar9pgooFtcPFX2A+IrSL1I8
	ABM65eO9dq2Eq+7LJnJ8rORVFSvUyDTRKSlI/Es73KUkJMgcGf82XE0ZKMmw
X-Google-Smtp-Source: AGHT+IF1d/JjNvaUdlV4zt2IUW1FJQXeQEYCUkspAPTpUNljVFGhXPd+BPdq0X4tfzWPOphzi79Nzg==
X-Received: by 2002:a17:902:d2d0:b0:1dc:6d64:dcff with SMTP id n16-20020a170902d2d000b001dc6d64dcffmr41795plc.37.1710424476027;
        Thu, 14 Mar 2024 06:54:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001dd95b5dd0fsm1700430plg.69.2024.03.14.06.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:54:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a4229dee-8a4b-488d-99de-84ed255583a5@roeck-us.net>
Date: Thu, 14 Mar 2024 06:54:33 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] s390: Add support for suppressing warning
 backtraces
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 loongarch@lists.linux.dev, netdev@lists.linux.dev
References: <20240312170309.2546362-1-linux@roeck-us.net>
 <20240312170309.2546362-12-linux@roeck-us.net>
 <CAMuHMdXHKfd8agPGx+MjvC4cjW5F6DEeVec3Moe-=LLkrT3CXQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdXHKfd8agPGx+MjvC4cjW5F6DEeVec3Moe-=LLkrT3CXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/24 00:57, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Tue, Mar 12, 2024 at 6:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> Add name of functions triggering warning backtraces to the __bug_table
>> object section to enable support for suppressing WARNING backtraces.
>>
>> To limit image size impact, the pointer to the function name is only added
>> to the __bug_table section if both CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE
>> are enabled. Otherwise, the __func__ assembly parameter is replaced with a
>> (dummy) NULL parameter to avoid an image size increase due to unused
>> __func__ entries (this is necessary because __func__ is not a define but a
>> virtual variable).
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks for your patch!
> 
>> --- a/arch/s390/include/asm/bug.h
>> +++ b/arch/s390/include/asm/bug.h
>> @@ -8,19 +8,30 @@
>>
>>   #ifdef CONFIG_DEBUG_BUGVERBOSE
>>
>> +#if IS_ENABLED(CONFIG_KUNIT)
>> +# define HAVE_BUG_FUNCTION
>> +# define __BUG_FUNC_PTR        "       .long   %0-.\n"
>> +# define __BUG_FUNC    __func__
>> +#else
>> +# define __BUG_FUNC_PTR
>> +# define __BUG_FUNC    NULL
>> +#endif /* IS_ENABLED(CONFIG_KUNIT) */
>> +
>>   #define __EMIT_BUG(x) do {                                     \
>>          asm_inline volatile(                                    \
>>                  "0:     mc      0,0\n"                          \
>>                  ".section .rodata.str,\"aMS\",@progbits,1\n"    \
>>                  "1:     .asciz  \""__FILE__"\"\n"               \
>>                  ".previous\n"                                   \
>> -               ".section __bug_table,\"awM\",@progbits,%2\n"   \
>> +               ".section __bug_table,\"awM\",@progbits,%3\n"   \
> 
> This change conflicts with commit 3938490e78f443fb ("s390/bug:
> remove entry size from __bug_table section") in linus/master.
> I guess it should just be dropped?
> 

Yes, I know. I'll send v2 rebased to v6.9-rc1 once it is available and,
yes, the change will be gone after that.

Thanks,
Guenter



