Return-Path: <linux-arch+bounces-451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE87F84D6
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 20:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044BA282EB3
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 19:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7867A3306F;
	Fri, 24 Nov 2023 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1hswrWx"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9A98
	for <linux-arch@vger.kernel.org>; Fri, 24 Nov 2023 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700854923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l7H6pu8nkSic7rPSXh8wGAQ480LZx0Q6bv1ihMXvDxs=;
	b=V1hswrWxcl3rwezVHUm70rOFmoupEY2OLbZSIEzPf+xw5EF4bJtqN/hwaCggbaH614yZwW
	czWEDBTTPQu76J9n0Or64I00xSqT7hxmTzovt+5inu/vNmlffZdmWjy3MbeCsi07M3A400
	7yAZ3mMjED/OBwO9Us+HAXZoa9jaI1M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-_0pkcS3aM9ers5IGM3BCZg-1; Fri, 24 Nov 2023 14:41:00 -0500
X-MC-Unique: _0pkcS3aM9ers5IGM3BCZg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b2a386e8dso12465725e9.0
        for <linux-arch@vger.kernel.org>; Fri, 24 Nov 2023 11:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700854859; x=1701459659;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7H6pu8nkSic7rPSXh8wGAQ480LZx0Q6bv1ihMXvDxs=;
        b=lFFM/h6jJA1q/Ha3nQMjvC16h9rueMmvvzXlK4BYzL0RsslYxzrb0NIKzLKhcABZL+
         Xc3D8/PSQ75fLYa568hwOmLAj8JkWavyLiIXO/6YqBQwnA1kxCf6JpPskwqYRC8YTjti
         zV1MKKme6wEQFtQFg8SMqxZTutYFPbZynueP6NmjCpWx8WLsT1OTDXCjfg6WCphMO0Kh
         6aZCbComrLroX51W38Fm3qKitH4GwCarL+iX+2SHgEyUeV+0Lu8t0v24zy+B0a70JYxG
         Y9XYbgos4r8W2h5egdvv+jeQb9DpxAtXDArJ2oQRWwTEJKOoYNnHV6K4+CvofGDhaV5j
         mRHw==
X-Gm-Message-State: AOJu0YygAPzwg4JRFgTDUhkMdXORDCIT70ULn/LT5qAhoSaihOLcxi+E
	4xOFn8BspzsYQJdbARQGIOS0H3YGkuFkc+ieNRWNFUf0afxfhpDTHvhHjwi1Mkx+R3uoCxDQCUp
	W0iZZSXDsQSfavRruRglnXw==
X-Received: by 2002:a05:600c:1c0d:b0:40b:3d92:de42 with SMTP id j13-20020a05600c1c0d00b0040b3d92de42mr1468705wms.8.1700854858872;
        Fri, 24 Nov 2023 11:40:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIa0Ag7nDmLb2STet/Q4xvrchyDOT8XsLNG+hJoGxgGenmCCkTOk+e6C/hGzb6XbqyhNhLmA==
X-Received: by 2002:a05:600c:1c0d:b0:40b:3d92:de42 with SMTP id j13-20020a05600c1c0d00b0040b3d92de42mr1468683wms.8.1700854858417;
        Fri, 24 Nov 2023 11:40:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00405959469afsm5921177wms.3.2023.11.24.11.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 11:40:58 -0800 (PST)
Message-ID: <c49cd89d-41cf-495b-9b96-4434ab407967@redhat.com>
Date: Fri, 24 Nov 2023 20:40:55 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 12/27] arm64: mte: Add tag storage pages to the
 MIGRATE_CMA migratetype
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 mhiramat@kernel.org, rppt@kernel.org, hughd@google.com
Cc: pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
 vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
 hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-13-alexandru.elisei@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231119165721.9849-13-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.23 17:57, Alexandru Elisei wrote:
