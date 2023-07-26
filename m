Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E407628F3
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 04:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGZC5r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 22:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGZC5q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 22:57:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453EF106;
        Tue, 25 Jul 2023 19:57:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55adfa72d3fso3243041a12.3;
        Tue, 25 Jul 2023 19:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690340265; x=1690945065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk1HjFcBc1GtTDRHtJQF8KdFGzRcJUPncSBKnYseuuM=;
        b=K0vICeWVh3tzWSLAdPbGiR3yhNI964VAqbftkTON5aZ9fVGHVQgr1zz6rz7rbDharv
         1UHEV26Nj3CBk/JQp42/yKehDIq3pI5eGtQFBI0MODSWh/5J6EPfIw9PDPQAqCA9bYR7
         +X/XJ8wcMyAPw+vLP8s2lsWJWq/gSffoc14+au2Q8y4SkUB+Uto/1wdEDnpuY8ltB5g2
         sOb1arx4e6mpoWJjX6zhCrPBzFAy+MBBBKJ7adyz65qzeD2RXausSdEZ3ESlEOYxksh+
         1T7XhOycftQLQcD+3nPch6wbZaUO9JQC/VnxV8ATRAvc07K2kTM483Hd5qB7uo4/EDjd
         ph7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690340265; x=1690945065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vk1HjFcBc1GtTDRHtJQF8KdFGzRcJUPncSBKnYseuuM=;
        b=Dil9TdfENfpL3n5MhVnuTvv5hQhZDZXLa65rRv0b3ZIiqVcM5EypB7ygMJS+gvnZso
         i1EesDIw3a9Kmb1+m08Kf5BfbJxE8iHy4SxmwKJfKB7ec/I8d8BzdrYvCd08z9LI51U3
         3yWjTBIzpyibvu/wpEoi/PQRaRmPrjLXDnFnN8Kz+IXVLHxtCYoVK9u7PlY4QzMnI9Ab
         wcPQgArS4Rf6gzz0lJ344pAtQochikYdmy852HyP2UMhbUdG9LZMGFay2B+UgbcmZvUt
         MfXHj3oCkAYDvxtkLutOoDl44zFzpUetolOIqDQDuhB2b8ZqQD9fjG2SC+4ZAwAkH8qd
         jizw==
X-Gm-Message-State: ABy/qLbsAuMYrVbd66BzewkcagjZiiZkFxpMSW+Xnxpl/42SZG6jga1v
        pFLEmMwJrQKS6svuFZNEvR4=
X-Google-Smtp-Source: APBJJlHFTLyUhR7TdUembZ48HfygjQ6ODz6Q3J5DfEJS0mBMY9b3/X5gEFD9Vsnn+HXY9iSVFYh2kw==
X-Received: by 2002:a17:902:be07:b0:1bb:8064:91d2 with SMTP id r7-20020a170902be0700b001bb806491d2mr694517pls.69.1690340264626;
        Tue, 25 Jul 2023 19:57:44 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001b8b6a19bd6sm362317plx.63.2023.07.25.19.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 19:57:43 -0700 (PDT)
Message-ID: <6e222bb6-84b4-3bc2-4ed3-5f249d128733@gmail.com>
Date:   Wed, 26 Jul 2023 10:57:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to
 isol_type_snp_paravisor/enlightened()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, arnd@arndb.de,
        kirill.shutemov@linux.intel.com, rppt@kernel.org, nikunj@amd.com,
        thomas.lendacky@amd.com, liam.merwick@oracle.com,
        alexandr.lobakin@intel.com, michael.roth@amd.com,
        tiala@microsoft.com, pasha.tatashin@soleen.com,
        peterz@infradead.org, jpoimboe@kernel.org,
        michael.h.kelley@microsoft.com
References: <20230725150825.283891-1-ltykernel@gmail.com>
 <871qgwow1q.fsf@redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <871qgwow1q.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/25/2023 11:22 PM, Vitaly Kuznetsov wrote:
> Tianyu Lan <ltykernel@gmail.com> writes:
> 
>> From: Tianyu Lan <tiala@microsoft.com>
>>
>> Rename hv_isolation_type_snp and hv_isolation_type_en_snp()
>> to make them much intuitiver.
>>
>> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> 
> Thanks for the patch! A few comments below ...
> 
>> ---
>> This patch is based on the patchset "x86/hyperv: Add AMD sev-snp
>> enlightened guest support on hyperv" https://lore.kernel.org/lkml/
>> 20230718032304.136888-3-ltykernel@gmail.com/T/.
>>
>>   arch/x86/hyperv/hv_init.c       |  6 +++---
>>   arch/x86/hyperv/ivm.c           | 17 +++++++++--------
>>   arch/x86/include/asm/mshyperv.h |  8 ++++----
>>   arch/x86/kernel/cpu/mshyperv.c  | 12 ++++++------
>>   drivers/hv/connection.c         |  2 +-
>>   drivers/hv/hv.c                 | 16 ++++++++--------
>>   drivers/hv/hv_common.c          | 10 +++++-----
>>   include/asm-generic/mshyperv.h  |  4 ++--
>>   8 files changed, 38 insertions(+), 37 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index 2eda4e69849d..2911c2525ed5 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -591,24 +591,25 @@ bool hv_is_isolation_supported(void)
>>   	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
>>   }
>>   
>> -DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
>> +DEFINE_STATIC_KEY_FALSE(isol_type_snp_paravisor_flag);
>>   
>>   /*
>> - * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
>> + * isol_type_snp_paravisor - Check system runs in the AMD SEV-SNP based
>>    * isolation VM.
>>    */
>> -bool hv_isolation_type_snp(void)
>> +bool isol_type_snp_paravisor(void)
> 
> 
> I think that it would be better to keep 'hv_' prefix here for two reasons:
> ...
> 

Agree. Will update.

Thanks.

