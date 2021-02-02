Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753E330BBFD
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 11:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBBKXX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 05:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBBKXW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 05:23:22 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286EEC061573;
        Tue,  2 Feb 2021 02:22:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e9so2083405pjj.0;
        Tue, 02 Feb 2021 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=feNMs9NZIZZBFRuPZuPQAraD1ls2HBTzJnPTDra1dJo=;
        b=Hsn610B9baMjUo1dtjNGVVl0OMIYTZTIqhnRX3zMn7zT8usqwHFf51r2OfflOoiC0c
         19XwAcKChgc/bO3PHxkM0Sszy87AP165fkRjy9N9U5+kYTBBFGNrGeeMkAHUGleudAgh
         54LrQGzm/wtP2C3shypmgkoFHl1Peul+jfBAvSV9vdz+0Ah0FzSZ9hGANzqMRm4IDNhC
         Y7lLxrRQxpvh1/LVTxLwGEhvGLkM1b/wWBUPLvVlX8QBHq2pAhmDzzDPLIphrrd6Bljg
         aGFaAJHE9uUfySvC5HASZYUAGc4IyII5YQS6M975rZTgLCb/ciN2JNJi3IlkvM8ZJeVN
         A/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=feNMs9NZIZZBFRuPZuPQAraD1ls2HBTzJnPTDra1dJo=;
        b=QwwS/BmUvbj10aDzr4f9C+P1HsHkSuGgHUK1EhZZhG1IQJZPjtxPm9+NeeCjyrdyUa
         J6dAuZLlOawcKD6JRcdH1pM96JkQC3HNUA2QBwjbVAbHN4eF/ahOs0TT7cggV4043gn/
         9oXaR6JIJFQ0MjG0RTeEskVUdTzNhaj43fQ8YqAB89Ndl68EjEzhp5s3yDurcdOBBg+s
         JPRhkwvnxf0c+oEAGal9/A8BGYy9hJbV5eD70+qmwvneFu2Moo4j25Upf1Mgh2+8ozcZ
         ONJ3Ilawn3SBXAvxMR4Ah+2183AJ8EjOz8EVsUkr3NzjFlbpMEoATFE1/8wGYe9lA8n3
         Vh0A==
X-Gm-Message-State: AOAM533/w+Z91gKsqPI5tOgmySmkpNJfbN63+PZkKdc1ay6BZ3CPaqbr
        bawXfads9nP4jU8FMRzWSb8=
X-Google-Smtp-Source: ABdhPJwAydycRDrEu05vCkvnwXNns+f1xdrkCkAXHMftwOd5L2+xxwr6QxnPETGvBPuRovul4hnQfw==
X-Received: by 2002:a17:90a:aa85:: with SMTP id l5mr3754761pjq.230.1612261361659;
        Tue, 02 Feb 2021 02:22:41 -0800 (PST)
Received: from localhost (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id o10sm21105273pfp.87.2021.02.02.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 02:22:40 -0800 (PST)
Date:   Tue, 02 Feb 2021 20:22:35 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v11 01/13] mm/vmalloc: fix HUGE_VMAP regression by
 enabling huge pages in vmalloc_to_page
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ding Tianhong <dingtianhong@huawei.com>, linux-mm@kvack.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210126044510.2491820-1-npiggin@gmail.com>
        <20210126044510.2491820-2-npiggin@gmail.com>
        <2dcbe2c9-c968-4895-fc43-c40dfe9f06d3@huawei.com>
