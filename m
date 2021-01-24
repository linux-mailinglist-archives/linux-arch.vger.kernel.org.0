Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21AD301F84
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jan 2021 00:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbhAXXSS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 18:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbhAXXSR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 18:18:17 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A2C061573;
        Sun, 24 Jan 2021 15:17:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p15so7224354pjv.3;
        Sun, 24 Jan 2021 15:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=vmIru6MfV60AorXtK81mK9wqaHb82tqsfwMpO7SPkgI=;
        b=K+U49/R9bHOeSIDkgGZanLLovgbgmh5uQMQVJNnno8FThvFwXybrHyFT1R0qJhL9GK
         K1z14NFcw8Tqbmru39dBz7taSSjxBTWys7rsL0OmtRPn95vN+d3PRTbM1dM386Q8o3NW
         ZE49oxL2QRa8FMV1zkeB4pVweM6cN0Tq37ApvBTDV/wUHnSWz3eB8Siv1aq6EDaIUxvk
         y3agWJFjQS6CACCLLpedCSp9CaUCa8JU1IiOXioY2cIn2r3WVWp8ZTeCKhd8ugm6CgOz
         +pSx4SP2x2g+/E2iZqd1FQYamEwSq1XLCNZ9sPvJ0B5GgaMWjXqggSIF09D7OVqoJAFB
         waYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=vmIru6MfV60AorXtK81mK9wqaHb82tqsfwMpO7SPkgI=;
        b=MUQ08/Xlj5ToZCyjGEf3nZ3r/SKlwrJwUTQMmAqw91RMW1LnjKip3d2RYedDj5u5n0
         ws2L81hOlFbnSeIXNnQXHaqDZHf8+Zl21QkcfUEJOgGE98QWtitUuTOnWwbvHO8k0JUB
         NyFiyb+32lBe6MCR3i+g91BA0b/HlBS2ldFwoigCO6ey1dp5bjoEpHSwyITCX7t4NDDj
         OiwBuVcCCMTUVXbPIRpOvbdeXNwMF2SgTRmflRvpy3NZW5Knyne7aKmfj/dLZgbHv3nm
         IqVWejcIZ5QHJRfVpeOsBNoGgv29ATI9AK6MYx68B/RDrZSdZgKepWfeEW/XlCbSWfs3
         R6WQ==
X-Gm-Message-State: AOAM530zzZPBPnPTTvnHLjE5cgCWCwxXW4fowkWVgpJFRo4mwi5dJK8Z
        j9r9EIn3PYIAmICMcW9fodw=
X-Google-Smtp-Source: ABdhPJy2kG8tVAgVFmG9UnEo3wcKE3mHDXxXZlqFto7Q/Kp/s+THDx1kKu0L5cmF2uvncLYV9yvjIw==
X-Received: by 2002:a17:902:c94d:b029:de:9b70:d886 with SMTP id i13-20020a170902c94db02900de9b70d886mr6340876pla.5.1611530255875;
        Sun, 24 Jan 2021 15:17:35 -0800 (PST)
Received: from localhost ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id gg6sm20043833pjb.2.2021.01.24.15.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 15:17:34 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:17:18 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v10 11/12] mm/vmalloc: Hugepage vmalloc mappings
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20210124082230.2118861-1-npiggin@gmail.com>
        <20210124082230.2118861-12-npiggin@gmail.com>
        <20210124150729.GC733865@infradead.org>
In-Reply-To: <20210124150729.GC733865@infradead.org>
MIME-Version: 1.0
Message-Id: <1611529781.hxjbuadzrl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christoph Hellwig's message of January 25, 2021 1:07 am:
> On Sun, Jan 24, 2021 at 06:22:29PM +1000, Nicholas Piggin wrote:
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 24862d15f3a3..f87feb616184 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -724,6 +724,16 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>  config HAVE_ARCH_HUGE_VMAP
>>  	bool
>> =20
>> +config HAVE_ARCH_HUGE_VMALLOC
>> +	depends on HAVE_ARCH_HUGE_VMAP
>> +	bool
>> +	help
>> +	  Archs that select this would be capable of PMD-sized vmaps (i.e.,
>> +	  arch_vmap_pmd_supported() returns true), and they must make no
>> +	  assumptions that vmalloc memory is mapped with PAGE_SIZE ptes. The
>> +	  VM_NOHUGE flag can be used to prohibit arch-specific allocations fro=
m
>> +	  using hugepages to help with this (e.g., modules may require it).
>=20
> help texts don't make sense for options that aren't user visible.

Yeah it was supposed to just be a comment but if it was user visible=20
then similar kind of thing would not make sense in help text, so I'll
just turn it into a real comment as per Randy's suggestion.

> More importantly, is there any good reason to keep the option and not
> just go the extra step and enable huge page vmalloc for arm64 and x86
> as well?

Yes they need to ensure they exclude vmallocs that can't be huge one
way or another (VM_ flag or prot arg).

After they're converted we can fold it into HUGE_VMAP.

>> +static inline bool is_vm_area_hugepages(const void *addr)
>> +{
>> +	/*
>> +	 * This may not 100% tell if the area is mapped with > PAGE_SIZE
>> +	 * page table entries, if for some reason the architecture indicates
>> +	 * larger sizes are available but decides not to use them, nothing
>> +	 * prevents that. This only indicates the size of the physical page
>> +	 * allocated in the vmalloc layer.
>> +	 */
>> +	return (find_vm_area(addr)->page_order > 0);
>=20
> No need for the braces here.
>=20
>>  }
>> =20
>> +static int vmap_pages_range_noflush(unsigned long addr, unsigned long e=
nd,
>> +		pgprot_t prot, struct page **pages, unsigned int page_shift)
>> +{
>> +	unsigned int i, nr =3D (end - addr) >> PAGE_SHIFT;
>> +
>> +	WARN_ON(page_shift < PAGE_SHIFT);
>> +
>> +	if (page_shift =3D=3D PAGE_SHIFT)
>> +		return vmap_small_pages_range_noflush(addr, end, prot, pages);
>=20
> This begs for a IS_ENABLED check to disable the hugepage code for
> architectures that don't need it.

Yeah good point.

>> +int map_kernel_range_noflush(unsigned long addr, unsigned long size,
>> +			     pgprot_t prot, struct page **pages)
>> +{
>> +	return vmap_pages_range_noflush(addr, addr + size, prot, pages, PAGE_S=
HIFT);
>> +}
>=20
> Please just kill off map_kernel_range_noflush and map_kernel_range
> off entirely in favor of the vmap versions.

I can do a cleanup patch on top of it.

>> +	for (i =3D 0; i < area->nr_pages; i +=3D 1U << area->page_order) {
>=20
> Maybe using a helper that takes the vm_area_struct and either returns
> area->page_order or always 0 based on IS_ENABLED?

I'll see how it looks.

Thanks,
Nick
