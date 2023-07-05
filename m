Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A487486A8
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjGEOnq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 10:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjGEOno (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 10:43:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA71723;
        Wed,  5 Jul 2023 07:43:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad9eede0so8036825ad.1;
        Wed, 05 Jul 2023 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688568213; x=1691160213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU+as7wi3eWeTFoM78W/MqGEZzj4O8MVzCBXBVMDvTE=;
        b=CDviufEV0708sItf7c2FKXs4Jfh5YrsBI5pHDUqAWLyDcd53zSNBPcoXBLPuuUXTH0
         ptCs47ERg/pFhIRrt3Jc60JmJX/7wPV2FNsGT2xnhpBX/EF5HloGSLijrlRcGhk/qPHP
         3ATxszMjeg6fsrz/NB7zi39ZpD9++HpqERXRQQnxKqp4o++EdRmK0A0mSJfrIv0cNTSU
         k7Fh+DBpLDEnkyPkXrFxbMX5lrJxtpfnCZGAkOsLVIuERmXQw8SkVp8L5ZFoSljBNbty
         0dGLBtN9XHEywpg7kMAFcKwtpsZ0M4GgvbNXV78zc2wLaOTh6RgYfrkbNyVHYWvGlgoj
         RMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688568213; x=1691160213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JU+as7wi3eWeTFoM78W/MqGEZzj4O8MVzCBXBVMDvTE=;
        b=LZgY2jHTtCjxgvxO4rf6Gk3j/sow86+rlfVvQ0kiCttzVjNQieAFNn+dt1fsZvEAjH
         QOpAMbfGsLp/dH0ZUDQ1loxMFSc4maeXbzpejGeTijuIhcPpw+rdiaEBLqB5Y4b9ywOM
         ZYIxptVZTd2PGk3VC30ztkF7ZM/niFWaxIunu6QQEBEObYr9gCWl/IGNrUn1Dg+I6ncf
         MRngIgVCPnHjYQEt2VNGFdwEZvSdDwBf49P7TqNCsDI1E84QkD25smL6iF2eyaY/Y5Ew
         x61wJg1/NWjekv1o+FS5fq2GkrhPhc8fHb2+M5eHNQhCNnJJ2dSEKO/t/hqAePTh1Oth
         Fc3Q==
X-Gm-Message-State: ABy/qLYFhuQEAD9Z9/fNBxjtreI3GghDo1f6N2LxbsAxGyLfE3VzcqgM
        uXGbCJS6E+lsWWSTaoi6v9tMod7Iy2RVew==
X-Google-Smtp-Source: APBJJlFPaTaZfq7+Sz5pIUtEQPN4UM27g9oO2o1OevevI5ribpX1uyVE8K/jeL4+S3Ctqyt3W5B3CA==
X-Received: by 2002:a17:902:c40c:b0:1b8:8dbd:e1a0 with SMTP id k12-20020a170902c40c00b001b88dbde1a0mr12991090plk.13.1688568213440;
        Wed, 05 Jul 2023 07:43:33 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902868300b001b04b1bd774sm19078415plo.208.2023.07.05.07.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 07:43:33 -0700 (PDT)
Message-ID: <ecd0aa48-90a4-50cb-7a4e-b7a6419576ce@gmail.com>
Date:   Wed, 5 Jul 2023 22:43:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 1/9] x86/hyperv: Add sev-snp enlightened guest static
 key
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-2-ltykernel@gmail.com>
 <BYAPR21MB1688570E8D0D0C49B68DD548D72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB1688570E8D0D0C49B68DD548D72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 7/4/2023 10:17 PM, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, June 26, 2023 8:23 PM
>>
>> Introduce static key isolation_type_en_snp for enlightened
>> sev-snp guest check.
>>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>>   arch/x86/hyperv/ivm.c           | 11 +++++++++++
>>   arch/x86/include/asm/mshyperv.h |  3 +++
>>   arch/x86/kernel/cpu/mshyperv.c  |  9 +++++++--
>>   drivers/hv/hv_common.c          |  6 ++++++
>>   include/asm-generic/mshyperv.h  | 12 +++++++++---
>>   5 files changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index cc92388b7a99..5d3ee3124e00 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -409,3 +409,14 @@ bool hv_isolation_type_snp(void)
>>   {
>>   	return static_branch_unlikely(&isolation_type_snp);
>>   }
>> +
>> +DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
>> +/*
>> + * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
>> + * isolation enlightened VM.
>> + */
>> +bool hv_isolation_type_en_snp(void)
>> +{
>> +	return static_branch_unlikely(&isolation_type_en_snp);
>> +}
>> +
> 
> Vitaly had suggested some renaming of this and related variables and
> functions, which you had agreed to do.  But I don't see that renaming
> reflected in this patch or throughout the full patch set.
> 

Hi Michael:
	Thanks for your review. I am preparing a separating patchset to rework 
hv_isolation_type_en_snp() and hv_isolation_type_snp() according to 
Vitaly suggestion because it will touch more files and not affect 
SEV-SNP function.

Thanks.