In-Reply-To: <2dcbe2c9-c968-4895-fc43-c40dfe9f06d3@huawei.com>
MIME-Version: 1.0
Message-Id: <1612261080.2gjaa5ecdf.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Ding Tianhong's message of January 28, 2021 1:13 pm:
> On 2021/1/26 12:44, Nicholas Piggin wrote:
>> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
>> Whether or not a vmap is huge depends on the architecture details,
>> alignments, boot options, etc., which the caller can not be expected
>> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.
>>=20
>> This change teaches vmalloc_to_page about larger pages, and returns
>> the struct page that corresponds to the offset within the large page.
>> This makes the API agnostic to mapping implementation details.
>>=20
>> [*] As explained by commit 029c54b095995 ("mm/vmalloc.c: huge-vmap:
>>     fail gracefully on unexpected huge vmap mappings")
>>=20
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  mm/vmalloc.c | 41 ++++++++++++++++++++++++++---------------
>>  1 file changed, 26 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index e6f352bf0498..62372f9e0167 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -34,7 +34,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/rbtree_augmented.h>
>>  #include <linux/overflow.h>
>> -
>> +#include <linux/pgtable.h>
>>  #include <linux/uaccess.h>
>>  #include <asm/tlbflush.h>
>>  #include <asm/shmparam.h>
>> @@ -343,7 +343,9 @@ int is_vmalloc_or_module_addr(const void *x)
>>  }
>> =20
>>  /*
>> - * Walk a vmap address to the struct page it maps.
>> + * Walk a vmap address to the struct page it maps. Huge vmap mappings w=
ill
>> + * return the tail page that corresponds to the base page address, whic=
h
>> + * matches small vmap mappings.
>>   */
>>  struct page *vmalloc_to_page(const void *vmalloc_addr)
>>  {
>> @@ -363,25 +365,33 @@ struct page *vmalloc_to_page(const void *vmalloc_a=
ddr)
>> =20
>>  	if (pgd_none(*pgd))
>>  		return NULL;
>> +	if (WARN_ON_ONCE(pgd_leaf(*pgd)))
>> +		return NULL; /* XXX: no allowance for huge pgd */
>> +	if (WARN_ON_ONCE(pgd_bad(*pgd)))
>> +		return NULL;
>> +
>>  	p4d =3D p4d_offset(pgd, addr);
>>  	if (p4d_none(*p4d))
>>  		return NULL;
>> -	pud =3D pud_offset(p4d, addr);
>> +	if (p4d_leaf(*p4d))
>> +		return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
>> +	if (WARN_ON_ONCE(p4d_bad(*p4d)))
>> +		return NULL;
>> =20
>> -	/*
>> -	 * Don't dereference bad PUD or PMD (below) entries. This will also
>> -	 * identify huge mappings, which we may encounter on architectures
>> -	 * that define CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy. Such regions will be
>> -	 * identified as vmalloc addresses by is_vmalloc_addr(), but are
>> -	 * not [unambiguously] associated with a struct page, so there is
>> -	 * no correct value to return for them.
>> -	 */
>> -	WARN_ON_ONCE(pud_bad(*pud));
>> -	if (pud_none(*pud) || pud_bad(*pud))
>> +	pud =3D pud_offset(p4d, addr);
>> +	if (pud_none(*pud))
>> +		return NULL;
>> +	if (pud_leaf(*pud))
>> +		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>=20
> Hi Nicho:
>=20
> /builds/1mzfdQzleCy69KZFb5qHNSEgabZ/mm/vmalloc.c: In function 'vmalloc_to=
_page':
> /builds/1mzfdQzleCy69KZFb5qHNSEgabZ/include/asm-generic/pgtable-nop4d-hac=
k.h:48:27: error: implicit declaration of function 'pud_page'; did you mean=
 'put_page'? [-Werror=3Dimplicit-function-declaration]
>    48 | #define pgd_page(pgd)    (pud_page((pud_t){ pgd }))
>       |                           ^~~~~~~~
>=20
> the pug_page is not defined for aarch32 when enabling 2-level page config=
, it break the system building.

Hey thanks for finding that, not sure why that didn't trigger any CI.

Anyway newer kernels don't have the ptable-*-hack.h headers, but even so=20
it still breaks upstream. arm is using some hand-rolled 2-level folding
of its own (which is fair enough because most 32-bit archs were 2 level
at the time I added pgtable-nopud.h header).

This patch seems to at least make it build.

Thanks,
Nick

---
 arch/arm/include/asm/pgtable-3level.h | 2 --
 arch/arm/include/asm/pgtable.h        | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/p=
gtable-3level.h
index 2b85d175e999..d4edab51a77c 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -186,8 +186,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
=20
 #define pmd_write(pmd)		(pmd_isclear((pmd), L_PMD_SECT_RDONLY))
 #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
-#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
-#define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
=20
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.=
h
index c02f24400369..d63a5bb6bd0c 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -166,6 +166,9 @@ extern struct page *empty_zero_page;
=20
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
=20
+#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
+#define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
=20
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
--=20
2.23.0

