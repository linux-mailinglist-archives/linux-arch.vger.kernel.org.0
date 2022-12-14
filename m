Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA6764CDA0
	for <lists+linux-arch@lfdr.de>; Wed, 14 Dec 2022 17:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiLNQDY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Dec 2022 11:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbiLNQDB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2022 11:03:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF39321E30;
        Wed, 14 Dec 2022 08:02:55 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so7622698pjs.4;
        Wed, 14 Dec 2022 08:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pgi0dlvSQzyvmNPYDcBWPemtVuLvSRqlLXQqHLtPYrs=;
        b=gbOsj6txcB+1SjQWX1orynLQpHzuvDNm5O70wSyH12Aqh9/qs2jFxWH21CNLHxmyNW
         haHNJjwTnOZwWPcnOFz48k+aMUAQrYumYzZqda2XIM1bCt47/MF8hgIn+OjNLP0TRHms
         HDCC6mfBEz/QKW1xIs5YJ+NfpdVw7dIx+zL2yYcLyjbxpO50qQjYAhCgZqVlkZNq+Exf
         aiJVw0lCpSm66OGurDABwzc/jzTXL3/yhx496XImzSurh5zWHiuBxiZrpbzvDiKQzmW+
         yRZ/eYCsxU1hLx5xIBnT0FT1NTB9OOH0myWg4iaaCDu1MeM063LNUgCt8L86MjOh7ezu
         sb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pgi0dlvSQzyvmNPYDcBWPemtVuLvSRqlLXQqHLtPYrs=;
        b=WY3ip58kV43zHNrJzDSobJ0sp1A20pW+z4RaAwiBn7/jz0nvawOnEDIPLazgFbW+GG
         MD5VKhEXmSRMaI6j6PHocjwo+cQ12L45JAjya8uQ4piNHeQN2HtoCPrfF+fRMBtsLa/Y
         lV3QSZgxehDp1DiCI98+PIYMgIUDelzuoOEVlNi4Xv8ZWzToJANlWhsHafQd0QHVeFgA
         UTpdQ0gf6nKIoSUGJzCIJ4KcKpmo6Sc9QFG+msORkRmTs+iNY+aq6Bh9qsFJwDBO9zCq
         lN61xsJHJA27A9pc8+6DLwrZLbwqr82zdVpzRfkB6060bLktzKHCvm4L/f5QIXGoICME
         XDgg==
X-Gm-Message-State: ANoB5pn6BxAVpeS51/85ArURdDFVep/+RwtJjbTEEiN89y4o9Uwaqz2Q
        2dbbBnoCUgsnuYZ62GFy11s=
X-Google-Smtp-Source: AA0mqf7+v1MReG+8HjWyjL+Nj0IxaZAhG0cM1E+ggHrUtVrYtzWr0e56YvYZVl40ZVQIoJotLAZJbg==
X-Received: by 2002:a17:902:7c0e:b0:18f:9cfb:42aa with SMTP id x14-20020a1709027c0e00b0018f9cfb42aamr13002085pll.10.1671033775182;
        Wed, 14 Dec 2022 08:02:55 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b001896522a23bsm2101678plg.39.2022.12.14.08.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:02:54 -0800 (PST)
Message-ID: <76952ed2-9fee-eae9-c9f3-5a7dd0fc1153@gmail.com>
Date:   Thu, 15 Dec 2022 00:02:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 06/18] x86/hyperv: Use vmmcall to implement hvcall
 in sev-snp enlightened guest
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
 <20221119034633.1728632-7-ltykernel@gmail.com>
 <BYAPR21MB1688016185991B6298EBF308D7E39@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB1688016185991B6298EBF308D7E39@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 12/14/2022 1:19 AM, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, November 18, 2022 7:46 PM
>>
>> In sev-snp enlightened guest, hvcall needs to use vmmcall to trigger
> 
> What does "hvcall" refer to here?  Is this a Hyper-V hypercall, or just
> a generic hypervisor call?

It's should be Hyper-V hypercall. Will make it accurate in the next
version. Thanks for reminder.

