Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA70B33111A
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 15:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCHOlz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 09:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhCHOlu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 09:41:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4171BC06174A
        for <linux-arch@vger.kernel.org>; Mon,  8 Mar 2021 06:41:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j2so11707055wrx.9
        for <linux-arch@vger.kernel.org>; Mon, 08 Mar 2021 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7B7r2PIQsNLPhUBaGZox3quraAswSP5TnQzchYGCOUM=;
        b=qu5jtfWTr1ZQolUgTQLm1z8dITdB6EwY2PQSWLoQN4+pJEBx26DobIKS9tYvv5WB3n
         AZensSnEF9B7B8+AwA9WSqUUKOItJPYu4j0qEHpf2RB7yXQl2TrwqxtjJlvd0kJ0P/s+
         dbIJS2iQsQEo87nnl/XepAs81x9KczjunahnOfBv38d3s0rIgp0d7JIK9IcEYPKIHjkW
         Jk+eB9LgmIG2Wgc9aBk8F2jT1aBgJstvQajp9FU7iwhBszglAT452RVzY1WQpANw8B66
         UdsXpesD7n6zN8obaK8I3bTQMTEfc4i/yivS0eIrSr4ryIXFw7Jbz6bFK3pXoRvjGfd3
         wg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7B7r2PIQsNLPhUBaGZox3quraAswSP5TnQzchYGCOUM=;
        b=uiuG7wZ6ky6XNtDsZO7q13+irILnxKg9Cs+R/uu5T25zv2h7PyhWeM2M6GlmulfUfY
         zNNq619LH4fhGNrlI2khz6axzxAtGfuTes8qQ7GRMiXPl9mb7X1c+0SK0lu5qzzVFHwY
         E/TPbXHtFINHUsWk6wgqbyzuOmTouJoyJvdfsMezbsAVHAq8J8FBBzfcJI9mutoxm1SO
         duTA5guX9sPKoyp4VyN8wM3slf+cbEJTMCBJXqCGRYlUkSuq2npIbNTuN8orei4eVENR
         Isrg/o/LuufCV1bO0QSl8FlN2wSq6IiKHSRUnBj22+zFQgcBkoSB4bW8FDHjE7aYQsy3
         3D8A==
X-Gm-Message-State: AOAM530ThLEwtLsMh0fTb/1eBpiBhn6iznMME8kHpTPyJLgyDIJU5DWM
        WJ3uENnGF+eNWhn3L2pRERyGRw==
X-Google-Smtp-Source: ABdhPJzzBBYrgTqUI9n7R+h405kDWoEgTJNwWMNyi7MnyaNKNrv12/FN3yDTgHvgByszjgvF0a3eRQ==
X-Received: by 2002:a05:6000:1546:: with SMTP id 6mr22940925wry.398.1615214508819;
        Mon, 08 Mar 2021 06:41:48 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:60f3:8fc:7d4b:c2d9? ([2a01:e34:ed2f:f020:60f3:8fc:7d4b:c2d9])
        by smtp.googlemail.com with ESMTPSA id r10sm19761272wmh.45.2021.03.08.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 06:41:48 -0800 (PST)
Subject: Re: [PATCH v3 07/10] clocksource/drivers/hyper-v: Handle vDSO
 differences inline
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
 <1614721102-2241-8-git-send-email-mikelley@microsoft.com>
 <25234414-d905-0f9c-af92-9a9e4cde30c4@linaro.org>
 <MWHPR21MB1593EF82FC3C8B5F9D466E5BD7999@MWHPR21MB1593.namprd21.prod.outlook.com>
 <MWHPR21MB15933A79CB7C4552FEA6F583D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6dc5ed39-ab08-67fb-b528-26c3145bde0b@linaro.org>
Date:   Mon, 8 Mar 2021 15:41:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB15933A79CB7C4552FEA6F583D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/03/2021 14:49, Michael Kelley wrote:
> From: Michael Kelley <mikelley@microsoft.com> Sent: Tuesday, March 2, 2021 3:07 PM
>>
>> From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Tuesday, March 2, 2021 2:14 PM
>>>
>>> On 02/03/2021 22:38, Michael Kelley wrote:
>>>> While the driver for the Hyper-V Reference TSC and STIMERs is architecture
>>>> neutral, vDSO is implemented for x86/x64, but not for ARM64.  Current code
>>>> calls into utility functions under arch/x86 (and coming, under arch/arm64)
>>>> to handle the difference.
>>>>
>>>> Change this approach to handle the difference inline based on whether
>>>> VDSO_CLOCK_MODE_HVCLOCK is present.  The new approach removes code under
>>>> arch/* since the difference is tied more to the specifics of the Linux
>>>> implementation than to the architecture.
>>>>
>>>> No functional change.
>>>>
>>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>>>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>>> ---
>>>>  arch/x86/include/asm/mshyperv.h    |  4 ----
>>>>  drivers/clocksource/hyperv_timer.c | 10 ++++++++--
>>>>  2 files changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>>>> index c10dd1c..4f566db 100644
>>>> --- a/arch/x86/include/asm/mshyperv.h
>>>> +++ b/arch/x86/include/asm/mshyperv.h
>>>> @@ -27,10 +27,6 @@ static inline u64 hv_get_register(unsigned int reg)
>>>>  	return value;
>>>>  }
>>>>
>>>> -#define hv_set_clocksource_vdso(val) \
>>>> -	((val).vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK)
>>>> -#define hv_enable_vdso_clocksource() \
>>>> -	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
>>>>  #define hv_get_raw_timer() rdtsc_ordered()
>>>>
>>>>  /*
>>>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>>>> index c73c127..06984fa 100644
>>>> --- a/drivers/clocksource/hyperv_timer.c
>>>> +++ b/drivers/clocksource/hyperv_timer.c
>>>> @@ -370,11 +370,13 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>>>>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>>>>  }
>>>>
>>>> +#ifdef VDSO_CLOCKMODE_HVCLOCK
>>>>  static int hv_cs_enable(struct clocksource *cs)
>>>>  {
>>>> -	hv_enable_vdso_clocksource();
>>>> +	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
>>>>  	return 0;
>>>>  }
>>>> +#endif
>>>
>>> We had a confusion here. The suggestion was to remove the #ifdef here
>>> and add the __maybe_unused annotation to the function.
>>
>> I wondered if maybe that's what you were getting at with your
>> most recent comments.  But the code doesn't compile on ARM64
>> with __maybe_unused instead of the #ifdef because
>> VDSO_CLOCKMODE_HVCLOCK is undefined.
>>
>> Michael
>>
> 
> Daniel -- any additional comments/feedback?  Getting your Ack on
> this patch should be the last step to wrap up the patch series.

It would have been nice to simplify those #ifdef but I don't see a
straightforward change for that... :(

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
