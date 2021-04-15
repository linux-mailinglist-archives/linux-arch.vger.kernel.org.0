Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4471C36159D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhDOWoI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbhDOWoH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Apr 2021 18:44:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E599C061756
        for <linux-arch@vger.kernel.org>; Thu, 15 Apr 2021 15:43:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 20so8968268pll.7
        for <linux-arch@vger.kernel.org>; Thu, 15 Apr 2021 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JY3LY8etXyosEeu5nfWlhvzebGDT/edrkrlKplV2R0Q=;
        b=LGwG/jXjcqstX7vCLunH2tlSTh6FEg3VqmVYhhwaWMbz1gRpN9Dc+pKMBttZG4F2eH
         +nk8aBQ2fPJnJhVZ2Nv5ytsKTlagBaosP37szFwCRj8Ib0f+ZQBXZ6lPne4jFGq86Bs7
         Yl/AWNZNO+DwuQ/A/1FVG7uXMXFQ0Bg71mqpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JY3LY8etXyosEeu5nfWlhvzebGDT/edrkrlKplV2R0Q=;
        b=YUY2r/ywmav2Cz07YZ+fooE1OClvkc9IaGrV2Pl5NChcKGvnmA+hltGV649x6rmUyk
         ZqpneuQYSiC/1BuwY+x6HlkxHDQWUDNeQOoC6ehJI6y1R7TNby4eiWkZMqxvlUN23dhS
         c/oWV2J0HhnTdLka3/4u0ejYhfuzYHjyg8I7vYsWTmSV3MKiFS2DoveNpKtFMAACbjfG
         SQGF6Jh6gvZfJiar7rZFUJFjAWeqo3Fz/LWDhowBzfwtuZ9UN0k6Q0jJyoPN7d93nSUV
         dCjxN5DujSj18p2cMyP3/AmcljQrKR4p0pl/K4tg1mVLNDLZd2lN0HNt0r5VcjeXgyap
         nbjg==
X-Gm-Message-State: AOAM532DlRcwqXG/MxoximkbYTP7+EBZj+TPwBC3XY2EohjDOlKQKXx8
        Ri1Y7Ha6HSsTQMlh4K7v84/5QxOaotj1wQ==
X-Google-Smtp-Source: ABdhPJyqfJG8J3NRw4PtXWUZy53AS96UfvtUYllUApPaRqPEmjx1X+9e6E5OLIVUTnR/j6EwfW2Icg==
X-Received: by 2002:a17:90a:17a3:: with SMTP id q32mr6358434pja.224.1618526621918;
        Thu, 15 Apr 2021 15:43:41 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-3f8b-a64e-9a27-b872.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:3f8b:a64e:9a27:b872])
        by smtp.gmail.com with ESMTPSA id h22sm2980650pfn.55.2021.04.15.15.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 15:43:41 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/5] mm: pagewalk: Fix walk for hugepage tables
In-Reply-To: <733408f48b1ed191f53518123ee6fc6d42287cc6.1618506910.git.christophe.leroy@csgroup.eu>
References: <cover.1618506910.git.christophe.leroy@csgroup.eu> <733408f48b1ed191f53518123ee6fc6d42287cc6.1618506910.git.christophe.leroy@csgroup.eu>
Date:   Fri, 16 Apr 2021 08:43:38 +1000
Message-ID: <877dl3184l.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe,

> Pagewalk ignores hugepd entries and walk down the tables
> as if it was traditionnal entries, leading to crazy result.
>
> Add walk_hugepd_range() and use it to walk hugepage tables.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  mm/pagewalk.c | 54 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index e81640d9f177..410a9d8f7572 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -58,6 +58,32 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	return err;
>  }
>  
> +static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
> +			     unsigned long end, struct mm_walk *walk, int pdshift)
> +{
> +	int err = 0;
> +#ifdef CONFIG_ARCH_HAS_HUGEPD
> +	const struct mm_walk_ops *ops = walk->ops;
> +	int shift = hugepd_shift(*phpd);
> +	int page_size = 1 << shift;
> +
> +	if (addr & (page_size - 1))
> +		return 0;
> +
> +	for (;;) {
> +		pte_t *pte = hugepte_offset(*phpd, addr, pdshift);
> +
> +		err = ops->pte_entry(pte, addr, addr + page_size, walk);
> +		if (err)
> +			break;
> +		if (addr >= end - page_size)
> +			break;
> +		addr += page_size;
> +	}

Initially I thought this was a somewhat unintuitive way to structure
this loop, but I see it parallels the structure of walk_pte_range_inner,
so I think the consistency is worth it.

I notice the pte walking code potentially takes some locks: does this
code need to do that?

arch/powerpc/mm/hugetlbpage.c says that hugepds are protected by the
mm->page_table_lock, but I don't think we're taking it in this code.

> +#endif
> +	return err;
> +}
> +
>  static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  			  struct mm_walk *walk)
>  {
> @@ -108,7 +134,10 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  				goto again;
>  		}
>  
> -		err = walk_pte_range(pmd, addr, next, walk);
> +		if (is_hugepd(__hugepd(pmd_val(*pmd))))
> +			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
> +		else
> +			err = walk_pte_range(pmd, addr, next, walk);
>  		if (err)
>  			break;
>  	} while (pmd++, addr = next, addr != end);
> @@ -157,7 +186,10 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  		if (pud_none(*pud))
>  			goto again;
>  
> -		err = walk_pmd_range(pud, addr, next, walk);
> +		if (is_hugepd(__hugepd(pud_val(*pud))))
> +			err = walk_hugepd_range((hugepd_t *)pud, addr, next, walk, PUD_SHIFT);
> +		else
> +			err = walk_pmd_range(pud, addr, next, walk);

I'm a bit worried you might end up calling into walk_hugepd_range with
ops->pte_entry == NULL, and then jumping to 0.

static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
			  struct mm_walk *walk)
{
...
        pud = pud_offset(p4d, addr);
	do {
                ...
                if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
		    walk->action == ACTION_CONTINUE ||
		    !(ops->pmd_entry || ops->pte_entry)) <<< THIS CHECK
			continue;
                ...
		if (is_hugepd(__hugepd(pud_val(*pud))))
			err = walk_hugepd_range((hugepd_t *)pud, addr, next, walk, PUD_SHIFT);
		else
			err = walk_pmd_range(pud, addr, next, walk);
		if (err)
			break;
	} while (pud++, addr = next, addr != end);

walk_pud_range will proceed if there is _either_ an ops->pmd_entry _or_
an ops->pte_entry, but walk_hugepd_range will call ops->pte_entry
unconditionally.

The same issue applies to walk_{p4d,pgd}_range...

Kind regards,
Daniel
