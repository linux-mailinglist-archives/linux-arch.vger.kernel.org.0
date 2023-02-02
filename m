Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1BD68743A
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 05:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjBBECO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 23:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjBBECJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 23:02:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED697E075;
        Wed,  1 Feb 2023 20:02:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e6so600427plg.12;
        Wed, 01 Feb 2023 20:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA2f4kIoYW0zW49rLJoqHLmL9faUvqTBb7xYUY7v1VQ=;
        b=H8ZzT3DPUs+jLLCqGqKGObBrUiZ3ZGTgwTxY/2yIfMZie9PUcq8uNum9CAEwOTfk8k
         BTeNZA8SRSaa9It7mKE/WG4xq9i1yRkh2IhxlNqFXxxvtlEtBgao5bB0jo3PuXaqtCGX
         BLjdEd0fhEXNJw82pQfZW28wqrXqo/x6X2ANFFT4NUJq6YAGqx750cOOLyS0+sH6icTg
         shGDbgjkZBg7oF9wovvzptM6hertx24pvXZJd0npY4MwKmsHqd5G3qNZISCGjmi2N9+4
         AtmWmVffL9ILYo6+N+KmO5hd9DIaEREn4bnz9fiQKW1MrvJK7vbzOZB1W1GSW0aE4qAR
         NaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LA2f4kIoYW0zW49rLJoqHLmL9faUvqTBb7xYUY7v1VQ=;
        b=lFGY82kHvm3pFdqO2aEFhyWZ/B3tHB8AzrCT8N1dVMa9xBbrwT3v5qBeYd2HWZd8MB
         FE/P1A3q07PohFAii7ugrsx7hdZb490C6mhx0S9eYyMjNAAuL9wm1v/Nv14T1R7dJCY1
         QE+x2AtlK/CitwahdrVhH/6OqFGsjUpHetGnhENfESCPGqxieUChGleRXNzVMMTeCv9R
         jACPuoDsKX0veHw1zL/iIvA9yOWmbvSzJo8pGf7Q3GMXHFn7BJ8RFtd7g2hSf8bBKLdd
         KXzYmgvLb4I+5/cKABvZ+lh91thUAmgYY9+VNQQWdqPEhgxDY2GzqfAmyh0busKGAiMF
         tksA==
X-Gm-Message-State: AO0yUKUSNjTsWMLMAuc0IKcsYyqEqmL5/uzjyD2Pb44STkDTUtr4zJ6k
        tU8622Zn/2Y4z9uY//9mbgg=
X-Google-Smtp-Source: AK7set/S5ylzwpUk6T/QLWoaDx1UsTAyamH7uRcYzn/u/kRjHl9qg/FG6DX7feem/dfp0XWzLs8H6A==
X-Received: by 2002:a17:902:dac6:b0:196:6ff8:69b8 with SMTP id q6-20020a170902dac600b001966ff869b8mr5699008plx.27.1675310527773;
        Wed, 01 Feb 2023 20:02:07 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b00196251ca124sm12524446pla.75.2023.02.01.20.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 20:02:01 -0800 (PST)
Message-ID: <15204de3-42f8-e1f8-f8bd-83f909a5da8a@gmail.com>
Date:   Thu, 2 Feb 2023 12:01:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 01/16] x86/hyperv: Add sev-snp enlightened guest
 specific config
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-2-ltykernel@gmail.com>
 <BYAPR21MB1688C47E9B4BD0D1293E7D4DD7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB1688C47E9B4BD0D1293E7D4DD7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/1/2023 1:34 AM, Michael Kelley (LINUX) wrote:
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 8f83ceec45dc..ace5901ba0fc 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -273,6 +273,18 @@ static void __init ms_hyperv_init_platform(void)
>>
>>   	hv_max_functions_eax = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
>>
>> +	/*
>> +	 * Add custom configuration for SEV-SNP Enlightened guest
>> +	 */
>> +	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
>> +		ms_hyperv.features |= HV_ACCESS_FREQUENCY_MSRS;
>> +		ms_hyperv.misc_features |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>> +		ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
>> +		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
>> +		ms_hyperv.hints |= HV_X64_APIC_ACCESS_RECOMMENDED;
>> +		ms_hyperv.hints |= HV_X64_CLUSTER_IPI_RECOMMENDED;
> Two different things are happening in changing the above flags:
> 
> 1)  Disabling certain feature that Hyper-V might offer to a guest, such
> as the crash MSRs and Auto EOI.  (In some cases disabling the feature
> means removing the flag.  In other cases in means adding the flag.  But
> the net result is same -- other Hyper-V specific code will not use the
> feature.)  This category is OK.
> 
> 2)  Forcing certain features to be treated as enabled.  This category
> is somewhat concerning.  Assuming that Hyper-V is accurately indicating
> which features are available, it seems better to check that the flags
> required by SNP are present, and refuse to boot in SNP mode if not.
> Or is this code handling a different problem, where Hyper-V is not
> indicating that the feature is available, even though it really is?
> 

Agree. The CPUID emulation in SEV-SNP guest may be controlled by the
cpuid table which is passed to kernel via EFI bootloader or hypervisor.
In Hyper-V case, the CPUID table is passed by Hyper-V directly and the
table is built during making guest image. To avoid the confusion here,
will try hiding the change in the cpuid table and double check whether 
these features will be enalbed or disabled on different machine or VM
type.

Thanks.

