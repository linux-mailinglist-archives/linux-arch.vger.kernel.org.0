Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2C7637FC
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGZNrV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jul 2023 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjGZNrU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jul 2023 09:47:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B12132;
        Wed, 26 Jul 2023 06:47:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6686ef86110so3921563b3a.2;
        Wed, 26 Jul 2023 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690379233; x=1690984033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEBKhKypwi18xxxSmsgWv/sCzbnXlTbhCGDL5CnIwBs=;
        b=oAG8YTthjsWVst5LYf9Yoh23BB4vaB5UxkzszQpivFMLZ7ZJTQBmTsgUrPMeg5shCe
         iB3lRuUcFe3GhugNGsqkHi1JTuVJPJDecXnF3Q+rv1msYgPJSDjk1NIMWydK8cnCPTM7
         gRj6JlUm6GZNvLJSXA7sG9+ZauWIeG5Rb1IQA7UxQJ/97RGz4Em0aCFgjNEuAWRwl3ol
         kT09WO10Ba0KrSx7nXuXmKTyV98R9yXXmQytmq/KO5shc9bdKOR3uPq+ZEvg+H7I7+SB
         vzGbYPg4HODpIT1vGFrfSIapB86zcJe3BK1fCq5e78J4m/VlSKCO1TG0F7dLqgS0Rgnt
         anzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379233; x=1690984033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OEBKhKypwi18xxxSmsgWv/sCzbnXlTbhCGDL5CnIwBs=;
        b=lwjMVz7ADWyIrtw4whlPlVK08KbMGWLfjt8RoWzqLK8kmpKM0TOe7hKaLGkYr326Bq
         ri91OmqHtrgQYq5q+1njr8pfYAVQSoGlDpi2R+kgPEQWSKm65oDze2fUup02Lyd81ht/
         /GSD3rRdIDVTT8ftoUhWt67viT0GAFDztV2NVvUzhjNEqZuFRiPghafzUbcfqVLX1Gsz
         5EK/8tAMVTV8Zus2CKvj2eRDmu712dP87lDRCu5WPJ8EWRf39wOHpZoS5J6iapR/j+Rs
         O5NodcxlCV1Sa2KTA/64p1EYt+ZxJ/VeX6rH3QwxNJLVxOFwvM8lpvot/t328tmmm5oN
         Nb4Q==
X-Gm-Message-State: ABy/qLZrW4QfEklEXU7YKzDpY1jbXd1ihADQbvKGB/HIu/i6QfOr7eUf
        Bd8KDYiJBSTd92HoZqmTOfs=
X-Google-Smtp-Source: APBJJlG6byCNG8nM2Kh9w7hx73fBCHkLxoIk8j7UuPR1teP4xJ942NmwS+sWdAOXSVUiefiebxDOWA==
X-Received: by 2002:a05:6a00:1798:b0:686:a10b:e8b with SMTP id s24-20020a056a00179800b00686a10b0e8bmr2557408pfg.8.1690379233356;
        Wed, 26 Jul 2023 06:47:13 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78146000000b0066a31111ccdsm2068292pfn.65.2023.07.26.06.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:47:12 -0700 (PDT)
Message-ID: <89c9f27c-f539-ef75-dc67-bdb0a8480c4b@gmail.com>
Date:   Wed, 26 Jul 2023 21:47:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH V3 5/9] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
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
References: <20230718032304.136888-1-ltykernel@gmail.com>
 <20230718032304.136888-6-ltykernel@gmail.com>
 <BYAPR21MB16882FAEDEFAED59208ED9E0D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16882FAEDEFAED59208ED9E0D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/26/2023 11:44 AM, Michael Kelley (LINUX) wrote:
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 2fa38e9f6207..025eda129d99 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -64,12 +64,12 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>>   	if (!hv_hypercall_pg)
>>   		return U64_MAX;
>>
>> -	__asm__ __volatile__("mov %4, %%r8\n"
>> -			     CALL_NOSPEC
>> +	__asm__ __volatile__("mov %[output], %%r8\n"
>> +			     ALTERNATIVE("vmmcall", CALL_NOSPEC, X86_FEATURE_SEV_ES)
> Since this code is for SEV-SNP, what's the thinking behind using
> X86_FEATURE_SEV_ES in the ALTERNATIVE statements?   Don't you need
> to use X86_FEATURE_SEV_SNP (which is being added in another patch set that
> Boris Petkov pointed out).

Hi Michael:
	Thanks for your review. The patch mentioned by Boris has not been 
merged and so still use X86_FEATURE_SEV_ES here. We may replace the 
feature flag with X86_FEATURE_SEV_SNP after it's upstreamed.

> 
> Also, does this patch depend on Peter Zijlstra's patch to support nested
> ALTERNATIVE statements?  If so, that needs to be called out, probably in
> the cover letter.  Peter's patch doesn't yet appear in linux-next.
> 

It may work without Peterz's patch. Please see 
https://lkml.org/lkml/2023/6/27/520.
Peterz's patch optimizes ALTERNATIVE_n implementation with nested 
expression.
