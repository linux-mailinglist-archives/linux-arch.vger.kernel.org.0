Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809C232B4A6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhCCFYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351022AbhCBNCk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Mar 2021 08:02:40 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A81C06178C
        for <linux-arch@vger.kernel.org>; Tue,  2 Mar 2021 05:01:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u14so19779794wri.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Mar 2021 05:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P88OLgbTkZUMP2F6RxCTDa3UqTL0DvJ/H4h2928AGS0=;
        b=cWjTZIrPmgrzCItY3GJ2Ad5+F80d27tfXG3ciPRPzu5yFPVx0DuMOJ37cHpyYZ6hJY
         bDEVAFAwTwf7RBXKlXP9N39xkM0HBhEDsLYqDtJHJG2P1tVspg4k6Ae4+Pbv5B6Inz5D
         0Qzy7aC3jLZtaOhaanSYazYjwRPcpLkbE33gFT6FhRPqhKsIgIeFzEawFp8gn5B775DU
         jWnUFkFXK8E1HGlAV+DVB4yXG7JKf0PdINk5QN1sBDFRrBmvtg69qPBc0vdxqeeh19IQ
         cRKtfemz2MsMUmQ0cueUIaghph4L+iiOg/wlhM2WPPOoEeWqh45c0GM6IK+McsGFomTA
         2Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P88OLgbTkZUMP2F6RxCTDa3UqTL0DvJ/H4h2928AGS0=;
        b=hJTAEn29jzk60Qi4VFHt4Sf/TxFXiHzADxqI6LHbLOphnmD1uXC+kOkIK9vzOOVVeW
         h2zAbD+oDi/hQMOgyH4o8k0T4kgTujAqyzcHPgPYopLFddatsZMauvipMq81WcHa6gjJ
         vm/QCOmG5GBXAln2+etNn2Tre4T37QzC/z34ZDaWYa1J078wsF7qe554OJgLiHtclWOC
         GpWL191qWU1eyZnuBLePkiT/fyWp9Dxk8bfkC1bd9ZAqMpqB+C5KXeKx0UaRRm9trKzu
         7ED6i+QWTwzNUD8huZ25MghTYXuEu1afdmOuVb9lM/iK0TS9s2D50wl7h+mBL+qZ/Z1H
         XMTg==
X-Gm-Message-State: AOAM532uy5QWA3Qark/jXhrJcYHaDaxo4WTLbUY5u24uqkjJ9aXtuvDr
        AtXO4wvy4ZAe/KL6m3h9ItWbGFr2O/d/lA==
X-Google-Smtp-Source: ABdhPJzcyra0YjUAPO03uOeDAoSsXQjMzgxxaxB1srNOV9k4reCns8wKKgldcU0WpK4ycDHxpC0Kgw==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr6833415wrp.303.1614690086136;
        Tue, 02 Mar 2021 05:01:26 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id 91sm5782778wrl.20.2021.03.02.05.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 05:01:25 -0800 (PST)
Subject: Re: [PATCH v2 07/10] clocksource/drivers/hyper-v: Handle vDSO
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
 <1614561332-2523-8-git-send-email-mikelley@microsoft.com>
 <42dc252a-b09a-afeb-6792-9b77669c16e9@linaro.org>
 <MWHPR21MB15930DD833E49415610C021DD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f09da965-aeda-7edf-722c-dbc9d7daab38@linaro.org>
Date:   Tue, 2 Mar 2021 14:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB15930DD833E49415610C021DD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/03/2021 02:29, Michael Kelley wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Monday, March 1, 2021 4:22 AM
>>
>> On 01/03/2021 02:15, Michael Kelley wrote:
>>> While the driver for the Hyper-V Reference TSC and STIMERs is architecture
>>> neutral, vDSO is implemented for x86/x64, but not for ARM64.  Current code
>>> calls into utility functions under arch/x86 (and coming, under arch/arm64)
>>> to handle the difference.
>>>
>>> Change this approach to handle the difference inline based on whether
>>> VDSO_CLOCK_MODE_HVCLOCK is present.  The new approach removes code under
>>> arch/* since the difference is tied more to the specifics of the Linux
>>> implementation than to the architecture.
>>>
>>> No functional change.
>>
>> A suggestion below
>>
>>
>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>> ---
>>>  arch/x86/include/asm/mshyperv.h    |  4 ----
>>>  drivers/clocksource/hyperv_timer.c | 10 ++++++++--
>>>  2 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>>> index c73c127..5e5e08aa 100644
>>> --- a/drivers/clocksource/hyperv_timer.c
>>> +++ b/drivers/clocksource/hyperv_timer.c
>>> @@ -372,7 +372,9 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>>>
>>>  static int hv_cs_enable(struct clocksource *cs)
>>
>> static __maybe_unused int hv_cs_enable(struct clocksource *cs)
>>
>>>  {
>>> -	hv_enable_vdso_clocksource();
>>> +#ifdef VDSO_CLOCKMODE_HVCLOCK
>>> +	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
>>> +#endif
>>>  	return 0;
>>>  }
>>>
>>> @@ -385,6 +387,11 @@ static int hv_cs_enable(struct clocksource *cs)
>>>  	.suspend= suspend_hv_clock_tsc,
>>>  	.resume	= resume_hv_clock_tsc,
>>>  	.enable = hv_cs_enable,
>>> +#ifdef VDSO_CLOCKMODE_HVCLOCK
>>> +	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
>>> +#else
>>> +	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
>>> +#endif
>>
>> #ifdef VDSO_CLOCKMODE_HVCLOCK
>> 	.enable = hv_cs_enable,
>> 	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
>> #else
>> 	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
>> #endif
>>
> 
> Is there any particular benefit (that I might not be recognizing)
> to having the .enable function be NULL vs. a function that
> does nothing?  I can see the handful of places where the
> .enable function is invoked, and there doesn't seem to be
> much difference.
> 
> In any case, I have no problem with making the change in
> a v3 of the patch set.

It is just coding style, it allows to remove a #ifdef in the code.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
