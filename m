Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9638C6F6F35
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjEDPjE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDPjD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 11:39:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05100E40;
        Thu,  4 May 2023 08:39:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaf21bb42bso4296675ad.2;
        Thu, 04 May 2023 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683214742; x=1685806742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOGgWQuJu/YRKbk9W+6+ac1CmGjJUe63CUW4/pvlsNU=;
        b=U5e/LQKHGebm6o2FtyN4IfWhv37Kh+bKmrRJLKfrfKpvKVwZsssMvesX+hUlvg0Czt
         yhBRLfloG20LSm5cBU8VpmCW6MvhlSUQ7hIYkCQU/kLEuaIH+qt1A0OI9lDelOtfaiYM
         waIu1cNntp3QHy2TWo2UK7t41Sw7Bhsey4B8z3HEIDE1QRyMRHIWLCgFTahtSbHusWS8
         VQIGCYkywTnXH3Efs8pc/+87xl5p4Gl8GqUxEVVqq7VoG5aVhmxcx8B3+qx85KgpOKxc
         jsHRV9TuazmD5CgCv4OtOkq77EVTpXZHA9Vf6m6eWL098M296VPjYRKw+wwIHsc02O1W
         CFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683214742; x=1685806742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOGgWQuJu/YRKbk9W+6+ac1CmGjJUe63CUW4/pvlsNU=;
        b=IzQ02fsSqjWhe6yc1DkJWkQPHIHNBre8Uk/kHUelyycDx0OkEBkDucu3DSOPwJl6wp
         VFwN92nOo+NGVuivo4Fn0qS7F14dg9Dj+k0TNlErBb3oKNIPbWj6Y+AvL6SWumjPW5Ub
         illEJQ3EPYjp1IZqxPLZlne359tIIJgHbBgSMB4QF8KNvxuKb+TxbcfOeWkPofWKa/YB
         dlXzeqgrjek9Nr68JL1SxFNjmW6GlyRpwdES77/8UoRICBAYOX8j6N8bhnrvqhLx3OEu
         Rb2DecrY6Ya2NyfeZ88U3WjZlMQKy4Nw/tl7wOVUVoq+6SCWnIm8kfunFfHisvdM3jPF
         /N/A==
X-Gm-Message-State: AC+VfDxgzQJb5sdk9k1Qc256kZQBx2aItAyhqw4kKOXGWaarVyzZhoAU
        062UVKVYXIiy6s27cWpX4ss=
X-Google-Smtp-Source: ACHHUZ65hClqFofcepcwLzUQyAH9m5rdgCEkU2a2LZRiVJTgEbAJrhkVAWMLJnbYei/J74wra6C/wA==
X-Received: by 2002:a17:902:b116:b0:1ab:224b:d1fc with SMTP id q22-20020a170902b11600b001ab224bd1fcmr3796900plr.41.1683214742309;
        Thu, 04 May 2023 08:39:02 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5::e29? ([2404:f801:9000:18:6fec::e29])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902bd8b00b001a96a6877fdsm19553531pls.3.2023.05.04.08.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:39:01 -0700 (PDT)
Message-ID: <4db13429-ffb0-debc-cec4-e37d0e526934@gmail.com>
Date:   Thu, 4 May 2023 08:38:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH V5 03/15] x86/hyperv: Set Virtual Trust Level in VMBus
 init message
Content-Language: en-US
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-4-ltykernel@gmail.com>
 <20230502223041.00000240.zhi.wang.linux@gmail.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230502223041.00000240.zhi.wang.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/2/2023 12:30 PM, Zhi Wang wrote:
> On Mon,  1 May 2023 04:57:13 -0400
> Tianyu Lan <ltykernel@gmail.com> wrote:
> 
>> From: Tianyu Lan <tiala@microsoft.com>
>>
>> sev-snp guest provides vtl(Virtual Trust Level) and
>> get it from hyperv hvcall via HVCALL_GET_VP_REGISTERS.
>> Set target vtl in the VMBus init message.
>>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>> Change since RFC v4:
>>         * Use struct_size to calculate array size.
>>         * Fix some coding style
>>
>> Change since RFC v3:
>>         * Use the standard helper functions to check hypercall result
>>         * Fix coding style
>>
>> Change since RFC v2:
>>         * Rename get_current_vtl() to get_vtl()
>>         * Fix some coding style issues
>> ---
>>   arch/x86/hyperv/hv_init.c          | 36 ++++++++++++++++++++++++++++++
>>   arch/x86/include/asm/hyperv-tlfs.h |  7 ++++++
>>   drivers/hv/connection.c            |  1 +
>>   include/asm-generic/mshyperv.h     |  1 +
>>   include/linux/hyperv.h             |  4 ++--
>>   5 files changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 9f3e2d71d015..331b855314b7 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -384,6 +384,40 @@ static void __init hv_get_partition_id(void)
>>   	local_irq_restore(flags);
>>   }
>>   
>> +static u8 __init get_vtl(void)
>> +{
>> +	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
>> +	struct hv_get_vp_registers_input *input;
>> +	struct hv_get_vp_registers_output *output;
>> +	u64 vtl = 0;
>> +	u64 ret;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	output = (struct hv_get_vp_registers_output *)input;
> 
> ===
>> +	if (!input) {
>> +		local_irq_restore(flags);
>> +		goto done;
>> +	}
>> +
> ===
> Is this really necessary?
> 
> drivers/hv/hv_common.c:
> 
>          hyperv_pcpu_input_arg = alloc_percpu(void  *);
>          BUG_ON(!hyperv_pcpu_input_arg);
> 
> 

Hi Zhi:
	The hyperv_pcpu_input_arg is a point to address of input arg
pages and these pages are allocated in the hv_common_cpu_init(). If
it failed to allocate these pages, the value pointed by 
hyperv_pcpu_input_arg will be NULL.
	
