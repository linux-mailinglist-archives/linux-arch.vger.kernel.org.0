Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D2D647C43
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 03:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLIC1S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 21:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiLIC1H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 21:27:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F086AAC6CB;
        Thu,  8 Dec 2022 18:27:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso7034561pjb.1;
        Thu, 08 Dec 2022 18:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbPDlthA5QMrCiVF+zEK9fkfI4RLt96DNaR+n8gduKM=;
        b=PugI+mf5T7sKtWsytITVHnSPZSj+kCZikqeC0l6VdiOFaOLg4m8LSXOAQFNjkpWUP0
         9OlLzKNM5TSFmZSKdXVnIi9bQTSFdkEb6yntgysR/i35jUc07X7bSZQ0fIsxY34LyMGC
         5EkTVglC67N4dI/U1ZiCIzpcm6z4Q7oGCJiYMXyXMaJsp3P8CL3wsJUzWphxZTAD2F7J
         Lc9VB4w1MNfCo9Al7DgjSwkWrfIK9ybgdPZ92IoFjdhmMAvgfKXLS7P7yad35pGOb5n8
         r9cBuwk4VTsNoaGLmQLkmmMrVvdyatdHCq7fjU4PFz0IIV+tzBHwXXqkn/lrCsIRUBjZ
         Iwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbPDlthA5QMrCiVF+zEK9fkfI4RLt96DNaR+n8gduKM=;
        b=Z62NpvkzrXAlOGYmbgc4/x8w/D0eOt2AOk0P31wKWHewsvb2/DHoGesWsJvs4isVCq
         +oj2CZjGOpCBGU6kS7y3H4iqg+2sm7G0M6MYtEYqrbnihnz7UuUuUah40SqbJL57JQzD
         mIypjVyRRiFwxV+/Am8FjDPyCkgs9IYM2X2NUWt0pAKo4H+C3ihNlOda1+RqqcQFUERr
         h23dpPquaN+KlpqGhQPCcLFXI9CfF0naocTrZZ6PrKI3OT99OjfKqWGFMC2Lk2Z0yRUS
         /Kxu05v1WokXS6r0vVzgQnoAMG0XIijQ6VBd9IMA4ufZWzNLB3hqnzOJMwJFTUa1d30l
         r4JQ==
X-Gm-Message-State: ANoB5pmDyw7EYQFzgz/S0skVRIralKsQLU9pBgS2SP3l079rYrX6NZeV
        hdI/yds1ttJNrUeU1Uui2Qw=
X-Google-Smtp-Source: AA0mqf4ia0Zg1Z3eCHwugZhoxIs+iOjYg1lcKbJjzY0XHZHwHRh8Qxgt7nR88Xl/8SurMv9+V/IJAw==
X-Received: by 2002:a05:6a21:3a86:b0:a7:9f6:b790 with SMTP id zv6-20020a056a213a8600b000a709f6b790mr5705512pzb.10.1670552826425;
        Thu, 08 Dec 2022 18:27:06 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090a1b8200b00219b04cf66asm242039pjc.36.2022.12.08.18.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 18:27:05 -0800 (PST)
Message-ID: <5909d07b-4930-6790-e160-ed6c88a8c58a@gmail.com>
Date:   Fri, 9 Dec 2022 10:26:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 10/18] drivers: hv: Decrypt percpu hvcall input arg
 page in sev-snp enlightened guest
To:     Dexuan Cui <decui@microsoft.com>,
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
 <20221119034633.1728632-11-ltykernel@gmail.com>
 <SA1PR21MB13357A3B9348705F4EB59DAFBF1D9@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <SA1PR21MB13357A3B9348705F4EB59DAFBF1D9@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/9/2022 5:52 AM, Dexuan Cui wrote:
>> @@ -134,6 +136,16 @@ int hv_common_cpu_init(unsigned int cpu)
>>   	if (!(*inputarg))
>>   		return -ENOMEM;
>>
>> +	if (hv_isolation_type_en_snp()) {
>> +		ret = set_memory_decrypted((unsigned long)*inputarg, 1);
> Is it possible hv_root_partition==1 here? If yes, the pgcount is 2.
>
Hi Dexuan:
	Thanks for review. So far, root partition doesn't support sev 
enlightened guest and so here assume pgcount is always 1. We may use 
pgcount variable here instead of the number.

>> +		if (ret) {
>> +			kfree(*inputarg);
>> +			return ret;
>> +		}
>> +
>> +		memset(*inputarg, 0x00, PAGE_SIZE);
>> +	}
>> +
>>   	if (hv_root_partition) {
>>   		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>>   		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
>> @@ -168,6 +180,9 @@ int hv_common_cpu_die(unsigned int cpu)
>>
>>   	local_irq_restore(flags);
>>
>> +	if (hv_isolation_type_en_snp())
>> +		set_memory_encrypted((unsigned long)mem, 1);
> If set_memory_encrypted() fails, we should not free the 'mem'.

Good point. Will update in the next version.
