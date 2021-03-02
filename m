Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C286A32B4A8
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbhCCFYc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351192AbhCBNfM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Mar 2021 08:35:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E526DC06121F
        for <linux-arch@vger.kernel.org>; Tue,  2 Mar 2021 05:34:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o16so2770515wmh.0
        for <linux-arch@vger.kernel.org>; Tue, 02 Mar 2021 05:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZdRgbB/+xhU+BLrEYW5FodZNgcXrZTzEEyZSROXdiNs=;
        b=AYlTlq4uW3iRg29N/HN0EX4sWg7+Le02hNVo3M/Yt9O05X/IY8T6751/c1wmEoCY0L
         biLdWKDhwHXiyra5neWncvah9XDw0cZFZJYMMmR2gsOLFy14QaWJtQ2kIHUgb8mfRkSx
         /6LKYUXahNk7VB85kjvAsvXfx364A2h5uMQWfrZ6YMhc35f0NceLI5S+fQ1oG2z19JHa
         O9v7dj6PPis7ILJNbQNLncYb9BLabzUFOYX1exg4oixDpugNo8v9EqICPC1JiRgX2+JI
         VRU8jezhLwGk8aPjOVf05vtVleyBrItTHD93svBy/b403AaUGdbqIfMBVCDNNC9s8I/Q
         3q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZdRgbB/+xhU+BLrEYW5FodZNgcXrZTzEEyZSROXdiNs=;
        b=DYnaL4elrXAuxC2UEFPQguPN0finbmqUfnn9imDz8zg//RjSb1MRb0uoqtvodDFrRy
         dpuKpByKyEbzAbIbyfyuUeG6HJTt4txbIep07e8/XTn6Mz+8LVMB04WPPooLDiayZA/D
         JVirtle1XfryMiUCbFvfssP2W4AKByyGLLRCeEY//+tafvfNzN7+fMaIxHjH/VQqcbzB
         2q4D5DjmtuTKEybjGteVtPwGCp/W1yh6pSchDe3S0x/BxottlM1iJ9lvfZyeT7NpYatA
         c5JUYbh/C79ixM5qYOwQ1ui2ONEP7x/I1gfc2qVzfbzs/J4xRXZrsDB5Yipn9PTheHI2
         N42w==
X-Gm-Message-State: AOAM533Yzw1Rm12bDAOF/IYQ2/22NCfwiFLn7BCmVKzmXs83wMf96GB8
        y8sNQ2ZvWtPSmD5gqWHjtN6LbAhcZdOKCw==
X-Google-Smtp-Source: ABdhPJyD6nClABQXADENbFNrOJPev1ANCgFMGR64xibMhC4BJsr7IRE+y2o+qXFj/OTvruUkwmPhYg==
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr4092039wmj.46.1614692054679;
        Tue, 02 Mar 2021 05:34:14 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id w18sm2428636wrr.7.2021.03.02.05.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 05:34:14 -0800 (PST)
Subject: Re: [PATCH v2 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
To:     Michael Kelley <mikelley@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-9-git-send-email-mikelley@microsoft.com>
 <2c320759-4e0e-752f-f3e8-7594cc1d544f@linaro.org>
 <MWHPR21MB1593812919AF130E61C2A1CFD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6c0b3487-5f99-764c-6dc7-70454916cd57@linaro.org>
Date:   Tue, 2 Mar 2021 14:34:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593812919AF130E61C2A1CFD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/03/2021 02:38, Michael Kelley wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Monday, March 1, 2021 6:25 AM
>>
>> On 01/03/2021 02:15, Michael Kelley wrote:
>>> While the Hyper-V Reference TSC code is architecture neutral, the
>>> pv_ops.time.sched_clock() function is implemented for x86/x64, but not
>>> for ARM64. Current code calls a utility function under arch/x86 (and
>>> coming, under arch/arm64) to handle the difference.
>>>
>>> Change this approach to handle the difference inline based on whether
>>> GENERIC_SCHED_CLOCK is present.  The new approach removes code under
>>> arch/* since the difference is tied more to the specifics of the Linux
>>> implementation than to the architecture.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>> ---
>>
>> [ ... ]
>>
>>> +/*
>>> + * Reference to pv_ops must be inline so objtool
>>> + * detection of noinstr violations can work correctly.
>>> + */
>>> +static __always_inline void hv_setup_sched_clock(void *sched_clock)
>>> +{
>>> +#ifdef CONFIG_GENERIC_SCHED_CLOCK
>>> +	/*
>>> +	 * We're on an architecture with generic sched clock (not x86/x64).
>>> +	 * The Hyper-V sched clock read function returns nanoseconds, not
>>> +	 * the normal 100ns units of the Hyper-V synthetic clock.
>>> +	 */
>>> +	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
>>> +#else
>>> +#ifdef CONFIG_PARAVIRT
>>> +	/* We're on x86/x64 *and* using PV ops */
>>> +	pv_ops.time.sched_clock = sched_clock;
>>> +#endif
>>> +#endif
>>> +}
>> Please refer to:
>>
>> Documentation/process/coding-style.rst
>>
>> Section 21)
>>
>> [ ... ]
>>
>> Prefer to compile out entire functions, rather than portions of
>> functions or portions of expressions.
>>
>> [ ... ]
>>
> 
> OK.  I'll rework the #ifdef in v3 of the patch set.  Is the following
> the preferred approach?

Yes but with an indentation and comment to describe the section end.

eg.

#ifdef A
#else
# ifdef B
...
# else
# endif /* B */
#endif /* A */

> #ifdef CONFIG_GENERIC_SCHED_CLOCK
> static __always_inline void hv_setup_sched_clock(void *sched_clock)
> {
> 	sched_clock_register(sched_clock, 64 NSEC_PER_SEC);
> }
> #else
> #ifdef CONFIG_PARAVIRT
> static __always_inline void hv_setup_sched_clock(void *sched_clock)
> {
> 	pv_ops.time.sched_clock = sched_clock:
> }
> #else
> static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
> #endif
> #endif

Or

#ifdef CONFIG_GENERIC_SCHED_CLOCK
...
#elif defined CONFIG_PARAVIRT
...
#else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
...
#endif /* CONFIG_GENERIC_SCHED_CLOCK */



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
