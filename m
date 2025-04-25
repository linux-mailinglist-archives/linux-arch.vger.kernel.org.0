Return-Path: <linux-arch+bounces-11580-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BEDA9CE4C
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 18:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F74E1C94
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9A1ADFE4;
	Fri, 25 Apr 2025 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I6iMPIIM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA019A2A3;
	Fri, 25 Apr 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599003; cv=none; b=cS5TwulQu84rBgDZOHZTchZORbmgywYmUSmeKlWsl5Cxk1UqBCAJuaYoDjHHUei4VxAKuGQo/wwo+mRvLuPo8S5MIDAnU4OTAocXyIo8VhMFXkRBgzOguh1LREIxO/N8GxshrNceyD2avC0aRDIrFfCxOWT+ZQ+DjpTrO5Ng2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599003; c=relaxed/simple;
	bh=eDuPpVQfrrEHxYXwOVOoK73qECeDiWq8T7hCKEyeku0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9iZYDVAvDU4AFzNA9VZ6Rono2d6yDOcQmtP/+S1G2lG8lOD6YEcQytE/yUvrs0PQzAD3zm9BQ2NImszjjq/2OH2NKBKp2IzfiIC6jbeK2cCRnhue8cDrXMJd8G07JDNaISa1aN7u31FtIpes2x4jKwyUHrhAUpC+aGu1mEZMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I6iMPIIM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAftkV024809;
	Fri, 25 Apr 2025 16:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UoSIWEZjnJvFHHJcidBd9gWqF1dgFi
	YXT2UqixJzyRw=; b=I6iMPIIMKAA98kW3WEbpflVNtKf9Vf/3RXc49Xlyb+oaEO
	DkFcwBa5NOK/Ijyze6TsMdgIA0BN/40a01sWV1hsCHNsSDOa2h5dvitFEfqfUy+6
	xnSPfd68+Yf4rEik84JilejXUuMTVBn27suA16fX+VK3Qvb7ZxVo9PrcJiFCcATe
	3j0R3EI/NZmCPfZbtJ+hdnnBSKxFw9cBbHuloJ8GR+C/wlKAFKUmgNarRhmrk/aJ
	b4DdMyARsXJ8YAojaXQutX0wjRRap+GcrAu8FQt9LLj9NxNWLYifHEJbT3VHgAWR
	BuiJxB4OSQ9f8fl8twYhwpLsrXMUxnr7vU4Akqiw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688ushnap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 16:34:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PG9Iq6005861;
	Fri, 25 Apr 2025 16:34:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxp49b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 16:34:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PGYunP34144900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:34:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 117B320043;
	Fri, 25 Apr 2025 16:34:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 327C120040;
	Fri, 25 Apr 2025 16:34:54 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.73.111])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Apr 2025 16:34:54 +0000 (GMT)
Date: Fri, 25 Apr 2025 18:34:52 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Larsson <andreas@gaisler.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
        Yang Shi <yang@os.amperecomputing.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 01/12] mm: Pass mm down to pagetable_{pte,pmd}_ctor
Message-ID: <aAu5rHSX7w9xjqg9@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250408095222.860601-1-kevin.brodsky@arm.com>
 <20250408095222.860601-2-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408095222.860601-2-kevin.brodsky@arm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=680bb9b3 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=7XQ_oYAFJgMplnqaJ0EA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExNCBTYWx0ZWRfX9h3njuqExHoJ HJja56Lsy6oDF9Y2PLpbY+BFxd+fFSA9eBOYUkRmoMsfaaEczHXT0eDuxVxlAIJlJaXl7Xv4svl xoD9EVVTCUr7G+SiAowO7thlblslz0QJVG0YZJ4LLob9P5jRE+9+FXgAlOa2WKV0mUz/rHhvjYU
 ZaYlhcCij+yfiw3l3u7HqsXe947Sd+mv7GgDjQ/XOdobx+p/ADROGya1SGkL7CQwpRfGrIsJeNQ SsjPFxupcxH7HW2700dNMXsuJM80DaxyYPS558iwl5L2yjVjkxzKDcnXaPT36gp6VICnX1ilHLD 17wtWOO+Bsz/H9E6NGBT7N7S3f5yQk0YK8qoc+FuXC5RN62KwcdDcYpG2DlQuYQ0y/a7g+0+cTX
 hkJE/E/TkWW9RaWs6WdeNkTOse1BsrO1K9sG/M2tJB/eJ4fHemqsaYVdBoroeLJ8IffsQG2U
