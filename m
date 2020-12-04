Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464082CE94B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 09:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgLDINu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 03:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgLDINu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 03:13:50 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53704C061A51;
        Fri,  4 Dec 2020 00:13:10 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id h7so3410213pjk.1;
        Fri, 04 Dec 2020 00:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=3fbzFtODlG6DhIFOuWtZWUtQuIVTw1JtB82OhelR1f8=;
        b=hiaCSk2RB4ZbZZ7qUDKx5WuheWKkTpmcIvHy+cDMvtWoe2wDZGGmS/CTLyju1KF2h8
         wrdeWY5t6bUGml15IUYpkpCB3LWc8lGpFbHfR3bWaCjZlD3sXcH9T/3RpltgStc6Koto
         1j8Cz+Cj3tG5sw/UmjdiDUMINMSPhCVp5JuxGyUJtGxH4PAe0RR8GUSCV82Zd8p/Yh41
         BzYOl3j+6ON8TZJFpdErKBQway7qpqf5hq+9ZcktbSgtVO/++tslXRwcBKuYp/G8Kldq
         AlgSDTdbZ8gam9IwQZQDkNGSFEc5lAR9DYMhIO6aym5RiP/KPWlSuKDaVLgbPXhM+Sm+
         jnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=3fbzFtODlG6DhIFOuWtZWUtQuIVTw1JtB82OhelR1f8=;
        b=oY2aBJKp5hYSyLJCNOnvLg6Vz4qg1EUJN5VPyrFAzRZ7S56IPY+oNKLv+sZgfjghM0
         kKa2IFRtTnMsHh6QjAyfAryfXWhRgYDlr6IL47w+I/+4EjJECEnblBVMvPRqGfBqmE0i
         l20a6qeT6CwSUQXUH5tsIMnnyB6iM7yrQioGy+DWKneb7Pv75jFrk6FoAgIJIqya9dQC
         vEqhMY1DrvD9c9EENOObCPiN2Mu1YlZAtmvmytsZ3RZs6RdmEiQ1xkx5m/ZO7PX+FPTL
         g2ehTByEQ6I+5z6rnLh/ewlEZ3btJbpEiE7aG5LdGZcpnqsfMeEPz5CiTV9VkJEmUQ6S
         YLQA==
X-Gm-Message-State: AOAM532JT858ZyxOMh+NtSzkg5fNoKzeD8KIaIN192F7A6J+Ba9OyOM4
        vVE14HSOgDqyj6SkzDyQmSuXR+m4kLs=
X-Google-Smtp-Source: ABdhPJxFGKvxSujUjSN4DbHCJiDIqCfKt/Gd/ih5Y1oXid6kspH8VxuaLkxN8iSd6XopGq0+v05kZA==
X-Received: by 2002:a17:902:c395:b029:da:9aca:c972 with SMTP id g21-20020a170902c395b02900da9acac972mr2815306plg.32.1607069588337;
        Fri, 04 Dec 2020 00:13:08 -0800 (PST)
Received: from localhost ([1.129.136.83])
        by smtp.gmail.com with ESMTPSA id n68sm4177105pfn.161.2020.12.04.00.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 00:13:07 -0800 (PST)
Date:   Fri, 04 Dec 2020 18:12:58 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v8 11/12] mm/vmalloc: Hugepage vmalloc mappings
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "hch@infradead.org" <hch@infradead.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>
References: <20201128152559.999540-1-npiggin@gmail.com>
        <20201128152559.999540-12-npiggin@gmail.com>
        <e9d3a50e1b18f9ea1cdfdc221bef75db19273417.camel@intel.com>
In-Reply-To: <e9d3a50e1b18f9ea1cdfdc221bef75db19273417.camel@intel.com>
MIME-Version: 1.0
Message-Id: <1607068679.lfd133za4h.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Edgecombe, Rick P's message of December 1, 2020 6:21 am:
> On Sun, 2020-11-29 at 01:25 +1000, Nicholas Piggin wrote:
>> Support huge page vmalloc mappings. Config option
>> HAVE_ARCH_HUGE_VMALLOC
>> enables support on architectures that define HAVE_ARCH_HUGE_VMAP and
>> supports PMD sized vmap mappings.
>>=20
>> vmalloc will attempt to allocate PMD-sized pages if allocating PMD
>> size
>> or larger, and fall back to small pages if that was unsuccessful.
>>=20
>> Allocations that do not use PAGE_KERNEL prot are not permitted to use
>> huge pages, because not all callers expect this (e.g., module
>> allocations vs strict module rwx).
>=20
> Several architectures (x86, arm64, others?) allocate modules initially
> with PAGE_KERNEL and so I think this test will not exclude module
> allocations in those cases.

Ah, thanks. I guess archs must additionally ensure that their
PAGE_KERNEL allocations are suitable for huge page mappings before
enabling the option.

If there is interest from those archs to support this, I have an
early (un-posted) patch that adds an explicit VM_HUGE flag that could
override the pessemistic arch default. It's not much trouble to add this=20
to the large system hash allocations. It's very out of date now but I=20
can at least give what I have to anyone doing an arch support that
wants it.

>=20
> [snip]
>=20
>> @@ -2400,6 +2453,7 @@ static inline void set_area_direct_map(const
>> struct vm_struct *area,
>>  {
>>  	int i;
>> =20
>> +	/* HUGE_VMALLOC passes small pages to set_direct_map */
>>  	for (i =3D 0; i < area->nr_pages; i++)
>>  		if (page_address(area->pages[i]))
>>  			set_direct_map(area->pages[i]);
>> @@ -2433,11 +2487,12 @@ static void vm_remove_mappings(struct
>> vm_struct *area, int deallocate_pages)
>>  	 * map. Find the start and end range of the direct mappings to
>> make sure
>>  	 * the vm_unmap_aliases() flush includes the direct map.
>>  	 */
>> -	for (i =3D 0; i < area->nr_pages; i++) {
>> +	for (i =3D 0; i < area->nr_pages; i +=3D 1U << area->page_order) {
>>  		unsigned long addr =3D (unsigned long)page_address(area-
>> >pages[i]);
>>  		if (addr) {
>> +			unsigned long page_size =3D PAGE_SIZE << area-
>> >page_order;
>>  			start =3D min(addr, start);
>> -			end =3D max(addr + PAGE_SIZE, end);
>> +			end =3D max(addr + page_size, end);
>>  			flush_dmap =3D 1;
>>  		}
>>  	}
>=20
> The logic around this is a bit tangled. The reset of the direct map has
> to succeed, but if the set_direct_map_() functions require a split they
> could fail. For x86, set_memory_ro() calls on a vmalloc alias will
> mirror the page size and permission on the direct map and so the direct
> map will be broken to 4k pages if it's a RO vmalloc allocation.
>=20
> But after this, module vmalloc()'s could have large pages which would
> result in large RO pages on the direct map. Then it could possibly fail
> when trying to reset a 4k page out of a large RO direct map mapping.=20
>=20
> I think either module allocations need to be actually excluded from
> having large pages (seems like you might have seen other issues as
> well?), or another option could be to use the changes here:
> https://lore.kernel.org/lkml/20201125092208.12544-4-rppt@kernel.org/
> to reset the direct map for a large page range at a time for large=20
> vmalloc pages.
>=20

Right, x86 would have to do something about that before enabling.
A VM_HUGE flag might be quick and easy but maybe other options are not=20
too difficult.

Thanks,
Nick
