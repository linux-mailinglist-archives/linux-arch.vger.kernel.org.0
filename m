Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B777244B5
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jun 2023 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbjFFNnm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jun 2023 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFFNnl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2023 09:43:41 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE610C0;
        Tue,  6 Jun 2023 06:43:40 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bad102ce9eeso6869495276.0;
        Tue, 06 Jun 2023 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686059020; x=1688651020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9EwgLTm3uk2N6CWlYnbzgRJMZwF8wSB6ctMqYZN5fM=;
        b=ScyjYBSHXfb6/G7Id3dmt1S5h6e8i8rKdofIgjnD2Qa5IMUdF5Od5tAfZkT0BDw/ES
         Ig2zpA1UMe2J8Ps674PaT6EtdQWv9Z9HI7UMu02v3qkHff1PKtcowCwR958P6f3U1a+D
         AwlEykPiUgTAYa5ybNJ8sjozYvEhC1+UCIghB85LLNto4j9NZ3/1iBwF1I+89tyLItw8
         L6mA1C39XxDzE1+vns4IHMmJ7H83uT2sHhmisGmIZx/OWT7c2wBv5C3BqSmgt5G2hlDe
         2C1bD3LE0XlJ+qdwuTIbJyBs+U4CvTieUMeqh4BfyPDH4UI4cczC8wQVlTRdJB3vTVbS
         p8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686059020; x=1688651020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9EwgLTm3uk2N6CWlYnbzgRJMZwF8wSB6ctMqYZN5fM=;
        b=I6xhb0lxLufSdsUOKo9r/H79yM0DS/BrwhuZK3ujw0/Bb50MkOesHh5wBsLEABRM1o
         K3RS5/DAJShzzYMAxLg3R3WdWmSeYQuRU6KBFC00wNRJvXgslFf87B3ykQ/jrPmTKh1I
         fTVc3zUBJJ4L1gQdadvbWWnDnTW40zbJAWEoJQKkoB8YtYtIgR9ErP112PWWaY5fsSZX
         /CQoAxCMGIjlWPaSItR+j2T4/qa/U37+ay3bkLr3HnR6OtdItTllzXDadiA2rrzf1EoP
         girdRtSZjJ3QNql7HVKQjRruJOp7WiBKlZMu9hl3RBPPTl8dyzWb4M2JrbRcqTvwdjpd
         eD2Q==
X-Gm-Message-State: AC+VfDzOjCjK12HvZDzo3fWykwWHQT2HxlOmYFwXMdjF+n+895blOgjf
        8txRYW04Utwn67bXc68JaaU=
X-Google-Smtp-Source: ACHHUZ5RT6ZZel6x4+GVU8gSGVs0pY79fFr4EWUV/L6R7oWo3J99yAHMnBn7Py5vtQQfbLHfMsMGGQ==
X-Received: by 2002:a25:b003:0:b0:bac:b8bd:65e2 with SMTP id q3-20020a25b003000000b00bacb8bd65e2mr1872806ybf.37.1686059019825;
        Tue, 06 Jun 2023 06:43:39 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090a778b00b0025954958e06sm3671187pjk.18.2023.06.06.06.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 06:43:39 -0700 (PDT)
Message-ID: <693ff56a-9870-9eb0-c4c8-84b4451667cd@gmail.com>
Date:   Tue, 6 Jun 2023 21:43:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/9] x86/hyperv: Add sev-snp enlightened guest static key
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-2-ltykernel@gmail.com> <874jnmkt4p.fsf@redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <874jnmkt4p.fsf@redhat.com>
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



On 6/5/2023 8:09 PM, Vitaly Kuznetsov wrote:
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -402,8 +402,12 @@ static void __init ms_hyperv_init_platform(void)
>>   		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>>   			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>>   
>> -		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
>> +
>> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
>> +			static_branch_enable(&isolation_type_en_snp);
>> +		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
>>   			static_branch_enable(&isolation_type_snp);
> Nitpick: In case 'isolation_type_snp' and 'isolation_type_en_snp' are
> mutually exclusive, I'd suggest we rename the former: it is quite
> un-intuitive that for an enlightened SNP guest '&isolation_type_snp' is
> NOT enabled. E.g. we can use
> 
> 'isol_type_snp_paravisor'
> and
> 'isol_type_snp_enlightened'
> 
> (I also don't like 'isolation_type_en_snp' name as 'en' normally stands
> for 'enabled')

Hi Vitaly:
	Thanks for your review. Agree. Will rename them.

> 
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -36,15 +36,21 @@ struct ms_hyperv_info {
>>   	u32 nested_features;
>>   	u32 max_vp_index;
>>   	u32 max_lp_index;
>> -	u32 isolation_config_a;
>> +	union {
>> +		u32 isolation_config_a;
>> +		struct {
>> +			u32 paravisor_present : 1;
>> +			u32 reserved1 : 31;
>> +		};
>> +	};
>>   	union {
>>   		u32 isolation_config_b;
>>   		struct {
>>   			u32 cvm_type : 4;
>> -			u32 reserved1 : 1;
>> +			u32 reserved2 : 1;
>>   			u32 shared_gpa_boundary_active : 1;
>>   			u32 shared_gpa_boundary_bits : 6;
>> -			u32 reserved2 : 20;
>> +			u32 reserved3 : 20;
> Maybe use 'reserved_a1', 'reserved_b1', 'reserved_b2',... to avoid the
> need to rename in the future when more bits from isolation_config_a get
> used?
> 

Good suggestion. will update.
