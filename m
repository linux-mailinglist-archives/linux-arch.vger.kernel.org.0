Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86BF1F3EE2
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgFIPI5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 11:08:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728082AbgFIPI5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 11:08:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059F3iXK050778;
        Tue, 9 Jun 2020 11:07:59 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31hrq84dk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 11:07:58 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059F55G4029091;
        Tue, 9 Jun 2020 15:07:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 31g2s7x5x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 15:07:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059F7sNU42729578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 15:07:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCF0242042;
        Tue,  9 Jun 2020 15:07:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23B7342041;
        Tue,  9 Jun 2020 15:07:53 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.223])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Jun 2020 15:07:53 +0000 (GMT)
Date:   Tue, 9 Jun 2020 18:07:51 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org,
        jroedel@suse.de, Andy Lutomirski <luto@kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, hch@lst.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Move p?d_alloc_track to separate header file
Message-ID: <20200609150751.GF1149842@linux.ibm.com>
References: <20200609120533.25867-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609120533.25867-1-joro@8bytes.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_09:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 suspectscore=1 clxscore=1011 priorityscore=1501
 malwarescore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090111
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 09, 2020 at 02:05:33PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The functions are only used in two source files, so there is no need
> for them to be in the global <linux/mm.h> header. Move them to the new
> <linux/pgalloc-track.h> header and include it only where needed.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/mm.h            | 45 -------------------------------
>  include/linux/pgalloc-track.h | 51 +++++++++++++++++++++++++++++++++++
>  lib/ioremap.c                 |  1 +
>  mm/vmalloc.c                  |  1 +
>  4 files changed, 53 insertions(+), 45 deletions(-)
>  create mode 100644 include/linux/pgalloc-track.h
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9d6042178ca7..22d8b2a2c9bc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2092,51 +2092,11 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
>  		NULL : pud_offset(p4d, address);
>  }
>  
> -static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
> -				     unsigned long address,
> -				     pgtbl_mod_mask *mod_mask)
> -
> -{
> -	if (unlikely(pgd_none(*pgd))) {
> -		if (__p4d_alloc(mm, pgd, address))
> -			return NULL;
> -		*mod_mask |= PGTBL_PGD_MODIFIED;
> -	}
> -
> -	return p4d_offset(pgd, address);
> -}
> -
> -static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
> -				     unsigned long address,
> -				     pgtbl_mod_mask *mod_mask)
> -{
> -	if (unlikely(p4d_none(*p4d))) {
> -		if (__pud_alloc(mm, p4d, address))
> -			return NULL;
> -		*mod_mask |= PGTBL_P4D_MODIFIED;
> -	}
> -
> -	return pud_offset(p4d, address);
> -}
> -
>  static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
>  {
>  	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
>  		NULL: pmd_offset(pud, address);
>  }
> -
> -static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
> -				     unsigned long address,
> -				     pgtbl_mod_mask *mod_mask)
> -{
> -	if (unlikely(pud_none(*pud))) {
> -		if (__pmd_alloc(mm, pud, address))
> -			return NULL;
> -		*mod_mask |= PGTBL_PUD_MODIFIED;
> -	}
> -
> -	return pmd_offset(pud, address);
> -}
>  #endif /* CONFIG_MMU */
>  
>  #if USE_SPLIT_PTE_PTLOCKS
> @@ -2252,11 +2212,6 @@ static inline void pgtable_pte_page_dtor(struct page *page)
>  	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
>  		NULL: pte_offset_kernel(pmd, address))
>  
> -#define pte_alloc_kernel_track(pmd, address, mask)			\
> -	((unlikely(pmd_none(*(pmd))) &&					\
> -	  (__pte_alloc_kernel(pmd) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
> -		NULL: pte_offset_kernel(pmd, address))
> -
>  #if USE_SPLIT_PMD_PTLOCKS
>  
>  static struct page *pmd_to_page(pmd_t *pmd)
> diff --git a/include/linux/pgalloc-track.h b/include/linux/pgalloc-track.h
> new file mode 100644
> index 000000000000..1dcc865029a2
> --- /dev/null
> +++ b/include/linux/pgalloc-track.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGALLLC_TRACK_H
> +#define _LINUX_PGALLLC_TRACK_H
> +
> +#if defined(CONFIG_MMU)
> +static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
> +				     unsigned long address,
> +				     pgtbl_mod_mask *mod_mask)
> +{
> +	if (unlikely(pgd_none(*pgd))) {
> +		if (__p4d_alloc(mm, pgd, address))
> +			return NULL;
> +		*mod_mask |= PGTBL_PGD_MODIFIED;
> +	}
> +
> +	return p4d_offset(pgd, address);
> +}
> +
> +static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
> +				     unsigned long address,
> +				     pgtbl_mod_mask *mod_mask)
> +{
> +	if (unlikely(p4d_none(*p4d))) {
> +		if (__pud_alloc(mm, p4d, address))
> +			return NULL;
> +		*mod_mask |= PGTBL_P4D_MODIFIED;
> +	}
> +
> +	return pud_offset(p4d, address);
> +}
> +
> +static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
> +				     unsigned long address,
> +				     pgtbl_mod_mask *mod_mask)
> +{
> +	if (unlikely(pud_none(*pud))) {
> +		if (__pmd_alloc(mm, pud, address))
> +			return NULL;
> +		*mod_mask |= PGTBL_PUD_MODIFIED;
> +	}
> +
> +	return pmd_offset(pud, address);
> +}
> +#endif /* CONFIG_MMU */
> +
> +#define pte_alloc_kernel_track(pmd, address, mask)			\
> +	((unlikely(pmd_none(*(pmd))) &&					\
> +	  (__pte_alloc_kernel(pmd) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
> +		NULL: pte_offset_kernel(pmd, address))
> +
> +#endif /* _LINUX_PGALLLC_TRACK_H */
> diff --git a/lib/ioremap.c b/lib/ioremap.c
> index ad485f08173b..608fcccd21c8 100644
> --- a/lib/ioremap.c
> +++ b/lib/ioremap.c
> @@ -11,6 +11,7 @@
>  #include <linux/sched.h>
>  #include <linux/io.h>
>  #include <linux/export.h>
> +#include <linux/pgalloc-track.h>
>  #include <asm/cacheflush.h>
>  #include <asm/pgtable.h>
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3091c2ca60df..edc43f003165 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -35,6 +35,7 @@
>  #include <linux/bitops.h>
>  #include <linux/rbtree_augmented.h>
>  #include <linux/overflow.h>
> +#include <linux/pgalloc-track.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/tlbflush.h>
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
