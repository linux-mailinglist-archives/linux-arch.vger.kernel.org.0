Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A070D688EEA
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 06:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjBCFXT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 00:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBCFXS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 00:23:18 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC353C2B0;
        Thu,  2 Feb 2023 21:23:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so3952048pjb.1;
        Thu, 02 Feb 2023 21:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9Al5IgfTAXRchBvFsd8KHoDxMsWlvFtFMC8MfqxpJs=;
        b=CVpzx6OeNkGU3rRXC6PcXEzYF0Lmo5pQHI8yZobfDC2+War/IUoq4rplgc54ROqSnz
         qAcBdMqdl5JH2BFeaEda3mX9cx9eQW8pZWWNU7OFtrs5pe2pePnNDivyI+C38IRJ6GTq
         EKe54v+qakVRUEgGDlomkDb3xXHYXfO8ElaEUmB1kFYmGgDeuj2BkfEaCE4slfXwB9Xb
         6P9KXM6mJBe8s0jIpMn0RtnuiQeoVyZ1PGKqjU3/GwCrAKC3+FYJxfeUJCXfZtphgNAU
         mmOjv+VFkuN6q73gKUclGeQa+5vxkwdFqxm0dTUvPKuoF4j6EmrdflOeUJHJkXYUj6TI
         6nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R9Al5IgfTAXRchBvFsd8KHoDxMsWlvFtFMC8MfqxpJs=;
        b=R9C0BkKsd1+xqzQ7pcHWu111nFEcsMyPHIeCv9xT6cn1L4gt/PLtZM/2S/+kvnacWK
         TYghYayYZA2kTaNq9yPdfZRbdU8QVDIf4Ss83BYYNDXYnDeIZAQ+j2Hkt05TvtpNd/jB
         pxnByJAjibMm8iKXwqxw9ILloKITPEhTfSjZ7JicqyJTd+SuKUTgdGYB2877eof+ry9c
         lMG73O4VAgO8EwTRq7RB/YpRwpzY6JpEVtDTaQPqeYKbFkd0tEu4JqUkGNXPkdTghiV9
         naD877eOKgumUpmN2nfnCYhboQ+gXa4HiZJybNR6iNB8AzTO4aR/l6TYDLEif0B94SOW
         ZcmQ==
X-Gm-Message-State: AO0yUKVSm+qAKs2onyz0yEE4d2uEXohV1wLZGE7uGHdvx/vsANVWLYtc
        xEa27r4kO7O6lKtJ3HSZn9o=
X-Google-Smtp-Source: AK7set+zd9ZiKwFgx4hfM+/7+UOyxzIAR1hNtMF9N4dpoUga9mKgwiwr09Ho5r/ItUxOnCv7AexCNQ==
X-Received: by 2002:a17:90b:4d12:b0:22c:9912:39e with SMTP id mw18-20020a17090b4d1200b0022c9912039emr3842185pjb.36.1675401796098;
        Thu, 02 Feb 2023 21:23:16 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a4dc600b002271b43e528sm4025076pjl.33.2023.02.02.21.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 21:23:15 -0800 (PST)
Message-ID: <3bfbbaa1-69f8-0f33-a4dc-5a10758e603a@gmail.com>
Date:   Fri, 3 Feb 2023 13:23:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 07/16] drivers: hv: Decrypt percpu hvcall input arg
 page in sev-snp enlightened guest
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
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-8-ltykernel@gmail.com>
 <BYAPR21MB16880F982D51474B0911D528D7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16880F982D51474B0911D528D7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/1/2023 2:02 AM, Michael Kelley (LINUX) wrote:
>> @@ -134,6 +136,17 @@ int hv_common_cpu_init(unsigned int cpu)
>>   	if (!(*inputarg))
>>   		return -ENOMEM;
>>
>> +	if (hv_isolation_type_en_snp()) {
>> +		ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
> You used "pgcount" here in response to a comment on v2 of the
> patch.  But the corresponding re-encryption in hv_common_cpu_die()
> uses a fixed value of "1".   The two cases should be consistent.  Either
> assert that hv_root_partition will never be true in an SNP VM, in which
> case hard coding "1" is OK.  Or properly calculate the number of pages
> in both cases so they are consistent.
> 

Agree. We should keep the logic in both hv_common_cpu_init() and 
hv_common_cpu_die(). Will fix it.
