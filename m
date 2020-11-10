Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC62AD6EA
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 13:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgKJMzv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 07:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbgKJMzv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Nov 2020 07:55:51 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF0C0613D3
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2020 04:55:51 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so2887543wmg.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2020 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nv2Iddcxs1d2PfbeIZnN3SiLsasGHglATCG+tB07IsI=;
        b=WIVjv45X5toRFfkJ1lSrT0YVSLDS40EsO3c19JdIRRJXhJJiPh5wHBhSzMa0sZkU3M
         NN3kAzPgxlBGxobUZP1kN8kVJw6Kq/GqGFXT6CIjCr99S4nB1qziNbvIDZakx/CwB+Gv
         OMeqbOntEMQl0liun1n0Du7Hbbkt5pZKZkmo5Y+y7YIY1iAOvJ7lCNhPJ4nEt+UJwSJ9
         XbiHr8IRj+oCHJurlLL4waYuCZt9Nsada1DDlNpOPgb4VcwW9jbVnR/y6WgtiENSNww/
         ZzQQ1OW6gOXj0eUbkT3YnQa82ilMVNzOCOkvQD0dKszIoVYqsVn4IFo9qPk29tkCWGHZ
         ruhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nv2Iddcxs1d2PfbeIZnN3SiLsasGHglATCG+tB07IsI=;
        b=kn8c2X1ayGSzULxz4JNgROUZ+4WrvEjDzyURQxiuFlXF7R7X7Mz1BLbZAGKFDfqVNK
         6PJXCNrUN8VIo7lCMo/tsEQOwk6gUMXKlTVtqIvr88W3mOk07Uvi0hTujux3cqSDqh8K
         HOGdppmgajkxI9sQsJfiDPdmABtiuF3Oomtike/X+LRrObk7bWroCyqL1eS4ols46N7T
         6vLj5yB17zAboeFzSJxo9on8mrLzD/03NkjHyG+P3ueDsnIlcjLZviBiTQMaoouM9515
         KhHIc381yfdvkIgtOIPRpFEUv2Bz0k67iNto/vn8WFXnUYO3FpQSS6xDLwlL1oDly1kn
         eLzQ==
X-Gm-Message-State: AOAM530r4Llr3Oq4vLnpKKDW+DfZetb3exPid9MxBfiryKoxe2CU8bse
        BHMqLiHmuyCaBg07+nUvDsDt19ci/11g7g==
X-Google-Smtp-Source: ABdhPJwO00jWObsmAMNaE0hP33ILrN87kQ+KfLYdT2MJbty3Uht3B979tZpO1RurYxLHmQeuwnJKQw==
X-Received: by 2002:a1c:9d02:: with SMTP id g2mr4804119wme.110.1605012949305;
        Tue, 10 Nov 2020 04:55:49 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1087:e960:613c:926b? ([2a01:e34:ed2f:f020:1087:e960:613c:926b])
        by smtp.googlemail.com with ESMTPSA id k20sm977440wmi.15.2020.11.10.04.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 04:55:48 -0800 (PST)
Subject: Re: [PATCH 3/4] powercap/drivers/dtpm: Add API for dynamic thermal
 power management
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <20201006122024.14539-4-daniel.lezcano@linaro.org>
 <8fea0109-30d4-7d67-ffeb-8e588a4dadc3@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6c018f8e-41b9-55bc-4d47-d2104cabfb86@linaro.org>
Date:   Tue, 10 Nov 2020 13:55:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8fea0109-30d4-7d67-ffeb-8e588a4dadc3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hi Lukasz,

thanks for the review

On 10/11/2020 10:59, Lukasz Luba wrote:

[ ... ]

>> +/* Init section thermal table */
>> +extern struct dtpm_descr *__dtpm_table[];
>> +extern struct dtpm_descr *__dtpm_table_end[];
>> +
>> +#define DTPM_TABLE_ENTRY(name)            \
>> +    static typeof(name) *__dtpm_table_entry_##name    \
>> +    __used __section(__dtpm_table) = &name
> 
> I had to change the section name to string, to pass compilation:
> __used __section("__dtpm_table") = &name
> I don't know if it's my compiler or configuration.

Actually, it is:

commit 33def8498fdde180023444b08e12b72a9efed41d
Author: Joe Perches <joe@perches.com>
Date:   Wed Oct 21 19:36:07 2020 -0700

    treewide: Convert macro and uses of __section(foo) to __section("foo")

Your change is correct, I've noticed it a few days ago when rebasing the
series.

> I've tried to register this DTPM in scmi-cpufreq.c with macro
> proposed in patch 4/4 commit message, but I might missed some
> important includes there...
> 
>> +
>> +#define DTPM_DECLARE(name)    DTPM_TABLE_ENTRY(name)
>> +
>> +#define for_each_dtpm_table(__dtpm)    \
>> +    for (__dtpm = __dtpm_table;    \
>> +         __dtpm < __dtpm_table_end;    \
>> +         __dtpm++)
>> +
>> +static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
>> +{
>> +    return container_of(zone, struct dtpm, zone);
>> +}
>> +
>> +int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max);
>> +
>> +int dtpm_release_zone(struct powercap_zone *pcz);
>> +
>> +struct dtpm *dtpm_alloc(void);
>> +
>> +void dtpm_unregister(struct dtpm *dtpm);
>> +
>> +int dtpm_register_parent(const char *name, struct dtpm *dtpm,
>> +             struct dtpm *parent);
>> +
>> +int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm
>> *parent,
>> +          struct powercap_zone_ops *ops, int nr_constraints,
>> +          struct powercap_zone_constraint_ops *const_ops);
>> +#endif
>>
> 
> Minor comment. This new framework deserves more debug prints, especially
> in registration/unregistration paths. I had to put some, to test it.
> But it can be done later as well, after it gets into mainline.

Ok, I will add some debug traces.

> I have also run different hotplug stress tests to check this tree
> locking. The userspace process constantly reading these values, while
> the last CPU in the cluster was going on/off and node was detaching.
> I haven't seen any problems, but the tree wasn't so deep.
> Everything was calculated properly, no error, null pointers, etc.

Great! thank you very much for this test

> Apart from the spelling minor issues and the long constraint name, LGTM
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks for the review

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
