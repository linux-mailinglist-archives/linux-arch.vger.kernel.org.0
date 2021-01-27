Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABC23051B0
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 06:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhA0FFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 00:05:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11609 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhA0D2T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 22:28:19 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQRqt0YPLz1607h;
        Wed, 27 Jan 2021 10:09:30 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 10:10:34 +0800
Subject: Re: [PATCH v11 03/13] mm/vmalloc: rename vmap_*_range
 vmap_pages_*_range
To:     Nicholas Piggin <npiggin@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@lst.de>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210126044510.2491820-1-npiggin@gmail.com>
 <20210126044510.2491820-4-npiggin@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <01fe6df9-8c92-72c9-94cb-797e11160ad7@huawei.com>
Date:   Wed, 27 Jan 2021 10:10:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126044510.2491820-4-npiggin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi:
On 2021/1/26 12:45, Nicholas Piggin wrote:
> The vmalloc mapper operates on a struct page * array rather than a
> linear physical address, re-name it to make this distinction clear.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  mm/vmalloc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 62372f9e0167..7f2f36116980 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -189,7 +189,7 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
>  		arch_sync_kernel_mappings(start, end);
>  }
>  
> -static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
> +static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
>  		pgtbl_mod_mask *mask)
>  {
> @@ -217,7 +217,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
>  	return 0;
>  }
>  
> -static int vmap_pmd_range(pud_t *pud, unsigned long addr,
> +static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
>  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
>  		pgtbl_mod_mask *mask)
>  {
> @@ -229,13 +229,13 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
>  		return -ENOMEM;
>  	do {
>  		next = pmd_addr_end(addr, end);
> -		if (vmap_pte_range(pmd, addr, next, prot, pages, nr, mask))
> +		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
>  			return -ENOMEM;
>  	} while (pmd++, addr = next, addr != end);
>  	return 0;
>  }
>  
> -static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
> +static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
>  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
>  		pgtbl_mod_mask *mask)
>  {
> @@ -247,13 +247,13 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
>  		return -ENOMEM;
>  	do {
>  		next = pud_addr_end(addr, end);
> -		if (vmap_pmd_range(pud, addr, next, prot, pages, nr, mask))
> +		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
>  			return -ENOMEM;
>  	} while (pud++, addr = next, addr != end);
>  	return 0;
>  }
>  
> -static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
> +static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
>  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
>  		pgtbl_mod_mask *mask)
>  {
> @@ -265,7 +265,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
>  		return -ENOMEM;
>  	do {
>  		next = p4d_addr_end(addr, end);
> -		if (vmap_pud_range(p4d, addr, next, prot, pages, nr, mask))
> +		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
>  			return -ENOMEM;
>  	} while (p4d++, addr = next, addr != end);
>  	return 0;
> @@ -306,7 +306,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_bad(*pgd))
>  			mask |= PGTBL_PGD_MODIFIED;
> -		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
> +		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
>  		if (err)
>  			return err;
>  	} while (pgd++, addr = next, addr != end);
> 

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
