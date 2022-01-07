Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538E2487810
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347510AbiAGNP4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jan 2022 08:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiAGNP4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jan 2022 08:15:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01287C061212
        for <linux-arch@vger.kernel.org>; Fri,  7 Jan 2022 05:15:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e5so3894257wmq.1
        for <linux-arch@vger.kernel.org>; Fri, 07 Jan 2022 05:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VkR7BTBuYolNplyfmZPpWt062c+R++SOe8lOMyFDxzA=;
        b=TSI1Uo5IqQWt41egEUQOWD2ZOVg8WW2OdrwdJxsisNTy3dNplBALo1z28jPuv7Nhof
         VB4+QmLi+PFoPvgpa7lXMVy4mqbV9XNuqVtNmquqYFQXJdzo3vR/DGAUoQdWHJ93sZOe
         serITN14TGSsrRISIe18MbEZ3KOSgqZu0RgP53RzSfIcRFpAEmJmnDXNcfZuyIHDfKGk
         g1S9wLVJC/smAs4RcUS6zMJRYTbi6ra0bBpF7gW9RrSzBU2Q9QDzYb6FGVK7JM1aZvbT
         LGKuZ4ta/m8WtJv0KLBaa0B3uSZejAyocp/63t1XALX/sx81FSk9ulGGSOkyirrR775+
         Hwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VkR7BTBuYolNplyfmZPpWt062c+R++SOe8lOMyFDxzA=;
        b=mjX2VQ5ylsCropHg23Q2bYjGfFo18iOnjeL7WOxAlq3YDBdJFf/vrUN6LP4/E5AGqc
         EvjY3JtmvixVy23rB/zhh1Dzi9+s8nymoVzzTabS4C/x0kzsrEHaWg02ZDjpCsgNSW2b
         RwxvUXnhMjHijwcY6VuO8SVopcOVN00Kz6L+NyPJ2rEel7oFFjPWCsknjk1TTdPE0x3q
         Fy9iVQzbWWIjL4aBEH8FB4h30AXzIBohqa3vfNGHtVM2x5w+MjWoq8hmnOwZcZmGuiN6
         MO0oUbXe7LUCgYnCx8I7ce1wb5SFfXYMXtfDYtGMCHXvu1JnOORgAeQc/PNPEXqDB/VR
         mZFw==
X-Gm-Message-State: AOAM531dls/BUM+dVsTB9dODYNw9Lfcw7FmPjzRF0ohzdEYIdbDxGH7p
        R1c7fTJQDFJBNEx9fLkUZVc1yt9lBpwCaahR
X-Google-Smtp-Source: ABdhPJyEBWAWCrDWZzRzk8VSqs3XQybb8ZvQsVJEq5AWCS7ypIsmZ0NfN2lDWn6OPcd5vrwigK5qvg==
X-Received: by 2002:a1c:9d54:: with SMTP id g81mr8910621wme.51.1641561354512;
        Fri, 07 Jan 2022 05:15:54 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4875:220c:f3a4:c74e? ([2a01:e34:ed2f:f020:4875:220c:f3a4:c74e])
        by smtp.googlemail.com with ESMTPSA id b14sm4922565wrg.15.2022.01.07.05.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 05:15:54 -0800 (PST)
Subject: Re: [PATCH v5 1/6] powercap/drivers/dtpm: Move dtpm table from init
 to data section
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-2-daniel.lezcano@linaro.org>
 <CAPDyKFpY4i0Mtb==8zknsuG0HdhPW2fXFvEN+AJScVmT65A-ow@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <556eca9c-4ce8-1c79-cc6d-08d0ec603bd4@linaro.org>
Date:   Fri, 7 Jan 2022 14:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpY4i0Mtb==8zknsuG0HdhPW2fXFvEN+AJScVmT65A-ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 31/12/2021 14:33, Ulf Hansson wrote:
> On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The dtpm table is used to let the different dtpm backends to register
>> their setup callbacks in a single place and preventing to export
>> multiple functions all around the kernel. That allows the dtpm code to
>> be self-encapsulated.
> 
> Well, that's not entirely true. The dtpm code and its backends (or
> ops, whatever we call them) are already maintained from a single
> place, the /drivers/powercap/* directory. I assume we intend to keep
> it like this going forward too, right?
> 
> That is also what patch4 with the devfreq backend continues to conform to.
> 
>>
>> The dtpm hierarchy will be passed as a parameter by a platform
>> specific code and that will lead to the creation of the different dtpm
>> nodes.
>>
>> The function creating the hierarchy could be called from a module at
>> init time or when it is loaded. However, at this moment the table is
>> already freed as it belongs to the init section and the creation will
>> lead to a invalid memory access.
>>
>> Fix this by moving the table to the data section.
> 
> With the above said, I find it a bit odd to put a table in the data
> section like this. Especially, since the only remaining argument for
> why, is to avoid exporting functions, which isn't needed anyway.
> 
> I mean, it would be silly if we should continue to put subsystem
> specific tables in here, to just let them contain a set of subsystem
> specific callbacks.

So I tried to change the approach and right now I was not able to find
an alternative keeping the code self-encapsulate and without introducing
cyclic dependencies.

I suggest to keep the patch as it is and double check if it makes sense
to change it after adding more dtpm backends

Alternatively I can copy the table to a dynamically allocated table.


>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Kind regards
> Uffe
> 
>> ---
>>  include/asm-generic/vmlinux.lds.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index 42f3866bca69..50d494d94d6c 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -362,7 +362,8 @@
>>         BRANCH_PROFILE()                                                \
>>         TRACE_PRINTKS()                                                 \
>>         BPF_RAW_TP()                                                    \
>> -       TRACEPOINT_STR()
>> +       TRACEPOINT_STR()                                                \
>> +       DTPM_TABLE()
>>
>>  /*
>>   * Data section helpers
>> @@ -723,7 +724,6 @@
>>         ACPI_PROBE_TABLE(irqchip)                                       \
>>         ACPI_PROBE_TABLE(timer)                                         \
>>         THERMAL_TABLE(governor)                                         \
>> -       DTPM_TABLE()                                                    \
>>         EARLYCON_TABLE()                                                \
>>         LSM_TABLE()                                                     \
>>         EARLY_LSM_TABLE()                                               \
>> --
>> 2.25.1
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
