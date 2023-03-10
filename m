Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0D6B4BE3
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 17:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCJQEI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 11:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCJQDp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 11:03:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E22E20D7;
        Fri, 10 Mar 2023 07:59:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so8132308pjn.1;
        Fri, 10 Mar 2023 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678463980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWnJVZ8zQQjr3m+ec/YY0RjBIDG3ID5LNYQ1rz1/Oz8=;
        b=NI0T0Td9A3HNZQN0TP9/Oy9tSn099iWpj+drYAy75MVTOhjeOPgZ5+eWgpjBme9MnG
         2g+cbSI1nyoDInDo1nyeek5Djxkna4hVmDUuYpInU/uWHiYN3LMIk/tfAIuBxW+2tyn1
         14nREjpGZtRy88PJ/41qfl+nNe5Zsz3XqtX5nbz9G4XOoa3rKGEP7zGVp0jdI8tC3Q/n
         AWB53SqB/OZigs/m7mediAezuMDz5MAJHmO4m5lIaKPyc8g4v1NQjspjYMJYcxTxSvqV
         uNkb3GFBTJ3B6PLJlmI840vrr/kETkiAhnuA+0vKhVIumC2CaAWa6+SEDVNQL5ZxlnQa
         JoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678463980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NWnJVZ8zQQjr3m+ec/YY0RjBIDG3ID5LNYQ1rz1/Oz8=;
        b=iNvY4ITIt+SJJG+ubuOvqQgqzAxSOOvpF8m8pMm6VSY2PMuqjccC3+HflXONXAvC0t
         HZE6oqhhWqNs5BecPa1qKy8F7Rbf7ZQ3zZZym5Yu55f06L84tK7CGn19co2RE8Hux4M+
         fgvfWBXd8ZkC3GI1mwFoa9Q0dn21yr+Gzb6hu9MDM7ggXZpA80mHFFF/aT6CGCXFcFkf
         2JXY4jkdLxaVPU3Fzg8XUo8Zd+48AWNR0ckuvOspxC5J6PheuI9HBkrl4KGYL/sZd+sN
         WgogJS6MllN+MApPQuq0R476pFkSv9ATQMFMnhFE6FjH0MkvTJrZa1Ud/bTHDPf0fth6
         W0Wg==
X-Gm-Message-State: AO0yUKXHETQXUmwgvqqvduPHpe4QwqQYqcbBH5xEWtemesksenhzXESz
        62P/+B2/+fwvAFNX3wrQ44Y=
X-Google-Smtp-Source: AK7set8XFDjfWUFpUZ1jwhLdRFQs6vHNkY0lsEzycNkocnnPuw2epZbY19gvtm05W7ILqpWvzHfolg==
X-Received: by 2002:a17:903:2291:b0:19e:b988:e81f with SMTP id b17-20020a170903229100b0019eb988e81fmr24925943plh.0.1678463980123;
        Fri, 10 Mar 2023 07:59:40 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902d64300b00196025a34b9sm191815plh.159.2023.03.10.07.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 07:59:39 -0800 (PST)
Message-ID: <cdfe4403-edd9-f265-1ea3-2aa57c0edddc@gmail.com>
Date:   Fri, 10 Mar 2023 23:59:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V3 13/16] x86/sev: Add Check of #HV event in path
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
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-14-ltykernel@gmail.com>
 <e3c53388-f332-5b52-c724-a42d8ea624a7@amd.com>
 <5061dfee-636c-6b68-8f33-5f32e5bfa093@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <5061dfee-636c-6b68-8f33-5f32e5bfa093@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/9/2023 12:18 AM, Gupta, Pankaj wrote:
> On 3/1/2023 12:11 PM, Gupta, Pankaj wrote:
>> On 1/22/2023 3:46 AM, Tianyu Lan wrote:

>>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>>> index a8862a2eff67..fe5e5e41433d 100644
>>> --- a/arch/x86/kernel/sev.c
>>> +++ b/arch/x86/kernel/sev.c
>>> @@ -179,6 +179,45 @@ void noinstr __sev_es_ist_enter(struct pt_regs 
>>> *regs)
>>>       this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
>>>   }
>>> +static void do_exc_hv(struct pt_regs *regs)
>>> +{
>>> +    /* Handle #HV exception. */
>>> +}
>>> +
>>> +void check_hv_pending(struct pt_regs *regs)
>>> +{
>>> +    if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>>> +        return;
>>> +
>>> +    if ((regs->flags & X86_EFLAGS_IF) == 0)
>>> +        return;
>>
>> Will this return and prevent guest from executing NMI's
>> while irqs are disabled?
> 
> I think we need to handle NMI's even when irqs are disabled.
> 

Yes, nice catch!

> As we reset "no_further_signal" in hv_raw_handle_exception()
> and return from check_hv_pending() when irqs are disabled, this
> can result in loss/delay of NMI event?

Will fix this in the next version.

Thanks.
