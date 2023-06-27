Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC673FA9A
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 12:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjF0K5i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0K5h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 06:57:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7308A1BE4;
        Tue, 27 Jun 2023 03:57:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b7e66ff65fso25942895ad.0;
        Tue, 27 Jun 2023 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687863456; x=1690455456;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr8SROad9OO/4TJb06TdXZu2wTOX69wCmDgB0z/3wFo=;
        b=l/IkUZk50vSHN3AQH7gUq03hB0XIreUXuIfURSbu/oF9s5vb9vwupArgjGwTvTJYUj
         oyvOvyOoFwhCRQ1RdqYjYWtJ5h2eCGzIH0h9CBeS6zXcs6m0nnYxHXphRd06m96UN5KP
         Ib1dipSC7y0Rlc1CBgq/PfUzV9C+gS6bz4uBGNSQNU/i8uTsNMmkaZ1Mauk7hbxkpAB1
         forzL8bXSw+0WyVQaWl43/NHWzV0flibgtNTBmTpvSOCTbtfi4iehqZNLhXaHHIeEO8f
         s7E5PXboYH7wu7Zi1XlWw4wFaqfu4brwqGVOzPf7fr5FCPWDQGoIcnHpy1zKIMumG2C5
         y7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687863456; x=1690455456;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pr8SROad9OO/4TJb06TdXZu2wTOX69wCmDgB0z/3wFo=;
        b=Ojz6xmZQMFddQwQNi0PPL6PsNXH2hJzt+acecVtL3PNiHAactkmtt7OALbaK69wMR8
         2fX8vbW65OtxHaR+uSaEMrSPejmGNRmy3shzViHT7LN+05oFC8Ed1aalxuapGX06CiWB
         YAs882og35R8t8f+9bgkNIZSiwHoBq4MlozcoEmG6nJk9qDAydxFawXXW0oLpgctMF7P
         hwFGp8eDTvbDWuCG6fgc/lPLe+pEKWvieUBJg2qYlg3B2DDoAjj4nTCwGdozm5DmVXeJ
         YrG09IgX3uEMq6XWo7Byq+LBZuN6cq+5CqdtgsX/FaUOVD8LTmmoa833eP9Vx5uzyA+x
         24bg==
X-Gm-Message-State: AC+VfDyuZGG3R0gjEmEjsyEE6YhcHlfHveB6K0i/CjmO6VlVuR5AFocq
        UiMf/czFbdZcGKBwJq+f1h8=
X-Google-Smtp-Source: ACHHUZ45ML7mn6h4txTGqQ3XW4VvhA9f/9IqPZLQT1fRUb6npg2JGsOM8Kh2YvtT57JI4a9F2DRx7w==
X-Received: by 2002:a17:903:41c7:b0:1b5:5ad6:ce9d with SMTP id u7-20020a17090341c700b001b55ad6ce9dmr12334679ple.50.1687863455767;
        Tue, 27 Jun 2023 03:57:35 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902b19800b001ab18eaf90esm5703663plr.158.2023.06.27.03.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 03:57:35 -0700 (PDT)
Message-ID: <d06bb33e-047f-c849-de6a-246bc361c7af@gmail.com>
Date:   Tue, 27 Jun 2023 18:57:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [EXTERNAL] Re: [PATCH 5/9] x86/hyperv: Use vmmcall to implement
 Hyper-V hypercall in sev-snp enlightened guest
From:   Tianyu Lan <ltykernel@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-6-ltykernel@gmail.com>
 <20230608132127.GK998233@hirez.programming.kicks-ass.net>
 <8b93aa93-903f-3a69-77f9-0c6b694d826b@gmail.com>
