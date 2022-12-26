Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ECF6560C3
	for <lists+linux-arch@lfdr.de>; Mon, 26 Dec 2022 08:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLZH0m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Dec 2022 02:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZH0m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Dec 2022 02:26:42 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF54CE5;
        Sun, 25 Dec 2022 23:26:41 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 7so6798283pga.1;
        Sun, 25 Dec 2022 23:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BP28ThNDrV2+rj7tyFrglRNo5Mo/dZrYmPpGBSiwqg=;
        b=J9xkOrFjRuPH/wQYbTXZd86iNKUmAZCtUK8mRWuXKGimVW+cix1U7UmdkbEelLbyqA
         udrffEjJy6YF+oHuN94bvwxsO1PRXL3UesBT752P6lgGBxHBestN3hu3yg2aET+DEdah
         MHlVZw5qDx8oeM/9k8RlcRdWrjr/SCfj6n8SKRRc2MBwaM+CuUkxXvEBsfW3u4ZeZdbp
         iuP1e+aVAXTCVMTrZOh2IPJ4WBbRNH4b+HgWWbgymuGAq3VhMMdjgc9mWjsr+BWHvE9c
         sihA3I2RdPuZJMpxWLNLhU8JT4hHjHcK17GySMtrDK5hJ79PTdurllIqiltLzjboyyoy
         ppSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BP28ThNDrV2+rj7tyFrglRNo5Mo/dZrYmPpGBSiwqg=;
        b=b0/BbMFbLrFjEAAX4/svR+t/rNQDRzC9ylXXDVzfytvQXkMRK71m+EVWXeNUcXLMbD
         xZEkU951VzwEnUM6it/Z13ws4GHr7MJAfKQNtqcLzU1l9z9bHZ4YrTCr89z1jnim77vY
         2qgGFAPPh7zulM2hTQGjo8sBv7pcMsfa4aceCPG3zs5SaPIvLcBlwFBcV/ZBDNRcequf
         EP/ZABMi/IQpDZZZLVi3GszDUtfO4X4s9pdfl964mKo3kofwlfzbRkN0/d/bj+zOFj/V
         2Vl2iyJlV1OaDj47REtRYEWsgQ9Zjb6isPDWDSmznaE+PtCm/ci/tv2zd6WN8JqMC92s
         fMsw==
X-Gm-Message-State: AFqh2kqafDJwGcdeIWbHetHMlnj3KDVRciCMdVELugBDANb9jQboQz8w
        uroIez8IeB0oS6AnBhBPbsw=
X-Google-Smtp-Source: AMrXdXuyr5O0DLExCO9wALqIc5t/+SNGh1usm32pp45Z+S6V5/Is/1z5fyykemBBcsB1O66woqdJUQ==
X-Received: by 2002:a62:4e93:0:b0:57f:ef11:acf9 with SMTP id c141-20020a624e93000000b0057fef11acf9mr18045290pfb.10.1672039600680;
        Sun, 25 Dec 2022 23:26:40 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id a7-20020aa795a7000000b0056cea9530b6sm1845037pfk.202.2022.12.25.23.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 23:26:40 -0800 (PST)
Message-ID: <a42f1d1a-3eda-83dc-7806-7ea2c9e7656a@gmail.com>
Date:   Mon, 26 Dec 2022 15:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V2 10/18] drivers: hv: Decrypt percpu hvcall input arg
 page in sev-snp enlightened guest
Content-Language: en-US
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
 <20221119034633.1728632-11-ltykernel@gmail.com>
 <BYAPR21MB168878729E4A76AFC9B3E053D7E09@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB168878729E4A76AFC9B3E053D7E09@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/15/2022 2:16 AM, Michael Kelley (LINUX) wrote:
>> @@ -134,6 +136,16 @@ int hv_common_cpu_init(unsigned int cpu)
>>   	if (!(*inputarg))
>>   		return -ENOMEM;
>>
>> +	if (hv_isolation_type_en_snp()) {
>> +		ret = set_memory_decrypted((unsigned long)*inputarg, 1);
>> +		if (ret) {
>> +			kfree(*inputarg);
> After the kfree(), set *inputarg back to NULL.  There's other code that
> tests the value of *inputarg to know if the per-CPU hypercall page has
> been successfully allocated.
> 

Good point! Will add in the next version.
