Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636056560FE
	for <lists+linux-arch@lfdr.de>; Mon, 26 Dec 2022 09:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiLZIAI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Dec 2022 03:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiLZIAF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Dec 2022 03:00:05 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F44B115E;
        Mon, 26 Dec 2022 00:00:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 17so10227159pll.0;
        Mon, 26 Dec 2022 00:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snF9FgPM3QZjb6wYG/8ShchxVTbs8eu54AlMx41SJXI=;
        b=I9kpb2beBVnPOjsLJGcv0RYiBxwiJwxcOTw40CumIZc1EnhS/GQAT4QRDqEBM5sSYf
         Wd0CZdozC+zvNZ7cefd7AMsfQMn8aUnwQfQ/uf7n6zSgQA1Ebim0kWEsrEKkU4KiHbf5
         CTAKlSW3/BWnXqb8ZO7yZcTq22RASfUWsBbIgpvirQGHePw9rpt4KRdY3+r+VSGYlaL6
         J6oyvXqwS5xVcMVIHNV/tuuCBQMpa2kDLG7bIuzQRnXNP65cDWBWSS8XymH/O7pfjYzN
         Cf09qjoM18+lqqsA9DjGW8bHSTBHxh79FnzS3q9y4D1zUfjg9aGHptcrwmvICxm1/7BI
         kZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snF9FgPM3QZjb6wYG/8ShchxVTbs8eu54AlMx41SJXI=;
        b=NFzv5Plj9UpRLa47HCk05zMKxlGP3/OcBKtET8od6IqMVC+imTQ0ZRjqot+sEUxhvf
         //ZGyoAPsmzendWsHheiSKV2L2f81VEfrScVQGNQtonOfpynytBi/3lvsboxvoYzSoG+
         rVdiG5eOg50Od/KwAbx3oFovYdhDAVKSzcHGxbDQGWs0D7q4pDL4yEKCMZYaIjM5fZae
         1nOSqhk3O57pW8tzQil5JmSCGZ03MnVffezABl7ESk9GKwYYBLonKeWUT2/tamyEzduD
         vv4Arlj79DrTjI6+rWfr5I2edKahEs8VW5ZPcmk1TLLSfkP/y8Q8ygOR0EZ22FtxxHv5
         HQGA==
X-Gm-Message-State: AFqh2kp+6dldAtf1XuokYcuc6k5U1kUiAD5NdD9yuNJ+rBT1xkcl9apT
        VGgYU0GSPOHydExemnVsIwg=
X-Google-Smtp-Source: AMrXdXsYDTq8QKHNt6PaId85nRz+73j5VQZcvOKpuC70WJG4kZTU8GY496g9fIp6s4h43XrC3tqXlg==
X-Received: by 2002:a17:902:7e03:b0:192:70f1:b34 with SMTP id b3-20020a1709027e0300b0019270f10b34mr6048820plm.19.1672041603032;
        Mon, 26 Dec 2022 00:00:03 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id s19-20020a170903201300b00187197c4999sm6447717pla.167.2022.12.25.23.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 00:00:02 -0800 (PST)
Message-ID: <ee43a3ce-2b66-f660-39cc-32cdc0cf6587@gmail.com>
Date:   Mon, 26 Dec 2022 15:59:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V2 11/18] Drivers: hv: vmbus: Decrypt vmbus ring
 buffer
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-12-ltykernel@gmail.com>
 <BYAPR21MB1688329AFB42391E92051E9CD7E09@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB1688329AFB42391E92051E9CD7E09@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/15/2022 2:25 AM, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan<ltykernel@gmail.com>  Sent: Friday, November 18, 2022 7:46 PM
>> The ring buffer is remapped in the hv_ringbuffer_init()
>> and it should be with decrypt flag in order to share it
>> with hypervisor in sev-snp enlightened guest.
> FWIW, the change in this patch is included in Patch 9
> in my vTOM-related patch series.
> 

I will rebase next version on your series. Thanks for reminder.
