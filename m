Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9FB688FFC
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 08:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBCHA5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 02:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjBCHA4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 02:00:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1405F65EEA;
        Thu,  2 Feb 2023 23:00:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l4-20020a17090a850400b0023013402671so7930129pjn.5;
        Thu, 02 Feb 2023 23:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwqQ7dTzglUPvW7FiYTF4tlugby7dSi3QDvb/pRU6so=;
        b=KU/PXxP43Wu5mush0paSvuUGEsjcE1vGXNErzChZ3H/kx0ZMJJNrQXuQ6u4QiRLsy7
         ML2rZMtOhcZQkBncXiaUO2J9F7Ly6JumAV68HZrW3UVE7Z33ZioAamx/bOpjr7K1D9d/
         unqRXgBsCD6ZPraqSuJuAwPj06ukSN68h7+JEgmkrn6PFGn4aU+oWXbCILmvbHrOLjor
         mcNcUZKgckiYVxeJ4CbV1SvZGH3/o/kCu83pquVySiX3UfWe4H60LHsVjSsouxRSzBQl
         ZCqJycr8Su856LQsAScNIJyT49+RK/wcK53gej1cFSGFxBJeOLhF0RF51fYxkcPn44M9
         tk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwqQ7dTzglUPvW7FiYTF4tlugby7dSi3QDvb/pRU6so=;
        b=2zvL8KclBj63PaXEJad+XFvLehYBmyxe209l8WFGB762IQYwXt/vUTKuT1P2YNoZuE
         7CZg1lijXatyUg15M9cBsFJ8/LFUV1GkZ2xudz3tyK42IGZRjbOXQ/DVUZi95T5IGwwW
         cDxe4VL3d0VhUkaSwoYHwPUSnzMVzeWZDY/Qg1dg4OYr/ghZHUT6vsimpWBkpOjNqLct
         7lPTvZ2JPXVpUssIm32DkRJyvrtmrt7QIkwwLYzO23IZmIU+9DpNkPrttAOld2tBn8bo
         AC3obBEAjT/ogyBZM9hQBB5541y9NFunuiQSYL1MJiit1a24ZdPKEFauRZ3sBhP9lMvn
         NTfQ==
X-Gm-Message-State: AO0yUKWIcd0jJLz6+X1UQJBehliYDKQXnTxk+wOoZdZqAENSb4/NUC8s
        5+cwMeTlRuADLNDOq6iDJGCeUk34reBoJQ==
X-Google-Smtp-Source: AK7set/4r1Yd3ym9LGZwmJiAV/I24VPctNUSU10TEez+Qk+piovBGWFFYF1N/uuY/eX5s6HoA/1Q+g==
X-Received: by 2002:a17:902:d1cb:b0:196:125a:e4b8 with SMTP id g11-20020a170902d1cb00b00196125ae4b8mr6366704plb.12.1675407655585;
        Thu, 02 Feb 2023 23:00:55 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id jh3-20020a170903328300b001966297bbbfsm807661plb.197.2023.02.02.23.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 23:00:55 -0800 (PST)
Message-ID: <ce9b4a79-b877-211d-aee8-bbc02e6805b5@gmail.com>
Date:   Fri, 3 Feb 2023 15:00:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 10/16] x86/hyperv: Add smp support for sev-snp
 guest
To:     Tom Lendacky <thomas.lendacky@amd.com>, luto@kernel.org,
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
        michael.roth@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-11-ltykernel@gmail.com>
 <62ffd8b2-3d88-499e-ba13-1da26f664c6f@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <62ffd8b2-3d88-499e-ba13-1da26f664c6f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/23/2023 11:30 PM, Tom Lendacky wrote:
> On 1/21/23 20:46, Tianyu Lan wrote:
>> From: Tianyu Lan <tiala@microsoft.com>
>>
>> The wakeup_secondary_cpu callback was populated with wakeup_
>> cpu_via_vmgexit() which doesn't work for Hyper-V. Override it
> 
> An explanation as to why is doesn't work would be nice here.

Hi Thomas：
	Thanks for your review. Good idea. Will update.

>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index cb1ee53ad3b1..f8b321a11ee4 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -336,6 +336,53 @@ struct vmcb_save_area {
> 
> Please don't update the vmcb_save_area, you should be using/updating the 
> sev_es_save_area structure for SNP.

OK. Will update in the next version.

>>             u64 sev_feature_restrict_injection    : 1;
>> +            u64 sev_feature_alternate_injection    : 1;
>> +            u64 sev_feature_full_debug        : 1;
>> +            u64 sev_feature_reserved1        : 1;
>> +            u64 sev_feature_snpbtb_isolation    : 1;
>> +            u64 sev_feature_resrved2        : 56;
> 
> For the bits definition, use:
> 
>              u64 sev_feature_snp            : 1,
>                  sev_feature_vtom            : 1,
>                  sev_feature_reflectvc        : 1,
>                  ...
> 

Good suggestion. Thanks.
