Return-Path: <linux-arch+bounces-9623-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A769A04219
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 15:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CC97A06BD
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9A1E9B00;
	Tue,  7 Jan 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XZA2f+w+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6491EE03B;
	Tue,  7 Jan 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259718; cv=none; b=HmR4grh6b6e8QZpxggL1IiIcmSXsb9q92uFk7TVWYkiCpsmqFOmFhPKJiQ0y7cPEFTKtr+jPtNebyIt5toSwsnFCE9msiChSoW6WGwV2KwQsP+p5Vw+7EBjbsP7wEWpRj5TOPoS8coF9Yd4yL+lWkrOc9HZMofaBDweTBozPxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259718; c=relaxed/simple;
	bh=XbIEoJ1ylQIsr8aUM5aotWzq/cv/udcop0c+xL9yzDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPZQktIGdhpQ+zXC4Zi6KqQg0+YQ08vXUDfIREpZRhm0qW740xsL4XiTfLngDO+GLJUTLPa7n2R4LC9kBJwoYbDTNQs71qMPueFFz5gVoUw4XsCCL6RpMuZ0OBPi+fg56/S5PHzdpgc61MgLL9nmtRaVVKGiSW8weHpU2WKATwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XZA2f+w+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50785lmS018139;
	Tue, 7 Jan 2025 14:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PZcAQo2jVZKhpUA/J5KNxIBIcwI9ru
	7trJmhob0Z6oo=; b=XZA2f+w+ZgaVD9bbZcCmyCGgsXz2felIn2ZCDI9+FmzGTH
	Eainpr7pfGKSTDzrmX3jhKmLGQgNrMONcuqUzI5XahM+03uE0ABbIfzQrAkkXRdQ
	zQyY3LcpYQtizGCGoFg+C1o070Epat0Ertl+Oj+j5GZbCQJpo6fBpvqaNlv0Uj4h
	jCp+oWr7fNZcGMEOuZ4JkwAxZo52l1qIWDUqKRwUfHiXmblJLI3ae2nNo1pFrfBS
	DcDWcjtyioeUbc3EdHzCB9GFsZ3E41si5WIYxTtQP1Lqc0+5shC0eyKIw8ZyhlDs
	ilv7kx5646E7KIqpUVnFvTxFL5QXObvV+xfaYIjg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f39jr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:20:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507EKsge024914;
	Tue, 7 Jan 2025 14:20:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f39jr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:20:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507DRZPg013571;
	Tue, 7 Jan 2025 14:20:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygantsep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:20:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507EKpgt21889308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 14:20:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59FEC2004B;
	Tue,  7 Jan 2025 14:20:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92F3320043;
	Tue,  7 Jan 2025 14:20:50 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Jan 2025 14:20:50 +0000 (GMT)
Date: Tue, 7 Jan 2025 15:20:49 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
        tglx@linutronix.de, david@redhat.com, jannh@google.com,
        hughd@google.com, yuzhao@google.com, willy@infradead.org,
        muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
        akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
        arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org,
        npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org,
        ryan.roberts@arm.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v4 13/15] mm: pgtable: introduce generic
 __tlb_remove_table()
Message-ID: <Z304QRzGgg/0HI6L@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <f7febc7719fd84673a8eae8af71b7b4278d3e110.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7febc7719fd84673a8eae8af71b7b4278d3e110.1735549103.git.zhengqi.arch@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pJGOWrM73oMm5Nze_uVYydJm8haany2l
X-Proofpoint-ORIG-GUID: yqOSxHIumtcfGGAun6YrBrVvCrkUAfiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=797
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070118

