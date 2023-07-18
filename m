Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9C75736F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 07:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGRFw1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 01:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGRFw0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 01:52:26 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3836910C7;
        Mon, 17 Jul 2023 22:52:25 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-55e04a83465so3392395eaf.3;
        Mon, 17 Jul 2023 22:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689659544; x=1692251544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdprTsF43JhnGLQ7TKBfm7c4J0WkCWqyFS35pHh0IrI=;
        b=leqmFlJruAGU2RrfUqEif6aEHuDId6bW/g33QH8+acqPMPTgdWidIMMPxpUGHkUO7U
         vydNr5BhYkWqRhIkyuzXhlEHjXlD+fNlbZ57vhXA2xmr7IB1UQT9aZCI6aimt4KUZuVq
         NmEBAhB9Ew+PAhAl+Qyr7R2fcnzBCQ+WXybLmb5jDjJBKnjvLI852QchrX1syQK11pRy
         zIWlzHsE2X3YEf7KvPTCe+RiArEuJjXLNnVj12Y8IgBfXj+zAS9ZkjPYDXCkktA1RnLA
         wHP5Gef2ZnN7o0lEtMg5UzYfSgYf6ts8feBNgng3Ye03d2XDRVv22WSdhZCD5ADI5mRf
         ooAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689659544; x=1692251544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vdprTsF43JhnGLQ7TKBfm7c4J0WkCWqyFS35pHh0IrI=;
        b=SxgFkdVXHrjOhZnNXWrJXK45Pm6hzrfv16wozagTTvHsfNTwQIDqfyVY6ux1w2FE1F
         Sf0p5rlePMCjQ+KFduCTMzK/x+KkmRUgrCCrXiGop5RVEIrTRuQ36HT3awcznLOM2zFc
         8srlVFZLqrSn7hVyaxA+U/OnHBmU+slPrzdlQOmCTvXTjnB3/10lxNF0p0FL7Fc3SjbP
         NGn7XUb0qlZ5MBVQa3+nGSks60CuMmz/CW/6GRCUbLr7OX/SfW17IbUfPcZlpWQBr/Jb
         9bossJQ+/ki/Du7EXSNQawWUsismhdtpl2afFeE0FAkrYOZMqQYR53YlSkITgcIf/yC6
         Tpjg==
X-Gm-Message-State: ABy/qLa5eE26zJs8GNgMkQJh6HmGHHO4EN+RLEJoo7dsepRhKuQ853f4
        BqQVGpjTUfMjLdPWl79ZJlA=
X-Google-Smtp-Source: APBJJlEkJ50GPEiJ2NBFcvsDtbvhoYvX5llixCR9BxIJKINL5VAmv//UgOFTDCwdI6+mFsfGA45qCg==
X-Received: by 2002:a05:6358:7e0f:b0:134:c739:75f7 with SMTP id o15-20020a0563587e0f00b00134c73975f7mr2170942rwm.12.1689659544367;
        Mon, 17 Jul 2023 22:52:24 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id j24-20020aa78d18000000b00679fef56287sm719628pfe.147.2023.07.17.22.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 22:52:23 -0700 (PDT)
Message-ID: <ff8a3cea-10a2-1f27-d5eb-4c93d9992c5f@gmail.com>
Date:   Tue, 18 Jul 2023 13:52:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
> Tianyu Lan <ltykernel@gmail.com> writes:
>>   int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index c7969e806c64..9186453251f7 100644
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
> 
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
> 

Hi Vitaly:
	I will do such rename the function in the following patchset and this 
will not affect SEV-SNP function.