> 
>> vmexit and notify hypervisor to handle hypercall request.
>>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>>   arch/x86/include/asm/mshyperv.h | 66 ++++++++++++++++++++++-----------
>>   1 file changed, 45 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 9b8c3f638845..28d5429e33c9 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -45,16 +45,25 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>>   	u64 hv_status;
>>
>>   #ifdef CONFIG_X86_64
>> -	if (!hv_hypercall_pg)
>> -		return U64_MAX;
>> +	if (hv_isolation_type_en_snp()) {
>> +		__asm__ __volatile__("mov %4, %%r8\n"
>> +				"vmmcall"
>> +				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> +				"+c" (control), "+d" (input_address)
>> +				:  "r" (output_address)
>> +				: "cc", "memory", "r8", "r9", "r10", "r11");
>> +	} else {
>> +		if (!hv_hypercall_pg)
>> +			return U64_MAX;
>>
>> -	__asm__ __volatile__("mov %4, %%r8\n"
>> -			     CALL_NOSPEC
>> -			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> -			       "+c" (control), "+d" (input_address)
>> -			     :  "r" (output_address),
>> -				THUNK_TARGET(hv_hypercall_pg)
>> -			     : "cc", "memory", "r8", "r9", "r10", "r11");
>> +		__asm__ __volatile__("mov %4, %%r8\n"
>> +				CALL_NOSPEC
>> +				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> +				"+c" (control), "+d" (input_address)
>> +				:  "r" (output_address),
>> +					THUNK_TARGET(hv_hypercall_pg)
>> +				: "cc", "memory", "r8", "r9", "r10", "r11");
>> +	}
>>   #else
>>   	u32 input_address_hi = upper_32_bits(input_address);
>>   	u32 input_address_lo = lower_32_bits(input_address);
>> @@ -82,12 +91,18 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
>>   	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
>>
>>   #ifdef CONFIG_X86_64
>> -	{
>> +	if (hv_isolation_type_en_snp()) {
>> +		__asm__ __volatile__(
>> +				"vmmcall"
>> +				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> +				"+c" (control), "+d" (input1)
>> +				:: "cc", "r8", "r9", "r10", "r11");
>> +	} else {
>>   		__asm__ __volatile__(CALL_NOSPEC
>> -				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> -				       "+c" (control), "+d" (input1)
>> -				     : THUNK_TARGET(hv_hypercall_pg)
>> -				     : "cc", "r8", "r9", "r10", "r11");
>> +				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> +				"+c" (control), "+d" (input1)
>> +				: THUNK_TARGET(hv_hypercall_pg)
>> +				: "cc", "r8", "r9", "r10", "r11");
> 
> The above 4 lines appear to just have changes in indentation.  Maybe
> there's value in having the same indentation as the new code you've
> added, so I won't object if you want to keep the changes.

OK. Will update in the next version.

> 
>>   	}
>>   #else
>>   	{
>> @@ -113,14 +128,21 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
>>   	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
>>
>>   #ifdef CONFIG_X86_64
>> -	{
>> +	if (hv_isolation_type_en_snp()) {
>>   		__asm__ __volatile__("mov %4, %%r8\n"
>> -				     CALL_NOSPEC
>> -				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> -				       "+c" (control), "+d" (input1)
>> -				     : "r" (input2),
>> -				       THUNK_TARGET(hv_hypercall_pg)
>> -				     : "cc", "r8", "r9", "r10", "r11");
>> +				"vmmcall"
>> +				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> +				"+c" (control), "+d" (input1)
>> +				: "r" (input2)
>> +				: "cc", "r8", "r9", "r10", "r11");
>> +	} else {
>> +		__asm__ __volatile__("mov %4, %%r8\n"
>> +				CALL_NOSPEC
>> +				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> +				"+c" (control), "+d" (input1)
>> +				: "r" (input2),
>> +				THUNK_TARGET(hv_hypercall_pg)
>> +				: "cc", "r8", "r9", "r10", "r11");
> 
