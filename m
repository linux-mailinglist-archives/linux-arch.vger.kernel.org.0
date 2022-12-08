Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A5664719A
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 15:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLHOXc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 09:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiLHOWt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 09:22:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFF887CBE;
        Thu,  8 Dec 2022 06:21:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so4777284pjj.2;
        Thu, 08 Dec 2022 06:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqtUGDeRhyIU0uvL6sB1iilGR2QZ+QgSxzpj3bG0/0w=;
        b=XbzNLFQn2MkS6jKtKCqOuDgonun+mWLHs+6xOUJWR9JbHFWiwxJUIcyHlCqydnO1w0
         raO/wFAEMQwlhYleVtmSMFLq/T1EL+n+FX3ZPasyKW8KlNyaceOFzUHCaLNgF4X3TRTD
         ySOR+k+3O5bIdPFTcyM6yHwcDL6CUmRcFz9MxSo6695POP/0H/13HaLeiqgMtGVomMIr
         EggUyaQcI6bfI3BYr42b2sBxh9H163oibE82E1udhNDJWwSVlRQ5TfycS6NdiOX3L82Z
         W55jWqFZd0e5JWvKrghbGpG3WPwk5y2y/u2UCyIX8jRvnmcBQ+VIas5MsptNokxHLuGS
         p8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqtUGDeRhyIU0uvL6sB1iilGR2QZ+QgSxzpj3bG0/0w=;
        b=mIZNY0/TVMSANfW899puJVNyBUmjdMAO/xiNZfWmTq9QsVwrz1V++wazzKSJX0IvIs
         wXsPuULJxav+Wj5K5Dhc2b3Ew1D9NJEvDc+x6PsePoW3fzlN+E6Vy1MkbsYG7YowXIE7
         N6U2xjhfyxb20/vaZbU1Cm1tcH7H0OjkqMFh1M1LSJzCoXKrCSL/ljKqpFDusOqSVM19
         HqVgU7fGdDrUhY96nyG/PDwtdZ1OFuHXJDE27Rd1fWZG+Tb5t/emoBcnaCJGKkGfCfkI
         3n2oN+2c/sIOsOBftwihlDjC+FXWXwgvPmaST4QSlonjqjeorrx6W8bpoxtZorK/UePT
         Atqg==
X-Gm-Message-State: ANoB5pny6+KyAPfDZHQwAwttNZLO+N1CGnXxlxij8cj08cVJLA2/yJo8
        purFbYSFj41IcqfbED/gLpY=
X-Google-Smtp-Source: AA0mqf62yqWGX4NSoquH8/vJ6ywT+lO47rCgmhBS/AlPQYSxPcvr5USAYB11rckMDH3o8dzPiQWkdw==
X-Received: by 2002:a17:903:32cb:b0:189:cca6:3966 with SMTP id i11-20020a17090332cb00b00189cca63966mr21750475plr.89.1670509305032;
        Thu, 08 Dec 2022 06:21:45 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id c129-20020a624e87000000b0057627521e82sm13398950pfb.195.2022.12.08.06.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 06:21:44 -0800 (PST)
Message-ID: <c3123488-1623-831e-783f-dae215b3f457@gmail.com>
Date:   Thu, 8 Dec 2022 22:21:34 +0800
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
 <ddb23472-3f8e-191d-fa5f-d18f1a9e4ad7@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <ddb23472-3f8e-191d-fa5f-d18f1a9e4ad7@amd.com>
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

On 12/7/2022 10:13 PM, Gupta, Pankaj wrote:
>> +#endif
>> +}
>> +
>>   static __always_inline void native_irq_disable(void)
>>   {
>>       asm volatile("cli": : :"memory");
>> @@ -43,6 +59,9 @@ static __always_inline void native_irq_disable(void)
>>   static __always_inline void native_irq_enable(void)
>>   {
>>       asm volatile("sti": : :"memory");
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +    check_hv_pending(NULL);
> 
> Just trying to understand when regs will be NULL?

check_hv_pending() will be divided into two functions.

The one handles #hv event in the #HV exception code path.
The other one handles pending irq event in the irq re-enable
code path。 In this version, the "regs = NULL" for check_hv_pending()
is used in the irq re-enable code path.

