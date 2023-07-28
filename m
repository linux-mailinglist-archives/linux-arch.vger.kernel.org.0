Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCDE766F56
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjG1OWc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 10:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjG1OWb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 10:22:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C784422B;
        Fri, 28 Jul 2023 07:22:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-56401f1da3dso1030262a12.0;
        Fri, 28 Jul 2023 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690554128; x=1691158928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaHDfRPeOYEFoHO/IUNE0JLDV+4mnu7twVsVbad4hws=;
        b=TCkoVpnoq7rWVgCt4u3ufL0iy8Y5iTREf6qhy36uqb4y2aJAyZXxCXigZh/xyysfpX
         /3kqX8pP1ws104T9gEKexu+X0pg9Hxl7t0JP4HK4caRtY2h8o2TeCevpLQ3ruCQVF21n
         Qr+stlczafmHz67i9bz5hWVkdDqxuczyZc/aj6yJQG2pNtGo1u6wr0m2mQkt+DOos1+s
         5RFf+ScKzX3qIzano3KtS7q/43p68BLv3aDdYUp9Id6EvYTlVJk+oHmWZqA7vDxGf+gY
         A1Hme/hP2kWPxbhOh8wWk2sxp59nEwzwiHK7dliE9CX2qTk3rj1SNQVnhsUJF7nKKM4s
         XQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554128; x=1691158928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yaHDfRPeOYEFoHO/IUNE0JLDV+4mnu7twVsVbad4hws=;
        b=CMOLMhxsyp5ISccbDi6rM3c2Unw7X2D0ZgsY0zxR9kpp06PIHPdvxebWc0IqrGYTx6
         0Nu+ukvaTvEeytUZJQHiZivycnVfRxbN12yIhlOZ8DgBBCPv55egM2C7WIKvu0l2fOoa
         sLNFBC69Lyo6u19xN3YrEJe4EP/GZIENr6qfqKYY6y3HyjcfOCTOJ9Fie5bMsLyEZbr1
         jU2Sax2H3y9UC/aFLDFe6JnlpOf5frI30SvrR5IZGpb2uJ4VTeajvzBqIL46YbWfbPVV
         /VpEi61uyEXO1mKRXhPsW02ckUCs5Rf86Gm7QTKmxOlY7DJ5InDL03VWg3JFKXpIu/en
         j/3Q==
X-Gm-Message-State: ABy/qLZ1Szpw7rpjkKUmit0r8hZCP/MhfWCNYCB0pZhsaJf40pZAlm2O
        q5Bwh2L7eAAE+5JM6ZQUBqQ=
X-Google-Smtp-Source: APBJJlF89ELEa4ed3usCbf4UmNMKfQ5ivHg7Rz8sOUofytiRiDTG5MwXDPheALvyHG5drlWsb7u9qA==
X-Received: by 2002:a17:90a:c205:b0:263:f776:8ba3 with SMTP id e5-20020a17090ac20500b00263f7768ba3mr1655996pjt.9.1690554127611;
        Fri, 28 Jul 2023 07:22:07 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id ev16-20020a17090aead000b002684b837d88sm2690605pjb.14.2023.07.28.07.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:22:07 -0700 (PDT)
Message-ID: <29fa53c5-7374-0b64-d135-54c968498685@gmail.com>
Date:   Fri, 28 Jul 2023 22:21:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH V2] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to
 isol_type_snp_paravisor/enlightened()
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
        "arnd@arndb.de" <arnd@arndb.de>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
References: <20230726124900.300258-1-ltykernel@gmail.com>
 <BYAPR21MB168896AAD24E773B92DD2B10D706A@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB168896AAD24E773B92DD2B10D706A@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 7/28/2023 10:53 AM, Michael Kelley (LINUX) wrote:
>> @@ -268,7 +268,7 @@ static inline void hv_sev_init_mem_and_cpu(void) {}
>>   static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
>>   #endif
>>
>> -extern bool hv_isolation_type_snp(void);
>> +extern bool hv_isol_type_snp_paravisor(void);
> This declaration of hv_isolation_type_snp() also occurs twice
> in include/asm-generic/mshyperv.h.  I think this one can be
> dropped entirely rather than renamed since
> include/asm-generic/mshyperv.h is #include'd at the bottom of
> this file, and there is no user in between.
> 
> hv_isolation_type_snp() is used in several architecture
> independent source code files, so having it declared in
> include/asm-generic/mshyperv.h makes sense rather than
> being in an architecture-specific version of mshyperv.h.
> 

Agree. Will update in the next version.
