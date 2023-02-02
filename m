Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D999688A66
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 00:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjBBXBI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 18:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBXBH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 18:01:07 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29E26B9B9;
        Thu,  2 Feb 2023 15:01:06 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x6so1427578ilv.7;
        Thu, 02 Feb 2023 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogxAJgAv5ZwvjJ5uqoNGnyBKo5TtWPAyVcNxJx6NQyQ=;
        b=m5G86emYgdelQlRze3wZPK7EJq+pzBlZMHnzPKgVFLQSK0NnjmhYbKPo+Dbz+KZVzi
         GxBjL+9+xlG6T/vPHlgyOiiAsvF0Rlr37vQROYACrX+gGR9/S/OyggGK23iZXbu9pB8a
         hBtALzg8PCZjlgUFwn4TQI2MKTBe3ejJCjyTc9LTDyR505rvFw16HM+8YLKjO1fANLC1
         GorhcWyJVw0MfBOWcVTx4HF74dA6Q/qSWlEDXL+8UdWOYoA7CTj/55ZKC/y99a9shzu9
         5an5TGu8lCXw0zMIMRYZgQtAazAZkASpOn4k9vNEMtsj4zWjVwH/iyEFIV0V103xQVlO
         gfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogxAJgAv5ZwvjJ5uqoNGnyBKo5TtWPAyVcNxJx6NQyQ=;
        b=FyIw84ls1zxahvug/4sxXJ/QNsKloCIz4H+fHccvPx2q1ylXRIMbZdrQT9zdwvPDtv
         qA2kTqPOO317q5ky5G1huwuTvfgFM3imv+ye6yLNNGYBE8W64ThfjdsyY3wVgRdjBhxt
         +2rXG7h1NSzcIuokPdg8IMBZrDROM1V4C9BzhMR2yU/QA++azZL+W/RXLLkZdNn9loE9
         HOAVmrg9Q+3yjBINelNrN9/llLoyzLeqQHOGJY4mMk/iujj9/S2D8eDMSOEf5C/8TWlp
         Z/eBDWr6gKg2Cd7ze7uAfT0W0BvwO3a5G/6wJssKbPNKn70XNTSzKxKNBrZgCQNQUN96
         cKwA==
X-Gm-Message-State: AO0yUKWYzjNMvGOyCNl0Fb5j5qaBKpmUZWuFjztnJt2yOP3nQd20jBWd
        O4V9ltVmxqgF3oRjYbxCFGs=
X-Google-Smtp-Source: AK7set8jxP7ZsE1rlLhqP/0F0minwg8PSz95UNIGSnAPozeRHn/niBG34CaAFsZMrMsZGVXM2WAX9Q==
X-Received: by 2002:a92:c5b2:0:b0:310:9adc:e1bb with SMTP id r18-20020a92c5b2000000b003109adce1bbmr4800098ilt.0.1675378865991;
        Thu, 02 Feb 2023 15:01:05 -0800 (PST)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id b10-20020a056638388a00b003a7cadffda7sm338016jav.2.2023.02.02.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:01:05 -0800 (PST)
Date:   Fri, 3 Feb 2023 01:00:56 +0200
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V3 00/16] x86/hyperv/sev: Add AMD sev-snp
 enlightened guest support on hyperv
Message-ID: <20230203010056.000021af@gmail.com>
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 21 Jan 2023 21:45:50 -0500
Tianyu Lan <ltykernel@gmail.com> wrote:

1) I am thinking if it is a good time to organize a common code path for
enlightened VM on hyper-v.

Wouldn't it be better to have a common flag for enlightened VM? 
Like bool hv_isolation_type_enlightened()

Many of the decryption of the post msg page... are also required
in the enlightened TDX guest, they are not AMD-specific. 

Then in the "TDX guest on hyper-V" patch set, Dexuan can save some LOCs instead
of ending up with if (hv_isolation_type_en_snp() ||
hv_isolation_type_en_tdx())...

2) It seems the AMD SEV-SNP enlightened guest on hyper-V is implemented as
CC_VENDOR_AMD, while TDX enlightened guest is still implemented as
CC_VENDOR_HYPERV. I am curious about the reason.

