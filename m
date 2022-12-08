Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6396471B8
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 15:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLHO0i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 09:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLHOZr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 09:25:47 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80FA58BF8;
        Thu,  8 Dec 2022 06:25:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jl24so1633292plb.8;
        Thu, 08 Dec 2022 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmGAlO5zyAzLmsfcY7QO9uc196l8ZQ3S+6vXq/Ug34c=;
        b=K43863XHWOnOdREK4qgSuixcuHMF+6d1XlSrRcXHm+c9Y6lIfMrxulmZ4840gJFNLl
         w6JhkZtLAQhzCvqAXcVVclkf3JY2q2Qpyd+lzd+zneRggndPx5YO76ZqW7G4UCNkvohF
         qM3qV+3JCVXhDgio0RwbZ88HMQovUtn2rHsmzEQmgbRC6m/QWLS5ZlZHfOvdZSlUdOB3
         4Z5eMmS3m8rEqUe7LPBt7X+0+CSKNRjk2HQ+7Ttm9Te1fy2ft/OPnPvpcbTmdxTCkXul
         xuRYhXD0zFmF7GEBVWXi2hhNNFEx4uu9LBRB6pvSxDdNanmlLSY51cyzyUWpZ8aXz5eB
         U3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmGAlO5zyAzLmsfcY7QO9uc196l8ZQ3S+6vXq/Ug34c=;
        b=O2cC3QIf0IYcjD+NADZPLaCGXAcOp0clIJtEheZ5kkqH4RAnk65MzxrQyVAxAtSRgY
         lqPLxlYHQh2gDbLJkz5ei1FTK3U6fPevdrTS36UMVkLEu73aOiDu67DPAlg3T2meHFQK
         MEhIDyOYkQkMVX4x2yRk4rNMDSE6x1c/FV69CvhCbmUhd5hkuokywdwXTUctqzSxNKQN
         407JhP5JyHu7tIcYGOlZ+MjjVyihuzoqdEkFZ4aGot01UUyzMsAG52ias2Qm5+COmaFw
         uCBMjRavhweJgYbxkCS/ElnNpjWX3Q+BbuPbmDYp17bmTMguk6DonxDa4HXMJ4EZvd69
         c58w==
X-Gm-Message-State: ANoB5pnFnHosDDShRPQechkjay3CPqb7HxOGNs38yXIDrRW6/JsRC/oN
        /+700LuBtJKOr8B3bCM6Sc8=
X-Google-Smtp-Source: AA0mqf5+AFH8z+yVHXhseghDySWBisQPIq86nNDTfcvaUbBTefO9DVTOWDp2XaeGtLyV/YtPMmHhVg==
X-Received: by 2002:a17:90a:2dc8:b0:219:baef:3ba with SMTP id q8-20020a17090a2dc800b00219baef03bamr22954074pjm.6.1670509514241;
        Thu, 08 Dec 2022 06:25:14 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id gt14-20020a17090af2ce00b00219bf165b5fsm2972546pjb.21.2022.12.08.06.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 06:25:13 -0800 (PST)
Message-ID: <f832f118-2049-72f4-1b82-d3e4b5cdebae@gmail.com>
Date:   Thu, 8 Dec 2022 22:25:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 16/18] x86/sev: Initialize #HV doorbell and handle
 interrupt requests
Content-Language: en-US
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-17-ltykernel@gmail.com>
 <fe527e7a-1cd2-1e93-7149-9f68f1ef8761@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <fe527e7a-1cd2-1e93-7149-9f68f1ef8761@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/8/2022 7:47 PM, Gupta, Pankaj wrote:
>> diff --git a/arch/x86/include/asm/irqflags.h 
>> b/arch/x86/include/asm/irqflags.h
>> index 7793e52d6237..e0730d8bc0ac 100644
>> --- a/arch/x86/include/asm/irqflags.h
>> +++ b/arch/x86/include/asm/irqflags.h
>> @@ -14,6 +14,9 @@
>>   /*
>>    * Interrupt control:
>>    */
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +void check_hv_pending(struct pt_regs *regs);
>> +#endif
>>   /* Declaration required for gcc < 4.9 to prevent 
>> -Werror=missing-prototypes */
>>   extern inline unsigned long native_save_fl(void);
>> @@ -35,6 +38,19 @@ extern __always_inline unsigned long 
>> native_save_fl(void)
>>       return flags;
>>   }
>> +extern inline void native_restore_fl(unsigned long flags)
> 
> Don't know if want to re-introduce this again? as it was removed with 
> ab234a260b1f ("x86/pv: Rework arch_local_irq_restore() to not use popf")

Nice catch！ This should be here again. Will remove it in the next
version.

Thanks.
