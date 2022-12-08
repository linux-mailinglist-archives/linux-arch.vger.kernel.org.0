Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522F3647065
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 14:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiLHNEY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 08:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLHNEX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 08:04:23 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223E390756;
        Thu,  8 Dec 2022 05:04:22 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id w37so1133633pga.5;
        Thu, 08 Dec 2022 05:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XPIojMEU3Uk2sxpHYe07tX6pxUYF84XeqU9rfvtr8NU=;
        b=gdYzEeQQKZkShQb5QebR8HseGam8L3X3SxfNfap9dA22y74aF2tRGTU9n9gpJBROI0
         iPSPcHCdrbV4LRRGMy7hp6W/8PKHugFX6mtVM1RpbsK/7uBrgKwRym+RMaCC1KVdg4GD
         /q/AEd9TZ4/eiXVNbnRaPg0YnuWPar8Qu7UvtYQ/MljEIyqtXzlSysTXXIcZKhorQ1C+
         3Obdk7WOp2b7wOeBf4bG+RY/54hRVcybS7YB0Uc3qVMS4pG67Hg+6g1YPZfVOgE5KH8h
         XEGWKll+4OQzOkRrTAwS/U1Rr1nJz9MGZQfpp1DaDqJnvXNeq7FWvce/oxW0Q1eFnULx
         caIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPIojMEU3Uk2sxpHYe07tX6pxUYF84XeqU9rfvtr8NU=;
        b=ylpc511XjO/akpQiVZWzNIzQK3becAJgknMVNj1e2ISGz0RNanBBTjg6/KqacuAhGK
         sPD1pFC4I/Fh9pTIXojkz6FFYOGUPD+Gd4aKLs8mOZKaPmtYf+6EEk14quoc/TNiXURr
         cyEaZwNrTn5TSbA+uBS72NihFtrAXjm/Pqdbw7Anfx3k53oSB8yKsCeDcbDsmKwC66+1
         HqJSVTBWZu4s7UMFLJyDUAPDzsIl/TifaMxwYkO5+n5SgEMzxxGgUOM0HVPQUXNPN+PB
         gW/7PxVD96KMOwv5mWhizNAOZwRP+21OSDdfcQGAxWHh6DaxW5bJj4otPDyfXEGg0kni
         gang==
X-Gm-Message-State: ANoB5pkY+K0PVv7R9iHUVKCWoMKP17ExcKsV7/fUrp7MQIIqd1rEWOG0
        JJ5PvTMocaUueyW5158beGs=
X-Google-Smtp-Source: AA0mqf6OPNkOMO6/SVyCg8eEu0qOaJuvqFCSd2zQn4XCdJadLYxuQKiZTUgd/cLx4Xm+AAy5vzPKlg==
X-Received: by 2002:a63:3d8d:0:b0:46f:d4b8:409f with SMTP id k135-20020a633d8d000000b0046fd4b8409fmr86831624pga.475.1670504661067;
        Thu, 08 Dec 2022 05:04:21 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b00176b3c9693esm16574824pls.299.2022.12.08.05.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 05:04:20 -0800 (PST)
Message-ID: <bb66e339-61db-6c0b-4e39-22bfd70073fd@gmail.com>
Date:   Thu, 8 Dec 2022 21:04:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 01/18] x86/sev: Pvalidate memory gab for
 decompressing kernel
Content-Language: en-US
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-2-ltykernel@gmail.com>
 <eee97d32-09ea-b5d0-f45a-51c0e1d18d55@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <eee97d32-09ea-b5d0-f45a-51c0e1d18d55@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/6/2022 5:16 PM, Gupta, Pankaj wrote:
> Hi Tianyu,
> 
> Some minor nits below.
>
Thanks a lot to review. I will change these in the next version.

