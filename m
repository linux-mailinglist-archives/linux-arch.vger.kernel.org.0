Return-Path: <linux-arch+bounces-3222-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E01388E8AA
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 16:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC36290CF0
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD4D131BB7;
	Wed, 27 Mar 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+uLdb2H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5184A2A;
	Wed, 27 Mar 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552258; cv=none; b=Gt84/ybaXzp8ZA1eM7AJQ0W7TmmianZyFahfA/KfQ8Yy5uFty07dgRphXxbyZFLRXFIfJ+5rGstR/4Gut015vFr7SqlZun3iv0Fmy/0GvmXcKubnvvgcMt/yEF4kwhQtdLZQDm1KMgZJrT1Au1IuI3SPx695uLTE5VpxLpYLir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552258; c=relaxed/simple;
	bh=hZADyUy9JYJUx70kDvTSFdOct8TUW++G/hR/m5TbJ5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9D4Qfo6rKAGqd8LE7XF5F9yIYDspV6E2mg7LEm37hxFb6uGIo7sbpldFtQERJS2nw+aDPBrxgxGkYoXlBul1pt+oylRDE74GNBYzFkt6hA47LzE+e+36vuwdPw9YoJ//n/3q2Lf04TjW318mHvwhTMVNSTgQCu8nWUTAPN1cW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+uLdb2H; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so4670040b3a.2;
        Wed, 27 Mar 2024 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552255; x=1712157055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GhC1S2pW9btr9pVuDZELsqNgJuQdIsA6xlv8onmT65s=;
        b=i+uLdb2HWxyuVw5Db3DGWEk9UTq0u831fRAaB2ysl3AReUdwpgOmdJSI3NfmAjaLV3
         fTyL+m4fn+NLF3FbRspB/r630RmPsawW3kcHO43rIISjS3kbd+nAeY+VKu9cZv6d/k7m
         uOK8qtUg08v9Yl+cLpg10W3rftFrOmiRtY8pOAXmQwgr6o/j4qM8ZeWw46ptRvqh+8NK
         eka3CHtIKvAoL4PXYjG4RsqyAJ+osfJTq4IKwKmUQKc1JUMArzxtQ+bKn3L8dsXTb3rt
         ySIIWblJ4mubCcfXZmdUyGL5CHJ2uJeXMdNoIQXl04bPmBlTci/r7ymym73B4icqjtgB
         L3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552255; x=1712157055;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhC1S2pW9btr9pVuDZELsqNgJuQdIsA6xlv8onmT65s=;
        b=MXJzXQGbINSrOd0jrh7vcHD2mTq/I+jhGLBvaWnAcT7EdQUAlk1wgyhMEGdv9rOw2/
         bDYUA+7Tm0k4qM3+37ORS5kzDnfjBjrbqEdLcrW883eQfsqhmVZW0v2ps3jKuIaVw5hu
         u801y4DtvUEZKIJIwQf2aK3rz1khzr2n1c8vIk4DhE6/ETVAus1vxbFkTEy3KPTsFt1a
         31Mee5cGAVLOAawOJbyyE9TKGxCgM4meGEalK/9mIbMGlNdOYDnrWmAFUxbfx4dYy8er
         gG69s1TlMyHOXccKfKDmH7W5MnuaiH9Wu1gEQBqC3X2zRY61rhFOWGuMkdpYj1JCYVBo
         OLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpnzUcC5UQTlsfMkvZ1VUHfkeei8qR7u150mc2S2RgTEJybHqJ7yFZDxeq/4ZqZrOVI4Nc99Agy6yHL9CpYiIh5vbNbWRYwWZCnTZhfM7rkg4vXd9AO13NzZFm4/sNFhvrLtK+S5HBlTbIWk/vwC67FyPEqtExw29529uZQYrwFHUhol916KNNX994ecygkXEZ+jorwFWq6fCr0TYfnFYIKw58Q3+X6drBoEoFcFNXnlnar9b3HwzL1vWlEH5tpZvXUsakludCERBIId2bLab6ZsfHkN3DB+v9c3yro/3/dYEembAu/iMALJ9JWS8oVw==
X-Gm-Message-State: AOJu0Yw8W7WHi7TVqQIhNDTmQUv0WDfoFRXAmfC88VWaz5eA9nqxLifk
	b9Jv71yhmkwmKENAJaDxZ66ieazhBkxqTgNHCMcWvacCYnW1Wftz
