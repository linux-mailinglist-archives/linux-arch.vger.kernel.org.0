Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45FC688F31
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 06:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjBCF6f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 00:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBCF6e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 00:58:34 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20036FD08;
        Thu,  2 Feb 2023 21:58:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z1so4247910plg.6;
        Thu, 02 Feb 2023 21:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AsWB2oc0/sOofgx7ES2UpPnarL2Q9v7WCxcvNNPysY=;
        b=JV3lVC11SOYxhQ8MfBmHeONQJVoFC/Kz/hzkAWDJuFlj3bFDHkLYR8FzvxqHlVHj7U
         d5WT5+bPDNrOZMPLvUY/RVtcJYRAiRkTeADgFNb1P0BKavdGxbeV5NPSn9btQyOldq1w
         kE9MA2CwS0+l5lKeypsvzdZ7mYrkrKMyK3ehJRyN+KqXH9u/zT9lajC1/v/Sahu4no/X
         9ZNdhmWbiuwqXqAPh6DHbFgTjtqXJDgUBVF33D1WN9UudbeoB16f9t4P2AtO5totj8R6
         +622ytIiE+9r7ncXEcIn8gDpt9r+CH256B4J+kUWrpc/4VkhH2DgUQFYCQlUkdr7dMFI
         cIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+AsWB2oc0/sOofgx7ES2UpPnarL2Q9v7WCxcvNNPysY=;
        b=IwN4nn50MeJmkd9yLnZJUNCaZFgFZkne2rpnCkYBz8L7AElD7TcvQWxuIpuYRO42hB
         smKQQXxoN5rHMO3Gm4YxF1ZL1FKj2O5kXZqtp6yf8GM+I+QvUur3FFF3/53g7Qdsw/M8
         enmBCPEjZlpIzNAwsi90mUyDg51n0+5T+BAUxtJ7xL0Rm3KsCUEHLKvDh0pxr/GvJ/sh
         6+eK7GNvPGluWtgkvxk/Bc6yvNwqslo4siUzKy5xZig+iGf/xKmw8HuuXUYeN/2UowF1
         FwkNeaAwERD3LYwReE70OelyHVIQfyok/FVZSBvVQQmiW41pEKvLj23ooywdIdgl85Dt
         J55g==
X-Gm-Message-State: AO0yUKVi7aV0NWrBa5Qu9AWat60f/Cpvl/MONBaUDSxc9+an7gVjPH4N
        W6ivEaK192OhAY/StyWcZOo=
X-Google-Smtp-Source: AK7set9SMkkiyl6xHOGhtlIl7qYfq9X3sxdVKCFtIQAIUpiv3tKE1yYkqyXCgVB0EsbYa5sP9gLjkA==
X-Received: by 2002:a17:902:d488:b0:195:f3e0:769a with SMTP id c8-20020a170902d48800b00195f3e0769amr11367976plg.69.1675403913436;
        Thu, 02 Feb 2023 21:58:33 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b0019601b73e33sm678577plk.30.2023.02.02.21.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 21:58:32 -0800 (PST)
Message-ID: <855e4043-d337-722e-77a0-5c2be246d2b5@gmail.com>
Date:   Fri, 3 Feb 2023 13:58:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V3 08/16] x86/hyperv: Initialize cpu and memory for
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
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-9-ltykernel@gmail.com>
 <BYAPR21MB168803F19A65E356758A6046D7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB168803F19A65E356758A6046D7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/1/2023 2:20 AM, Michael Kelley (LINUX) wrote:
>> +struct memory_map_entry {
>> +	u64 starting_gpn;
>> +	u64 numpages;
>> +	u16 type;
>> +	u16 flags;
>> +	u32 reserved;
>> +};
> Am I correct that this structure is defined by Hyper-V?  If so, it seems
> like it should go in hyperv-tlfs.h, along with the definition of
> EN_SEV_SNP_PROCESSOR_INFO_ADDR (which is also defined by
> Hyper-V?)
>

Yes, it's Hyper-V data structure and will move to hyperv-tlfs.h.


>> +			if (e820_end < ram_end) {
>> +				pr_info("Hyper-V: add e820 entry [mem %#018Lx-%#018Lx]\n", e820_end, ram_end - 1);
>> +				e820__range_add(e820_end, ram_end - e820_end,
>> +						E820_TYPE_RAM);
>> +				for (page = e820_end; page < ram_end; page += PAGE_SIZE)
>> +					pvalidate((unsigned long)__va(page), RMP_PG_SIZE_4K, true);
>> +			}
>> +		}
>> +	}
>> +
> For SNP vTOM mode, most of the supporting code is placed in
> arch/x86/hyperv/ivm.c, which is built only if CONFIG_HYPERV
> is defined.  arch/x86/kernel/cpu/mshyperv.c is built for*any*
> flavor of guest (i.e., CONFIG_HYPERVISOR_GUEST).  I'm thinking
> all this code should go as a supporting function in ivm.c, to
> avoid overloading mshyperv.c.  Take a look at how hv_vtom_init()
> is handled in my patch set.
> 
> Breaking it out as a separate supporting function might also
> help reduce the deep indentation problem a bit. 😄

Good idea. Will update in the next version.
Thanks for your suggestion.
> 
