Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6866E65C7
	for <lists+linux-arch@lfdr.de>; Tue, 18 Apr 2023 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjDRNYX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Apr 2023 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjDRNYW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Apr 2023 09:24:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A1FCC29;
        Tue, 18 Apr 2023 06:24:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2478485fd76so669685a91.2;
        Tue, 18 Apr 2023 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681824260; x=1684416260;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HGNOxFx7vNcnwQpD4qcW6bD8mczrYVsDoBGv26cM5o=;
        b=CoB825mb02L8FJB386fL18bU4xiWK6A3o9+x8bha2nHO9bPvbk2FY9GZ4cgxm3eS9m
         +dCyoSXZxnJVEU9XXbyPZ0CvODbICJFR7H8S/3V3tcSaqsG2erlXkCg/8LOat3yQ5Cmy
         ow0SHZF9oHyip5yTT96Nb1GHBVcrQMqtb+G5fwOQ1hN9W1iwrzqLiWCdveJ29bWBAfrH
         rTTOMAyO6/lC7RZA4Qqt/FV8tW/BFbNp3IrnD9DGPdwUJ9ciCk2rbJLPNXVRroaTMLjk
         d9Mzpjw1LSbgdByF1wHhFR7d5Bl+5E0fAeNRT8+C365BT4Ngks1m8ogDZ8T0DGP7PEI3
         y5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681824260; x=1684416260;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4HGNOxFx7vNcnwQpD4qcW6bD8mczrYVsDoBGv26cM5o=;
        b=i0i50+hYPf+AuQZ29OanbQAuOdBJL0IrQ3kygm43fGCKKdgIpUaS4LpyfYu9Nf3pMN
         Z0pO5VABsbOjibbkjXh/RJN9OuDmuGZYawuZTY6r1jSKoKaAgL4ow55cwoSiZ1NC0ugR
         dlAaR7Etqa1Q81EcJGzawWA7F39vgu73BfuZKsZxx2hxQx6c3h9UB9coqL+1GbZ59gNX
         PR7MZvo674s7pgpi4JWhxBqppIez2K7k4r/gjloOgKXeQZeOpzeNoNfifRnRccVLk9LR
         PtEtJEZ1vBZcb3YxW3htBdwbr5qcNjJb+5O/Kestz3i4h7KnjlqrW+n1v4hmMicRYJhq
         72bg==
X-Gm-Message-State: AAQBX9cHWoZ5cwMyDRYbZQIl0ApLyKNXlRqxvrsCOF/GmiweSouUkKzj
        SQznGBN1ycmLpKGKb38icfQ=
X-Google-Smtp-Source: AKy350ZLL1oJFDGCCHvw2aL2WbBa+CGtEBJoLXcoCEzWy2r21Yi5mC4xGmO23hq7DCnaEX81Xk+yEg==
X-Received: by 2002:a17:90a:28c6:b0:23f:1159:c0db with SMTP id f64-20020a17090a28c600b0023f1159c0dbmr1992710pjd.26.1681824260326;
        Tue, 18 Apr 2023 06:24:20 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090aaf9800b0023d0c2f39f2sm10392418pjq.19.2023.04.18.06.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:24:19 -0700 (PDT)
Message-ID: <03e7fd98-0df0-f191-4739-8a87726478c0@gmail.com>
Date:   Tue, 18 Apr 2023 21:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
To:     Dave Hansen <dave.hansen@intel.com>, luto@kernel.org,
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-9-ltykernel@gmail.com>
 <8ef9b06b-33b5-c785-8aec-0fd765c91911@intel.com>
In-Reply-To: <8ef9b06b-33b5-c785-8aec-0fd765c91911@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/12/2023 11:53 PM, Dave Hansen wrote:
>>   
>> +static u32 processor_count;
>> +
>> +static __init void hv_snp_get_smp_config(unsigned int early)
>> +{
>> +	if (!early) {
>> +		while (num_processors < processor_count) {
>> +			early_per_cpu(x86_cpu_to_apicid, num_processors) = num_processors;
>> +			early_per_cpu(x86_bios_cpu_apicid, num_processors) = num_processors;
>> +			physid_set(num_processors, phys_cpu_present_map);
>> +			set_cpu_possible(num_processors, true);
>> +			set_cpu_present(num_processors, true);
>> +			num_processors++;
>> +		}
>> +	}
>> +}
> Folks, please minimize indentation:
> 
> 	if (early)
> 		return;
> 
> It would also be nice to see*some*  explanation in the changelog or
> comments about why it's best and correct to just do nothing if early==1.
> 
> Also, this_consumes_  data from hv_sev_init_mem_and_cpu().  It would
> make more sense to me to have them ordered the other way.
> hv_sev_init_mem_and_cpu() first, this second.

Hi Dave
	Thanks for your review. Good suggestion! Will update in the next
verison.

