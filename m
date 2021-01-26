Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0354F30395E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 10:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbhAZJs1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 04:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391276AbhAZJsI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 04:48:08 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9357CC06174A;
        Tue, 26 Jan 2021 01:47:28 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g15so11134669pgu.9;
        Tue, 26 Jan 2021 01:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=SPAzPMHTUwMywoI0YQ3zzW5m1bqgTd/Dm/sAyJYiZoU=;
        b=W2PrIvrIVmdbuaEdejTXL/7FLIJb/5mP1qpGdgnJtEEGw7NLZ+e/FI97ohHsWVDipd
         5dF8C5mNdVkZUqB8JfAS7PVUERPWq0KWNurxULF9TUHwuvDN0DeZRbbdCL34p8Gvz4rL
         lmYEI8nq984fQtKOef6ZAELQJyH11zFN8f4BrI4A2zhXFdY6nTsAOBxwfPyggbwFRezg
         fqippu/BO5P96Mb8WjAFpfV2A8YAsRcRl8N4VBP7YTcQzZte9XHY+e/2unQxKMhd6eSy
         UmIiqO7KXZL6uSq5C2Wr8+0OKovo+QEy7YhcRTzibFN1n3rz7n4oqURRM4erA2+Pfj+/
         3vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=SPAzPMHTUwMywoI0YQ3zzW5m1bqgTd/Dm/sAyJYiZoU=;
        b=JyN2bTF+sm2Xr84SuTvJoEZbff4ya2QqFWyrbpx9lTUku2W2ZNGGKxGYjEAe4VAaLu
         x3k2sXaaZRCzSErK54himzCcZXARTNZT9F7dExq0pzdijOMzcUaMweJJZQayYigOk82v
         3nd4LJAwSEOe3fynxUxZZK32bBb6K/KTOZYo5aCUGXSEK3f2+UWhIX0ztxgkF/BCTcbL
         Oav6Epsh50Ty6ZAg/sVEmLl4CH9B8KhW5VZdMfkPuWmT3De8VkgS1QkviVluNY/7moJF
         FDZcWamuhzG83fTHNvKMl2yEmQBST5tc07SYjCMuwYeTlvfDG/esHMDhM0DGkA65Z4vk
         pqZg==
X-Gm-Message-State: AOAM530Q1JNy9CCaTdVjDBkPf+P9mGg+OrjNAry4yJv6jpGH7ffRMmAs
        AeyVFcXXRBoUqyeIOXOSNWM=
X-Google-Smtp-Source: ABdhPJw2MXPKRaA2kctx6FW3cVhePx8H93ZknPUe2RtbSEpjbwM/uc3AYcTkxnbnOic06K/F2HkFzQ==
X-Received: by 2002:a62:54c3:0:b029:1bc:731c:dfc1 with SMTP id i186-20020a6254c30000b02901bc731cdfc1mr4627362pfb.20.1611654448148;
        Tue, 26 Jan 2021 01:47:28 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id v21sm1095752pfn.80.2021.01.26.01.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 01:47:27 -0800 (PST)
Date:   Tue, 26 Jan 2021 19:47:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v11 12/13] mm/vmalloc: Hugepage vmalloc mappings
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ding Tianhong <dingtianhong@huawei.com>, linux-mm@kvack.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210126044510.2491820-1-npiggin@gmail.com>
        <20210126044510.2491820-13-npiggin@gmail.com>
        <0f360e6e-6d34-19ce-6c76-a17a5f4f7fc3@huawei.com>
