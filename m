Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B220864B2D8
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 10:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiLMJ6z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 04:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLMJ6y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 04:58:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD21AD86;
        Tue, 13 Dec 2022 01:58:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso2994732pjh.1;
        Tue, 13 Dec 2022 01:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuLMR9FIWZzyNJCC4WcSP5T3oRsb0xgx1FZCoYoEIrQ=;
        b=GHpw6ebMA/OUpqW3652Na6DtmERK3samo3gp7t2kal7/zRTHe5YRGf5oooYRAh3ehg
         Fl4a9R+Kj3fk/SimXQFcFziKIu+30fKGcxTNs4Y37O7/r6DusM6MLSvUqMIekbXZWwa9
         eIN3r9hUoLxle9h7IV2h/3lGKAShgQNA37YNdvzb/zuxrvV3k3Bn3C+NKDeZumMy2o5y
         6HrDdMiPZDHoDUIsMeY8NEjymA1RjQyXcBnsNBCnuDSr0iiuoN2kCgTvGhcuNNF5joIR
         dGORbqkoCenah5l4+Ccm/H1QIGi8DYnc7vz4utZAhh1oEX4ewMRXEEMJf2nSo4Jk+z8k
         9jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuLMR9FIWZzyNJCC4WcSP5T3oRsb0xgx1FZCoYoEIrQ=;
        b=rFJyCc+7Nn1AjDmHVQQRssQ9ls8+7AoyBV7NEWSZd9yLv6/jCj9IRwQkHPdATUxW5L
         s58/BXPcnv0ymlGmd6X5iYFbueG0h/c6yvPn3LzLwAIQEIhFZFA/g2RCa7czNzBfY27m
         JmgSdYTmBanVtWkeX1q2knZcIjtOdjBZU5yC7NxX8dNXtSSaieiEHcp8oMf8r7g2kVY4
         RBhpd8uzriYxMhU6wVhg0Yu4nVYJ5m9nM5xUt4FKHmnsM/3lradbfAIB7kTii77boHHq
         EYu0nLoJrfu86m8TawK/wHMy51dxsbsvZzp6bJ/4jkmF6omfZTGhdU/eniOlr7ecZuqf
         5PVQ==
X-Gm-Message-State: ANoB5pkxj0w130kfSSFAgPXlb51taB64Sqna2yRUTsZmP+aQ5X9qCEgF
        VWzt/w2RNuOff47Z/Njzy70=
X-Google-Smtp-Source: AA0mqf5L9x1U0OhBNQAH6PAzJrj0nxvVgtR/eNVzhvRT4fu3tfYRytJlFHGGNHa88QlXcUoz5PzflQ==
X-Received: by 2002:a05:6a20:ce4d:b0:9d:efd3:66ca with SMTP id id13-20020a056a20ce4d00b0009defd366camr22779411pzb.17.1670925532287;
        Tue, 13 Dec 2022 01:58:52 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id k28-20020a63561c000000b0046fe244ed6esm6516569pgb.23.2022.12.13.01.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 01:58:51 -0800 (PST)
Message-ID: <52125d44-e488-6c31-e624-4094619dfcc6@gmail.com>
Date:   Tue, 13 Dec 2022 17:58:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 02/18] x86/hyperv: Add sev-snp enlightened guest
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
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-3-ltykernel@gmail.com>
 <BYAPR21MB168814EC5FA61976B69158B7D7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB168814EC5FA61976B69158B7D7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/13/2022 1:56 AM, Michael Kelley (LINUX) wrote:
>> @@ -32,6 +33,7 @@ extern u64 hv_current_partition_id;
>>
>>   extern union hv_ghcb * __percpu *hv_ghcb_pg;
>>
>> +extern bool hv_isolation_type_en_snp(void);
> This file also has a declaration for hv_isolation_type_snp().  I
> think this new declaration is near the beginning of this file so
> that it can be referenced by hv_do_hypercall() and related
> functions in Patch 6 of this series.  So maybe move the
> declaration of hv_isolation_type_snp() up so it is adjacent
> to this one?  It would make sense for the two to be together.

Agree. Will update in the next version.

> 
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 831613959a92..2ea4f21c6172 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -273,6 +273,21 @@ static void __init ms_hyperv_init_platform(void)
>>   	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>>   	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
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
>> +	}
>> +
>> +	pr_info("Hyper-V: enlightment features 0x%x, hints 0x%x, misc 0x%x\n",
>> +		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
>> +
> What's the reason for this additional call to pr_info()?  There's a call to pr_info()
> a couple of lines below that displays the same information, and a little bit more.
> It seems like the above call should be deleted, as I think we should try to be as
> consistent as possible in the output.

Sorry for noise. This one should be redundant. Will remove in the next 
version.

> 
>> @@ -328,18 +343,22 @@ static void __init ms_hyperv_init_platform(void)
>>   		ms_hyperv.shared_gpa_boundary =
>>   			BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
>>
>> -		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>> -			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>> -
>> -		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
>> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
>> +			static_branch_enable(&isolation_type_en_snp);
>> +		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
>>   			static_branch_enable(&isolation_type_snp);
>>   #ifdef CONFIG_SWIOTLB
>>   			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
>>   #endif
>>   		}
>> +
>> +		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>> +			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>> +
> Is there a reason for moving this pr_info() down a few lines?  I can't see that the
> intervening code changes any of the settings that are displayed, so it should be
> good in the original location.  Just trying to minimize changes that don't add value ...
> 

Agree. Will keep previous order. Thanks.
