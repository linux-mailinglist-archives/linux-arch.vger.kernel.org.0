Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4EA72838C
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbjFHPSr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjFHPSq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 11:18:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D64E2;
        Thu,  8 Jun 2023 08:18:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-654f8b56807so654258b3a.1;
        Thu, 08 Jun 2023 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686237525; x=1688829525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfmWXGoHuPXdu5coFsqQXedQPyhL6v7p78yOG0R6v0s=;
        b=qsCXrd6G3Hszwd0S5q43Ga5tOGt43g6pNYbCr5UCEe3SKiTTWbOBOBfZQmlHr4WxRX
         FFJtLM4ByTtDnNHz74eDXW1k6twllp3Efldd6F/71oQQErRy5OmYOa4bxRADJQLaap4c
         jgl96c49Ia6Dv3PXlf1WKSGO67CLJ1MbS4AdKL9ce5u5uBaLK9eZe9cWDOcQlcROnwBo
         GmjMTipdUWPOgEjV0tFoM1eYyNwSevGIFjMuqh/AqcBLrrNlQewINURVsWyjqkzfp6M4
         REY1FRZp6v1LHNNhw/sM4KvPWzZ7OyB/WrG/EqhwyYOb5/EErx19K5qP/riEVOnnVebw
         Lcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686237525; x=1688829525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pfmWXGoHuPXdu5coFsqQXedQPyhL6v7p78yOG0R6v0s=;
        b=eWluEdsFfh5ulKLFQho9N++8qF/ekQDBTfaIDlxcA77rH6CsqdMtEL1MNcBP3BjD8b
         xPXu/D/Oty8YkoLPw72UzChN35xtmld3g7xtAwJ1T6g3wvJYqcaU4WEuij/L6+ZyEbTe
         /M1T/HwPJb+81V11++gNNUADqnill461p0iEtL779oQzlKrI8I0tM70R1mZ5GMLoT+vm
         VhfTU4OVp/qFTiSwBO5GWA9M2njgwgYyRbGUDXN1Y++b1n4wXPU4i9UH+W1nb8tCUqgQ
         Bkm5hbtdsKVf6r0dQWzmD4580qdFg3O66sMFMUobsk02F3MF4r2peytEimlNYylmnkue
         g8Wg==
X-Gm-Message-State: AC+VfDxO9qVocV/irZfFD8yutqLRtQHK/ND6Di4+fSHqMabXoCu7PVJp
        NGm9o5qF5Pb2vhA3hbEHZ0A=
X-Google-Smtp-Source: ACHHUZ44Fw7yXO28Kkb6ujVeCtHugcY8yRxF4c5Agojd9bA4r0AoqSzyjiMGv8muJevVDmVl/Dk0dA==
X-Received: by 2002:a05:6a00:134b:b0:640:f313:efba with SMTP id k11-20020a056a00134b00b00640f313efbamr11442084pfu.19.1686237524787;
        Thu, 08 Jun 2023 08:18:44 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79215000000b0063a04905379sm1227423pfo.137.2023.06.08.08.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 08:18:44 -0700 (PDT)
Message-ID: <c051f8cd-9743-4beb-9887-18894c46e909@gmail.com>
Date:   Thu, 8 Jun 2023 23:18:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
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
 <20230601151624.1757616-8-ltykernel@gmail.com>
 <BYAPR21MB16882DC67EAF87B518D5D72ED750A@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16882DC67EAF87B518D5D72ED750A@BYAPR21MB1688.namprd21.prod.outlook.com>
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



On 6/8/2023 10:09 PM, Michael Kelley (LINUX) wrote:
>> +static __init void hv_snp_get_smp_config(unsigned int early)
>> +{
>> +	/*
>> +	 * The "early" is only to be true when there is AMD
>> +	 * numa support. Hyper-V AMD SEV-SNP guest may not
>> +	 * have numa support. To make sure smp config is
>> +	 * always initialized, do that when early is false.
>> +	 */
> I didn't really understand this comment.  After doing a little research, let
> me suggest this wording:
> 
> 	/*
> 	 * The "early" parameter can be true only if old-style AMD
> 	 * Opteron NUMA detection is enabled, which should never be
> 	 * the case for an SEV-SNP guest.  See CONFIG_AMD_NUMA.
> 	 * For safety, just do nothing if "early" is true.
> 	 */
> 
> Let me know if this new wording makes sense based on your understanding.
> 

Yes, it makes sense. Will update. Thanks.
