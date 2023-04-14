Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DC6E283A
	for <lists+linux-arch@lfdr.de>; Fri, 14 Apr 2023 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjDNQW0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Apr 2023 12:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNQWZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Apr 2023 12:22:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5D26A6;
        Fri, 14 Apr 2023 09:22:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l21so841351pla.5;
        Fri, 14 Apr 2023 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681489344; x=1684081344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTEhNVqZBw01s/PMM+cJ3g7Yn/OTOx3Os9TZhJT3Cc4=;
        b=aExfXPPVLsn0eHbcr8h1bPznS8NVUHwuPKSzj0+5N4a2kMXbIh/OXWyITEDlmn0Nji
         QNCvFNFoMgwekDUy3kxaF7hcgEG8WpDDLfpxzPztHFN21pOG5gLoyGQOyeA7TtDa5A6n
         SycOB056nVLgChG/grzC1kxLHAuraxX86UG4GeIKPF9m+KlpRN1MeRL5sQcTnZ02C5mu
         iU4RqNdcrDQCg4Ngjq7wldL/l/jMmHk6IGSJYxVTTp6MyGmSXL4Oul5wlQmDh4EqqepH
         wc7E8UM44C+2QuuyR57JBDiC1Lzs8z2qXFyaTHvg+MciV2wUgICEiK9QfUC3NyZ+2t6W
         YucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681489344; x=1684081344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fTEhNVqZBw01s/PMM+cJ3g7Yn/OTOx3Os9TZhJT3Cc4=;
        b=ZguXbEaQLtmqbyRmf7XJnAE2MPtdI/GZewAovK4NRt6l0q637JaWYo0z74It8vfgjd
         nqHUEixejOzsXeIOP3al1peEPNyLiLZ9MHMZkHUFAVoDmkHmcM0hVGV9LoDm/kY6/WMa
         FXHHbStoWUaJVn0hn8Pb2Kgds0vRtfiMYDT5GQfqORvu93OkJoQ5RNNMlbGqTR5gzUu/
         tfd5/jb17xAG5dNrvcvrgyJlRbHJPjStNNaRw4BjzDf3KJONu/lRQf0U3x/6jfauZxdH
         aBNNEPEi1+V+CdBvifxQLb/fYJwMuOobxJg0HWlsQZOb0kHUgHvkdTt3rk9B4tKdfRFc
         14tg==
X-Gm-Message-State: AAQBX9cKtjgoxLsZMmT1DpyC8wBjHDxjHUkxAkRdA+qtQadBpX3dvNrQ
        GmueUphis10YgVHCWXKRmQ4=
X-Google-Smtp-Source: AKy350Z4vu+cCQgSZbC4FG5FrywIq84iQCCq6NtgzACoGTjuRdeel5I8bVWxLOeexnvLfuSw/7uoYA==
X-Received: by 2002:a17:90b:3a92:b0:240:90f0:fbe with SMTP id om18-20020a17090b3a9200b0024090f00fbemr6163103pjb.45.1681489344019;
        Fri, 14 Apr 2023 09:22:24 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id iq3-20020a17090afb4300b00233b196fe30sm4885542pjb.20.2023.04.14.09.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:22:23 -0700 (PDT)
Message-ID: <527df1fc-5927-de9c-e18d-00fc1fab575e@gmail.com>
Date:   Sat, 15 Apr 2023 00:22:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH V4 10/17] x86/hyperv: Add smp support for sev-snp
 guest
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
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
Cc:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-11-ltykernel@gmail.com>
 <BYAPR21MB1688D729D203638C17FBC82AD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB1688D729D203638C17FBC82AD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/12/2023 10:59 PM, Michael Kelley (LINUX) wrote:
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>
>>   #define GHCB_USAGE_HYPERV_CALL	1
>>
>> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
>> +static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
> Just a question:  ap_start_stack is a static variable that gets used as the
> starting stack for every AP.  So obviously, once each AP is started, we must
> be sure that the AP moves off the ap_start_stack before the next AP is
> started.  How is that synchronization done?  I see that do_boot_cpu() is
> where the wakeup_secondary_cpu() function is called.  Then there's
> some waiting until the AP completes "initial initialization" per the
> comment in the code.  Is there where we know that the AP is no
> longer using ap_start_stack?
> 

Hi Micahel:
	secondary_startup_64_no_verify() in the head_64.S initializes
a boot time stack to replace the old stack. It's very begining stage of
starting AP. The initial_stack was initialized with idle->thread.sp in
the do_boot_cpu(). The AP is started one by one in current code and so
It's safe to reuse the stack for all APs to boot up.

278        /*
279         * Setup a boot time stack - Any secondary CPU will have lost 
its stack
280         * by now because the cr3-switch above unmaps the real-mode stack
281         */
282        movq initial_stack(%rip), %rsp
283

