Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9253C67762D
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 09:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAWIQ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 03:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjAWIQ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 03:16:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6284C17CE3
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 00:16:57 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so9989379wmb.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 00:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mASwyI0y84zkiwwYs/n5l2nc6iOYa0RADtrERsvZZ/4=;
        b=PbtbFjx/YiFhnvdSh29MEa6PF9nytW6aCWO3mfmnb/mQIcXmYF78LAsc2CggFv8ULD
         e4BRWhtMDFcjb48YrV5CwLYYEDCSPpFwiZtDp3EIPeH4ghdvc/kRyAgMJZFsjxPBIoTz
         +SoqSV1LzOhYpwZP13Fz2w7f8NCsVFjpHxINOB7Fv4jVkf8oPTVcds0QmhBw/FdMKTv3
         C3YWOZXlKHC0ry7oZ/l4Dn9zEN/mCuHKvr5terRV3WZlPSZGrqDpxLJDEVtSKWbICyJo
         TUdsnRByRwYR97rhmP9tjgC7v4IL/MFGCM/gxVMcS86Dkk73qsm7esM5DLU3bXjo/yG2
         nBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mASwyI0y84zkiwwYs/n5l2nc6iOYa0RADtrERsvZZ/4=;
        b=1IpRHsx9C5AJ/RTwzGtLdkctAJ3vSMEww+dGGjqf/wYWWm6XWLaRfZBntiF2otiiu0
         OpGQtfUFowQHD1f+VbkGcVwZ5fnlFI2Kud5xlZSyM0uty5jQ2ZGHWyWJFNFtKKjvFYM/
         mQdeyxRopm3KQumAjbWkUwAJgc+Nt5A4HpxTzzxIBYV9CADt5iS3zarYqPm2Bi7gmZjr
         ien04QxyrSv22QB55htF8KIWxwNWjdERlqykkw7CYIz+4zW5WiT2FYtm2Ed1xp0dGLio
         u9p04HY5+YxuFfTNwgEC5DOi2jEDJmfaXy96qtmoEdL3zaAH9VCPj6XQhKsLnr7oLlsA
         Z8Uw==
X-Gm-Message-State: AFqh2kpxa0xFBbiUaoy/6uWFxUgctnDab9l7spYgVPOrwAcaN0mUnTeo
        v1jIO5Uc3WOEavfOF+ScD8INjISwHIFsVg==
X-Google-Smtp-Source: AMrXdXs78YIwmy6vXp8dUen1lH+gRIzlW9AG1nDQeN2sZijzpWuNRWZPH+x2GWIkurJEuK4QH4aP5A==
X-Received: by 2002:a05:600c:1c8e:b0:3d9:e5f9:984c with SMTP id k14-20020a05600c1c8e00b003d9e5f9984cmr23361419wms.2.1674461815625;
        Mon, 23 Jan 2023 00:16:55 -0800 (PST)
Received: from [192.168.86.94] ([77.137.66.37])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b003db0bb81b6asm10522350wmo.1.2023.01.23.00.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:16:55 -0800 (PST)
Message-ID: <e8fac6e0-487f-37c3-5be4-19518ffa845e@gmail.com>
Date:   Mon, 23 Jan 2023 10:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.0
Subject: Re: [PATCH v6 3/5] lazy tlb: shoot lazies, non-refcounting lazy tlb
 mm reference handling scheme
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
References: <20230118080011.2258375-1-npiggin@gmail.com>
 <20230118080011.2258375-4-npiggin@gmail.com>
 <5F3590B8-3F25-4EFB-BE3A-D32AAAC0B2F4@gmail.com>
 <CPVVOWQ6SE2S.NQ3R9R77MFKI@bobo>
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CPVVOWQ6SE2S.NQ3R9R77MFKI@bobo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 1/19/23 6:22 AM, Nicholas Piggin wrote:
> On Thu Jan 19, 2023 at 8:22 AM AEST, Nadav Amit wrote:
>>
>>
>>> On Jan 18, 2023, at 12:00 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> +static void do_shoot_lazy_tlb(void *arg)
>>> +{
>>> +	struct mm_struct *mm = arg;
>>> +
>>> + 	if (current->active_mm == mm) {
>>> + 		WARN_ON_ONCE(current->mm);
>>> + 		current->active_mm = &init_mm;
>>> + 		switch_mm(mm, &init_mm, current);
>>> + 	}
>>> +}
>>
>> I might be out of touch - doesn’t a flush already take place when we free
>> the page-tables, at least on common cases on x86?
>>
>> IIUC exit_mmap() would free page-tables, and whenever page-tables are
>> freed, on x86, we do shootdown regardless to whether the target CPU TLB state
>> marks is_lazy. Then, flush_tlb_func() should call switch_mm_irqs_off() and
>> everything should be fine, no?
>>
>> [ I understand you care about powerpc, just wondering on the effect on x86 ]
> 
> Now I come to think of it, Rik had done this for x86 a while back.
> 
> https://lore.kernel.org/all/20180728215357.3249-10-riel@surriel.com/
> 
> I didn't know about it when I wrote this, so I never dug into why it
> didn't get merged. It might have missed the final __mmdrop races but
> I'm not not sure, x86 lazy tlb mode is too complicated to know at a
> glance. I would check with him though.

My point was that naturally (i.e., as done today), when exit_mmap() is 
done, you release the page tables (not just the pages). On x86 it means 
that you also send shootdown IPI to all the *lazy* CPUs to perform a 
flush, so they would exit the lazy mode.

[ this should be true for 99% of the cases, excluding cases where there
   were not page-tables, for instance ]

So the patch of Rik, I think, does not help in the common cases, 
although it may perhaps make implicit actions more explicit in the code.