> From: Tianyu Lan <tiala@microsoft.com>
> 
> This patchset is to add AMD sev-snp enlightened guest
> support on hyperv. Hyperv uses Linux direct boot mode
> to boot up Linux kernel and so it needs to pvalidate
> system memory by itself.
> 
> In hyperv case, there is no boot loader and so cc blob
> is prepared by hypervisor. In this series, hypervisor
> set the cc blob address directly into boot parameter
> of Linux kernel. If the magic number on cc blob address
> is valid, kernel will read cc blob.
> 
> Shared memory between guests and hypervisor should be
> decrypted and zero memory after decrypt memory. The data
> in the target address. It maybe smearedto avoid smearing
> data.
> 
> Introduce #HV exception support in AMD sev snp code and
> #HV handler.
> 
> Change since v2:
>        - Remove validate kernel memory code at boot stage
>        - Split #HV page patch into two parts
>        - Remove HV-APIC change due to enable x2apic from
>        	 host side
>        - Rework vmbus code to handle error of decrypt page
>        - Spilt memory and cpu initialization patch. 
> 
> Change since v1:
>        - Remove boot param changes for cc blob address and
>        use setup head to pass cc blob info
>        - Remove unnessary WARN and BUG check
>        - Add system vector table map in the #HV exception
>        - Fix interrupt exit issue when use #HV exception
> 
> Ashish Kalra (2):
>   x86/sev: optimize system vector processing invoked from #HV exception
>   x86/sev: Fix interrupt exit code paths from #HV exception
> 
> Tianyu Lan (14):
>   x86/hyperv: Add sev-snp enlightened guest specific config
>   x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
>   x86/hyperv: Set Virtual Trust Level in vmbus init message
>   x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
>     enlightened guest
>   clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp
>     enlightened guest
>   x86/hyperv: decrypt vmbus pages for sev-snp enlightened guest
>   drivers: hv: Decrypt percpu hvcall input arg page in sev-snp
>     enlightened guest
>   x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
>   x86/hyperv: SEV-SNP enlightened guest don't support legacy rtc
>   x86/hyperv: Add smp support for sev-snp guest
>   x86/hyperv: Add hyperv-specific hadling for VMMCALL under SEV-ES
>   x86/sev: Add a #HV exception handler
>   x86/sev: Add Check of #HV event in path
>   x86/sev: Initialize #HV doorbell and handle interrupt requests
> 
>  arch/x86/entry/entry_64.S             |  82 ++++++
>  arch/x86/hyperv/hv_init.c             |  43 +++
>  arch/x86/hyperv/ivm.c                 |  10 +
>  arch/x86/include/asm/cpu_entry_area.h |   6 +
>  arch/x86/include/asm/hyperv-tlfs.h    |   4 +
>  arch/x86/include/asm/idtentry.h       | 105 ++++++-
>  arch/x86/include/asm/irqflags.h       |  10 +
>  arch/x86/include/asm/mem_encrypt.h    |   2 +
>  arch/x86/include/asm/mshyperv.h       |  56 +++-
>  arch/x86/include/asm/msr-index.h      |   6 +
>  arch/x86/include/asm/page_64_types.h  |   1 +
>  arch/x86/include/asm/sev.h            |  13 +
>  arch/x86/include/asm/svm.h            |  59 +++-
>  arch/x86/include/asm/trapnr.h         |   1 +
>  arch/x86/include/asm/traps.h          |   1 +
>  arch/x86/include/asm/x86_init.h       |   2 +
>  arch/x86/include/uapi/asm/svm.h       |   4 +
>  arch/x86/kernel/cpu/common.c          |   1 +
>  arch/x86/kernel/cpu/mshyperv.c        | 228 ++++++++++++++-
>  arch/x86/kernel/dumpstack_64.c        |   9 +-
>  arch/x86/kernel/idt.c                 |   1 +
>  arch/x86/kernel/sev.c                 | 395 ++++++++++++++++++++++----
>  arch/x86/kernel/traps.c               |  42 +++
>  arch/x86/kernel/vmlinux.lds.S         |   7 +
>  arch/x86/kernel/x86_init.c            |   4 +-
>  arch/x86/mm/cpu_entry_area.c          |   2 +
>  drivers/clocksource/hyperv_timer.c    |   2 +-
>  drivers/hv/connection.c               |   1 +
>  drivers/hv/hv.c                       |  33 ++-
>  drivers/hv/hv_common.c                |  26 +-
>  include/asm-generic/hyperv-tlfs.h     |  19 ++
>  include/asm-generic/mshyperv.h        |   2 +
>  include/linux/hyperv.h                |   4 +-
>  33 files changed, 1102 insertions(+), 79 deletions(-)
> 

