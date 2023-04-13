Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404B36E0536
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 05:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDMD3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 23:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMD3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 23:29:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B12139;
        Wed, 12 Apr 2023 20:29:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a52674f1abso9563125ad.2;
        Wed, 12 Apr 2023 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681356588; x=1683948588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ct5vuDCIzGTNk2BukrX+dS6D2BQBnqAt9BW7ZooNL4=;
        b=i51NDCHer5Nw5tsR6vq2qb3VFxbbEMt8N3XKCTXJn4CRPmo9u1H9DVKr6bUFmKd2qr
         UH6hyyjuajYvY+Ww1ecJgQ6TuYj6o8OL5qV+Kx/mTsHQZhTjA99KJveR27Tupro20RdJ
         AlxAWwLXCTNawsNaoZAs7/nh+vomwU7TGDy8TQCTnGQ3SfZTmPFBdw78aW0Kerczi3Rz
         VTQiPb29KOUwdX7tfrZsi9pkQtvJSV3p9+R7jZB3pX6u5LA5gbFtBAp6FtiU7Sgyq5Bn
         EuQEgt258NXfxoTPwWx+lA9ac4RP70bNejZdgTytiP+IzGz/GoApaUEZnhBKOvmOjjtV
         wmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681356588; x=1683948588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ct5vuDCIzGTNk2BukrX+dS6D2BQBnqAt9BW7ZooNL4=;
        b=LSg2kIDL6pOqSV2HuAYFFI/tqVCvtwc+TJlf3IpgTnnNPRpjcBWSxZ/JHumdXtA4wN
         Qu9GvlNqqgPX6nb3ouO/Z1D+U9mtuxQnse/jKy07K0MgmoPSqQQpdJXfZZFdbHDPLMdY
         ap2o/hG+n/D7CY85SukMk/Tw6LrPo71gXQeOwso/WIvj6aLNbfzV3S16sNF8KOsIA1bF
         AHL9siBUgMFYYA/02i7JvLCbQaO/v5OXdvC9jlK2in1rwW9lNv+QaPKDKbJkMgulQsd2
         McQzYhrs2LFhLpmYiWz9vLJjC4tKIBV2aprbTlZZGX0mSyGddvWKxpPgW6/+BpIpkBal
         Pq2Q==
X-Gm-Message-State: AAQBX9eEOg4AUKyCRixTpW92Jj39vlz2xPKj16tuBfPHlZCecZ0BnIUs
        r2lWe9hx/aGL4Irgw0tlBgQ=
X-Google-Smtp-Source: AKy350a5bJd+5J9hzd7eNKibHMPGrbvJJaBfv31qVnH2TgtZiZ0L8twbCoBPIz9V/kjtsW4YgUp+bg==
X-Received: by 2002:a05:6a00:a1d:b0:637:f1ae:d47 with SMTP id p29-20020a056a000a1d00b00637f1ae0d47mr1369781pfh.17.1681356588596;
        Wed, 12 Apr 2023 20:29:48 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78d45000000b005941ff79428sm199275pfe.90.2023.04.12.20.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 20:29:48 -0700 (PDT)
Message-ID: <518e2a05-a4e8-8dbb-8ba0-8e8cf80a57d2@gmail.com>
Date:   Thu, 13 Apr 2023 11:29:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V4 03/17] x86/hyperv: Set Virtual Trust Level in VMBus
 init message
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
Cc:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-4-ltykernel@gmail.com>
 <BYAPR21MB1688C9F78B11DA2FC7A5AAFFD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB1688C9F78B11DA2FC7A5AAFFD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 4/12/2023 10:24 PM, Michael Kelley (LINUX) wrote:
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
>> +	input = *(struct hv_get_vp_registers_input **)this_cpu_ptr(hyperv_pcpu_input_arg);
> The cast to struct hv_get_vp_registers_input isn't needed here.  Just do:
> 
> 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> 
> I know we have other code that references hyperv_pcpu_input_arg with a more
> complicated code sequence, but it's really not necessary.  At some point, we
> should go back and clean those up, but let's not add any new cases. 😄


Hi Michael:
	Thanks for your review. Yes, agree. I just follow the old coding style 
and will update.

> 
> 
>> +	output = (struct hv_get_vp_registers_output *)input;
>> +	if (!input) {
>> +		local_irq_restore(flags);
>> +		goto done;
>> +	}
>> +
>> +	memset(input, 0, sizeof(*input) + sizeof(input->element[0]));
> Use struct_size() to calculate the size of a structure plus a trailing
> variable size array.
> 
>> +	input->header.partitionid = HV_PARTITION_ID_SELF;
>> +	input->header.vpindex = HV_VP_INDEX_SELF;
>> +	input->header.inputvtl = 0;
>> +	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
>> +
>> +	ret = hv_do_hypercall(control, input, output);
>> +	if (hv_result_success(ret))
>> +		vtl = output->as64.low & HV_X64_VTL_MASK;
>> +	else
>> +		pr_err("Hyper-V: failed to get VTL!");
> Let's include the hypercall status in the failure message.  If a failure ever
> happens, we will really want to know what that status is.  😄
> 

Agree. Will update.

>> rv;
>>   extern bool hv_nested;
>> @@ -58,6 +59,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>>   extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>>   extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>>   extern bool hv_isolation_type_snp(void);
>> +extern bool hv_isolation_type_en_snp(void);
> 

