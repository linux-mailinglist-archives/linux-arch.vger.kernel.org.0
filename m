Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE68368A6C
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 03:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhDWBf1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 21:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhDWBf1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 21:35:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0CEC061574
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 18:34:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u11so18627862pjr.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 18:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2u9IVBbrQtK5nxCkY5Ql7e2S1s+pJgrMEaI8rlOVi1A=;
        b=kTIabuH9XG8EpGNkxN0ttB2TSmNE1UXivJVL/O3iBhAmQtRpUGW6mdNngm3gaVyfHk
         mZd9igv/ZBylu7j0rFkbzyVbfgP+ZKtnZIFUq1iqZQmxygpodGL8feHFwTGP6bxSDycC
         aS/dcIescNWiXHRyi86Y8JX+grwyam5ml+aVSu0fu1iKHlX2FNXST0o08A+dKXWyewrs
         Kh2wSpw3Z38NA32RLIlAhlUrXsT3V8u9XqihnCW3TDKfRab7JiRIMyde0fJAEMOA6t0x
         dHExxcIpGTZcYxxvXbTeDJKIXOlCaRLkaiKneXlRbAMT21PyRBSE/QeEK7EInSAU7Ulk
         lR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2u9IVBbrQtK5nxCkY5Ql7e2S1s+pJgrMEaI8rlOVi1A=;
        b=dPlXdto98jflBMcH7HyYABGpoI1BPR5r+502PLvxw1h2/4mkesTKmB7YW1OkWi2DYq
         KSWWuv+PunDSTcD1Xk5VEuwtu2X0WbolLaucH0+udnPdlfT0G1R/jlpZh6XWQyLk8X+C
         nAOKNOky+/vb+rFAmXzVrIdYoGdViRo3R8dg2/VD0MBqn0jtbHH58IEd5y49NHDRcw2p
         FgIUdnCN6gaGbM/8wHLCl2a+JFeOUPNrO5bqqHtOYLQ65j50eeMzo3Ml17ptXFrYt7ey
         O9/wxCDGW/thd4RuLkGzr7buqqSlElAzurko16X79XQpI4bQjnZl5xumPYBS2DDoK0LA
         Dn2Q==
X-Gm-Message-State: AOAM530U5CfsbcSsnPggFLIaQFWKP2ZYkbVUQfLps3/VZ6tlK2g6n1id
        T7BJxKnFK762TIKt022R4It07w==
X-Google-Smtp-Source: ABdhPJyPGTWn9ZwTGF0D0ZB3bx8F9D7skQtSMEe+BuiaPPW01VWIa1OOFmwPEC3wIJMBb5FDn5+xdg==
X-Received: by 2002:a17:90b:950:: with SMTP id dw16mr3058402pjb.68.1619141690659;
        Thu, 22 Apr 2021 18:34:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w140sm3106903pfc.176.2021.04.22.18.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:34:50 -0700 (PDT)
Date:   Thu, 22 Apr 2021 18:34:50 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 18:34:48 PDT (-0700)
Subject:     Re: [PATCH] riscv: Protect kernel linear mapping only if CONFIG_STRICT_KERNEL_RWX is set
In-Reply-To: <72130961-0419-9b1f-e88e-aa1e933f2942@ghiti.fr>
CC:     anup@brainfault.org, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-45fde203-6fd8-408c-b911-3efbb83d9cf3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 17 Apr 2021 10:26:36 PDT (-0700), alex@ghiti.fr wrote:
> Le 4/16/21 à 12:33 PM, Palmer Dabbelt a écrit :
>> On Fri, 16 Apr 2021 03:47:19 PDT (-0700), alex@ghiti.fr wrote:
>>> Hi Anup,
>>>
>>> Le 4/16/21 à 6:41 AM, Anup Patel a écrit :
>>>> On Thu, Apr 15, 2021 at 4:34 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>>>
>>>>> If CONFIG_STRICT_KERNEL_RWX is not set, we cannot set different
>>>>> permissions
>>>>> to the kernel data and text sections, so make sure it is defined before
>>>>> trying to protect the kernel linear mapping.
>>>>>
>>>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>>>
>>>> Maybe you should add "Fixes:" tag in commit tag ?
>>>
>>> Yes you're right I should have done that. Maybe Palmer will squash it as
>>> it just entered for-next?
>>
>> Ya, I'll do it.  My testing box was just tied up last night for the rc8
>> PR, so I threw this on for-next to get the buildbots to take a look.
>> It's a bit too late to take something for this week, as I try to be
>> pretty conservative this late in the cycle.  There's another kprobes fix
>> on the list so if we end up with an rc8 I might send this along with
>> that, otherwise this'll just go onto for-next before the linear map
>> changes that exercise the bug.
>>
>> You're more than welcome to just dig up the fixes tag and reply, my
>> scripts pull all tags from replies (just like Revieweb-by).  Otherwise
>> I'll do it myself, most people don't really post Fixes tags that
>> accurately so I go through it for pretty much everything anyway.
>
> Here it is:
>
> Fixes: 4b67f48da707 ("riscv: Move kernel mapping outside of linear mapping")

Thanks.  I just squashed it, though, as I had to rewrite this anyway.

>
> Thanks,
>
>>
>> Thanks for sorting this out so quickly!
>>
>>>
>>>>
>>>> Otherwise it looks good.
>>>>
>>>> Reviewed-by: Anup Patel <anup@brainfault.org>
>>>
>>> Thank you!
>>>
>>> Alex
>>>
>>>>
>>>> Regards,
>>>> Anup
>>>>
>>>>> ---
>>>>>   arch/riscv/kernel/setup.c | 8 ++++----
>>>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>>> index 626003bb5fca..ab394d173cd4 100644
>>>>> --- a/arch/riscv/kernel/setup.c
>>>>> +++ b/arch/riscv/kernel/setup.c
>>>>> @@ -264,12 +264,12 @@ void __init setup_arch(char **cmdline_p)
>>>>>
>>>>>          sbi_init();
>>>>>
>>>>> -       if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
>>>>> +       if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
>>>>>                  protect_kernel_text_data();
>>>>> -
>>>>> -#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>>>>> -       protect_kernel_linear_mapping_text_rodata();
>>>>> +#ifdef CONFIG_64BIT
>>>>> +               protect_kernel_linear_mapping_text_rodata();
>>>>>   #endif
>>>>> +       }
>>>>>
>>>>>   #ifdef CONFIG_SWIOTLB
>>>>>          swiotlb_init(1);
>>>>> --
>>>>> 2.20.1
>>>>>
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