X-Google-Smtp-Source: AGHT+IFTcwPFOlfI6eRT+0rf0ZnAMCTISb8ttH9tKFaraPJRt460mqVcAAiNBuFiDAxZrRyiWoSPIw==
X-Received: by 2002:a05:6a20:f39d:b0:1a0:adbc:7a96 with SMTP id qr29-20020a056a20f39d00b001a0adbc7a96mr225466pzb.36.1711552255375;
        Wed, 27 Mar 2024 08:10:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b006e4e616e520sm7950526pfh.72.2024.03.27.08.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 08:10:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <320aacc6-b7e5-4c3d-948e-d0743ab26c5d@roeck-us.net>
Date: Wed, 27 Mar 2024 08:10:51 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] sh: Add support for suppressing warning
 backtraces
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
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
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 Linux Kernel Functional Testing <lkft@linaro.org>
References: <20240325175248.1499046-1-linux@roeck-us.net>
 <20240325175248.1499046-13-linux@roeck-us.net>
 <20240327144431.GL403975@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240327144431.GL403975@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 07:44, Simon Horman wrote:
> On Mon, Mar 25, 2024 at 10:52:46AM -0700, Guenter Roeck wrote:
>> Add name of functions triggering warning backtraces to the __bug_table
>> object section to enable support for suppressing WARNING backtraces.
>>
>> To limit image size impact, the pointer to the function name is only added
>> to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
>> CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
>> parameter is replaced with a (dummy) NULL parameter to avoid an image size
>> increase due to unused __func__ entries (this is necessary because __func__
>> is not a define but a virtual variable).
>>
>> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> - Rebased to v6.9-rc1
>> - Added Tested-by:, Acked-by:, and Reviewed-by: tags
>> - Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
>>
>>   arch/sh/include/asm/bug.h | 26 ++++++++++++++++++++++----
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
>> index 05a485c4fabc..470ce6567d20 100644
>> --- a/arch/sh/include/asm/bug.h
>> +++ b/arch/sh/include/asm/bug.h
>> @@ -24,21 +24,36 @@
>>    * The offending file and line are encoded in the __bug_table section.
>>    */
>>   #ifdef CONFIG_DEBUG_BUGVERBOSE
>> +
>> +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
>> +# define HAVE_BUG_FUNCTION
>> +# define __BUG_FUNC_PTR	"\t.long %O2\n"
>> +#else
>> +# define __BUG_FUNC_PTR
>> +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
>> +
> 
> Hi Guenter,
> 
> a minor nit from my side: this change results in a Kernel doc warning.
> 
>       .../bug.h:29: warning: expecting prototype for _EMIT_BUG_ENTRY(). Prototype was for HAVE_BUG_FUNCTION() instead
> 
> Perhaps either the new code should be placed above the Kernel doc,
> or scripts/kernel-doc should be enhanced?
> 

Thanks a lot for the feedback.

The definition block needs to be inside CONFIG_DEBUG_BUGVERBOSE,
so it would be a bit odd to move it above the documentation
just to make kerneldoc happy. I am not really sure that to do
about it.

I'll wait for comments from others before making any changes.

Thanks,
Guenter

>>   #define _EMIT_BUG_ENTRY				\
>>   	"\t.pushsection __bug_table,\"aw\"\n"	\
>>   	"2:\t.long 1b, %O1\n"			\
>> -	"\t.short %O2, %O3\n"			\
>> -	"\t.org 2b+%O4\n"			\
>> +	__BUG_FUNC_PTR				\
>> +	"\t.short %O3, %O4\n"			\
>> +	"\t.org 2b+%O5\n"			\
>>   	"\t.popsection\n"
>>   #else
>>   #define _EMIT_BUG_ENTRY				\
>>   	"\t.pushsection __bug_table,\"aw\"\n"	\
>>   	"2:\t.long 1b\n"			\
>> -	"\t.short %O3\n"			\
>> -	"\t.org 2b+%O4\n"			\
>> +	"\t.short %O4\n"			\
>> +	"\t.org 2b+%O5\n"			\
>>   	"\t.popsection\n"
>>   #endif
>>   
>> +#ifdef HAVE_BUG_FUNCTION
>> +# define __BUG_FUNC	__func__
>> +#else
>> +# define __BUG_FUNC	NULL
>> +#endif
>> +
>>   #define BUG()						\
>>   do {							\
>>   	__asm__ __volatile__ (				\
> 
> ...


