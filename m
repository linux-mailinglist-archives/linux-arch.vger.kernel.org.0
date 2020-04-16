Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362EA1AB5FA
	for <lists+linux-arch@lfdr.de>; Thu, 16 Apr 2020 04:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbgDPCim (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 22:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732153AbgDPCik (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 22:38:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABADC061A0C;
        Wed, 15 Apr 2020 19:38:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 188so921226pgj.13;
        Wed, 15 Apr 2020 19:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=inF2oUQWOVUn1zSzuLcDRWp19ZrU3frGNXSsTZrmfdQ=;
        b=jrHbU5WLW/3NRzRL4tUP93CurNe3euf3u04ZSvHtx4DoKvg6BdTPCBmBNvMyBxrmZ7
         TgU6cisZ6MbOW00sFnL3XXqhrZos/MnOzXaPFFHxANt1Lbnm9vbEaY/H69/eXJTkDffy
         ipYXWrWZ5P1cZa1xWZhnN8U2oyc9HkCyolyDPlTsvYS1NbDcLglMyXiC04gAJ3QohUCR
         jjhhKSZFl5DZdnIqOWAvjUvsN7l3N7G0oCbfxTH2p8/CtE0JdvlD3sOFTmXSKJceP4wx
         +WBjX7cQkyZuAZdZmSzBG05XUhJpmhNFkrmD+CwNHb8SpwSIZ1DZTATXqT/9abQkBz88
         tb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=inF2oUQWOVUn1zSzuLcDRWp19ZrU3frGNXSsTZrmfdQ=;
        b=HBQY6RygLqh0Xsz/eR3ySaemX6k9UPmfL1o5GwXkq3jaVaC743Wa2sW2PIQAxd7kjT
         TonJHlVxA7zRWX/eyAPTTNSSy/yPk5nKvSS9jUHq/1j4QEQaZZ+BoBBzB4AkihJyG/6Z
         Ori/6l2qIsKHxWzCKKHrnX7/w+clg0xcMsnqzto+4a4T8KB515xKF0PNv/i+peI8yNDl
         VehmoxF+bgA33H35IB0FUsNfVV11+3OxfhHCN9TQx5I08K258OIdW6lCobzwMaWfTDUH
         /OTiNPRdsln4bsuEO6+pDVbGTagBGdi6X6DjQfDeLM+OoIXPa3gtVKcYuG+plgBGhb5D
         xKyA==
X-Gm-Message-State: AGi0PubdI6IWBjFOScn6xHAKmJjH9if5+ANryksO5yJTA4/FfY9masoj
        nKr1q/u7/7rDjrT0ysqmOjo=
X-Google-Smtp-Source: APiQypLiACMHB4H40lzo7TjDzMxKO4UkcSYRYlY6AuEcTVgyHDfawhLANelI41IO6oDhsCuzUrA+DA==
X-Received: by 2002:a62:7811:: with SMTP id t17mr31223582pfc.268.1587004718236;
        Wed, 15 Apr 2020 19:38:38 -0700 (PDT)
Received: from localhost ([203.18.28.220])
        by smtp.gmail.com with ESMTPSA id 198sm15506729pfa.87.2020.04.15.19.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 19:38:37 -0700 (PDT)
Date:   Thu, 16 Apr 2020 12:38:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
To:     Will Deacon <will@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <20200415104755.GD12621@willie-the-truck>
In-Reply-To: <20200415104755.GD12621@willie-the-truck>
MIME-Version: 1.0
Message-Id: <1587003993.x84ylh11b2.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Will Deacon's message of April 15, 2020 8:47 pm:
> Hi Nick,
>=20
> On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
>> For platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmap mappi=
ngs,
>> have vmalloc attempt to allocate PMD-sized pages first, before falling b=
ack
>> to small pages. Allocations which use something other than PAGE_KERNEL
>> protections are not permitted to use huge pages yet, not all callers exp=
ect
>> this (e.g., module allocations vs strict module rwx).
>>=20
>> This gives a 6x reduction in dTLB misses for a `git diff` (of linux), fr=
om
>> 45600 to 6500 and a 2.2% reduction in cycles on a 2-node POWER9.
>=20
> I wonder if it's worth extending vmap() to handle higher order pages in
> a similar way? That might be helpful for tracing PMUs such as Arm SPE,
> where the CPU streams tracing data out to a virtually addressed buffer
> (see rb_alloc_aux_page()).

Yeah it becomes pretty trivial to do that with VM_HUGE_PAGES after
this patch, I have something to do it but no callers ready yet, if
you have an easy one we can add it.

>> This can result in more internal fragmentation and memory overhead for a
>> given allocation. It can also cause greater NUMA unbalance on hashdist
>> allocations.
>>=20
>> There may be other callers that expect small pages under vmalloc but use
>> PAGE_KERNEL, I'm not sure if it's feasible to catch them all. An
>> alternative would be a new function or flag which enables large mappings=
,
>> and use that in callers.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  include/linux/vmalloc.h |   2 +
>>  mm/vmalloc.c            | 135 +++++++++++++++++++++++++++++-----------
>>  2 files changed, 102 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
>> index 291313a7e663..853b82eac192 100644
>> --- a/include/linux/vmalloc.h
>> +++ b/include/linux/vmalloc.h
>> @@ -24,6 +24,7 @@ struct notifier_block;		/* in notifier.h */
>>  #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initializ=
ed */
>>  #define VM_NO_GUARD		0x00000040      /* don't add guard page */
>>  #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory =
*/
>> +#define VM_HUGE_PAGES		0x00000100	/* may use huge pages */
>=20
> Please can you add a check for this in the arm64 change_memory_common()
> code? Other architectures might need something similar, but we need to
> forbid changing memory attributes for portions of the huge page.

Yeah good idea, I can look about adding some more checks.

>=20
> In general, I'm a bit wary of software table walkers tripping over this.
> For example, I don't think apply_to_existing_page_range() can handle
> huge mappings at all, but the one user (KASAN) only ever uses page mappin=
gs
> so it's ok there.

Right, I have something to warn for apply to page range (and looking
at adding support for bigger pages). It doesn't even have a test and
warn at the moment which isn't good practice IMO so we should add one
even without huge vmap.

>=20
>> @@ -2325,9 +2356,11 @@ static struct vm_struct *__get_vm_area_node(unsig=
ned long size,
>>  	if (unlikely(!size))
>>  		return NULL;
>> =20
>> -	if (flags & VM_IOREMAP)
>> -		align =3D 1ul << clamp_t(int, get_count_order_long(size),
>> -				       PAGE_SHIFT, IOREMAP_MAX_ORDER);
>> +	if (flags & VM_IOREMAP) {
>> +		align =3D max(align,
>> +			    1ul << clamp_t(int, get_count_order_long(size),
>> +					   PAGE_SHIFT, IOREMAP_MAX_ORDER));
>> +	}
>=20
>=20
> I don't follow this part. Please could you explain why you're potentially
> aligning above IOREMAP_MAX_ORDER? It doesn't seem to follow from the rest
> of the patch.

Trying to remember. If the caller asks for a particular alignment we=20
shouldn't reduce it. Should put it in another patch.

Thanks,
Nick
