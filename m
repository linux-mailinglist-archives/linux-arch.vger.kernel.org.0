Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347A6D9EC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2019 01:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfD1XX1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Apr 2019 19:23:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54327 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfD1XX1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Apr 2019 19:23:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so11395882wml.4
        for <linux-arch@vger.kernel.org>; Sun, 28 Apr 2019 16:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sFibqTzckd76beem9F5bCskmi7SB/Bj+0SdWxridQMM=;
        b=sNaFnAv+mR9LPXBttWPjaMs42DQrViVwbahxcKH2g+lH/u6XmrHZpSTSMv/7Pqme15
         kG9zyev1TVbYrvlWymonLMmDcult6Urp0lzGhFtiS7y431KBwcjOVjRo6irPrCxQAnmu
         TFOfCdj2JAaZPfdxgI2GDBzSZ7dPq5t1MwMYLdaXsTyqftO/8KW7vt16U+vSxVnX5u1v
         l7YHqGUQHV8Op1u3U65xQEnU4CQcsc/MhkQBM9Ovs2GxsFBWjcrjlAQ2Mi+UQVXPNFyx
         l1CA4j0HrERevFRyRWGTOWgID9nf2Jq721r/xC+v+M1ojkWyQhq9nJRr2or9La2uug2+
         iMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sFibqTzckd76beem9F5bCskmi7SB/Bj+0SdWxridQMM=;
        b=uIqIpHlcnOs95QwW+7YRaehnUrej4AJxzzcxTWMTLvkomJtW+mSECpErZO2W8n8N8O
         /kJlDbl1EqUAo0CNndTOg1uCDrn4Al3p8MZekGiHS4KZdx4n+fiDk0b4PcwiPAOqD9vH
         c9L3355QSBq2XfdFS5FA6rnLm1eKeB3xmGpz55gcz8AnhMmHLdyhhRfJaWHN0EM/fZGo
         w4ahZaJfqEL/qWo8zEl2Z7dTa//0eMkm7Nz52j1GqNGiHlq1Jb8MB2WjmbPCjJSQDc/u
         MFXC4ORCX/VuS2XXBNK68nvMQgiQfjPOeRd5p9xUSvfCx4PTjfo9GnZKa/1zTkkISxJW
         jUAQ==
X-Gm-Message-State: APjAAAWGwyn7aPx6IufMC5QlLh0S902FJsKYG08CFcK4rSE0d0b10omh
        eLKGSbbSYc0Z4SVGDjmSXeb+Maj1/Po=
X-Google-Smtp-Source: APXvYqwdLAcIwXDpTggFd9Yw2dAZPxGFOlvruxAvGAWmF3nUnwAoca/6yrfdBmPs70q2W+Y/J6GBFw==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr39185wmg.53.1556493804055;
        Sun, 28 Apr 2019 16:23:24 -0700 (PDT)
Received: from [192.168.0.41] (86.204.129.77.rev.sfr.net. [77.129.204.86])
        by smtp.googlemail.com with ESMTPSA id u189sm42326728wme.25.2019.04.28.16.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 16:23:22 -0700 (PDT)
Subject: Re: [PATCH 3/7] thermal/drivers/core: Add init section table for
 self-encapsulation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-3-daniel.lezcano@linaro.org>
 <1555922585.26198.19.camel@intel.com>
 <fb45157c-38c4-7940-3252-af459d446323@linaro.org>
 <1555999165.26198.39.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2c0bc40d-328a-fc96-73da-9d65fee253fb@linaro.org>
Date:   Mon, 29 Apr 2019 01:23:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555999165.26198.39.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 23/04/2019 07:59, Zhang Rui wrote:
> Hi, Daniel,
> 
> thanks for clarifying.
> It is true that we need to make thermal framework ready as early as
> possible. And a static table works for me as long as vmlinux.lds.h is
> the proper place.
> 
> Arnd,
> are you okay with this patch? if yes, I suppose I can take it through
> my tree, right?

Arnd?