In-Reply-To: <0f360e6e-6d34-19ce-6c76-a17a5f4f7fc3@huawei.com>
MIME-Version: 1.0
Message-Id: <1611653945.t3oot63nwn.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Ding Tianhong's message of January 26, 2021 4:59 pm:
> On 2021/1/26 12:45, Nicholas Piggin wrote:
>> Support huge page vmalloc mappings. Config option HAVE_ARCH_HUGE_VMALLOC
>> enables support on architectures that define HAVE_ARCH_HUGE_VMAP and
>> supports PMD sized vmap mappings.
>>=20
>> vmalloc will attempt to allocate PMD-sized pages if allocating PMD size
>> or larger, and fall back to small pages if that was unsuccessful.
>>=20
>> Architectures must ensure that any arch specific vmalloc allocations
>> that require PAGE_SIZE mappings (e.g., module allocations vs strict
>> module rwx) use the VM_NOHUGE flag to inhibit larger mappings.
>>=20
>> When hugepage vmalloc mappings are enabled in the next patch, this
>> reduces TLB misses by nearly 30x on a `git diff` workload on a 2-node
>> POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%.
>>=20
>> This can result in more internal fragmentation and memory overhead for a
>> given allocation, an option nohugevmalloc is added to disable at boot.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/Kconfig            |  11 ++
>>  include/linux/vmalloc.h |  21 ++++
>>  mm/page_alloc.c         |   5 +-
>>  mm/vmalloc.c            | 215 +++++++++++++++++++++++++++++++---------
>>  4 files changed, 205 insertions(+), 47 deletions(-)
>>=20
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 24862d15f3a3..eef170e0c9b8 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -724,6 +724,17 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>  config HAVE_ARCH_HUGE_VMAP
>>  	bool
>> =20
>> +#
>> +#  Archs that select this would be capable of PMD-sized vmaps (i.e.,
>> +#  arch_vmap_pmd_supported() returns true), and they must make no assum=
ptions
>> +#  that vmalloc memory is mapped with PAGE_SIZE ptes. The VM_NO_HUGE_VM=
AP flag
>> +#  can be used to prohibit arch-specific allocations from using hugepag=
es to
>> +#  help with this (e.g., modules may require it).
>> +#
>> +config HAVE_ARCH_HUGE_VMALLOC
>> +	depends on HAVE_ARCH_HUGE_VMAP
>> +	bool
>> +
>>  config ARCH_WANT_HUGE_PMD_SHARE
>>  	bool
>> =20
>> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
>> index 99ea72d547dc..93270adf5db5 100644
>> --- a/include/linux/vmalloc.h
>> +++ b/include/linux/vmalloc.h
>> @@ -25,6 +25,7 @@ struct notifier_block;		/* in notifier.h */
>>  #define VM_NO_GUARD		0x00000040      /* don't add guard page */
>>  #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory =
*/
>>  #define VM_MAP_PUT_PAGES	0x00000100	/* put pages and free array in vfre=
e */
>> +#define VM_NO_HUGE_VMAP		0x00000200	/* force PAGE_SIZE pte mapping */
>>=20
>>  /*
>>   * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALL=
OC.
>> @@ -59,6 +60,9 @@ struct vm_struct {
>>  	unsigned long		size;
>>  	unsigned long		flags;
>>  	struct page		**pages;
>> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
>> +	unsigned int		page_order;
>> +#endif
>>  	unsigned int		nr_pages;
>>  	phys_addr_t		phys_addr;
>>  	const void		*caller;
> Hi Nicholas:
>=20
> Give a suggestion :)
>=20
> The page order was only used to indicate the huge page flag for vm area, =
and only valid when
> size bigger than PMD_SIZE, so can we use the vm flgas to instead of that,=
 just like define the
> new flag named VM_HUGEPAGE, it would not break the vm struct, and it is e=
asier for me to backport the serious
> patches to our own branches. (Base on the lts version).

Hmm, it might be possible. I'm not sure if 1GB vmallocs will be used any=20
time soon (or maybe they will for edge case configurations? It would be=20
trivial to add support for).

The other concern I have is that Christophe IIRC was asking about=20
implementing a mapping for PPC which used TLB mappings that were=20
different than kernel page table tree size. Although I guess we could=20
deal with that when it comes.

I like the flexibility of page_order though. How hard would it be for=20
you to do the backport with VM_HUGEPAGE yourself?

I should also say, thanks for all the review and testing from the Huawei=20
team. Do you have an x86 patch?

Thanks,
Nick
