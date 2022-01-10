Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800BD4899FD
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 14:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiAJNdn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 08:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiAJNdn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 08:33:43 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E2C061748
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 05:33:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l25so15938273wrb.13
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 05:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wykY6RVdYGo3LCViVwH8y47ACjO/I+ljCrJ3y0UU7JI=;
        b=v1Zcv9HlWrtnmwH4thsDg6vrRCwzTZ5N6M/GatTtutfPZRit5EBvmKTBFZPCgPTJKW
         ovkE2K8C4JhfsZPyursJLwrLenN+sCROvchDrLPWtois83nNe6YYbIe/BCDgQcK+0l/p
         tTIDGwkBM8KEPu415OviYoXRz8J1Z1kCPc0bqLx/PlI/4s8PxAovVHHB+l8qXpsKgRQL
         wBDQYezTgMUITDf96ffPgD+YzjzwSGEcIzcoTGVRnZJIvAC+PsFiacF21s/8pDE3ngmT
         46HZdvjWelj18UoR1KCCNUrAaU//W3ki8ACtpxocSZOpGzpDxp3KsRx1sE1oE08S/plk
         +57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wykY6RVdYGo3LCViVwH8y47ACjO/I+ljCrJ3y0UU7JI=;
        b=TBHWFJvV7uKpiRk0qqakJk1XzRz3FhfyIkZKCjfrlxaGf8R64N+5hV2Yy5LWsWhL2F
         IB6ac7g39kUuR6rbqA0RbVZSqosJVRg0JP5ubpaUKstYHKSquEV1GMaFn+PD/OTxry4d
         /UF6J8HvhtfFXJZW5SvQfu3Zn2TokIiqWIqDjKGCN/ha7yRuZt+qH71t4OdtMhgnv+pS
         jewDrO9KhvTaEeYJ/j7BS/vzpY494o4rwlwPdXBkKYf5eXRqhgWKul6VK2t263khdQXd
         57OnbsQmAvfgYDl+FRgQzpNTIjHONz8amCyVmushl4Rm5Q5Xlo6DS6diq9cxPkphNc0g
         YHkw==
X-Gm-Message-State: AOAM530AyyXnXcsOfarvcxr+mlBMOsF2CkT6IQ0Uqmu1ZOsVYABCjhrD
        JTTDiyanfW53atYvhdnWcUDrvlhMAUSz9CB2
X-Google-Smtp-Source: ABdhPJx1Hj2+aXURh9tvHBF3KCs98lyOQJ6RXC4QdC+VRwtBLAb5wjpVXh0T8OgzHl7S46JpaQ8bpg==
X-Received: by 2002:a05:6000:18a5:: with SMTP id b5mr66369168wri.267.1641821621565;
        Mon, 10 Jan 2022 05:33:41 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:18f0:2692:14f:d8fd? ([2a01:e34:ed2f:f020:18f0:2692:14f:d8fd])
        by smtp.googlemail.com with ESMTPSA id 5sm7563904wrb.77.2022.01.10.05.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 05:33:40 -0800 (PST)
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
 <556eca9c-4ce8-1c79-cc6d-08d0ec603bd4@linaro.org>
 <CAPDyKFpWtVFoqhFrhMQOgHUjggvg_GPYwmeK-jkphQpA7KQZRw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a4581b79-c2b2-c2bd-b96c-98389ea15a1e@linaro.org>
Date:   Mon, 10 Jan 2022 14:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpWtVFoqhFrhMQOgHUjggvg_GPYwmeK-jkphQpA7KQZRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 07/01/2022 15:49, Ulf Hansson wrote:
> On Fri, 7 Jan 2022 at 14:15, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 31/12/2021 14:33, Ulf Hansson wrote:
>>> On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> The dtpm table is used to let the different dtpm backends to register
>>>> their setup callbacks in a single place and preventing to export
>>>> multiple functions all around the kernel. That allows the dtpm code to
>>>> be self-encapsulated.
>>>
>>> Well, that's not entirely true. The dtpm code and its backends (or
>>> ops, whatever we call them) are already maintained from a single
>>> place, the /drivers/powercap/* directory. I assume we intend to keep
>>> it like this going forward too, right?
>>>
>>> That is also what patch4 with the devfreq backend continues to conform to.
>>>
>>>>
>>>> The dtpm hierarchy will be passed as a parameter by a platform
>>>> specific code and that will lead to the creation of the different dtpm
>>>> nodes.
>>>>
>>>> The function creating the hierarchy could be called from a module at
>>>> init time or when it is loaded. However, at this moment the table is
>>>> already freed as it belongs to the init section and the creation will
>>>> lead to a invalid memory access.
>>>>
>>>> Fix this by moving the table to the data section.
>>>
>>> With the above said, I find it a bit odd to put a table in the data
>>> section like this. Especially, since the only remaining argument for
>>> why, is to avoid exporting functions, which isn't needed anyway.
>>>
>>> I mean, it would be silly if we should continue to put subsystem
>>> specific tables in here, to just let them contain a set of subsystem
>>> specific callbacks.
>>
>> So I tried to change the approach and right now I was not able to find
>> an alternative keeping the code self-encapsulate and without introducing
>> cyclic dependencies.
>>
>> I suggest to keep the patch as it is and double check if it makes sense
>> to change it after adding more dtpm backends
>>
>> Alternatively I can copy the table to a dynamically allocated table.
> 
> I am not sure I understand the problem. You don't need a "table of
> callbacks" at all, at least to start with.
> 
> Instead, what you need is to make a call to a function, or actually
> one call per supported dtpm type from dtpm_setup_dt() (introduced in
> patch2).
> 
> For CPUs, you would simply call dtpm_cpu_setup() (introduced in
> patch3) from dtpm_setup_dt(), rather than walking the dtpm table an
> invoking the ->setup() callback.
>
> Did that make sense to you?

Yeah, I already got the point ;)

I'll convert it to something else, and we will see in the future if that
needs to be converted back to the table.


> Going forward, when we decide to introduce the option to add/remove
> support for dtpm types dynamically, you can then convert to a
> dynamically allocated table.
> 
> [...]
> 
> Kind regards
> Uffe
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
