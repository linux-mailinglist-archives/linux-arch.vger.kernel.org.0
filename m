Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC866E35A5
	for <lists+linux-arch@lfdr.de>; Sun, 16 Apr 2023 09:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjDPHWG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Apr 2023 03:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjDPHWF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Apr 2023 03:22:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA63AB0;
        Sun, 16 Apr 2023 00:21:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517c0b93cedso1282469a12.3;
        Sun, 16 Apr 2023 00:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629696; x=1684221696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzApRNmLj/C3OG/CHM2LgsaZWOMDJjJGhX2jIgFh5iQ=;
        b=qMiR54KzcLn1DsnMyZOFNfkPOGsHgIksYHpXeU+7AhizRUl8WZpQhhtR3RVu/h1RDZ
         1MshIYnilckG98SWYHJX83+cm3V/TKfxbld149/3XfWsw5M1AEKdF99VKOT1kTbWeQtx
         SYwuD0bTWJZYoZWcMPXBohh0eUVWTztWf8B8Tc+bD/wVLzGrktczCPkc6azqpWq2Q9cO
         MRYmkuslT8pooJCGslPwvpBxLw2AlolRauqlKl15eLNXZtEJZqAB4JGYpJOotQavoDp7
         pSH2ywgg4/5s68FVeI+HNzXpGZWg6llMKns6fXxIs/w5MuBJg4GngVkuJPWikPc4G8QA
         sQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629696; x=1684221696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WzApRNmLj/C3OG/CHM2LgsaZWOMDJjJGhX2jIgFh5iQ=;
        b=aUrokqSxWDE5CI22klzyTqLb+I1PCtw0d/YcrOfUr7MgwRZm9RFOcdb6i/DE1m07R4
         LaYTTaFNuoGsSDQ63y3tUy/PmBeewq5dZ+Lx5cePMaEWFEcbRF9UJLUQqWWtLGDZ9Npq
         QK2m5GDLZavsWIxW1VyKRTwxmaPRmSSVf9MD52pECX72il7M7tVflBQYWASouey1oKUb
         i7A/g2UluOSRUbgIiA/kv7L5ENdsQq1uO9naXv+sZYmnj4N94LfZzKsR6P42Uuu8+73E
         +Kf9dVmm44cgAZridtHk65r0lGvINiMK+AhrqghmWdbM/OuCyNyr2IU1YbCq1eGiC3w0
         Vbdg==
X-Gm-Message-State: AAQBX9cEb6Zb8/ErTmcUvGd2AXV3Ht+kDt7zQ9EslBjx7XRFjbfqqYBT
        qhc9/DOYgifLPvANJqM/eSM=
X-Google-Smtp-Source: AKy350atqxP4Yz6NIUftxzPOKTEySbesWnO8LNsuERkvUh0YKCErD2eEKFRksqY+kmu8cvuUIarOIQ==
X-Received: by 2002:a05:6a00:234a:b0:63b:2102:a068 with SMTP id j10-20020a056a00234a00b0063b2102a068mr17495268pfj.26.1681629695927;
        Sun, 16 Apr 2023 00:21:35 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id v18-20020a62a512000000b006089fb79f1esm5690205pfm.96.2023.04.16.00.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 00:21:35 -0700 (PDT)
Message-ID: <b4c74d0e-5b54-5101-ec18-cc09449ed358@gmail.com>
Date:   Sun, 16 Apr 2023 15:21:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
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
Cc:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-9-ltykernel@gmail.com>
 <BYAPR21MB1688DB1442B486A8DEBEF821D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB1688DB1442B486A8DEBEF821D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/12/2023 10:39 PM, Michael Kelley (LINUX) wrote:
>> +	/* Read processor number and memory layout. */
>> +	processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
>> +	entry = (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR)
>> +			+ sizeof(struct memory_map_entry));
> Why is the first map entry being skipped?

The first entry is populated with processor count by Hyper-V.

