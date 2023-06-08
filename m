Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36795728361
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjFHPPo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFHPPn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 11:15:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F662D65;
        Thu,  8 Jun 2023 08:15:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-653fcd58880so504979b3a.0;
        Thu, 08 Jun 2023 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686237341; x=1688829341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55lU3irJzSJsczewYDUgMmkeCe1yQwAopk76mACRoR8=;
        b=bSovjVo5+79ACX4vm6JKqNPLYD4eh3+dh5dMYGQV+oC8Bpqk1J4Y9TM7YsRau2OLk8
         YuHmAxY6xVmI4FZvpwFVSlMokszfSXsExm9JggO3lHIQbcb7i3LqsoK0YJ+zN1CKMwzz
         Oc6J4WV4lX67xNuRNSOX62JOGQ7yjmFMq+nLq9sX/4H3qes1PYjN1ouH4l+g3RckprVY
         NEsWlS0huBmstEvgHDhVp+8YcyYQqnN3gT6yQirbRAeRaX/DKIvLqsKFt5oiXJ2TKHtf
         0hf43xR5VxUx+Cx5BnC17lc/JyKBWMuDov4/4SzeqE0xT+Yq4VcQck/hE3EvpVC9rC8k
         yBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686237341; x=1688829341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=55lU3irJzSJsczewYDUgMmkeCe1yQwAopk76mACRoR8=;
        b=hbL/IL8tbYzZ0sPxeBkLQQFJCTi2DtjfIP9mE+OQstBddlpLveHxQ7V8tttrInAsW4
         /KJx0EJSAutPLgAUgIccrq3BTh99YHBbbq1oJ52WfYEJ/vGU9eOyffM4wew8mokMBQDB
         MbEycWBBSFXJMeMg0EoWT8ejEXqS8wdBh0jk9NNAF1NRjYg7ZfeVbbgA4NziWHz5b+RC
         tf2nBYQUIT48UZUl7j+Xks9nw1DXAm6ME2ta9bZdlqBIY4C2ZSIZRJXowQzgUVyQOB2s
         +dvwcgh0TuqUcmNfPz/lGR3HQ6mnvqMsCkpQzIKoJt2CkSXNXA2geQXDfoTgCsFmd6Ei
         tNKw==
X-Gm-Message-State: AC+VfDwc0/psRp3Cv/yvgolNV684GZHPq3Ws3xMVHC3W8qmGG2KYLSXT
        zuT07dNSh04kX7cQ0I8L/j/GILoefRTruw==
X-Google-Smtp-Source: ACHHUZ42h/CI+r2MG29MXq+ydxY3pg+noX5hvO26RUOoZxcPPTVrrTYRI/PXAtIB3z3/6eLFy951Ug==
X-Received: by 2002:a05:6a00:24cc:b0:64c:c453:244f with SMTP id d12-20020a056a0024cc00b0064cc453244fmr7200998pfv.15.1686237341053;
        Thu, 08 Jun 2023 08:15:41 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id u1-20020aa78481000000b0064fd8b3dd10sm1230826pfn.109.2023.06.08.08.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 08:15:40 -0700 (PDT)
Message-ID: <8b93aa93-903f-3a69-77f9-0c6b694d826b@gmail.com>
Date:   Thu, 8 Jun 2023 23:15:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [EXTERNAL] Re: [PATCH 5/9] x86/hyperv: Use vmmcall to implement
 Hyper-V hypercall in sev-snp enlightened guest
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
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230608132127.GK998233@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/8/2023 9:21 PM, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 11:16:18AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <tiala@microsoft.com>
>>
>> In sev-snp enlightened guest, Hyper-V hypercall needs
>> to use vmmcall to trigger vmexit and notify hypervisor
>> to handle hypercall request.
>>
>> There is no x86 SEV SNP feature flag support so far and
>> hardware provides MSR_AMD64_SEV register to check SEV-SNP
>> capability with MSR_AMD64_SEV_ENABLED bit. ALTERNATIVE can't
>> work without SEV-SNP x86 feature flag. May add later when
>> the associated flag is introduced.
>>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>>   arch/x86/include/asm/mshyperv.h | 44 ++++++++++++++++++++++++---------
>>   1 file changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 31c476f4e656..d859d7c5f5e8 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -61,16 +61,25 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>>   	u64 hv_status;
>>   
>>   #ifdef CONFIG_X86_64
>> -	if (!hv_hypercall_pg)
>> -		return U64_MAX;
>> +	if (hv_isolation_type_en_snp()) {
>> +		__asm__ __volatile__("mov %4, %%r8\n"
>> +				     "vmmcall"
>> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> +				       "+c" (control), "+d" (input_address)
>> +				     :  "r" (output_address)
>> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
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
>> +				     CALL_NOSPEC
>> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>> +				       "+c" (control), "+d" (input_address)
>> +				     :  "r" (output_address),
>> +					THUNK_TARGET(hv_hypercall_pg)
>> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
>> +	}
>>   #else
> 
> Remains unanswered:
> 
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F20230516102912.GG2587705%2540hirez.programming.kicks-ass.net&data=05%7C01%7CTianyu.Lan%40microsoft.com%7C60a576eb67634ffa27b108db68234d5a%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638218273105649705%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=MFj67DON0K%2BUoUJbeaIA5oVTxyrzO3fb5DbxYgDWwX0%3D&reserved=0
> 
> Would this not generate better code with an alternative?


Hi Peter:
	Thanks to review. I put the explaination in the change log.

"There is no x86 SEV SNP feature(X86_FEATURE_SEV_SNP) flag
support so far and hardware provides MSR_AMD64_SEV register
to check SEV-SNP capability with MSR_AMD64_SEV_ENABLED bit
ALTERNATIVE can't work without SEV-SNP x86 feature flag."
There is no cpuid leaf bit to check AMD SEV-SNP feature.

After some Hyper-V doesn't provides SEV and SEV-ES guest before and so
may reuse X86_FEATURE_SEV and X86_FEATURE_SEV_ES flag as alternative
feature check for Hyper-V SEV-SNP guest. Will refresh patch.



