Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5152F63C2E1
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiK2OnF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Nov 2022 09:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiK2OnB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 09:43:01 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B28C30F4A;
        Tue, 29 Nov 2022 06:43:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so17539677pjc.3;
        Tue, 29 Nov 2022 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1K/S2qvXKDafV6DPA+7kDpqM5e0swHr/b4XJtu355Q=;
        b=TSoCoyZDKUQMfWUNIh8atxgcwoWpTJd9pvvrBSWFspxefz2R+3Mg91AA/XywjuRY4x
         d1OH5nY7uxtF/pO2o6C8nJ/145jU8/NVxX8vJk9pb23p7m5+GZgw91ooSTEqDOIaCjJb
         hiy8MTsUlDSOEa5QuU6tT3Ck+TnykibUTLpH16Omr4tzNixFTYspEG9W0/QOmmcP6ZDf
         oZJJnE/DrW/Y1VrxKJjVnKYWBNVZrtWt3oosJbPJ230tSDoDTnrxmg4hKihPlEhL5tjR
         1TVpfuxMQfhUWvStqH1wwPHncdInkk85pj1+ScwdWrJBEV3sGlo9QJnKj5Z0bzPiX+/K
         9/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1K/S2qvXKDafV6DPA+7kDpqM5e0swHr/b4XJtu355Q=;
        b=6tU+hH8OPtxTVmkK3pYOOVozpXS3sVklVevzPTvsf1h+fJU/YYbGIzEin02kaLrxxH
         D15DubRjzoW+1ZyETpOfvyXHy03/+dbtbbf40cbmRa/t8Gts/R9HH9b4Y7FtdC1YZmAE
         0CrTC3SULCYaXgQq5o9DoCvuSL4PsJhT+6qvzslrKutOcJGyDxKHmIYsukAPIsWcp07n
         pxVKYafdwqTPsjdbMNEBTMVLzmi+88P91kLLwVJ/OweNUYGrH3ZnhTg7inIjA2I6XbmB
         RfcVHCFmqA3Cm+cBcNXiCMvfT5n/AWOe82fLmC0kf0KcTkP4xSJ6rECFytFQO2VIjjsy
         PmkA==
X-Gm-Message-State: ANoB5pm6MqPUYg5/PqX5zYYiF+IorRrt0YQFWinAWdZckq8ggdBPlpJX
        muBPoXCgLI258PZRUXZAIVI=
X-Google-Smtp-Source: AA0mqf67r/XsFNm47qgLGsdoGzx47t44ia2XHmIj2DRTB1Uj5QUQZG1IB2BIF38XHdMX1YLdXCWEcw==
X-Received: by 2002:a17:90a:2b44:b0:213:d66b:4973 with SMTP id y4-20020a17090a2b4400b00213d66b4973mr66442998pjc.85.1669732979573;
        Tue, 29 Nov 2022 06:42:59 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id z7-20020aa79587000000b005625d5ae760sm10372710pfj.11.2022.11.29.06.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:42:58 -0800 (PST)