> 
>>   u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
>>   {
>>   	union hv_ghcb *hv_ghcb;
>> @@ -356,6 +377,63 @@ static bool hv_is_private_mmio(u64 addr)
>>   	return false;
>>   }
>>   
>> +__init void hv_sev_init_mem_and_cpu(void)
>> +{
>> +	struct memory_map_entry *entry;
>> +	struct e820_entry *e820_entry;
>> +	u64 e820_end;
>> +	u64 ram_end;
>> +	u64 page;
>> +
>> +	/*
>> +	 * Hyper-V enlightened snp guest boots kernel
>> +	 * directly without bootloader and so roms,
>> +	 * bios regions and reserve resources are not
>> +	 * available. Set these callback to NULL.
>> +	 */
>> +	x86_platform.legacy.reserve_bios_regions = 0;
>> +	x86_init.resources.probe_roms = x86_init_noop;
>> +	x86_init.resources.reserve_resources = x86_init_noop;
>> +	x86_init.mpparse.find_smp_config = x86_init_noop;
>> +	x86_init.mpparse.get_smp_config = hv_snp_get_smp_config;
> This is one of those places that vertical alignment adds clarity:
> 
>> +	x86_init.resources.probe_roms	     = x86_init_noop;
>> +	x86_init.resources.reserve_resources = x86_init_noop;
>> +	x86_init.mpparse.find_smp_config     = x86_init_noop;
>> +	x86_init.mpparse.get_smp_config      = hv_snp_get_smp_config;
> See? 3 noops and only one actual implemented function.  Clear as day now.
> 

Yes, this looks better. Will update.

>> +	/*> +	 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
>> +	 * and legacy APIC page read/write. Switch to hv apic here.
>> +	 */
>> +	disable_ioapic_support();
> Do these systems have X86_FEATURE_APIC set?  Why is this needed in
> addition to the architectural enumeration that already exists?
>

X86_FEATURE_APIC is still set. Hyper-V provides parav-virtualized local
apic interface to replace APIC page opeartion. In the SEV-SNP guest.

> Is there any other place in the kernel that has this one-off disabling
> of the APIC?

In current kernel code, ioapic support still may be disabled when there 
is no MP table or ACPI MADT configuration. Please see 
__apic_intr_mode_select() and disable_smp() for detial where ioapic is 
disabled.

> 
>> +	/* Read processor number and memory layout. */
>> +	processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
>> +	entry = (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR)
>> +			+ sizeof(struct memory_map_entry));
> Ick.
> 
> There are a lot of ways to do this.  But, this is an awfully ugly way.
> 
> struct snp_processor_info {
> 	u32 processor_count;
> 	struct memory_map_entry[] entries;
> }
> 
> struct snp_processor_info *snp_pi =
> 				__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
> processor_count = snp_pi->processor_count;
> 
> Then, have your for() loop through snp_pi->entries;
> 
> Actually, I'm not_quite_  sure that processor_count and entries are next
> to each other.  But, either way, I do think a struct makes sense.

Agree. Will update.

> 
> Also, what guarantees that EN_SEV_SNP_PROCESSOR_INFO_ADDR is mapped?
> It's up above 8MB which I don't remember off the top of my head as being
> a special address.

This EN_SEV_SNP_PROCESSOR_INFO_ADDR is specified by hypervisor tool.
Hypervisor populates mem and cpu info to the page in the memory and 
kernel may access it via adding PHYS_OFFSET_OFFSET directly.

> 
>> +	/*
>> +	 * E820 table in the memory just describes memory for
>> +	 * kernel, ACPI table, cmdline, boot params and ramdisk.
>> +	 * Hyper-V popoulates the rest memory layout in the EN_SEV_
>> +	 * SNP_PROCESSOR_INFO_ADDR.
>> +	 */
> Really?  That is not very cool.  We need a better explanation of why
> there was no way to use the decades-old e820 or EFI memory map and why
> this needs to be a special snowflake.

Agree. There should be a comment to describe that there is no virtual 
Bios in the guest and hypervisor boots Linux kernel directly. So kernel 
needs to populdate e820 tables which should be prepared by virtual Bios.

> 
>> +	for (; entry->numpages != 0; entry++) {
>> +		e820_entry = &e820_table->entries[
>> +				e820_table->nr_entries - 1];
>> +		e820_end = e820_entry->addr + e820_entry->size;
>> +		ram_end = (entry->starting_gpn +
>> +			   entry->numpages) * PAGE_SIZE;
>> +
>> +		if (e820_end < entry->starting_gpn * PAGE_SIZE)
>> +			e820_end = entry->starting_gpn * PAGE_SIZE;
>> +
>> +		if (e820_end < ram_end) {
>> +			pr_info("Hyper-V: add e820 entry [mem %#018Lx-%#018Lx]\n", e820_end, ram_end - 1);
>> +			e820__range_add(e820_end, ram_end - e820_end,
>> +					E820_TYPE_RAM);
>> +			for (page = e820_end; page < ram_end; page += PAGE_SIZE)
>> +				pvalidate((unsigned long)__va(page), RMP_PG_SIZE_4K, true);
>> +		}
>> +	}
>> +}
> Oh, is this just about having a pre-accepted area and a non-accepted
> area?  Is this basically another one-off implementation of unaccepted
> memory ... that doesn't use the EFI standard?

No, there is no virtual EFI firmware inside VM and so kernel gets mem 
and vcpu info directly from Hyper-V.