X-Proofpoint-ORIG-GUID: ySTbmFj0-W242HV95924LVB8DHS4YoGV
X-Proofpoint-GUID: ySTbmFj0-W242HV95924LVB8DHS4YoGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250114

On Tue, Apr 08, 2025 at 10:52:11AM +0100, Kevin Brodsky wrote:
> In preparation for calling constructors for all kernel page tables
> while eliding unnecessary ptlock initialisation, let's pass down the
> associated mm to the PTE/PMD level ctors. (These are the two levels
> where ptlocks are used.)
> 
> In most cases the mm is already around at the point of calling the
> ctor so we simply pass it down. This is however not the case for
> special page table allocators:
> 
> * arch/arm/mm/mmu.c
> * arch/arm64/mm/mmu.c
> * arch/riscv/mm/init.c
> 
> In those cases, the page tables being allocated are either for
> standard kernel memory (init_mm) or special page directories, which
> may not be associated to any mm. For now let's pass NULL as mm; this
> will be refined where possible in future patches.
> 
> No functional change in this patch.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm/mm/mmu.c                        |  2 +-
>  arch/arm64/mm/mmu.c                      |  4 ++--
>  arch/loongarch/include/asm/pgalloc.h     |  2 +-
>  arch/m68k/include/asm/mcf_pgalloc.h      |  2 +-
>  arch/m68k/include/asm/motorola_pgalloc.h | 10 +++++-----
>  arch/m68k/mm/motorola.c                  |  6 +++---
>  arch/mips/include/asm/pgalloc.h          |  2 +-
>  arch/parisc/include/asm/pgalloc.h        |  2 +-
>  arch/powerpc/mm/book3s64/pgtable.c       |  2 +-
>  arch/powerpc/mm/pgtable-frag.c           |  2 +-
>  arch/riscv/mm/init.c                     |  4 ++--
>  arch/s390/include/asm/pgalloc.h          |  2 +-
>  arch/s390/mm/pgalloc.c                   |  2 +-
>  arch/sparc/mm/init_64.c                  |  2 +-
>  arch/sparc/mm/srmmu.c                    |  2 +-
>  arch/x86/mm/pgtable.c                    |  2 +-
>  include/asm-generic/pgalloc.h            |  4 ++--
>  include/linux/mm.h                       |  6 ++++--
>  18 files changed, 30 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index f02f872ea8a9..edb7f56b7c91 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -735,7 +735,7 @@ static void *__init late_alloc(unsigned long sz)
>  	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM,
>  			get_order(sz));
>  
> -	if (!ptdesc || !pagetable_pte_ctor(ptdesc))
> +	if (!ptdesc || !pagetable_pte_ctor(NULL, ptdesc))
>  		BUG();
>  	return ptdesc_to_virt(ptdesc);
>  }
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ea6695d53fb9..8c5c471cfb06 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -494,9 +494,9 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
>  	 * folded, and if so pagetable_pte_ctor() becomes nop.
>  	 */
>  	if (shift == PAGE_SHIFT)
> -		BUG_ON(!pagetable_pte_ctor(ptdesc));
> +		BUG_ON(!pagetable_pte_ctor(NULL, ptdesc));
>  	else if (shift == PMD_SHIFT)
> -		BUG_ON(!pagetable_pmd_ctor(ptdesc));
> +		BUG_ON(!pagetable_pmd_ctor(NULL, ptdesc));
>  
>  	return pa;
>  }
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
> index b58f587f0f0a..1c63a9d9a6d3 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -69,7 +69,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  	if (!ptdesc)
>  		return NULL;
>  
> -	if (!pagetable_pmd_ctor(ptdesc)) {
> +	if (!pagetable_pmd_ctor(mm, ptdesc)) {
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> index 4c648b51e7fd..465a71101b7d 100644
> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -48,7 +48,7 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>  
>  	if (!ptdesc)
>  		return NULL;
> -	if (!pagetable_pte_ctor(ptdesc)) {
> +	if (!pagetable_pte_ctor(mm, ptdesc)) {
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
> index 5abe7da8ac5a..1091fb0affbe 100644
> --- a/arch/m68k/include/asm/motorola_pgalloc.h
> +++ b/arch/m68k/include/asm/motorola_pgalloc.h
> @@ -15,7 +15,7 @@ enum m68k_table_types {
>  };
>  
>  extern void init_pointer_table(void *table, int type);
> -extern void *get_pointer_table(int type);
> +extern void *get_pointer_table(struct mm_struct *mm, int type);
>  extern int free_pointer_table(void *table, int type);
>  
>  /*
> @@ -26,7 +26,7 @@ extern int free_pointer_table(void *table, int type);
>  
>  static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
> -	return get_pointer_table(TABLE_PTE);
> +	return get_pointer_table(mm, TABLE_PTE);
>  }
>  
>  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> @@ -36,7 +36,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  
>  static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>  {
> -	return get_pointer_table(TABLE_PTE);
> +	return get_pointer_table(mm, TABLE_PTE);
>  }
>  
>  static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
> @@ -53,7 +53,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
>  
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
> -	return get_pointer_table(TABLE_PMD);
> +	return get_pointer_table(mm, TABLE_PMD);
>  }
>  
>  static inline int pmd_free(struct mm_struct *mm, pmd_t *pmd)
> @@ -75,7 +75,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  
>  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> -	return get_pointer_table(TABLE_PGD);
> +	return get_pointer_table(mm, TABLE_PGD);
>  }
>  
>  
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index 73651e093c4d..6ab3ef39ba7a 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -139,7 +139,7 @@ void __init init_pointer_table(void *table, int type)
>  	return;
>  }
>  
> -void *get_pointer_table(int type)
> +void *get_pointer_table(struct mm_struct *mm, int type)
>  {
>  	ptable_desc *dp = ptable_list[type].next;
>  	unsigned int mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
> @@ -164,10 +164,10 @@ void *get_pointer_table(int type)
>  			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
>  			 * SMP.
>  			 */
> -			pagetable_pte_ctor(virt_to_ptdesc(page));
> +			pagetable_pte_ctor(mm, virt_to_ptdesc(page));
>  			break;
>  		case TABLE_PMD:
> -			pagetable_pmd_ctor(virt_to_ptdesc(page));
> +			pagetable_pmd_ctor(mm, virt_to_ptdesc(page));
>  			break;
>  		case TABLE_PGD:
>  			pagetable_pgd_ctor(virt_to_ptdesc(page));
> diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
> index bbca420c96d3..942af87f1cdd 100644
> --- a/arch/mips/include/asm/pgalloc.h
> +++ b/arch/mips/include/asm/pgalloc.h
> @@ -62,7 +62,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  	if (!ptdesc)
>  		return NULL;
>  
> -	if (!pagetable_pmd_ctor(ptdesc)) {
> +	if (!pagetable_pmd_ctor(mm, ptdesc)) {
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
> index 2ca74a56415c..3b84ee93edaa 100644
> --- a/arch/parisc/include/asm/pgalloc.h
> +++ b/arch/parisc/include/asm/pgalloc.h
> @@ -39,7 +39,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  	ptdesc = pagetable_alloc(gfp, PMD_TABLE_ORDER);
>  	if (!ptdesc)
>  		return NULL;
> -	if (!pagetable_pmd_ctor(ptdesc)) {
> +	if (!pagetable_pmd_ctor(mm, ptdesc)) {
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 8f7d41ce2ca1..a282233c8785 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -422,7 +422,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
>  	ptdesc = pagetable_alloc(gfp, 0);
>  	if (!ptdesc)
>  		return NULL;
> -	if (!pagetable_pmd_ctor(ptdesc)) {
> +	if (!pagetable_pmd_ctor(mm, ptdesc)) {
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> index 713268ccb1a0..387e9b1fe12c 100644
> --- a/arch/powerpc/mm/pgtable-frag.c
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -61,7 +61,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
>  		ptdesc = pagetable_alloc(PGALLOC_GFP | __GFP_ACCOUNT, 0);
>  		if (!ptdesc)
>  			return NULL;
> -		if (!pagetable_pte_ctor(ptdesc)) {
> +		if (!pagetable_pte_ctor(mm, ptdesc)) {
>  			pagetable_free(ptdesc);
>  			return NULL;
>  		}
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index ab475ec6ca42..e5ef693fc778 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -442,7 +442,7 @@ static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
>  {
>  	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
>  
> -	BUG_ON(!ptdesc || !pagetable_pte_ctor(ptdesc));
> +	BUG_ON(!ptdesc || !pagetable_pte_ctor(NULL, ptdesc));
>  	return __pa((pte_t *)ptdesc_address(ptdesc));
>  }
>  
> @@ -522,7 +522,7 @@ static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
>  {
>  	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
>  
> -	BUG_ON(!ptdesc || !pagetable_pmd_ctor(ptdesc));
> +	BUG_ON(!ptdesc || !pagetable_pmd_ctor(NULL, ptdesc));
>  	return __pa((pmd_t *)ptdesc_address(ptdesc));
>  }
>  
> diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> index 005497ffebda..5345398df653 100644
> --- a/arch/s390/include/asm/pgalloc.h
> +++ b/arch/s390/include/asm/pgalloc.h
> @@ -97,7 +97,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
>  	if (!table)
>  		return NULL;
>  	crst_table_init(table, _SEGMENT_ENTRY_EMPTY);
> -	if (!pagetable_pmd_ctor(virt_to_ptdesc(table))) {
> +	if (!pagetable_pmd_ctor(mm, virt_to_ptdesc(table))) {
>  		crst_table_free(mm, table);
>  		return NULL;
>  	}
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index e3a6f8ae156c..619d6917e3b7 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -145,7 +145,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
>  	if (!ptdesc)
>  		return NULL;
> -	if (!pagetable_pte_ctor(ptdesc)) {
> +	if (!pagetable_pte_ctor(mm, ptdesc)) {
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 760818950464..5c8eabda1d17 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2895,7 +2895,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>  
>  	if (!ptdesc)
>  		return NULL;
> -	if (!pagetable_pte_ctor(ptdesc)) {
> +	if (!pagetable_pte_ctor(mm, ptdesc)) {
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index dd32711022f5..f8fb4911d360 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -350,7 +350,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>  	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
>  	spin_lock(&mm->page_table_lock);
>  	if (page_ref_inc_return(page) == 2 &&
> -			!pagetable_pte_ctor(page_ptdesc(page))) {
> +			!pagetable_pte_ctor(mm, page_ptdesc(page))) {
>  		page_ref_dec(page);
>  		ptep = NULL;
>  	}
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index a05fcddfc811..7930f234c5f6 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -205,7 +205,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
>  
>  		if (!ptdesc)
>  			failed = true;
> -		if (ptdesc && !pagetable_pmd_ctor(ptdesc)) {
> +		if (ptdesc && !pagetable_pmd_ctor(mm, ptdesc)) {
>  			pagetable_free(ptdesc);
>  			ptdesc = NULL;
>  			failed = true;
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 892ece4558a2..e164ca66f0f6 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -70,7 +70,7 @@ static inline pgtable_t __pte_alloc_one_noprof(struct mm_struct *mm, gfp_t gfp)
>  	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
>  		return NULL;
> -	if (!pagetable_pte_ctor(ptdesc)) {
> +	if (!pagetable_pte_ctor(mm, ptdesc)) {
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> @@ -137,7 +137,7 @@ static inline pmd_t *pmd_alloc_one_noprof(struct mm_struct *mm, unsigned long ad
>  	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
>  		return NULL;
> -	if (!pagetable_pmd_ctor(ptdesc)) {
> +	if (!pagetable_pmd_ctor(mm, ptdesc)) {
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b7f13f087954..f9b793cce2c1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3100,7 +3100,8 @@ static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
>  	pagetable_free(ptdesc);
>  }
>  
> -static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
> +static inline bool pagetable_pte_ctor(struct mm_struct *mm,
> +				      struct ptdesc *ptdesc)
>  {
>  	if (!ptlock_init(ptdesc))
>  		return false;
> @@ -3206,7 +3207,8 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
>  	return ptl;
>  }
>  
> -static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
> +static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
> +				      struct ptdesc *ptdesc)
>  {
>  	if (!pmd_ptlock_init(ptdesc))
>  		return false;

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>	# s390

