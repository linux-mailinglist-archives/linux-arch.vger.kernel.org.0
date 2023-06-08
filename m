Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503BF728101
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjFHNRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 09:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjFHNRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 09:17:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006FD210C;
        Thu,  8 Jun 2023 06:17:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so324763b3a.2;
        Thu, 08 Jun 2023 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686230254; x=1688822254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy3Bf+NazHm1oNAREFVNFLHJOT3YLCmd5DpqRQr2VCQ=;
        b=YUYKox0MBLRcKzjuScabc+6kkVmePNsualolG63lhkSE9quGcrtR2sA5yxUZ6o19Hj
         HSIEyBTIB8cgjJVS/yCJyA1CONBIelkg8JoYM87R9tSbpkbTgM4ZMZ84BahfkZmoO51K
         C616u1ZgL/AB0Azp3UMrMFcF7GbqZtQHRTrttbDYcB21RKsmsxKzcP3ZtpNXSWQ1LYsu
         l1a6UeXBw2U37KrfomB3NmxfEAaG/R0VOXugJzJBMrvQe9lienwSKvMU5P6oQomgALtn
         6mVVwaZHNI1B4lVtW2r2IUp3lo1mwiAaory6FbjUU3u+eLookWf7gct8VYBzeTvuq1wx
         icPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686230254; x=1688822254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yy3Bf+NazHm1oNAREFVNFLHJOT3YLCmd5DpqRQr2VCQ=;
        b=dbNZ3pwUnRE6F+FmIarWp+0KA14/Q+p8OJe6ypFJNqKUFVV/cRdPLizrwz+mOFfMUj
         85JlTAL1Tbb/ESexjPOEslnUKfM59uxOLCq60+nwLZVsrLFaZ8M3nraT8ChwU9AsNTdh
         75ZtOixYctRCxjxUbFUDA8XEccG2TyRS6syaDMuSjdQvyMI1iD5RXVideHTczrgy+XoT
         rUXCfJDn3BvW26UORqN/j9z9nVHTZQvnErnjTM2ODF9bkPOEC5r2kH+qDeuD9OwpnTiR
         YOuK45CHDSRwg68s7YsBbleP6awaTHGkpSSdZySdb8NxotV/TY8nayzX08xAQ4iZjc/6
         DTAg==
X-Gm-Message-State: AC+VfDwdTMiKDcD5gsWN1lA3ggtJJ4nR1dsXxVGw9/B1xBsrI/czykEP
        fdZue97qv6zpM5XVv5bQd8c=
X-Google-Smtp-Source: ACHHUZ7S1sKJGDgwoxI9KIEm3hc0rB9Vq+vwLPT0vdAXyq345EdBOoTexBfh1JnjPXysgOy9EGMe6A==
X-Received: by 2002:a17:90b:d85:b0:258:71e6:1c24 with SMTP id bg5-20020a17090b0d8500b0025871e61c24mr5338938pjb.12.1686230254325;
        Thu, 08 Jun 2023 06:17:34 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id mq16-20020a17090b381000b00259980d373dsm3120187pjb.1.2023.06.08.06.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:17:33 -0700 (PDT)
Message-ID: <f3d994c1-852e-dee7-e1ed-7b9ef307cb4f@gmail.com>
Date:   Thu, 8 Jun 2023 21:17:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/9] x86/hyperv: Add sev-snp enlightened guest static key
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
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-2-ltykernel@gmail.com>
 <BYAPR21MB168808E653CDCE3585EB8858D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB168808E653CDCE3585EB8858D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 6/8/2023 8:56 PM, Michael Kelley (LINUX) wrote:
>> @ -473,7 +477,7 @@ static void __init ms_hyperv_init_platform(void)
>>
>>   #if IS_ENABLED(CONFIG_HYPERV)
>>   	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
>> -	    (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP))
>> +	    ms_hyperv.paravisor_present)
> This test needs to be:
> 
>    	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
> 	    ((hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) &&
> 	    ms_hyperv.paravisor_present)
> 
> We want to call hv_vtom_init() only when running with VBS, or
> with SEV-SNP*and*  we have a paravisor present.  Testing only for
> paravisor_present risks confusion with future TDX scenarios.

Yes, current paravisor is only available for VBS and SEV-SNP vTOM cases.
TDX may also have paravisor support. Will update.

Thanks.