>> Pvalidate needed pages for decompressing kernel. The E820_TYPE_RAM
>> entry includes only validated memory. The kernel expects that the
>> RAM entry's addr is fixed while the entry size is to be extended
>> to cover addresses to the start of next entry. This patch increases
>> the RAM entry size to cover all possilble memory addresses until
> 
> s/possilble/possible
> 
>> init_size.
>>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>>   arch/x86/boot/compressed/head_64.S |  8 +++
>>   arch/x86/boot/compressed/sev.c     | 84 ++++++++++++++++++++++++++++++
>>   2 files changed, 92 insertions(+)
>>
>> diff --git a/arch/x86/boot/compressed/head_64.S 
>> b/arch/x86/boot/compressed/head_64.S
>> index d33f060900d2..818edaf5d0cf 100644
>> --- a/arch/x86/boot/compressed/head_64.S
>> +++ b/arch/x86/boot/compressed/head_64.S
>> @@ -348,6 +348,14 @@ SYM_CODE_START(startup_64)
>>       cld
>>       cli
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +    /* pvalidate memory on demand if SNP is enabled. */
>> +    pushq    %rsi
>> +    movq    %rsi, %rdi
>> +    call     pvalidate_for_startup_64
>> +    popq    %rsi
>> +#endif
>> +
>>       /* Setup data segments. */
>>       xorl    %eax, %eax
>>       movl    %eax, %ds
>> diff --git a/arch/x86/boot/compressed/sev.c 
>> b/arch/x86/boot/compressed/sev.c
>> index 960968f8bf75..3a5a1ab16095 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c
>> @@ -12,8 +12,10 @@
>>    */
>>   #include "misc.h"
>> +#include <asm/msr-index.h>
>>   #include <asm/pgtable_types.h>
>>   #include <asm/sev.h>
>> +#include <asm/svm.h>
>>   #include <asm/trapnr.h>
>>   #include <asm/trap_pf.h>
>>   #include <asm/msr-index.h>
>> @@ -21,6 +23,7 @@
>>   #include <asm/ptrace.h>
>>   #include <asm/svm.h>
>>   #include <asm/cpuid.h>
>> +#include <asm/e820/types.h>
>>   #include "error.h"
>>   #include "../msr.h"
>> @@ -117,6 +120,22 @@ static enum es_result vc_read_mem(struct 
>> es_em_ctxt *ctxt,
>>   /* Include code for early handlers */
>>   #include "../../kernel/sev-shared.c"
>> +/* Check SEV-SNP via MSR */
>> +static bool sev_snp_runtime_check(void)
>> +{
>> +    unsigned long low, high;
>> +    u64 val;
>> +
>> +    asm volatile("rdmsr\n" : "=a" (low), "=d" (high) :
>> +            "c" (MSR_AMD64_SEV));
>> +
>> +    val = (high << 32) | low;
>> +    if (val & MSR_AMD64_SEV_SNP_ENABLED)
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>>   static inline bool sev_snp_enabled(void)
>>   {
>>       return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>> @@ -456,3 +475,68 @@ void sev_prep_identity_maps(unsigned long 
>> top_level_pgt)
>>       sev_verify_cbit(top_level_pgt);
>>   }
>> +
>> +static void extend_e820_on_demand(struct boot_e820_entry *e820_entry,
>> +                  u64 needed_ram_end)
>> +{
>> +    u64 end, paddr;
>> +    unsigned long eflags;
>> +    int rc;
>> +
>> +    if (!e820_entry)
>> +        return;
>> +
>> +    /* Validated memory must be aligned by PAGE_SIZE. */
>> +    end = ALIGN(e820_entry->addr + e820_entry->size, PAGE_SIZE);
>> +    if (needed_ram_end > end && e820_entry->type == E820_TYPE_RAM) {
> 
> maybe "if check" can be used to return from here, would read code better?
> 
>> +        for (paddr = end; paddr < needed_ram_end; paddr += PAGE_SIZE) 
> Maybe we could reuse 'pvalidate_pages' here?
> 
>> +            rc = pvalidate(paddr, RMP_PG_SIZE_4K, true);
>> +            if (rc) {
>> +                error("Failed to validate address.n");
> 
> Would it make sense to print the cause of failure here?
> 
>> +                return;
>> +            }
>> +        }
>> +        e820_entry->size = needed_ram_end - e820_entry->addr;
>> +    }
>> +}
>> +
>> +/*
>> + * Explicitly pvalidate needed pages for decompressing the kernel.
>> + * The E820_TYPE_RAM entry includes only validated memory. The kernel
>> + * expects that the RAM entry's addr is fixed while the entry size is 
>> to be
>> + * extended to cover addresses to the start of next entry.
>> + * The function increases the RAM entry size to cover all possible 
>> memory
>> + * addresses until init_size.
>> + * For example,  init_end = 0x4000000,
>> + * [RAM: 0x0 - 0x0],                       M[RAM: 0x0 - 0xa0000]
>> + * [RSVD: 0xa0000 - 0x10000]                [RSVD: 0xa0000 - 0x10000]
>> + * [ACPI: 0x10000 - 0x20000]      ==>       [ACPI: 0x10000 - 0x20000]
>> + * [RSVD: 0x800000 - 0x900000]              [RSVD: 0x800000 - 0x900000]
>> + * [RAM: 0x1000000 - 0x2000000]            M[RAM: 0x1000000 - 0x2001000]
>> + * [RAM: 0x2001000 - 0x2007000]            M[RAM: 0x2001000 - 0x4000000]
>> + * Other RAM memory after init_end is pvalidated by 
>> ms_hyperv_init_platform
>> + */
>> +__visible void pvalidate_for_startup_64(struct boot_params *boot_params)
>> +{
>> +    struct boot_e820_entry *e820_entry;
>> +    u64 init_end =
>> +        boot_params->hdr.pref_address + boot_params->hdr.init_size;
>> +    u8 i, nr_entries = boot_params->e820_entries;
>> +    u64 needed_end;
> 
> Could not very well interpret the name 'needed_end'.
> 
>> +
>> +    if (!sev_snp_runtime_check())
>> +        return;
>> +
>> +    for (i = 0; i < nr_entries; ++i) {
>> +        /* Pvalidate memory holes in e820 RAM entries. */
> 
> Pvalidate and pvalidate names are used interchangeably in comments.
> 
>> +        e820_entry = &boot_params->e820_table[i];
>> +        if (i < nr_entries - 1) {
>> +            needed_end = boot_params->e820_table[i + 1].addr;
>> +            if (needed_end < e820_entry->addr)
>> +                error("e820 table is not sorted.\n");
>> +        } else {
>> +            needed_end = init_end;
>> +        }
>> +        extend_e820_on_demand(e820_entry, needed_end);
>> +    }
>> +}
> 