> Add the MTE tag storage pages to the MIGRATE_CMA migratetype, which allows
> the page allocator to manage them like regular pages.
> 
> Ths migratype lends the pages some very desirable properties:
> 
> * They cannot be longterm pinned, meaning they will always be migratable.
> 
> * The pages can be allocated explicitely by using their PFN (with
>    alloc_contig_range()) when they are needed to store tags.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>   arch/arm64/Kconfig                  |  1 +
>   arch/arm64/kernel/mte_tag_storage.c | 68 +++++++++++++++++++++++++++++
>   include/linux/mmzone.h              |  5 +++
>   mm/internal.h                       |  3 --
>   4 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fe8276fdc7a8..047487046e8f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2065,6 +2065,7 @@ config ARM64_MTE
>   if ARM64_MTE
>   config ARM64_MTE_TAG_STORAGE
>   	bool "Dynamic MTE tag storage management"
> +	select CONFIG_CMA
>   	help
>   	  Adds support for dynamic management of the memory used by the hardware
>   	  for storing MTE tags. This memory, unlike normal memory, cannot be
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> index fa6267ef8392..427f4f1909f3 100644
> --- a/arch/arm64/kernel/mte_tag_storage.c
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -5,10 +5,12 @@
>    * Copyright (C) 2023 ARM Ltd.
>    */
>   
> +#include <linux/cma.h>
>   #include <linux/memblock.h>
>   #include <linux/mm.h>
>   #include <linux/of_device.h>
>   #include <linux/of_fdt.h>
> +#include <linux/pageblock-flags.h>
>   #include <linux/range.h>
>   #include <linux/string.h>
>   #include <linux/xarray.h>
> @@ -189,6 +191,14 @@ static int __init fdt_init_tag_storage(unsigned long node, const char *uname,
>   		return ret;
>   	}
>   
> +	/* Pages are managed in pageblock_nr_pages chunks */
> +	if (!IS_ALIGNED(tag_range->start | range_len(tag_range), pageblock_nr_pages)) {
> +		pr_err("Tag storage region 0x%llx-0x%llx not aligned to pageblock size 0x%llx",
> +		       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end),
> +		       PFN_PHYS(pageblock_nr_pages));
> +		return -EINVAL;
> +	}
> +
>   	ret = tag_storage_get_memory_node(node, &mem_node);
>   	if (ret)
>   		return ret;
> @@ -254,3 +264,61 @@ void __init mte_tag_storage_init(void)
>   		pr_info("MTE tag storage region management disabled");
>   	}
>   }
> +
> +static int __init mte_tag_storage_activate_regions(void)
> +{
> +	phys_addr_t dram_start, dram_end;
> +	struct range *tag_range;
> +	unsigned long pfn;
> +	int i, ret;
> +
> +	if (num_tag_regions == 0)
> +		return 0;
> +
> +	dram_start = memblock_start_of_DRAM();
> +	dram_end = memblock_end_of_DRAM();
> +
> +	for (i = 0; i < num_tag_regions; i++) {
> +		tag_range = &tag_regions[i].tag_range;
> +		/*
> +		 * Tag storage region was clipped by arm64_bootmem_init()
> +		 * enforcing addressing limits.
> +		 */
> +		if (PFN_PHYS(tag_range->start) < dram_start ||
> +				PFN_PHYS(tag_range->end) >= dram_end) {
> +			pr_err("Tag storage region 0x%llx-0x%llx outside addressable memory",
> +			       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end));
> +			ret = -EINVAL;
> +			goto out_disabled;
> +		}
> +	}
> +
> +	/*
> +	 * MTE disabled, tag storage pages can be used like any other pages. The
> +	 * only restriction is that the pages cannot be used by kexec because
> +	 * the memory remains marked as reserved in the memblock allocator.
> +	 */
> +	if (!system_supports_mte()) {
> +		for (i = 0; i< num_tag_regions; i++) {
> +			tag_range = &tag_regions[i].tag_range;
> +			for (pfn = tag_range->start; pfn <= tag_range->end; pfn++)
> +				free_reserved_page(pfn_to_page(pfn));
> +		}
> +		ret = 0;
> +		goto out_disabled;
> +	}
> +
> +	for (i = 0; i < num_tag_regions; i++) {
> +		tag_range = &tag_regions[i].tag_range;
> +		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages)
> +			init_cma_reserved_pageblock(pfn_to_page(pfn));
> +		totalcma_pages += range_len(tag_range);
> +	}

You shouldn't be doing that manually in arm code. Likely you want some 
cma.c helper for something like that.

But, can you elaborate on why you took this hacky (sorry) approach as 
documented in the cover letter:

"The arm64 code manages this memory directly instead of using
cma_declare_contiguous/cma_alloc for performance reasons."

What is the exact problem?

-- 
Cheers,

David / dhildenb