> thanks,
> rui
> 
> On 一, 2019-04-22 at 14:11 +0200, Daniel Lezcano wrote:
>> Hi Zhang,
>>
>>
>> On 22/04/2019 10:43, Zhang Rui wrote:
>>>
>>> Hi, Daniel,
>>>
>>> Thanks for the patches, it looks good to me except this one and
>>> patch
>>> 4/7.
>>>
>>> First, I don't think this is a cyclic dependency issue as they are
>>> in
>>> the same module.
>> The governors have to export their [un]register functions in order to
>> have the core to use them.
>>
>> The core has to export the [un]register function in order to have the
>> governors to use them.
>>
>> From my point of view it is a cyclic dependency. In any other
>> subsystems, the plugins/governor/drivers/whatever don't have to
>> export
>> their functions to the core, they use the core's exported functions.
>>
>>>
>>> Second, I have not read include/asm-generic/vmlinux.lds.h before,
>>> it
>>> seems that it is used for architecture specific stuff. Fix a
>>> thermal
>>> issue in this way seems overkill to me.
>> It is not architecture specific, it belongs to asm-generic. All init
>> calls are defined in it and more. It is a common way to define static
>> tables from different files without adding dependency and unload it
>> after init.
>>
>> All clk, timers, acpi tables, irq chip, cpuidle and cpu methods are
>> defined this way.
>>
>> When the thermal_core.c uses at the end fs_initcall it uses the same
>> mechanism.
>>
>>
>>>
>>> IMO, to make the code clean, we can build the governors as separate
>>> modules just like we do for cpu governors.
>>> This brings to the old commit 80a26a5c22b9("Thermal: build thermal
>>> governors into thermal_sys module"), and that was introduced to fix
>>> a
>>> problem when CONFIG_THERMAL is set to 'm'. So I think we can switch
>>> back to the old way as the problem is gone now.
>>>
>>> what do you think?
>> IMO, having the governors built as module is not a good thing because
>> the SoC needs the governor to be ready as soon as possible at boot
>> time.
>> I've been told some boards reboot at boot time because the governor
>> comes too late with the userspace governor for example.
>>
>> If you don't like the vmlinuz.lds.h approch (but again it is a common
>> way to initialize table and I wrote it to extend to more thermal
>> table
>> in the future) we can change the thermal core to replace
>> fs_initcall()
>> by core_initcall() and use postcore_initcall() in the governor.
>>
>>
>>
>>>
>>> Patch 1,2,5,6,7 applied first.
>>>
>>> thanks,
>>> rui
>>>
>>> On 二, 2019-04-02 at 18:12 +0200, Daniel Lezcano wrote:
>>>>
>>>> Currently the governors are declared in their respective files
>>>> but
>>>> they
>>>> export their [un]register functions which in turn call the
>>>> [un]register
>>>> the governors core's functions. That implies a cyclic dependency
>>>> which is
>>>> not desirable. There is a way to self-encapsulate the governors
>>>> by
>>>> letting
>>>> them to declare themselves in a __init section table.
>>>>
>>>> Define the table in the asm generic linker description like the
>>>> other
>>>> tables and provide the specific macros to deal with.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>  drivers/thermal/thermal_core.h    | 16 ++++++++++++++++
>>>>  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
>>>>  2 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/thermal/thermal_core.h
>>>> b/drivers/thermal/thermal_core.h
>>>> index 0df190ed82a7..28d18083e969 100644
>>>> --- a/drivers/thermal/thermal_core.h
>>>> +++ b/drivers/thermal/thermal_core.h
>>>> @@ -15,6 +15,22 @@
>>>>  /* Initial state of a cooling device during binding */
>>>>  #define THERMAL_NO_TARGET -1UL
>>>>  
>>>> +/* Init section thermal table */
>>>> +extern struct thermal_governor * __governor_thermal_table[];
>>>> +extern struct thermal_governor * __governor_thermal_table_end[];
>>>> +
>>>> +#define THERMAL_TABLE_ENTRY(table, name)			
>>>> \
>>>> +        static typeof(name) * __thermal_table_entry_##name	
>>>> \
>>>> +	__used __section(__##table##_thermal_table)		
>>>> \
>>>> +		= &name;
>>>> +
>>>> +#define THERMAL_GOVERNOR_DECLARE(name)	THERMAL_TABLE_ENTR
>>>> Y(go
>>>> vernor, name)
>>>> +
>>>> +#define for_each_governor_table(__governor)		\
>>>> +	for (__governor = __governor_thermal_table;	\
>>>> +	     __governor < __governor_thermal_table_end;	\
>>>> +	     __governor++)
>>>> +
>>>>  /*
>>>>   * This structure is used to describe the behavior of
>>>>   * a certain cooling device on a certain trip point
>>>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
>>>> generic/vmlinux.lds.h
>>>> index f8f6f04c4453..9893a3ed242a 100644
>>>> --- a/include/asm-generic/vmlinux.lds.h
>>>> +++ b/include/asm-generic/vmlinux.lds.h
>>>> @@ -239,6 +239,16 @@
>>>>  #define ACPI_PROBE_TABLE(name)
>>>>  #endif
>>>>  
>>>> +#ifdef CONFIG_THERMAL
>>>> +#define THERMAL_TABLE(name)					
>>>> 	
>>>> \
>>>> +        . = ALIGN(8);						
>>>> 	\
>>>> +        __##name##_thermal_table = .;				
>>>> 	\
>>>> +        KEEP(*(__##name##_thermal_table))			
>>>> 	
>>>> \
>>>> +        __##name##_thermal_table_end = .;
>>>> +#else
>>>> +#define THERMAL_TABLE(name)
>>>> +#endif
>>>> +
>>>>  #define KERNEL_DTB()						
>>>> 	
>>>> \
>>>>  	STRUCT_ALIGN();						
>>>> 	\
>>>>  	__dtb_start = .;						
>>>> \
>>>> @@ -609,6 +619,7 @@
>>>>  	IRQCHIP_OF_MATCH_TABLE()					
>>>> \
>>>>  	ACPI_PROBE_TABLE(irqchip)				
>>>> 	
>>>> \
>>>>  	ACPI_PROBE_TABLE(timer)					
>>>> 	\
>>>> +	THERMAL_TABLE(governor)					
>>>> 	\
>>>>  	EARLYCON_TABLE()						
>>>> \
>>>>  	LSM_TABLE()
>>>>  
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

