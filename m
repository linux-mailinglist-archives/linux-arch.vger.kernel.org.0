Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806216B4BF2
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCJQGH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 11:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjCJQFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 11:05:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D60D1C321;
        Fri, 10 Mar 2023 08:03:08 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z11so3941557pfh.4;
        Fri, 10 Mar 2023 08:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678464188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRM1CHPWj5Hky3ZAQSiDMG0dbAi4baYtTfySHDfx8JQ=;
        b=ljyCo1ovyO4+NmdKbPBVy4fXHW8xT8V6loKZ6JQan/QuvbTRCFw2yvjt/2faboQLSq
         zXc1drJ3GWX5MxohA/mPBRDSNEpLHGJ+6rzey+C9ctP352wiPIMJ5PIRwt+mVZ0X9zEI
         jk92ORsjBgHRSlj8vPDnkmx/NKbJEEoHdFCpFlCtnPA7tDhLUflWQ5VGJYdpqQ0JjgXy
         3tbHtWOlkPazMOSFdzc1PzZ8j8dbTJ/ZPlqVvJVqHqMP7iU+ABnxNn2araYmJAu+eZgy
         y0PRfjFEh7p+K01r+kJ3vKWzUBNez7JafZRhGsrZ4PxXE4j7zI6f+siLa4otwvIhaabR
         8qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678464188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRM1CHPWj5Hky3ZAQSiDMG0dbAi4baYtTfySHDfx8JQ=;
        b=7Wwg5PTxJZEKuPW2aoT3qL8ZPYL0WgfruleuepyNQi07cT6P6OvG+eY5ncoRX5Jl3y
         aVgE2b0LFgeeFjQsFFf/22jJluumw8MT3wl57L6ejRsQYARxMU8PVIXMQ6ZoXLotDaxo
         9+R13bSiUOhaZKdO4+oI2iEyqQbxNSTQtMHfAZvZyFY7Wnl/PfBLmlPl4LlYrhTdUYhs
         b7hF4qg8K6mu4QVBS393hdbqJhDXGZIF5QXmUGJJXCh6ccrxxZBd6PCEUqOs6U3/nUyG
         lMh/jgc/002sjGkrQAgJxVzWM6jORxlR0foSLpRsKGnzNOhB+ESnxfwiMWtAcBEJRbTS
         MI9A==
X-Gm-Message-State: AO0yUKXxPV5DjRWj8y9YGQ/fd7OL67PE9X+DecYZMUKgatYEsPQIEqx3
        4NC0ddOPGxuFxzo0+8TlUwk=
X-Google-Smtp-Source: AK7set90MDVxHF11XNGI4ExxJV62tZ4zuLmeorOUCUEL9sc/WcgkKOmRrK4NOf/qurDPDoNfi06J0Q==
X-Received: by 2002:a62:3205:0:b0:5dc:e03d:b95 with SMTP id y5-20020a623205000000b005dce03d0b95mr22015611pfy.12.1678464187698;
        Fri, 10 Mar 2023 08:03:07 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id f17-20020aa78b11000000b00571cdbd0771sm9980pfd.102.2023.03.10.08.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:03:07 -0800 (PST)
Message-ID: <1e620e45-4ab6-ae2a-18f7-d0a5521c6c7f@gmail.com>
Date:   Sat, 11 Mar 2023 00:02:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V3 16/16] x86/sev: Fix interrupt exit code paths from
 #HV exception
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
 <20230122024607.788454-17-ltykernel@gmail.com>
 <65f08b1e-ecae-7100-cdbe-79e07ade90e4@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <65f08b1e-ecae-7100-cdbe-79e07ade90e4@amd.com>
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

On 2/22/2023 12:44 AM, Gupta, Pankaj wrote:
>> @@ -2529,3 +2537,25 @@ static int __init snp_init_platform_device(void)
>>       return 0;
>>   }
>>   device_initcall(snp_init_platform_device);
>> +
>> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, 
>> irqentry_state_t state)
>> +{
> 
> This code path is being called even for the guest without SNP. Ran
> a SEV guest and guest crashed in this code path. Checking & returning
> made guest (non SNP) to boot with some call traces. But this branch 
> needs to be avoided for non-SNP guests and host as well.
> 

Nice catch! I will fix it in the next version.

Thanks.