In-Reply-To: <8b93aa93-903f-3a69-77f9-0c6b694d826b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 6/8/2023 11:15 PM, Tianyu Lan wrote:
> On 6/8/2023 9:21 PM, Peter Zijlstra wrote:
>> On Thu, Jun 01, 2023 at 11:16:18AM -0400, Tianyu Lan wrote:
>>> From: Tianyu Lan <tiala@microsoft.com>
>>>
>>> In sev-snp enlightened guest, Hyper-V hypercall needs
>>> to use vmmcall to trigger vmexit and notify hypervisor
>>> to handle hypercall request.
>>>
>>> There is no x86 SEV SNP feature flag support so far and
>>> hardware provides MSR_AMD64_SEV register to check SEV-SNP
>>> capability with MSR_AMD64_SEV_ENABLED bit. ALTERNATIVE can't
>>> work without SEV-SNP x86 feature flag. May add later when
>>> the associated flag is introduced.
>>>
>>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>>> ---
>>>   arch/x86/include/asm/mshyperv.h | 44 ++++++++++++++++++++++++---------
>>>   1 file changed, 33 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/mshyperv.h 
>>> b/arch/x86/include/asm/mshyperv.h
>>> index 31c476f4e656..d859d7c5f5e8 100644
>>> --- a/arch/x86/include/asm/mshyperv.h
>>> +++ b/arch/x86/include/asm/mshyperv.h
>>> @@ -61,16 +61,25 @@ static inline u64 hv_do_hypercall(u64 control, 
>>> void *input, void *output)
>>>       u64 hv_status;
>>>   #ifdef CONFIG_X86_64
>>> -    if (!hv_hypercall_pg)
>>> -        return U64_MAX;
>>> +    if (hv_isolation_type_en_snp()) {
>>> +        __asm__ __volatile__("mov %4, %%r8\n"
>>> +                     "vmmcall"
>>> +                     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>>> +                       "+c" (control), "+d" (input_address)
>>> +                     :  "r" (output_address)
>>> +                     : "cc", "memory", "r8", "r9", "r10", "r11");
>>> +    } else {
>>> +        if (!hv_hypercall_pg)
>>> +            return U64_MAX;
>>> -    __asm__ __volatile__("mov %4, %%r8\n"
>>> -                 CALL_NOSPEC
>>> -                 : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>>> -                   "+c" (control), "+d" (input_address)
>>> -                 :  "r" (output_address),
>>> -                THUNK_TARGET(hv_hypercall_pg)
>>> -                 : "cc", "memory", "r8", "r9", "r10", "r11");
>>> +        __asm__ __volatile__("mov %4, %%r8\n"
>>> +                     CALL_NOSPEC
>>> +                     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>>> +                       "+c" (control), "+d" (input_address)
>>> +                     :  "r" (output_address),
>>> +                    THUNK_TARGET(hv_hypercall_pg)
>>> +                     : "cc", "memory", "r8", "r9", "r10", "r11");
>>> +    }
>>>   #else
>>
>> Remains unanswered:
>>
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F20230516102912.GG2587705%2540hirez.programming.kicks-ass.net&data=05%7C01%7CTianyu.Lan%40microsoft.com%7C60a576eb67634ffa27b108db68234d5a%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638218273105649705%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=MFj67DON0K%2BUoUJbeaIA5oVTxyrzO3fb5DbxYgDWwX0%3D&reserved=0
>>
>> Would this not generate better code with an alternative?
> 
> 
> Hi Peter:
>      Thanks to review. I put the explaination in the change log.
> 
> "There is no x86 SEV SNP feature(X86_FEATURE_SEV_SNP) flag
> support so far and hardware provides MSR_AMD64_SEV register
> to check SEV-SNP capability with MSR_AMD64_SEV_ENABLED bit
> ALTERNATIVE can't work without SEV-SNP x86 feature flag."
> There is no cpuid leaf bit to check AMD SEV-SNP feature.
> 
> After some Hyper-V doesn't provides SEV and SEV-ES guest before and so
> may reuse X86_FEATURE_SEV and X86_FEATURE_SEV_ES flag as alternative
> feature check for Hyper-V SEV-SNP guest. Will refresh patch.
> 

Hi Peter:
      I tried using alternative for "vmmcall" and CALL_NOSPEC in a single
Inline assembly. The output is different in the SEV-SNP mode. When SEV-
SNP is enabled, thunk_target is not required. While it's necessary in
the non SEV-SNP mode. Do you have any idea how to differentiate outputs 
in the single Inline assembly which just like alternative works for
assembler template.