Message-ID: <6b3bdbbd-d381-3e52-57ec-729c8ab2d042@gmail.com>
Date:   Tue, 29 Nov 2022 22:42:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH V2 01/18] x86/sev: Pvalidate memory gab for
 decompressing kernel
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
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
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-2-ltykernel@gmail.com> <Y4YBfk3lyUJie4bR@zn.tnic>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <Y4YBfk3lyUJie4bR@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/29/2022 8:56 PM, Borislav Petkov wrote:
>> +/* Check SEV-SNP via MSR */
>> +static bool sev_snp_runtime_check(void)
> Functions need to have a verb in the name.
> 
>> +{
>> +	unsigned long low, high;
>> +	u64 val;
>> +
>> +	asm volatile("rdmsr\n" : "=a" (low), "=d" (high) :
>> +			"c" (MSR_AMD64_SEV));
>> +
>> +	val = (high << 32) | low;
>> +	if (val & MSR_AMD64_SEV_SNP_ENABLED)
>> +		return true;
> There already is a sev_snp_enabled() in that very same file. Did you not
> see it?
> 
> Why are you even adding such a function?!
Hi Boris:
	Thanks for your review. sev_snp_enabled() is used after
sev_status was initialized in sev_enable() while  pvalidate_for_startup_
64() is called before sev_enable(). So add sev_snp_runtime_check() to 
check sev snp capability before calling sev_enable().

> 
>> +	return false;
>> +}
>> +
>>   static inline bool sev_snp_enabled(void)
>>   {
>>   	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>> @@ -456,3 +475,68 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
>>   
>>   	sev_verify_cbit(top_level_pgt);
>>   }
>> +
>> +static void extend_e820_on_demand(struct boot_e820_entry *e820_entry,
>> +				  u64 needed_ram_end)
>> +{
>> +	u64 end, paddr;
>> +	unsigned long eflags;
>> +	int rc;
>> +
>> +	if (!e820_entry)
>> +		return;
>> +
>> +	/* Validated memory must be aligned by PAGE_SIZE. */
>> +	end = ALIGN(e820_entry->addr + e820_entry->size, PAGE_SIZE);
>> +	if (needed_ram_end > end && e820_entry->type == E820_TYPE_RAM) {
>> +		for (paddr = end; paddr < needed_ram_end; paddr += PAGE_SIZE) {
>> +			rc = pvalidate(paddr, RMP_PG_SIZE_4K, true);
>> +			if (rc) {
>> +				error("Failed to validate address.n");
>> +				return;
>> +			}
>> +		}
>> +		e820_entry->size = needed_ram_end - e820_entry->addr;
>> +	}
>> +}
>> +
>> +/*
>> + * Explicitly pvalidate needed pages for decompressing the kernel.
>> + * The E820_TYPE_RAM entry includes only validated memory. The kernel
>> + * expects that the RAM entry's addr is fixed while the entry size is to be
>> + * extended to cover addresses to the start of next entry.
>> + * The function increases the RAM entry size to cover all possible memory
> Similar issue as above: you don't need to say "this function" above this
> function. IOW, it should say:
> 
> "Increase the RAM entry size..."
> 
> I.e., imperative mood above.
> 
>> + * addresses until init_size.
>> + * For example,  init_end = 0x4000000,
>> + * [RAM: 0x0 - 0x0],                       M[RAM: 0x0 - 0xa0000]
>> + * [RSVD: 0xa0000 - 0x10000]                [RSVD: 0xa0000 - 0x10000]
>> + * [ACPI: 0x10000 - 0x20000]      ==>       [ACPI: 0x10000 - 0x20000]
>> + * [RSVD: 0x800000 - 0x900000]              [RSVD: 0x800000 - 0x900000]
>> + * [RAM: 0x1000000 - 0x2000000]            M[RAM: 0x1000000 - 0x2001000]
>> + * [RAM: 0x2001000 - 0x2007000]            M[RAM: 0x2001000 - 0x4000000]
> What is this trying to tell me?
> 
> That the end range 0x2007000 gets raised to 0x4000000?
> 
> Why?
> 
> This all sounds like there is some requirement somewhere but nothing
> says what that requirement is and why.
> 
>> + * Other RAM memory after init_end is pvalidated by ms_hyperv_init_platform
>> + */
>> +__visible void pvalidate_for_startup_64(struct boot_params *boot_params)
> This doesn't do any validation. And yet it has "pvalidate" in the name.
> 
>> +{
>> +	struct boot_e820_entry *e820_entry;
>> +	u64 init_end =
>> +		boot_params->hdr.pref_address + boot_params->hdr.init_size;
> Nope, we never break lines like that.
> 
>> +	u8 i, nr_entries = boot_params->e820_entries;
>> +	u64 needed_end;
> The tip-tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
> 
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
> 
> The above is faster to parse than the reverse ordering::
> 
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
> 
> And even more so than random ordering::
> 
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;
> 
>> +	if (!sev_snp_runtime_check())
>> +		return;
>> +
>> +	for (i = 0; i < nr_entries; ++i) {
>> +		/* Pvalidate memory holes in e820 RAM entries. */
>> +		e820_entry = &boot_params->e820_table[i];
>> +		if (i < nr_entries - 1) {
>> +			needed_end = boot_params->e820_table[i + 1].addr;
>> +			if (needed_end < e820_entry->addr)
>> +				error("e820 table is not sorted.\n");
>> +		} else {
>> +			needed_end = init_end;
>> +		}
>> +		extend_e820_on_demand(e820_entry, needed_end);
> Now*this*  function does call pvalidate() and yet it doesn't have
> "pvalidate" in the name. This all looks real confused.
> 
> So first of all, you need to explain*why*  you're doing this.
> 
> It looks like it is because the guest needs to do the memory validation
> by itself because nobody else does that.
> 
> If so, this needs to be explained in detail in the commit message.

Yes, I will update in the next version. Thanks for suggestion.

> 
> Also, why is that ok for SNP guests on other hypervisors which get the
> memory validated by the boot loader or firmware?

This is for Linux direct boot mode and so it needs to do such check 
here. Will fix this in the next version.