On Mon, Dec 30, 2024 at 05:07:48PM +0800, Qi Zheng wrote:
> Several architectures (arm, arm64, riscv and x86) define exactly the
> same __tlb_remove_table(), just introduce generic __tlb_remove_table() to
> eliminate these duplications.
> 
> The s390 __tlb_remove_table() is nearly the same, so also make s390
> __tlb_remove_table() version generic.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/arm/include/asm/tlb.h      |  9 ---------
>  arch/arm64/include/asm/tlb.h    |  7 -------
>  arch/powerpc/include/asm/tlb.h  |  1 +
>  arch/riscv/include/asm/tlb.h    | 12 ------------
>  arch/s390/include/asm/tlb.h     |  9 ++++-----
>  arch/s390/mm/pgalloc.c          |  7 -------
>  arch/sparc/include/asm/tlb_32.h |  1 +
>  arch/sparc/include/asm/tlb_64.h |  1 +
>  arch/x86/include/asm/tlb.h      | 17 -----------------
>  include/asm-generic/tlb.h       | 15 +++++++++++++--
>  10 files changed, 20 insertions(+), 59 deletions(-)
...
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index 79df7c0932c56..da4a7d175f69c 100644
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -22,7 +22,6 @@
>   * Pages used for the page tables is a different story. FIXME: more
>   */
>  
> -void __tlb_remove_table(void *_table);
>  static inline void tlb_flush(struct mmu_gather *tlb);
>  static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>  		struct page *page, bool delay_rmap, int page_size);
> @@ -87,7 +86,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>  	tlb->cleared_pmds = 1;
>  	if (mm_alloc_pgste(tlb->mm))
>  		gmap_unlink(tlb->mm, (unsigned long *)pte, address);
> -	tlb_remove_ptdesc(tlb, pte);
> +	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pte));
>  }
>  
>  /*
> @@ -106,7 +105,7 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>  	tlb->mm->context.flush_mm = 1;
>  	tlb->freed_tables = 1;
>  	tlb->cleared_puds = 1;
> -	tlb_remove_ptdesc(tlb, pmd);
> +	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
>  }
>  
>  /*
> @@ -124,7 +123,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>  	tlb->mm->context.flush_mm = 1;
>  	tlb->freed_tables = 1;
>  	tlb->cleared_p4ds = 1;
> -	tlb_remove_ptdesc(tlb, pud);
> +	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
>  }
>  
>  /*
> @@ -142,7 +141,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>  	__tlb_adjust_range(tlb, address, PAGE_SIZE);
>  	tlb->mm->context.flush_mm = 1;
>  	tlb->freed_tables = 1;
> -	tlb_remove_ptdesc(tlb, p4d);
> +	tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
>  }
>  
>  #endif /* _S390_TLB_H */
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index c73b89811a264..3e002dea6278f 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -193,13 +193,6 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>  	pagetable_dtor_free(ptdesc);
>  }
>  
> -void __tlb_remove_table(void *table)
> -{
> -	struct ptdesc *ptdesc = virt_to_ptdesc(table);
> -
> -	pagetable_dtor_free(ptdesc);
> -}
> -
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static void pte_free_now(struct rcu_head *head)
>  {
...
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 709830274b756..69de47c7ef3c5 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -153,8 +153,9 @@
>   *
>   *  Useful if your architecture has non-page page directories.
>   *
> - *  When used, an architecture is expected to provide __tlb_remove_table()
> - *  which does the actual freeing of these pages.
> + *  When used, an architecture is expected to provide __tlb_remove_table() or
> + *  use the generic __tlb_remove_table(), which does the actual freeing of these
> + *  pages.
>   *
>   *  MMU_GATHER_RCU_TABLE_FREE
>   *
> @@ -207,6 +208,16 @@ struct mmu_table_batch {
>  #define MAX_TABLE_BATCH		\
>  	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
>  
> +#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
> +static inline void __tlb_remove_table(void *table)
> +{
> +	struct ptdesc *ptdesc = (struct ptdesc *)table;
> +
> +	pagetable_dtor(ptdesc);
> +	pagetable_free(ptdesc);
> +}
> +#endif
> +
>  extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>  
>  #else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */

For s390:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

